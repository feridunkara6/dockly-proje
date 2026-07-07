-- ============================================================================
-- 0002_rls — Row Level Security (ADR-003, dar kapsam; docs/24 §7 savunma derinliği)
--
-- Desen: politika, oturumda `app.user_id` BİLDİRİLMİŞSE sahiplikle sınırlar;
-- bildirilmemişse (auth altyapı yolları: token-hash araması, kullanıcı upsert'i)
-- erişime izin verir. Böylece kullanıcı-bağlamlı her sorgu yanlışlıkla başka
-- kullanıcının satırına dokunamaz (BOLA hata sınıfına DB seviyesinde fren),
-- altyapı yolları çalışır kalır. Üretimde API, tablo sahibi OLMAYAN `dockly_app`
-- rolüyle bağlanır (rol oluşturma cluster-düzeyi ops adımıdır; CI doğrulaması
-- prisma/tests/rls_validation.sql içindedir).
-- ============================================================================

CREATE OR REPLACE FUNCTION app_current_user_id() RETURNS uuid
LANGUAGE sql STABLE AS $$
  SELECT NULLIF(current_setting('app.user_id', true), '')::uuid
$$;

-- Sahiplik kolonu user_id olan tablolar
DO $$
DECLARE t text;
BEGIN
  FOREACH t IN ARRAY ARRAY['user_profiles','user_settings','user_devices','user_sessions'] LOOP
    EXECUTE format('ALTER TABLE %I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format(
      'CREATE POLICY %I ON %I FOR ALL
         USING (app_current_user_id() IS NULL OR user_id = app_current_user_id())
         WITH CHECK (app_current_user_id() IS NULL OR user_id = app_current_user_id())',
      t || '_owner', t
    );
  END LOOP;
END $$;

-- boats: sahiplik kolonu owner_user_id
ALTER TABLE boats ENABLE ROW LEVEL SECURITY;
CREATE POLICY boats_owner ON boats FOR ALL
  USING (app_current_user_id() IS NULL OR owner_user_id = app_current_user_id())
  WITH CHECK (app_current_user_id() IS NULL OR owner_user_id = app_current_user_id());
