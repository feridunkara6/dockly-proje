-- ============================================================================
-- 0004_contact_types — iletişim tiplerini genişlet (v1.0 rezervasyon modeli)
--
-- ADDITIVE + GERİYE UYUMLU: mevcut enum değerlerine iki yeni değer eklenir;
-- mevcut satırlar/veri hiç etkilenmez. `IF NOT EXISTS` ile idempotent (CI seed'i
-- iki kez koşsa da güvenli).
--   * reservation_link — online rezervasyon linki (web olarak açılır)
--   * emergency        — acil durum telefonu (aranır; rezervasyon başlatmada kullanılmaz)
-- PostgreSQL 12+'da ADD VALUE işlem bloğunda çalışabilir (yeni değer aynı işlemde
-- KULLANILMAZ); CI PostGIS 15 kullanır.
-- ============================================================================

ALTER TYPE contact_type ADD VALUE IF NOT EXISTS 'reservation_link';
ALTER TYPE contact_type ADD VALUE IF NOT EXISTS 'emergency';
