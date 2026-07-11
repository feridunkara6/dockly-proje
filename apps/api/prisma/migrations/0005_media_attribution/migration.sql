-- ============================================================================
-- 0005_media_attribution — dış (CC / Wikimedia Commons) kapak görselleri + atıf
--
-- ADDITIVE + GERİYE UYUMLU: media tablosuna yalnız yeni NULLABLE sütunlar eklenir;
-- mevcut satırlar/veri hiç etkilenmez. `IF NOT EXISTS` ile idempotent (CI migrate
-- deploy tek kez koşar; yine de güvenli).
--   * external_url — barındırılan CDN yerine dış görsel URL'i (ör. upload.wikimedia.org)
--   * credit       — fotoğrafçı/atıf metni (CC lisansı zorunlu kılar)
--   * license_code — lisans kısa kodu (ör. 'CC BY-SA 4.0')
--   * source_url   — kaynak sayfa (ör. Commons dosya sayfası)
-- ============================================================================

ALTER TABLE media ADD COLUMN IF NOT EXISTS external_url text;
ALTER TABLE media ADD COLUMN IF NOT EXISTS credit text;
ALTER TABLE media ADD COLUMN IF NOT EXISTS license_code text;
ALTER TABLE media ADD COLUMN IF NOT EXISTS source_url text;
