-- ============================================================================
-- 0006_occupancy — koy doluluk bildirimleri (2026-07 ayrıştırma paketi ①)
--
-- ADDITIVE + GERİYE UYUMLU: yalnız yeni enum + yeni tablo eklenir; mevcut
-- satırlar/veri hiç etkilenmez. Tümü idempotent (IF NOT EXISTS / duplicate
-- yakalama) — aynı SQL Supabase SQL Editor'da elle de güvenle koşturulabilir.
--
-- Model: kullanıcı başına lokasyon başına TEK satır (PK location_id+user_id);
-- yeni bildirim üstüne yazar (ON CONFLICT DO UPDATE, uygulama katmanında).
-- Okumalar yalnız son 6 saatlik pencereye bakar — eski bildirim kendiliğinden
-- geçersizleşir, silme/temizlik işi gerekmez.
-- ============================================================================

DO $$ BEGIN
  CREATE TYPE occupancy_level AS ENUM ('empty', 'moderate', 'full');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE TABLE IF NOT EXISTS location_occupancy_reports (
  location_id uuid NOT NULL REFERENCES locations(id) ON DELETE CASCADE,
  user_id     uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  level       occupancy_level NOT NULL,
  reported_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (location_id, user_id)
);

CREATE INDEX IF NOT EXISTS ix_occupancy_location_time
  ON location_occupancy_reports (location_id, reported_at DESC);

-- RLS (0002_rls deseniyle aynı): kullanıcı bağlamı bildirilmişse yalnız kendi
-- satırına yazabilir; bağlamsız (anonim özet okumaları) serbesttir.
ALTER TABLE location_occupancy_reports ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  CREATE POLICY location_occupancy_reports_owner ON location_occupancy_reports FOR ALL
    USING (app_current_user_id() IS NULL OR user_id = app_current_user_id())
    WITH CHECK (app_current_user_id() IS NULL OR user_id = app_current_user_id());
EXCEPTION WHEN duplicate_object THEN NULL; END $$;
