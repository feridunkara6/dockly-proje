import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { FIREBASE_TOKEN_VERIFIER } from '../src/infrastructure/firebase/firebase-token.verifier';
import { FakeFirebaseVerifier, generateTestKeys } from './helpers/auth-test-kit';

/** boats CRUD uçtan uca — gerçek DB+Redis (yalnız CI). */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

function ftok(uid: string): string {
  return 'ftok:' + JSON.stringify({ uid, emailVerified: true, provider: 'google.com', email: `${uid}@e2e.dev` });
}

runIf('Boats API (e2e — gerçek DB+Redis)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;

  async function login(uid: string): Promise<string> {
    const res = await request(http)
      .post('/v1/auth/sessions')
      .send({ firebaseIdToken: ftok(uid) })
      .expect(200);
    return res.body.accessToken;
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

  it('token olmadan tüm boats uçları 401', async () => {
    await request(http).get('/v1/boats').expect(401);
    await request(http).post('/v1/boats').send({}).expect(401);
  });

  it('POST 201: ilk tekne birincil; GET list döner', async () => {
    const t = await login('boat-user-1');
    const created = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'Poyraz', boatTypeCode: 'sailboat', lengthM: 12.4, engineTypeCode: 'inboard_diesel' })
      .expect(201);
    expect(created.body.isPrimary).toBe(true);
    expect(created.body.boatTypeCode).toBe('sailboat');
    expect(created.body.lengthM).toBe(12.4);

    const list = await request(http).get('/v1/boats').set('Authorization', `Bearer ${t}`).expect(200);
    expect(list.body.data).toHaveLength(1);
  });

  it('geçersiz boatTypeCode → 422 alan hatası', async () => {
    const t = await login('boat-user-2');
    const res = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'X', boatTypeCode: 'uzay', lengthM: 5 })
      .expect(422);
    expect(res.body.errors.some((e: { field: string }) => e.field === 'boatTypeCode')).toBe(true);
  });

  it('boy sınırı (0 ve >200) → 422 (docs/22 CHECK)', async () => {
    const t = await login('boat-user-3');
    await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'X', boatTypeCode: 'other', lengthM: 0 })
      .expect(422);
    await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'X', boatTypeCode: 'other', lengthM: 250 })
      .expect(422);
  });

  it('çoklu tekne + birincil devri (PATCH isPrimary)', async () => {
    const t = await login('boat-user-4');
    const a = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'A', boatTypeCode: 'sailboat', lengthM: 10 })
      .expect(201);
    const b = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'B', boatTypeCode: 'motor_yacht', lengthM: 8 })
      .expect(201);
    expect(b.body.isPrimary).toBe(false);

    await request(http)
      .patch(`/v1/boats/${b.body.id}`)
      .set('Authorization', `Bearer ${t}`)
      .send({ isPrimary: true })
      .expect(200);

    const list = await request(http).get('/v1/boats').set('Authorization', `Bearer ${t}`).expect(200);
    const primaries = list.body.data.filter((x: { isPrimary: boolean }) => x.isPrimary);
    expect(primaries).toHaveLength(1);
    expect(primaries[0].id).toBe(b.body.id);
    expect(list.body.data.find((x: { id: string }) => x.id === a.body.id).isPrimary).toBe(false);
  });

  it('sahiplik izolasyonu: başka kullanıcının teknesi 404', async () => {
    const t1 = await login('boat-owner-a');
    const created = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t1}`)
      .send({ name: 'Gizli', boatTypeCode: 'other', lengthM: 6 })
      .expect(201);
    const t2 = await login('boat-owner-b');
    await request(http)
      .get(`/v1/boats/${created.body.id}`)
      .set('Authorization', `Bearer ${t2}`)
      .expect(404);
    await request(http)
      .patch(`/v1/boats/${created.body.id}`)
      .set('Authorization', `Bearer ${t2}`)
      .send({ name: 'Ele geçirildi' })
      .expect(404);
    await request(http)
      .delete(`/v1/boats/${created.body.id}`)
      .set('Authorization', `Bearer ${t2}`)
      .expect(404);
  });

  it('DELETE 204: birincil silinince yeni birincil atanır', async () => {
    const t = await login('boat-user-5');
    const a = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'A', boatTypeCode: 'sailboat', lengthM: 10 })
      .expect(201);
    const b = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'B', boatTypeCode: 'motor_yacht', lengthM: 8 })
      .expect(201);
    await request(http)
      .delete(`/v1/boats/${a.body.id}`)
      .set('Authorization', `Bearer ${t}`)
      .expect(204);
    const list = await request(http).get('/v1/boats').set('Authorization', `Bearer ${t}`).expect(200);
    expect(list.body.data).toHaveLength(1);
    expect(list.body.data[0].id).toBe(b.body.id);
    expect(list.body.data[0].isPrimary).toBe(true);
  });

  it('geçersiz UUID → 404; boş PATCH → 422', async () => {
    const t = await login('boat-user-6');
    await request(http).get('/v1/boats/not-a-uuid').set('Authorization', `Bearer ${t}`).expect(404);
    const b = await request(http)
      .post('/v1/boats')
      .set('Authorization', `Bearer ${t}`)
      .send({ name: 'A', boatTypeCode: 'other', lengthM: 5 })
      .expect(201);
    await request(http)
      .patch(`/v1/boats/${b.body.id}`)
      .set('Authorization', `Bearer ${t}`)
      .send({})
      .expect(422);
  });
});
