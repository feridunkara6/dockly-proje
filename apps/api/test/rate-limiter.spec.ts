import { RateLimiterService } from '../src/infrastructure/redis/rate-limiter.service';
import { RedisService } from '../src/infrastructure/redis/redis.service';

/** Bellek-içi sahte Redis: INCR/EXPIRE semantiği (yalnız testte mock kuralı). */
class FakeRedis {
  counters = new Map<string, number>();
  failing = false;

  client = {
    incr: async (key: string): Promise<number> => {
      if (this.failing) throw new Error('redis down');
      const next = (this.counters.get(key) ?? 0) + 1;
      this.counters.set(key, next);
      return next;
    },
    expire: async (): Promise<number> => 1,
  };

  async ensureConnected(): Promise<void> {
    if (this.failing) throw new Error('redis down');
  }
}

describe('RateLimiterService (docs/30 §1 + Redis kesintisinde bellek-içi yedek)', () => {
  let fake: FakeRedis;
  let limiter: RateLimiterService;

  beforeEach(() => {
    fake = new FakeRedis();
    limiter = new RateLimiterService(fake as unknown as RedisService);
  });

  it('limit altında izin verir, aşımda reddeder ve Retry-After üretir', async () => {
    for (let i = 0; i < 3; i++) {
      const d = await limiter.consume('auth', '1.2.3.4', 3, 60);
      expect(d.allowed).toBe(true);
    }
    const denied = await limiter.consume('auth', '1.2.3.4', 3, 60);
    expect(denied.allowed).toBe(false);
    expect(denied.retryAfterSec).toBeGreaterThan(0);
    expect(denied.retryAfterSec).toBeLessThanOrEqual(60);
  });

  it('farklı kimlikler birbirinin kotasını tüketmez', async () => {
    await limiter.consume('auth', 'a', 1, 60);
    const other = await limiter.consume('auth', 'b', 1, 60);
    expect(other.allowed).toBe(true);
  });

  it('Redis düşükse bellek-içi yedek DEVREYE girer: limit hâlâ uygulanır (fail-closed, A.3)', async () => {
    fake.failing = true;
    // max=2: ilk iki istek geçer, üçüncü Redis olmadan da reddedilir (fail-open DEĞİL).
    expect((await limiter.consume('auth', '9.9.9.9', 2, 60)).allowed).toBe(true);
    expect((await limiter.consume('auth', '9.9.9.9', 2, 60)).allowed).toBe(true);
    const denied = await limiter.consume('auth', '9.9.9.9', 2, 60);
    expect(denied.allowed).toBe(false);
    expect(denied.retryAfterSec).toBeGreaterThan(0);
  });

  it('bellek-içi yedek farklı kimlikleri ayırır', async () => {
    fake.failing = true;
    expect((await limiter.consume('auth', 'x', 1, 60)).allowed).toBe(true);
    expect((await limiter.consume('auth', 'x', 1, 60)).allowed).toBe(false);
    expect((await limiter.consume('auth', 'y', 1, 60)).allowed).toBe(true);
  });
});
