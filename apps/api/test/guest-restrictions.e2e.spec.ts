import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { FIREBASE_TOKEN_VERIFIER } from '../src/infrastructure/firebase/firebase-token.verifier';
import { FakeFirebaseVerifier, generateTestKeys } from './helpers/auth-test-kit';

/** Misafir (anonim) kısıtları uçtan uca — gerçek DB+Redis (yalnız CI). docs/12 §2.3. */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

/** Kayıtlı (Google) kullanıcı token'ı. */
function userTok(uid: string): string {
  return (
    'ftok:' +
    JSON.stringify({ uid, emailVerified: true, provider: 'google.com', email: `${uid}@e2e.dev` })
  );
}

/** Misafir (anonim Firebase) token'ı — provider 'anonymous' → isGuest=true. */
function guestTok(uid: string): string {
  return 'ftok:' + JSON.stringify({ uid, emailVerified: false, provider: 'anonymous' });
}

runIf('Misafir kısıtları (e2e — gerçek DB+Redis)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;

  async function login(firebaseTok: string): Promise<{ accessToken: string; isGuest: boolean }> {
    const res = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: firebaseTok })
      .expect(200);
    return { accessToken: res.body.accessToken, isGuest: res.body.user.isGuest };
  }

  beforeAll(async () => {
    const keys = generateTestKeys();
    process.env.FIREBASE_PROJECT_ID = 'dockly-e2e';
    process.env.JWT_PRIVATE_KEY_PEM = keys.privatePem;
    process.env.JWT_PUBLIC_KEY_PEM = keys.publicPem;
    process.env.AUTH_RATE_LIMIT_PER_MIN = '100';
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

  it('misafir oturumu isGuest=true döner', async () => {
    const guest = await login(guestTok('guest-1'));
    expect(guest.isGuest).toBe(true);
  });

  it('misafir /boats uçlarında 403 guest-not-allowed alır (okuma dahil)', async () => {
    const guest = await login(guestTok('guest-2'));
    const auth = `Bearer ${guest.accessToken}`;

    const listRes = await request(http).get('/v1/boats').set('Authorization', auth).expect(403);
    expect(listRes.body.type).toContain('guest-not-allowed');

    await request(http)
      .post('/v1/boats')
      .set('Authorization', auth)
      .send({ name: 'Misafir Tekne', boatTypeCode: 'sailboat', lengthM: 10 })
      .expect(403);
  });

  it('misafir /users/me okuma ve güncellemede 403 alır', async () => {
    const guest = await login(guestTok('guest-3'));
    const auth = `Bearer ${guest.accessToken}`;

    await request(http).get('/v1/users/me').set('Authorization', auth).expect(403);
    const patchRes = await request(http)
      .patch('/v1/users/me')
      .set('Authorization', auth)
      .send({ locale: 'en' })
      .expect(403);
    expect(patchRes.body.type).toContain('guest-not-allowed');
  });

  it('regresyon: kayıtlı kullanıcı aynı uçları normal kullanır', async () => {
    const user = await login(userTok('real-user-1'));
    expect(user.isGuest).toBe(false);
    const auth = `Bearer ${user.accessToken}`;

    await request(http).get('/v1/users/me').set('Authorization', auth).expect(200);
    const created = await request(http)
      .post('/v1/boats')
      .set('Authorization', auth)
      .send({ name: 'Gerçek Tekne', boatTypeCode: 'sailboat', lengthM: 11.2 })
      .expect(201);
    expect(created.body.name).toBe('Gerçek Tekne');
  });

  it('misafir keşif uçlarını (public locations) normal kullanır', async () => {
    const guest = await login(guestTok('guest-4'));
    // /locations public read — misafir erişebilir (kısıt yok).
    await request(http)
      .get('/v1/locations?bbox=27.0,36.0,29.0,37.5&zoom=8')
      .set('Authorization', `Bearer ${guest.accessToken}`)
      .expect(200);
  });
});
