import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { ReviewItem } from '../src/modules/locations/domain/location.types';

/** Yorum-listesi ucu uçtan uca — gerçek PostGIS (yalnız CI). */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

runIf('Locations reviews API (e2e — gerçek PostGIS)', () => {
  let app: INestApplication;
  let http: ReturnType<INestApplication['getHttpServer']>;
  let prisma: PrismaService;

  async function seedFixtures(): Promise<void> {
    await prisma.$executeRawUnsafe(`
      INSERT INTO locations (id, slug, location_type_id, status, country_code, name, position, rating_avg, rating_count, price_tier)
      VALUES (gen_random_uuid(), 'e2e-rev-loc', 1, 'published', 'TR', 'E2E Review Marina',
              ST_SetSRID(ST_MakePoint(27.10, 38.40), 4326)::geography, 4.5, 3, 'paid')
      ON CONFLICT (slug) DO NOTHING;
    `);
    await prisma.$executeRawUnsafe(`
      INSERT INTO users (id, firebase_uid, role_id, status, locale, country_code, is_guest)
      VALUES
        (gen_random_uuid(), 'e2e-rev-u1', 1, 'active', 'tr', 'TR', false),
        (gen_random_uuid(), 'e2e-rev-u2', 1, 'active', 'tr', 'TR', false),
        (gen_random_uuid(), 'e2e-rev-u3', 1, 'active', 'tr', 'TR', false),
        (gen_random_uuid(), 'e2e-rev-u4', 1, 'active', 'tr', 'TR', false)
      ON CONFLICT (firebase_uid) DO NOTHING;
    `);
    // u1, u2, u3 profilli; u4 profilsiz (anonim fallback yolunu doğrular).
    await prisma.$executeRawUnsafe(`
      INSERT INTO user_profiles (user_id, display_name)
      SELECT id, 'E2E Kaptan Ali' FROM users WHERE firebase_uid = 'e2e-rev-u1'
      ON CONFLICT (user_id) DO NOTHING;
    `);
    await prisma.$executeRawUnsafe(`
      INSERT INTO user_profiles (user_id, display_name)
      SELECT id, 'E2E Kaptan Veli' FROM users WHERE firebase_uid = 'e2e-rev-u3'
      ON CONFLICT (user_id) DO NOTHING;
    `);
    // Yorumları idempotent kur: önce bu lokasyonunkileri sil, sonra ekle.
    await prisma.$executeRawUnsafe(`
      DELETE FROM reviews WHERE location_id IN (SELECT id FROM locations WHERE slug = 'e2e-rev-loc');
    `);
    await prisma.$executeRawUnsafe(`
      INSERT INTO reviews (id, location_id, user_id, overall_rating, title, body, status, created_at)
      SELECT gen_random_uuid(), l.id, u.id, 5, 'Harika yer', 'Personel çok yardımcı.', 'approved', now() - interval '1 day'
      FROM locations l, users u WHERE l.slug = 'e2e-rev-loc' AND u.firebase_uid = 'e2e-rev-u1';
    `);
    await prisma.$executeRawUnsafe(`
      INSERT INTO reviews (id, location_id, user_id, overall_rating, title, body, status, created_at)
      SELECT gen_random_uuid(), l.id, u.id, 4, 'Profilsiz yorum', 'Sığınak iyi.', 'approved', now() - interval '2 day'
      FROM locations l, users u WHERE l.slug = 'e2e-rev-loc' AND u.firebase_uid = 'e2e-rev-u4';
    `);
    await prisma.$executeRawUnsafe(`
      INSERT INTO reviews (id, location_id, user_id, overall_rating, title, body, status, created_at)
      SELECT gen_random_uuid(), l.id, u.id, 3, 'İyi liman', 'Fena değil.', 'approved', now() - interval '3 day'
      FROM locations l, users u WHERE l.slug = 'e2e-rev-loc' AND u.firebase_uid = 'e2e-rev-u3';
    `);
    // Bekleyen (moderasyon) — görünmemeli.
    await prisma.$executeRawUnsafe(`
      INSERT INTO reviews (id, location_id, user_id, overall_rating, title, body, status, created_at)
      SELECT gen_random_uuid(), l.id, u.id, 2, 'Bekleyen yorum', 'Henüz onaysız.', 'pending', now()
      FROM locations l, users u WHERE l.slug = 'e2e-rev-loc' AND u.firebase_uid = 'e2e-rev-u2';
    `);
    // Onaylı ama silinmiş — görünmemeli.
    await prisma.$executeRawUnsafe(`
      INSERT INTO reviews (id, location_id, user_id, overall_rating, title, body, status, created_at, deleted_at)
      SELECT gen_random_uuid(), l.id, u.id, 1, 'Silinmiş yorum', 'Silindi.', 'approved', now() - interval '4 day', now()
      FROM locations l, users u WHERE l.slug = 'e2e-rev-loc' AND u.firebase_uid = 'e2e-rev-u2';
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

  it('slug ile onaylı+silinmemiş yorumları en yeniden eskiye döndürür', async () => {
    const res = await request(http).get('/v1/locations/e2e-rev-loc/reviews');
    expect(res.status).toBe(200);
    const data = res.body.data as ReviewItem[];
    const titles = data.map((r) => r.title);
    expect(titles).toEqual(['Harika yer', 'Profilsiz yorum', 'İyi liman']);
    expect(titles).not.toContain('Bekleyen yorum');
    expect(titles).not.toContain('Silinmiş yorum');

    const first = data[0];
    expect(first.authorName).toBe('E2E Kaptan Ali');
    expect(first.rating).toBe(5);
    expect(first.body).toBe('Personel çok yardımcı.');
    expect(typeof first.createdAt).toBe('string');
  });

  it('profili olmayan yazar için anonim fallback (Denizci)', async () => {
    const res = await request(http).get('/v1/locations/e2e-rev-loc/reviews');
    const data = res.body.data as ReviewItem[];
    const profilesiz = data.find((r) => r.title === 'Profilsiz yorum');
    expect(profilesiz?.authorName).toBe('Denizci');
  });

  it('limit uygulanır', async () => {
    const res = await request(http).get('/v1/locations/e2e-rev-loc/reviews?limit=1');
    const data = res.body.data as ReviewItem[];
    expect(data).toHaveLength(1);
    expect(data[0].title).toBe('Harika yer');
  });

  it('olmayan lokasyon → boş liste', async () => {
    const res = await request(http).get('/v1/locations/yok-boyle-bir-slug/reviews');
    expect(res.status).toBe(200);
    expect(res.body.data).toEqual([]);
  });
});
