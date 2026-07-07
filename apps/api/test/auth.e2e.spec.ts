import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { FIREBASE_TOKEN_VERIFIER } from '../src/infrastructure/firebase/firebase-token.verifier';
import { FakeFirebaseVerifier, generateTestKeys } from './helpers/auth-test-kit';

/**
 * Auth uçtan uca: GERÇEK PostgreSQL + Redis'e karşı (yalnız CI'da koşar).
 * Firebase doğrulayıcı sahte (dış ağ yok); geri kalan zincir gerçektir.
 */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

function ftok(uid: string, provider = 'google.com', extra: Record<string, unknown> = {}): string {
  return (
    'ftok:' +
    JSON.stringify({ uid, emailVerified: true, provider, email: `${uid}@e2e.dev`, ...extra })
  );
}

runIf('Auth API (e2e — gerçek DB+Redis)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;

  beforeAll(async () => {
    const keys = generateTestKeys();
    process.env.FIREBASE_PROJECT_ID = 'dockly-e2e';
    process.env.JWT_PRIVATE_KEY_PEM = keys.privatePem;
    process.env.JWT_PUBLIC_KEY_PEM = keys.publicPem;
    process.env.AUTH_RATE_LIMIT_PER_MIN = '30';

    const moduleRef = await Test.createTestingModule({ imports: [AppModule] })
      .overrideProvider(FIREBASE_TOKEN_VERIFIER)
      .useValue(new FakeFirebaseVerifier())
      .compile();
    app = moduleRef.createNestApplication({ logger: false });
    app.useGlobalFilters(new GlobalProblemFilter());
    app.setGlobalPrefix('v1', { exclude: ['healthz', 'readyz'] });
    await app.init();
    http = app.getHttpServer();
  });

  afterAll(async () => {
    await app.close();
  });

  it('POST /v1/auth/sessions → 200: token çifti + kullanıcı; DB satırı oluşur', async () => {
    const res = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-1') })
      .expect(200);
    expect(res.body.accessToken).toBeDefined();
    expect(res.body.refreshToken).toMatch(/^rt_/);
    expect(res.body.user.role).toBe('user');
    expect(res.body.user.isGuest).toBe(false);
  });

  it('aynı firebase kimliğiyle ikinci giriş AYNI kullanıcıyı döndürür', async () => {
    const a = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-2') })
      .expect(200);
    const b = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-2') })
      .expect(200);
    expect(b.body.user.id).toBe(a.body.user.id);
  });

  it('geçersiz gövde → 422 validation-error (alan listesiyle)', async () => {
    const res = await request(http).post('/v1/auth/sessions').send({ firebaseIdToken: 'kısa' });
    expect(res.status).toBe(422);
    expect(res.body.errors[0].field).toBe('firebaseIdToken');
  });

  it('refresh akışı: rotasyon → eski token reuse → aile iptali (SEC zinciri)', async () => {
    const first = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-3') })
      .expect(200);

    const second = await request(http)
      .post('/v1/auth/sessions/refresh')
      .send({ refreshToken: first.body.refreshToken })
      .expect(200);
    expect(second.body.refreshToken).not.toBe(first.body.refreshToken);

    // Eski token'ı tekrar kullan → reuse tespiti
    await request(http)
      .post('/v1/auth/sessions/refresh')
      .send({ refreshToken: first.body.refreshToken })
      .expect(401);

    // Aile düştü: yeni token da geçersiz
    await request(http)
      .post('/v1/auth/sessions/refresh')
      .send({ refreshToken: second.body.refreshToken })
      .expect(401);
  });

  it('DELETE /v1/auth/sessions (logout) → refresh artık çalışmaz; idempotent 204', async () => {
    const s = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-4') })
      .expect(200);
    await request(http)
      .delete('/v1/auth/sessions')
      .send({ refreshToken: s.body.refreshToken })
      .expect(204);
    await request(http)
      .post('/v1/auth/sessions/refresh')
      .send({ refreshToken: s.body.refreshToken })
      .expect(401);
    await request(http)
      .delete('/v1/auth/sessions')
      .send({ refreshToken: s.body.refreshToken })
      .expect(204);
  });

  it('DELETE /v1/auth/sessions/all Bearer ister; tüm oturumları düşürür', async () => {
    const a = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-5') })
      .expect(200);
    const b = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-user-5') })
      .expect(200);

    await request(http).delete('/v1/auth/sessions/all').expect(401);
    await request(http)
      .delete('/v1/auth/sessions/all')
      .set('Authorization', `Bearer ${a.body.accessToken}`)
      .expect(204);

    await request(http)
      .post('/v1/auth/sessions/refresh')
      .send({ refreshToken: a.body.refreshToken })
      .expect(401);
    await request(http)
      .post('/v1/auth/sessions/refresh')
      .send({ refreshToken: b.body.refreshToken })
      .expect(401);
  });

  it('misafir girişi guest=true; sosyal girişle aynı hesap yükselir', async () => {
    const guest = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-guest-1', 'anonymous', { emailVerified: false }) })
      .expect(200);
    expect(guest.body.user.isGuest).toBe(true);

    const upgraded = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok('e2e-guest-1', 'apple.com') })
      .expect(200);
    expect(upgraded.body.user.id).toBe(guest.body.user.id);
    expect(upgraded.body.user.isGuest).toBe(false);
  });

  it('rate limit: tavan aşımında 429 + Retry-After (docs/23 §6)', async () => {
    const payload = { firebaseIdToken: 'ftok-bozuk-ama-sayilir' };
    let got429 = false;
    for (let i = 0; i < 40 && !got429; i++) {
      const res = await request(http).post('/v1/auth/sessions').send(payload);
      if (res.status === 429) {
        expect(res.headers['retry-after']).toBeDefined();
        expect(res.body.type).toContain('rate-limited');
        got429 = true;
      }
    }
    expect(got429).toBe(true);
  });
});
