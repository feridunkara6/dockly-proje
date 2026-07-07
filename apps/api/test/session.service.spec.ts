import { createHash } from 'node:crypto';
import { EnvService } from '../src/config/env.service';
import { TokenSigner } from '../src/infrastructure/jwt/token.signer';
import { SessionService } from '../src/modules/auth/application/session.service';
import { AppProblem } from '../src/common/problem/problem';
import { JtiBlacklistService } from '../src/infrastructure/redis/jti-blacklist.service';
import {
  FakeFirebaseVerifier,
  generateTestKeys,
  InMemoryJtiBlacklist,
  InMemorySessionRepository,
  InMemoryUserAccountRepository,
} from './helpers/auth-test-kit';

function firebaseToken(uid: string, provider = 'google.com'): string {
  return 'ftok:' + JSON.stringify({ uid, emailVerified: true, provider, email: uid + '@t.dev' });
}

describe('SessionService (rotating refresh + reuse tespiti, docs/23 §3)', () => {
  let service: SessionService;
  let sessions: InMemorySessionRepository;
  let users: InMemoryUserAccountRepository;
  let signer: TokenSigner;
  let blacklist: InMemoryJtiBlacklist;

  beforeAll(() => {
    const keys = generateTestKeys();
    process.env.NODE_ENV = 'test';
    process.env.DATABASE_URL = 'postgresql://t:t@localhost:5432/t';
    process.env.REDIS_URL = 'redis://localhost:6379';
    process.env.FIREBASE_PROJECT_ID = 'dockly-test';
    process.env.JWT_PRIVATE_KEY_PEM = keys.privatePem;
    process.env.JWT_PUBLIC_KEY_PEM = keys.publicPem;
  });

  beforeEach(() => {
    const env = new EnvService();
    sessions = new InMemorySessionRepository();
    users = new InMemoryUserAccountRepository();
    signer = new TokenSigner(env);
    blacklist = new InMemoryJtiBlacklist();
    service = new SessionService(
      new FakeFirebaseVerifier(),
      sessions,
      users,
      signer,
      blacklist as unknown as JtiBlacklistService,
      env,
    );
  });

  it('oturum açma: geçerli JWT + rt_ önekli refresh + kullanıcı özeti döner', async () => {
    const bundle = await service.createSession(firebaseToken('u1'), { ip: '10.0.0.1' });
    expect(bundle.refreshToken).toMatch(/^rt_[A-Za-z0-9_-]{43}$/);
    expect(bundle.expiresIn).toBe(900);
    expect(bundle.user.isGuest).toBe(false);
    const principal = await signer.verifyAccess(bundle.accessToken);
    expect(principal.userId).toBe(bundle.user.id);
    expect(principal.role).toBe('user');
  });

  it('misafir girişi guest=true üretir; sosyal girişle yükseltilir', async () => {
    const guest = await service.createSession(
      'ftok:' + JSON.stringify({ uid: 'g1', emailVerified: false, provider: 'anonymous' }),
      {},
    );
    expect(guest.user.isGuest).toBe(true);
    const upgraded = await service.createSession(firebaseToken('g1'), {});
    expect(upgraded.user.isGuest).toBe(false);
    expect(upgraded.user.id).toBe(guest.user.id);
  });

  it('refresh: yeni çift üretir, eskisi iptal olur (rotasyon)', async () => {
    const first = await service.createSession(firebaseToken('u2'), {});
    const second = await service.refreshSession(first.refreshToken, {});
    expect(second.refreshToken).not.toBe(first.refreshToken);
    expect(second.user.id).toBe(first.user.id);
    const oldRow = await sessions.findByTokenHash(
      createHash('sha256').update(first.refreshToken).digest('hex'),
    );
    expect(oldRow?.revokedAt).not.toBeNull();
  });

  it('REUSE: döndürülmüş token tekrar kullanılırsa TÜM aile iptal edilir', async () => {
    const first = await service.createSession(firebaseToken('u3'), {});
    const second = await service.refreshSession(first.refreshToken, {});
    await expect(service.refreshSession(first.refreshToken, {})).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
    // Aile düştü: en güncel token bile artık çalışmamalı.
    await expect(service.refreshSession(second.refreshToken, {})).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
  });

  it('bilinmeyen refresh token invalid-token döner', async () => {
    await expect(service.refreshSession('rt_' + 'x'.repeat(43), {})).rejects.toBeInstanceOf(
      AppProblem,
    );
  });

  it('askıya alınan hesabın refresh denemesi aileyi kapatır', async () => {
    const bundle = await service.createSession(firebaseToken('u4'), {});
    users.suspendedIds.add(bundle.user.id);
    await expect(service.refreshSession(bundle.refreshToken, {})).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
  });

  it('logout aileyi düşürür ve idempotenttir', async () => {
    const bundle = await service.createSession(firebaseToken('u5'), {});
    await service.logout(bundle.refreshToken);
    await expect(service.refreshSession(bundle.refreshToken, {})).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
    await expect(service.logout(bundle.refreshToken)).resolves.toBeUndefined();
  });

  it('5 cihaz tavanı: 6. oturum en eski aileyi düşürür (docs/30 §11)', async () => {
    const bundles = [];
    for (let i = 0; i < 6; i++) {
      bundles.push(await service.createSession(firebaseToken('u-cap'), {}));
    }
    expect(await sessions.countActiveFamilies(bundles[0].user.id)).toBe(5);
    // İlk (en eski) ailenin refresh'i artık geçersiz
    await expect(service.refreshSession(bundles[0].refreshToken, {})).rejects.toBeInstanceOf(
      AppProblem,
    );
    // En yenisi çalışmaya devam eder
    await expect(service.refreshSession(bundles[5].refreshToken, {})).resolves.toBeDefined();
  });

  it('terminateUser: aileler düşer ve yaşayan jti karalisteye girer', async () => {
    const a = await service.createSession(firebaseToken('u-term'), {});
    const b = await service.createSession(firebaseToken('u-term'), {});
    await service.terminateUser(a.user.id);
    expect(blacklist.blocked.size).toBe(2);
    await expect(service.refreshSession(a.refreshToken, {})).rejects.toBeInstanceOf(AppProblem);
    await expect(service.refreshSession(b.refreshToken, {})).rejects.toBeInstanceOf(AppProblem);
  });

  it('logoutAll kullanıcının tüm ailelerini düşürür', async () => {
    const a = await service.createSession(firebaseToken('u6'), {});
    const b = await service.createSession(firebaseToken('u6'), {});
    await service.logoutAll(a.user.id);
    await expect(service.refreshSession(a.refreshToken, {})).rejects.toBeInstanceOf(AppProblem);
    await expect(service.refreshSession(b.refreshToken, {})).rejects.toBeInstanceOf(AppProblem);
  });
});
