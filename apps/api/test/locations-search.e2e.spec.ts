import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { LocationSummary } from '../src/modules/locations/domain/location.types';

/** Metin-arama ucu uçtan uca — gerçek PostGIS (yalnız CI). */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

/** Seed gerçek marinaları da içerir; yalnız bu testin fixture'larına bak. */
function onlyE2E(items: LocationSummary[]): LocationSummary[] {
  return items.filter((i) => i.name.startsWith('E2E Search'));
}

/** slug'a göre öğeyi bulur; yoksa testi net bir mesajla düşürür. */
function bySlug(items: LocationSummary[], slug: string): LocationSummary {
  const found = items.find((i) => i.slug === slug);
  if (!found) throw new Error(`fixture bulunamadı: ${slug}`);
  return found;
}

runIf('Locations search API (e2e — gerçek PostGIS)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;
  let prisma: PrismaService;

  async function seedFixtures(): Promise<void> {
    // 2 yayınlanmış (marina + fuel), 1 taslak, 1 silinmiş — hepsi 'Alfa' içerir.
    await prisma.$executeRawUnsafe(`
      INSERT INTO locations (id, slug, location_type_id, status, country_code, name, position, rating_avg, rating_count, price_tier)
      VALUES
        (gen_random_uuid(), 'e2e-search-marina', 1, 'published', 'TR', 'E2E Search Alfa Marina',
         ST_SetSRID(ST_MakePoint(28.10, 36.10), 4326)::geography, 4.5, 50, 'paid'),
        (gen_random_uuid(), 'e2e-search-fuel', 6, 'published', 'TR', 'E2E Search Alfa Yakit',
         ST_SetSRID(ST_MakePoint(28.20, 36.20), 4326)::geography, NULL, 3, 'unknown'),
        (gen_random_uuid(), 'e2e-search-draft', 1, 'draft', 'TR', 'E2E Search Alfa Taslak',
         ST_SetSRID(ST_MakePoint(28.30, 36.30), 4326)::geography, NULL, 0, 'unknown'),
        (gen_random_uuid(), 'e2e-search-deleted', 1, 'published', 'TR', 'E2E Search Alfa Silinmis',
         ST_SetSRID(ST_MakePoint(28.40, 36.40), 4326)::geography, NULL, 0, 'unknown')
      ON CONFLICT (slug) DO NOTHING;
    `);
    await prisma.$executeRawUnsafe(`
      UPDATE locations SET deleted_at = now() WHERE slug = 'e2e-search-deleted';
    `);
    // Marina'ya tekne boyut limitleri (özet projeksiyonunu doğrular).
    await prisma.$executeRawUnsafe(`
      UPDATE locations SET max_boat_length_m = 40, max_draft_m = 5 WHERE slug = 'e2e-search-marina';
    `);
    // Marina'ya olanaklar bağla (amenityCodes yolunu doğrular).
    await prisma.$executeRawUnsafe(`
      INSERT INTO location_amenities (location_id, amenity_id)
      SELECT l.id, a.id FROM locations l, amenities a
      WHERE l.slug = 'e2e-search-marina' AND a.code IN ('electricity', 'water')
      ON CONFLICT DO NOTHING;
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

  it('ada göre arama: yalnız yayınlanmış+silinmemiş; önem sırası; özet alanları', async () => {
    const res = await request(http).get('/v1/locations/search?q=Alfa');
    expect(res.status).toBe(200);
    const items = onlyE2E(res.body.data as LocationSummary[]);
    const slugs = items.map((i) => i.slug);
    expect(slugs).toContain('e2e-search-marina');
    expect(slugs).toContain('e2e-search-fuel');
    expect(slugs).not.toContain('e2e-search-draft');
    expect(slugs).not.toContain('e2e-search-deleted');
    // rating_count DESC → marina (50) fuel'den (3) önce.
    expect(slugs.indexOf('e2e-search-marina')).toBeLessThan(slugs.indexOf('e2e-search-fuel'));
    const marina = bySlug(items, 'e2e-search-marina');
    expect(marina.distanceNm).toBe(0);
    expect([...marina.amenityCodes].sort()).toEqual(['electricity', 'water']);
    expect(marina.ratingAvg).toBe(4.5);
    expect(marina.maxBoatLengthM).toBe(40);
    expect(marina.maxDraftM).toBe(5);
    const fuel = bySlug(items, 'e2e-search-fuel');
    expect(fuel.ratingAvg).toBeNull();
    expect(fuel.amenityCodes).toEqual([]);
  });

  it('tür filtresi sonuçları daraltır', async () => {
    const all = onlyE2E(
      (await request(http).get('/v1/locations/search?q=Alfa')).body.data as LocationSummary[],
    );
    const marinaType = bySlug(all, 'e2e-search-marina').type;
    const res = await request(http).get(`/v1/locations/search?q=Alfa&type=${marinaType}`);
    const slugs = onlyE2E(res.body.data as LocationSummary[]).map((i) => i.slug);
    expect(slugs).toContain('e2e-search-marina');
    expect(slugs).not.toContain('e2e-search-fuel');
  });

  it('kısa q → boş sonuç (422 değil)', async () => {
    const res = await request(http).get('/v1/locations/search?q=a');
    expect(res.status).toBe(200);
    expect(res.body.data).toEqual([]);
  });

  it('eşleşme yoksa boş sonuç', async () => {
    const res = await request(http).get('/v1/locations/search?q=zzznomatchqq');
    expect(res.status).toBe(200);
    expect(onlyE2E(res.body.data as LocationSummary[])).toEqual([]);
  });

  it('olanak filtresi (AND): electricity+water → yalnız marina', async () => {
    const res = await request(http).get(
      '/v1/locations/search?q=Alfa&amenity=electricity&amenity=water',
    );
    expect(res.status).toBe(200);
    const slugs = onlyE2E(res.body.data as LocationSummary[]).map((i) => i.slug);
    expect(slugs).toEqual(['e2e-search-marina']);
  });

  it('karşılanamayan olanak (fuel) → fixture eşleşmez', async () => {
    const res = await request(http).get('/v1/locations/search?q=Alfa&amenity=fuel');
    expect(res.status).toBe(200);
    expect(onlyE2E(res.body.data as LocationSummary[])).toHaveLength(0);
  });

  it('yalnız olanakla keşif (q YOK): marina listelenir', async () => {
    const res = await request(http).get(
      '/v1/locations/search?amenity=electricity&amenity=water&limit=50',
    );
    expect(res.status).toBe(200);
    const slugs = (res.body.data as LocationSummary[]).map((i) => i.slug);
    expect(slugs).toContain('e2e-search-marina');
  });

});
