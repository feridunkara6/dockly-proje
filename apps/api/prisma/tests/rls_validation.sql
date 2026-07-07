-- ============================================================================
-- RLS Doğrulama Paketi (ADR-003) — CI'da gerçek, tablo sahibi OLMAYAN rolle koşar.
-- Kapsam: bağlam bildirilince izolasyon; bağlamsız altyapı yolu; çapraz yazma engeli.
-- ============================================================================
\set ON_ERROR_STOP on

-- 0) Uygulama rolü (idempotent) + yetkiler — süperkullanıcı olarak
DO $$
BEGIN
  CREATE ROLE dockly_app LOGIN PASSWORD 'dockly_app_ci';
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
GRANT USAGE ON SCHEMA public TO dockly_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_profiles, user_settings, user_devices, user_sessions, boats TO dockly_app;
GRANT SELECT ON users, roles, boat_types, engine_types TO dockly_app;

-- 1) Test verisi (temizle + kur)
DELETE FROM user_sessions WHERE user_id IN (SELECT id FROM users WHERE firebase_uid LIKE 'rls-test-%');
DELETE FROM user_profiles WHERE user_id IN (SELECT id FROM users WHERE firebase_uid LIKE 'rls-test-%');
DELETE FROM users WHERE firebase_uid LIKE 'rls-test-%';
INSERT INTO users (id, firebase_uid) VALUES
  ('00000000-0000-7000-8000-00000000aaaa', 'rls-test-a'),
  ('00000000-0000-7000-8000-00000000bbbb', 'rls-test-b');
INSERT INTO user_profiles (user_id, display_name) VALUES
  ('00000000-0000-7000-8000-00000000aaaa', 'Kaptan A'),
  ('00000000-0000-7000-8000-00000000bbbb', 'Kaptan B');
INSERT INTO user_sessions (id, user_id, family_id, token_hash, expires_at) VALUES
  (gen_random_uuid(), '00000000-0000-7000-8000-00000000aaaa', gen_random_uuid(), 'rls_hash_a', now() + interval '1 day'),
  (gen_random_uuid(), '00000000-0000-7000-8000-00000000bbbb', gen_random_uuid(), 'rls_hash_b', now() + interval '1 day');

-- 2) Uygulama rolüne geç (tablo sahibi DEĞİL → RLS zorunlu)
\connect "postgresql://dockly_app:dockly_app_ci@localhost:5432/dockly_test"

-- 2a) Bağlam A → yalnız A'nın satırları görünür
SET app.user_id = '00000000-0000-7000-8000-00000000aaaa';
DO $$
DECLARE others int; mine int;
BEGIN
  SELECT count(*) INTO others FROM user_profiles WHERE user_id <> app_current_user_id();
  SELECT count(*) INTO mine FROM user_profiles WHERE user_id = app_current_user_id();
  IF others <> 0 THEN RAISE EXCEPTION 'RLS ihlali: başka kullanıcının profili görünüyor (%)', others; END IF;
  IF mine <> 1 THEN RAISE EXCEPTION 'RLS hatası: kendi profili görünmüyor'; END IF;
  RAISE NOTICE 'OK RLS-1: profil izolasyonu';
END $$;

DO $$
DECLARE others int;
BEGIN
  SELECT count(*) INTO others FROM user_sessions WHERE token_hash = 'rls_hash_b';
  IF others <> 0 THEN RAISE EXCEPTION 'RLS ihlali: başka kullanıcının oturumu görünüyor'; END IF;
  RAISE NOTICE 'OK RLS-2: oturum izolasyonu';
END $$;

-- 2b) Çapraz YAZMA engeli: A bağlamıyla B'nin profili güncellenemez (0 satır)
DO $$
DECLARE affected int;
BEGIN
  UPDATE user_profiles SET display_name = 'Hacklendi'
   WHERE user_id = '00000000-0000-7000-8000-00000000bbbb';
  GET DIAGNOSTICS affected = ROW_COUNT;
  IF affected <> 0 THEN RAISE EXCEPTION 'RLS ihlali: çapraz güncelleme başarılı oldu'; END IF;
  RAISE NOTICE 'OK RLS-3: çapraz yazma engellendi';
END $$;

-- 2c) Çapraz EKLEME engeli (WITH CHECK): A bağlamıyla B adına satır eklenemez
DO $$
BEGIN
  BEGIN
    INSERT INTO user_devices (user_id, fcm_token)
    VALUES ('00000000-0000-7000-8000-00000000bbbb', 'rls-forged-token');
    RAISE EXCEPTION 'RLS ihlali: çapraz insert kabul edildi';
  EXCEPTION WHEN insufficient_privilege OR check_violation THEN
    RAISE NOTICE 'OK RLS-4: çapraz insert engellendi';
  END;
END $$;

-- 2d) Bağlamsız altyapı yolu (auth deseni): token-hash araması çalışmalı
RESET app.user_id;
DO $$
DECLARE hits int;
BEGIN
  SELECT count(*) INTO hits FROM user_sessions WHERE token_hash = 'rls_hash_b';
  IF hits <> 1 THEN RAISE EXCEPTION 'RLS hatası: bağlamsız altyapı yolu kırıldı'; END IF;
  RAISE NOTICE 'OK RLS-5: bağlamsız altyapı yolu çalışıyor (ADR-003 deseni)';
END $$;

-- 3) Temizlik — süperkullanıcıya dön
\connect "postgresql://dockly:dockly@localhost:5432/dockly_test"
DELETE FROM user_sessions WHERE token_hash LIKE 'rls_hash_%';
DELETE FROM user_profiles WHERE user_id IN (SELECT id FROM users WHERE firebase_uid LIKE 'rls-test-%');
DELETE FROM users WHERE firebase_uid LIKE 'rls-test-%';
\echo 'RLS VALIDATION: ALL OK'
