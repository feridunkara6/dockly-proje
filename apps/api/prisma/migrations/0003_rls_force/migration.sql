-- ============================================================================
-- 0003_rls_force — RLS'i tablo SAHİBİ bağlantısına da uygula (docs/12 §0, Faz A.4)
--
-- 0002_rls politikaları kurdu; bu migration onları tablo sahibi rol için de zorunlu
-- kılar. FORCE olmadan, Prisma tablo sahibi bir rolle bağlanırsa RLS baypaslanır
-- (RLS'in uygulamada "inert" kalmasının bir nedeni buydu).
--
-- OPS ÖNKOŞULU (koddan yapılamaz, docs/12 §0 + security-evidence.md):
--   Üretim/staging'de API, tablo sahibi OLMAYAN ve SÜPERKULLANICI OLMAYAN bir rolle
--   (ör. `dockly_app`) bağlanmalıdır. Süperkullanıcı ve BYPASSRLS rolleri FORCE'a
--   rağmen RLS'i atlar; bu nedenle DATABASE_URL süperkullanıcı olmamalıdır.
--
-- Uygulama tarafı bağlam kurulumu: PrismaService.withUserContext() →
--   set_config('app.user_id', <userId>, true) (transaction-local).
-- ============================================================================

DO $$
DECLARE t text;
BEGIN
  FOREACH t IN ARRAY ARRAY['user_profiles','user_settings','user_devices','user_sessions','boats'] LOOP
    EXECUTE format('ALTER TABLE %I FORCE ROW LEVEL SECURITY', t);
  END LOOP;
END $$;
