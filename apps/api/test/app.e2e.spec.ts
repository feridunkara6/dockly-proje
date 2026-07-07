import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { RedisService } from '../src/infrastructure/redis/redis.service';

/**
 * Uygulama seviyesi test: gerçek HTTP hattı, sahte altyapı (DB/Redis testte mock —
 * docs/15: mock yalnız testte). Gerçek DB'ye karşı entegrasyon CI'da postgis imajıyla koşar.
 */
describe('API çekirdeği (e2e-lite)', () => {
  let app: INestApplication;
  let dbHealthy = true;
  let redisHealthy = true;

  beforeAll(async () => {
    process.env.NODE_ENV = 'test';
    process.env.DATABASE_URL = 'postgresql://test:test@localhost:5432/test';
    process.env.REDIS_URL = 'redis://localhost:6379';

    const moduleRef = await Test.createTestingModule({ imports: [AppModule] })
      .overrideProvider(PrismaService)
      .useValue({
        $queryRaw: () =>
          dbHealthy ? Promise.resolve([{ ok: 1 }]) : Promise.reject(new Error('db down')),
      })
      .overrideProvider(RedisService)
      .useValue({
        ping: () =>
          redisHealthy ? Promise.resolve(true) : Promise.reject(new Error('redis down')),
      })
      .compile();

    app = moduleRef.createNestApplication({ logger: false });
    app.useGlobalFilters(new GlobalProblemFilter());
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('GET /healthz → 200 ok (liveness altyapıya bakmaz)', async () => {
    dbHealthy = false;
    const res = await request(app.getHttpServer()).get('/healthz').expect(200);
    expect(res.body).toEqual({ status: 'ok' });
    dbHealthy = true;
  });

  it('GET /readyz → 200 ve kontrol raporu', async () => {
    const res = await request(app.getHttpServer()).get('/readyz').expect(200);
    expect(res.body.checks).toEqual({ database: 'ok', redis: 'ok' });
  });

  it('GET /readyz → DB düşükken 503 Problem döner', async () => {
    dbHealthy = false;
    const res = await request(app.getHttpServer()).get('/readyz').expect(503);
    expect(res.headers['content-type']).toContain('application/problem+json');
    dbHealthy = true;
  });

  it('GET /readyz → Redis düşükken 503 (bağımsız kontrol)', async () => {
    redisHealthy = false;
    await request(app.getHttpServer()).get('/readyz').expect(503);
    redisHealthy = true;
  });

  it('bilinmeyen rota → RFC 9457 not-found + requestId', async () => {
    const res = await request(app.getHttpServer()).get('/no-such-route').expect(404);
    expect(res.headers['content-type']).toContain('application/problem+json');
    expect(res.body.type).toBe('https://api.dockly.app/problems/not-found');
    expect(res.body.requestId).toBeDefined();
    expect(res.headers['x-request-id']).toBe(res.body.requestId);
  });

  it('istemcinin güvenli X-Request-Id değeri uçtan uca korunur', async () => {
    const res = await request(app.getHttpServer())
      .get('/no-such-route')
      .set('X-Request-Id', 'trace-me-12345')
      .expect(404);
    expect(res.body.requestId).toBe('trace-me-12345');
  });
});
