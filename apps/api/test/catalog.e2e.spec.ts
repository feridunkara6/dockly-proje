import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';

/** Katalog (sözlük) uçları uçtan uca — gerçek seed'li DB (yalnız CI). */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

interface Labeled {
  code: string;
  label: string;
}

runIf('Catalog API (e2e — gerçek seed DB)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] }).compile();
    app = moduleRef.createNestApplication({ logger: false });
    app.useGlobalFilters(new GlobalProblemFilter());
    app.setGlobalPrefix('v1', { exclude: ['healthz', 'readyz'] });
    await app.init();
    http = app.getHttpServer();
  });

  afterAll(async () => {
    await app.close();
  });

  it('location-types: anonim erişilir, 9 öğe, varsayılan TR etiket', async () => {
    const res = await request(http).get('/v1/location-types').expect(200);
    const items: Labeled[] = res.body.data;
    expect(items).toHaveLength(9);
    const priv = items.find((i) => i.code === 'private_marina');
    expect(priv?.label).toBe('Özel Marina');
  });

  it('location-types: Accept-Language=en → EN etiket', async () => {
    const res = await request(http)
      .get('/v1/location-types')
      .set('Accept-Language', 'en-US,en;q=0.9')
      .expect(200);
    const items: Labeled[] = res.body.data;
    const priv = items.find((i) => i.code === 'private_marina');
    expect(priv?.label).toBe('Private Marina');
  });

  it('location-types: desteklenmeyen dil (de) → TR fallback', async () => {
    const res = await request(http)
      .get('/v1/location-types')
      .set('Accept-Language', 'de-DE,de;q=0.9')
      .expect(200);
    const items: Labeled[] = res.body.data;
    expect(items.find((i) => i.code === 'private_marina')?.label).toBe('Özel Marina');
  });

  it('cache başlıkları: Cache-Control + Vary: Accept-Language', async () => {
    const res = await request(http).get('/v1/location-types').expect(200);
    expect(res.headers['cache-control']).toContain('max-age=3600');
    expect(res.headers['cache-control']).toContain('s-maxage=86400');
    expect(res.headers['vary']).toMatch(/Accept-Language/i);
  });

  it('amenities: 14 öğe, kategori alanı taşınır', async () => {
    const res = await request(http).get('/v1/amenities').expect(200);
    const items = res.body.data;
    expect(items).toHaveLength(14);
    const elec = items.find((i: Labeled) => i.code === 'electricity');
    expect(elec.label).toBe('Elektrik');
    expect(elec).toHaveProperty('category');
  });

  it('services: 6 öğe', async () => {
    const res = await request(http).get('/v1/services').expect(200);
    expect(res.body.data).toHaveLength(6);
  });

  it('boat-types: 9 öğe', async () => {
    const res = await request(http).get('/v1/boat-types').expect(200);
    expect(res.body.data).toHaveLength(9);
  });

  it('engine-types: 6 öğe, i18n yok → label = code', async () => {
    const res = await request(http).get('/v1/engine-types').expect(200);
    const items: Labeled[] = res.body.data;
    expect(items).toHaveLength(6);
    for (const it of items) {
      expect(it.label).toBe(it.code);
    }
    expect(items.map((i) => i.code)).toContain('inboard_diesel');
  });
});
