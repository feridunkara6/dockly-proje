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

  it('doluluk bildirimi: misafir 403, tokensiz 401, kayıtlı kullanıcı bildirir', async () => {
    // Misafir: üyelik kapısı sunucuda da tutarlı (2026-07 ayrıştırma paketi ①).
    const guest = await login(guestTok('guest-occ'));
    const gRes = await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .set('Authorization', `Bearer ${guest.accessToken}`)
      .send({ level: 'full', position: { lat: 36.749, lon: 28.943 } })
      .expect(403);
    expect(gRes.body.type).toContain('guest-not-allowed');

    // Tokensiz: 401.
    await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .send({ level: 'full', position: { lat: 36.749, lon: 28.943 } })
      .expect(401);

    // Kayıtlı kullanıcı: bildirim geçer, özet döner; aynı kullanıcının ikinci
    // bildirimi üstüne yazar (sayı artmaz — spam koruması).
    const user = await login(userTok('occ-user-1'));
    const auth = `Bearer ${user.accessToken}`;
    const first = await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .set('Authorization', auth)
      .send({ level: 'full', position: { lat: 36.749, lon: 28.943 } })
      .expect(200);
    expect(first.body.occupancy.level).toBe('full');
    expect(first.body.occupancy.reportCount).toBe(1);

    const second = await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .set('Authorization', auth)
      .send({ level: 'moderate', position: { lat: 36.749, lon: 28.943 } })
      .expect(200);
    expect(second.body.occupancy.level).toBe('moderate');
    expect(second.body.occupancy.reportCount).toBe(1); // üstüne yazdı

    // Geçersiz gövde → 400 (zod): bozuk düzey ve KONUMSUZ bildirim.
    await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .set('Authorization', auth)
      .send({ level: 'cok-dolu', position: { lat: 36.749, lon: 28.943 } })
      .expect(400);
    await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .set('Authorization', auth)
      .send({ level: 'full' })
      .expect(400);

    // KONUM DOĞRULAMASI: koydan uzak (İstanbul) konumla bildirim reddedilir.
    const far = await request(http)
      .post('/v1/locations/d-marin-gocek/occupancy')
      .set('Authorization', auth)
      .send({ level: 'full', position: { lat: 41.0, lon: 29.0 } })
      .expect(400);
    expect(JSON.stringify(far.body)).toContain('too_far');

    // Bilinmeyen lokasyon → 404.
    await request(http)
      .post('/v1/locations/yok-boyle-koy/occupancy')
      .set('Authorization', auth)
      .send({ level: 'full', position: { lat: 36.749, lon: 28.943 } })
      .expect(404);

    // Pin sorgusu doluluk özetini taşır (detay/harita yüzeyi).
    const map = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13')
      .expect(200);
    interface PinLite { name: string; occupancy: { level: string; reportCount: number } | null }
    const marina = (map.body.locations as PinLite[]).find((p) => p.name === 'D-Marin Göcek');
    expect(marina?.occupancy?.level).toBe('moderate');
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
