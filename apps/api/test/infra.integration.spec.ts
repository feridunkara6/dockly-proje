import { PrismaService } from '../src/infrastructure/prisma/prisma.service';
import { RedisService } from '../src/infrastructure/redis/redis.service';
import { EnvService } from '../src/config/env.service';

/**
 * Gerçek altyapıya karşı entegrasyon testleri — yalnız CI'da koşar
 * (CI=true + gerçek DATABASE_URL/REDIS_URL servis container'ları; docs/15).
 */
const runIf = process.env.CI === 'true' ? describe : describe.skip;

runIf('Altyapı entegrasyonu (gerçek PostgreSQL + Redis)', () => {
  let prisma: PrismaService;
  let redis: RedisService;

  beforeAll(async () => {
    prisma = new PrismaService();
    await prisma.onModuleInit();
    redis = new RedisService(new EnvService());
  });

  afterAll(async () => {
    await prisma.onModuleDestroy();
    await redis.onModuleDestroy();
  });

  it('PostgreSQL bağlantısı kurulur ve sorgu döner', async () => {
    const rows = await prisma.$queryRaw<Array<{ ok: number }>>`SELECT 1 AS ok`;
    expect(rows[0].ok).toBe(1);
  });

  it('PostGIS aktif ve geography tipi kullanılabilir', async () => {
    const rows = await prisma.$queryRaw<Array<{ d: number }>>`
      SELECT ST_Distance(
        ST_SetSRID(ST_MakePoint(27.5, 36.75), 4326)::geography,
        ST_SetSRID(ST_MakePoint(27.6, 36.75), 4326)::geography
      ) AS d`;
    // ~0.1 derece boylam @36.75N ≈ 8.9 km
    expect(rows[0].d).toBeGreaterThan(8000);
    expect(rows[0].d).toBeLessThan(10000);
  });

  it('seed lookup verileri yerinde (9 lokasyon tipi, 15 amenity)', async () => {
    const rows = await prisma.$queryRaw<Array<{ lt: bigint; am: bigint }>>`
      SELECT (SELECT count(*) FROM location_types) AS lt,
             (SELECT count(*) FROM amenities) AS am`;
    expect(Number(rows[0].lt)).toBe(9);
    expect(Number(rows[0].am)).toBe(15);
  });

  it('Redis ping PONG döner', async () => {
    await expect(redis.ping()).resolves.toBe(true);
  });

  it('Redis yaz/oku/sil turu çalışır', async () => {
    await redis.client.set('itest:key', 'value', 'EX', 10);
    await expect(redis.client.get('itest:key')).resolves.toBe('value');
    await redis.client.del('itest:key');
  });
});
