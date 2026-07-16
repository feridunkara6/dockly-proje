-- ============================================================================
-- 0007_wind_exposure — koyların/limanların rüzgâra açık yönleri (uyarı rozeti)
--
-- ADDITIVE + GERİYE UYUMLU: locations'a tek NULLABLE sütun eklenir; mevcut
-- satırlar etkilenmez. IF NOT EXISTS ile idempotent — aynı SQL Supabase SQL
-- Editor'da elle de güvenle koşturulabilir.
-- Değer biçimi: TR pusula kodlarıyla virgüllü liste (ör. 'G,GD' = güney ve
-- güneydoğuya açık). Kaynak: açıklamalardaki doğrulanmış, elle onaylı ifadeler.
-- ============================================================================

ALTER TABLE locations ADD COLUMN IF NOT EXISTS wind_exposed_dirs text;
