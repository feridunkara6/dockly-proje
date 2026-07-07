import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { LocationSummary } from '../src/modules/locations/domain/location.types';

/** Harita bbox pin ucu uçtan uca — gerçek PostGIS (yalnız CI). */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

interface Pin {
  id: string;
  name: string;
  type: string;
  position: { lat: number; lon: number };
  ratingAvg: number | null;
  priceTier: string;
}

runIf('Locations bbox API (e2e — gerçek PostGIS)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;
  let prisma: PrismaService;

  /** Bilinen konumlara test lokasyonları basar (position Prisma ile yazılamaz → ham SQL). */
  async function seedFixtures(): Promise<void> {
    // Göcek çevresi: 2 yayınlanmış (marina + fuel), 1 taslak, 1 silinmiş, 1 kutu dışı.
    await prisma.$executeRawUnsafe(`
      INSERT INTO locations (id, slug, location_type_id, status, country_code, name, position, rating_avg, rating_count, price_tier)
      VALUES
        (gen_random_uuid(), 'e2e-gocek-marina', 1, 'published', 'TR', 'E2E Göcek Marina',
         ST_SetSRID(ST_MakePoint(28.93, 36.75), 4326)::geography, 4.8, 100, 'paid'),
        (gen_random_uuid(), 'e2e-gocek-fuel', 6, 'published', 'TR', 'E2E Göcek Yakıt',
         ST_SetSRID(ST_MakePoint(28.94, 36.76), 4326)::geography, NULL, 5, 'unknown'),
        (gen_random_uuid(), 'e2e-gocek-draft', 1, 'draft', 'TR', 'E2E Göcek Taslak',
         ST_SetSRID(ST_MakePoint(28.93, 36.75), 4326)::geography, NULL, 0, 'unknown'),
        (gen_random_uuid(), 'e2e-gocek-deleted', 1, 'published', 'TR', 'E2E Göcek Silinmiş',
         ST_SetSRID(ST_MakePoint(28.93, 36.75), 4326)::geography, NULL, 0, 'unknown'),
        (gen_random_uuid(), 'e2e-outside', 1, 'published', 'TR', 'E2E Kutu Dışı',
         ST_SetSRID(ST_MakePoint(33.0, 38.0), 4326)::geography, NULL, 0, 'unknown')
      ON CONFLICT (slug) DO NOTHING;
    `);
    await prisma.$executeRawUnsafe(`
      UPDATE locations SET deleted_at = now() WHERE slug = 'e2e-gocek-deleted';
    `);
    // Marina'ya olanaklar bağla (amenityCodes array_agg yolunu doğrular).
    await prisma.$executeRawUnsafe(`
      INSERT INTO location_amenities (location_id, amenity_id)
      SELECT l.id, a.id FROM locations l, amenities a
      WHERE l.slug = 'e2e-gocek-marina' AND a.code IN ('electricity', 'water')
      ON CONFLICT DO NOTHING;
    `);
    // Tavan testi (500 pin): (30.0,40.0) çevresinde 501 yayınlanmış nokta.
    await prisma.$executeRawUnsafe(`
      INSERT INTO locations (id, slug, location_type_id, status, country_code, name, position, rating_count)
      SELECT gen_random_uuid(), 'e2e-trunc-' || gs, 1, 'published', 'TR', 'E2E Trunc ' || gs,
             ST_SetSRID(ST_MakePoint(29.99 + (gs % 20) * 0.001, 39.99 + ((gs / 20) % 20) * 0.001), 4326)::geography,
             gs
      FROM generate_series(1, 501) AS gs
      ON CONFLICT (slug) DO NOTHING;
    `);
  }

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] }).compile();
    app = moduleRef.createNestApplication({ logger: false });
    app.useGlobalFilters(new GlobalProblemFilter());
    app.setGlobalPrefix('v1', { exclude: ['healthz', 'readyz'] });
    await app.init();
    http = app.getHttpServer();
    prisma = app.get(PrismaService);
    await seedFixtures();
  });

  afterAll(async () => {
    await app.close();
  });

  it('bbox anonim erişilir; yalnız yayınlanmış+silinmemiş+kutu-içi pinler', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13')
      .expect(200);
    expect(res.body.truncated).toBe(false);
    const slugsPresent = res.body.locations.map((p: Pin) => p.type);
    // 2 pin: private_marina + fuel_pier (taslak/silinmiş/dışı hariç)
    expect(res.body.locations).toHaveLength(2);
    expect(slugsPresent).toEqual(expect.arrayContaining(['private_marina', 'fuel_pier']));
  });

  it('LocationPin DTO alanları doğru geçer', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13')
      .expect(200);
    const marina = res.body.locations.find((p: Pin) => p.name === 'E2E Göcek Marina');
    expect(marina).toBeDefined();
    expect(marina.type).toBe('private_marina');
    expect(marina.priceTier).toBe('paid');
    expect(marina.ratingAvg).toBeCloseTo(4.8, 2);
    expect(marina.position.lat).toBeCloseTo(36.75, 4);
    expect(marina.position.lon).toBeCloseTo(28.93, 4);
    const fuel = res.body.locations.find((p: Pin) => p.name === 'E2E Göcek Yakıt');
    expect(fuel.ratingAvg).toBeNull();
  });

  it('type filtresi (OR): yalnız fuel_pier', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13&type=fuel_pier')
      .expect(200);
    expect(res.body.locations).toHaveLength(1);
    expect(res.body.locations[0].type).toBe('fuel_pier');
  });

  it('tekrarlı type (OR): private_marina + fuel_pier → 2 pin', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13&type=fuel_pier&type=private_marina')
      .expect(200);
    expect(res.body.locations).toHaveLength(2);
  });

  it('cache başlığı: Cache-Control (120s + SWR)', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13')
      .expect(200);
    expect(res.headers['cache-control']).toContain('max-age=120');
    expect(res.headers['cache-control']).toContain('stale-while-revalidate=600');
  });

  it('500 pin tavanı → truncated=true, tam 500 öğe', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=29.98,39.98,30.02,40.02&zoom=14')
      .expect(200);
    expect(res.body.locations).toHaveLength(500);
    expect(res.body.truncated).toBe(true);
  });

  it('eksik bbox → 422', async () => {
    const res = await request(http).get('/v1/locations?zoom=13').expect(422);
    expect(res.body.errors[0].code).toBe('bbox-required');
  });

  it('bbox çok büyük (>5°) → 422 bbox-too-large', async () => {
    const res = await request(http).get('/v1/locations?bbox=20,30,27,37&zoom=8').expect(422);
    expect(res.body.errors[0].code).toBe('bbox-too-large');
  });

  it('geçersiz bbox (3 değer) → 422 bbox-invalid', async () => {
    const res = await request(http).get('/v1/locations?bbox=1,2,3&zoom=13').expect(422);
    expect(res.body.errors[0].code).toBe('bbox-invalid');
  });

  // --- 3.1b-iii: cluster modu (zoom < 12) ---

  interface ClusterDto {
    position: { lat: number; lon: number };
    count: number;
    bbox: [number, number, number, number];
  }

  it('cluster modu (zoom<12): Göcek 2 nokta → tek balon, locations boş', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=10')
      .expect(200);
    expect(res.body.locations).toEqual([]);
    const clusters: ClusterDto[] = res.body.clusters;
    expect(clusters).toHaveLength(1);
    expect(clusters[0].count).toBe(2);
    expect(clusters[0].bbox).toHaveLength(4);
    expect(clusters[0].position.lat).toBeCloseTo(36.755, 1);
  });

  it('cluster modu: 501 nokta tek balonda toplanır (düşük zoom)', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=29.50,39.50,30.50,40.50&zoom=6')
      .expect(200);
    expect(res.body.locations).toEqual([]);
    const clusters: ClusterDto[] = res.body.clusters;
    expect(clusters).toHaveLength(1);
    expect(clusters[0].count).toBe(501);
  });

  it('zoom ≥ 12 → pin modu (clusters boş)', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=13')
      .expect(200);
    expect(res.body.clusters).toEqual([]);
    expect(res.body.locations).toHaveLength(2);
  });

  it('geçersiz zoom → 422 zoom-invalid', async () => {
    const res = await request(http)
      .get('/v1/locations?bbox=28.90,36.70,29.00,36.80&zoom=abc')
      .expect(422);
    expect(res.body.errors[0].code).toBe('zoom-invalid');
  });

  // --- 3.1b-ii: /locations/nearby ---

  it('nearby: anonim; yarıçap içindeki 2 Göcek lokasyonu, mesafeye göre sıralı', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=10')
      .expect(200);
    const items: LocationSummary[] = res.body.data;
    expect(items.length).toBe(2);
    // Merkez marina noktası → mesafe ~0, ilk sırada
    expect(items[0].name).toBe('E2E Göcek Marina');
    expect(items[0].distanceNm).toBeLessThanOrEqual(items[1].distanceNm);
    expect(items[0].distanceNm).toBeCloseTo(0, 2);
  });

  it('nearby: LocationSummary alanları (mesafe, amenityCodes, coverMedia=null)', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=10')
      .expect(200);
    const marina = res.body.data.find((s: LocationSummary) => s.name === 'E2E Göcek Marina');
    expect(marina.type).toBe('private_marina');
    expect(marina.priceTier).toBe('paid');
    expect(marina.ratingAvg).toBeCloseTo(4.8, 2);
    expect(marina.ratingCount).toBe(100);
    expect(marina.slug).toBe('e2e-gocek-marina');
    expect(marina.coverMedia).toBeNull();
    expect(marina.city).toBeNull();
    expect(marina.waterBodyName).toBeNull();
    expect(marina.amenityCodes).toEqual(['electricity', 'water']);
    expect(typeof marina.distanceNm).toBe('number');
  });

  it('nearby: dar yarıçap yalnız merkezdeki marinayı döndürür', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=0.1')
      .expect(200);
    expect(res.body.data).toHaveLength(1);
    expect(res.body.data[0].name).toBe('E2E Göcek Marina');
  });

  it('nearby: type filtresi (fuel_pier)', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=10&type=fuel_pier')
      .expect(200);
    expect(res.body.data).toHaveLength(1);
    expect(res.body.data[0].type).toBe('fuel_pier');
  });

  it('nearby: limit uygulanır', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=10&limit=1')
      .expect(200);
    expect(res.body.data).toHaveLength(1);
  });

  it('nearby: eksik lat → 422 lat-required', async () => {
    const res = await request(http).get('/v1/locations/nearby?lon=28.93').expect(422);
    expect(res.body.errors[0].code).toBe('lat-required');
  });

  it('nearby: radiusNm > 50 → 422 radius-range', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=100')
      .expect(422);
    expect(res.body.errors[0].code).toBe('radius-range');
  });

  it('nearby: cache başlığı', async () => {
    const res = await request(http)
      .get('/v1/locations/nearby?lat=36.75&lon=28.93&radiusNm=10')
      .expect(200);
    expect(res.headers['cache-control']).toContain('max-age=60');
  });
});
