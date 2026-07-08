import { JtiBlacklistService } from '../src/infrastructure/redis/jti-blacklist.service';
import { RedisService } from '../src/infrastructure/redis/redis.service';
import { AppProblem } from '../src/common/problem/problem';

/** Bellek-içi sahte Redis: SET/EXISTS semantiği + failing anahtarı (yalnız testte). */
class FakeRedis {
  store = new Set<string>();
  failing = false;

  client = {
    set: async (key: string): Promise<'OK'> => {
      if (this.failing) throw new Error('redis down');
      this.store.add(key);
      return 'OK';
    },
    exists: async (key: string): Promise<number> => {
      if (this.failing) throw new Error('redis down');
      return this.store.has(key) ? 1 : 0;
    },
  };

  async ensureConnected(): Promise<void> {
    if (this.failing) throw new Error('redis down');
  }
}

describe('JtiBlacklistService (docs/12 §0.3 — okuma fail-closed, A.3)', () => {
  let fake: FakeRedis;
  let svc: JtiBlacklistService;

  beforeEach(() => {
    fake = new FakeRedis();
    svc = new JtiBlacklistService(fake as unknown as RedisService);
  });

  it('block sonrası isBlocked true; bloklanmamış jti false', async () => {
    await svc.block('jti-1', 900);
    expect(await svc.isBlocked('jti-1')).toBe(true);
    expect(await svc.isBlocked('jti-2')).toBe(false);
  });

  it('Redis düşükse isBlocked FAIL-CLOSED: service-unavailable (503) fırlatır', async () => {
    fake.failing = true;
    let thrown: unknown;
    try {
      await svc.isBlocked('jti-x');
    } catch (e) {
      thrown = e;
    }
    expect(thrown).toBeInstanceOf(AppProblem);
    expect((thrown as AppProblem).problemType).toBe('service-unavailable');
    expect((thrown as AppProblem).status).toBe(503);
  });

  it('Redis düşükse block BEST-EFFORT: hata fırlatmaz (DB refresh iptali kalıcı garanti)', async () => {
    fake.failing = true;
    await expect(svc.block('jti-y', 900)).resolves.toBeUndefined();
  });
});
