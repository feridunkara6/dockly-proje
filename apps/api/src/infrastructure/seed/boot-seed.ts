import { readFileSync } from 'fs';
import { dirname, join } from 'path';
import { Client } from 'pg';

/**
 * Açılışta içerik seed'i (SEED_ON_BOOT=true iken).
 *
 * Neden: CI, seed'i yalnız KENDİ geçici veritabanında koşar; canlı (Render)
 * veritabanı repo'daki yeni veri partilerini görmez. Seed tamamen idempotent
 * (ON CONFLICT DO NOTHING) olduğu için her açılışta güvenle uygulanabilir —
 * böylece "içerik = kod": yeni lokasyon partisi push'la birlikte canlıya iner.
 */

/** psql `\ir dosya.sql` include yönergelerini dosya içeriğiyle satır-içi açar. */
export function inlinePsqlIncludes(
  sql: string,
  baseDir: string,
  read: (path: string) => string = (p) => readFileSync(p, 'utf8'),
): string {
  return sql
    .split('\n')
    .map((line) => {
      const match = /^\\ir\s+(.+)$/.exec(line.trim());
      return match ? read(join(baseDir, match[1].trim())) : line;
    })
    .join('\n');
}

/** Seed dosyasını (include'ları açarak) tek toplu sorguda uygular. */
export async function runBootSeed(databaseUrl: string, seedPath: string): Promise<void> {
  const sql = inlinePsqlIncludes(readFileSync(seedPath, 'utf8'), dirname(seedPath));
  const client = new Client({ connectionString: databaseUrl });
  await client.connect();
  try {
    // pg basit-sorgu protokolü çok-ifadeli metni tek örtük işlemde çalıştırır.
    await client.query(sql);
  } finally {
    await client.end();
  }
}
