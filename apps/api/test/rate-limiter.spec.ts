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

describe('RateLimiterService (docs/30 §1 + fail-open kuralı)', () => {
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

  it('Redis düşükse FAIL-OPEN: istek geçer (docs/29 kabul edilen risk)', async () => {
    fake.failing = true;
    const d = await limiter.consume('auth', '1.2.3.4', 1, 60);
    expect(d.allowed).toBe(true);
  });
});
