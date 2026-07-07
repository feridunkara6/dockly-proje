-- ============================================================================
-- Dockly — PostGIS Spatial Doğrulama Paketi (Faz 1 zorunlu kontrolleri)
-- Gerçek PostgreSQL 16 + PostGIS ortamında koşar (CI: postgis/postgis:15-3.4).
-- Kapsam: GIST index kullanımı, ST_DWithin/Distance/Intersects/Contains/
-- MakeEnvelope, bbox/viewport sorguları, nearby sıralaması, performans eşiği.
-- Her doğrulama başarısızlıkta EXCEPTION fırlatır → psql ON_ERROR_STOP CI'ı kırar.
-- ============================================================================
\set ON_ERROR_STOP on

BEGIN;

-- ---------------------------------------------------------------------------
-- 0) Test verisi: Muğla kıyı kutusuna 10.000 sentetik nokta (deterministik)
-- ---------------------------------------------------------------------------
INSERT INTO users (id, firebase_uid) VALUES
  ('00000000-0000-0000-0000-0000000000aa', 'fb_spatial_test')
ON CONFLICT DO NOTHING;

INSERT INTO locations (id, slug, location_type_id, status, country_code, name, position)
SELECT
  gen_random_uuid(),
  'sp-test-' || gs,
  1 + (gs % 9),
  'published',
  'TR',
  'Spatial Test ' || gs,
  ST_SetSRID(ST_MakePoint(
    27.0 + (gs % 100) * 0.02,          -- lon 27.00–28.98
    36.5 + ((gs / 100) % 100) * 0.006  -- lat 36.50–37.09
  ), 4326)::geography
FROM generate_series(1, 10000) AS gs;

ANALYZE locations;

-- ---------------------------------------------------------------------------
-- 1) Geometry/Geography tip doğrulaması
-- ---------------------------------------------------------------------------
DO $$
DECLARE t text;
BEGIN
  SELECT format_type(a.atttypid, a.atttypmod) INTO t
  FROM pg_attribute a JOIN pg_class c ON c.oid = a.attrelid
  WHERE c.relname = 'locations' AND a.attname = 'position';
  IF t NOT LIKE 'geography(Point,4326)%' THEN
    RAISE EXCEPTION 'position tipi beklenen geography(Point,4326) değil: %', t;
  END IF;
  RAISE NOTICE 'OK 1: position = %', t;
END $$;

-- ---------------------------------------------------------------------------
-- 2) GIST index varlığı + index'in bbox sorgusunda KULLANILABİLİR olduğu.
-- Not: 10K satırlık test setinde planlayıcı seq scan'i haklı olarak seçebilir;
-- bu yüzden doğrulama enable_seqscan=off ile "index yolu çalışıyor mu"yu ölçer
-- (planlayıcı tercihi değil, fonksiyonel yetenek testi).
-- ---------------------------------------------------------------------------
SET LOCAL enable_seqscan = off;
DO $$
DECLARE plan json; uses_index boolean;
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_indexes
    WHERE tablename = 'locations' AND indexdef ILIKE '%USING gist%position%'
  ) THEN
    RAISE EXCEPTION 'locations.position üzerinde GIST index yok';
  END IF;

  EXECUTE 'EXPLAIN (FORMAT JSON)
    SELECT id FROM locations
    WHERE deleted_at IS NULL AND status = ''published''
      AND ST_Intersects(position, ST_MakeEnvelope(27.10, 36.55, 27.60, 36.85, 4326)::geography)'
  INTO plan;
  uses_index := plan::text ILIKE '%Index%Scan%';
  IF NOT uses_index THEN
    RAISE EXCEPTION 'bbox sorgusu GIST index kullanamıyor. Plan: %', plan::text;
  END IF;
  RAISE NOTICE 'OK 2: bbox sorgusu index scan kullanabiliyor';
END $$;
SET LOCAL enable_seqscan = on;

-- ---------------------------------------------------------------------------
-- 3) ST_MakeEnvelope viewport sorgusu — sonuç doğruluğu (23 §9.5 sözleşmesi)
-- ---------------------------------------------------------------------------
DO $$
DECLARE n_env int; n_brute int;
BEGIN
  SELECT count(*) INTO n_env FROM locations
  WHERE slug LIKE 'sp-test-%'
    AND ST_Intersects(position, ST_MakeEnvelope(27.10, 36.55, 27.60, 36.85, 4326)::geography);

  SELECT count(*) INTO n_brute FROM locations
  WHERE slug LIKE 'sp-test-%'
    AND ST_X(position::geometry) BETWEEN 27.10 AND 27.60
    AND ST_Y(position::geometry) BETWEEN 36.55 AND 36.85;

  IF n_env = 0 THEN RAISE EXCEPTION 'viewport sorgusu boş döndü'; END IF;
  IF n_env <> n_brute THEN
    RAISE EXCEPTION 'envelope (%) ile brute-force (%) sonuçları uyuşmuyor', n_env, n_brute;
  END IF;
  RAISE NOTICE 'OK 3: viewport % kayıt, brute-force ile birebir', n_env;
END $$;

-- ---------------------------------------------------------------------------
-- 4) ST_DWithin + ST_Distance — nearby sözleşmesi (10 nm yarıçap, mesafe sıralı)
-- ---------------------------------------------------------------------------
DO $$
DECLARE r record; prev double precision := 0; cnt int := 0; radius_m constant double precision := 18520; -- 10 nm
BEGIN
  FOR r IN
    SELECT id, ST_Distance(position, ST_SetSRID(ST_MakePoint(27.5, 36.75), 4326)::geography) AS d
    FROM locations
    WHERE slug LIKE 'sp-test-%'
      AND ST_DWithin(position, ST_SetSRID(ST_MakePoint(27.5, 36.75), 4326)::geography, radius_m)
    ORDER BY d ASC
    LIMIT 50
  LOOP
    cnt := cnt + 1;
    IF r.d < prev THEN RAISE EXCEPTION 'nearby sıralaması bozuk'; END IF;
    IF r.d > radius_m THEN RAISE EXCEPTION 'ST_DWithin yarıçap dışı kayıt döndürdü: % m', r.d; END IF;
    prev := r.d;
  END LOOP;
  IF cnt = 0 THEN RAISE EXCEPTION 'nearby sorgusu boş döndü'; END IF;
  RAISE NOTICE 'OK 4: nearby % kayıt, mesafe artan sırada, hepsi <= 10 nm', cnt;
END $$;

-- ---------------------------------------------------------------------------
-- 5) ST_Contains — poligon içi nokta (water_bodies.boundary senaryosu)
-- ---------------------------------------------------------------------------
DO $$
DECLARE inside boolean; outside boolean;
BEGIN
  SELECT ST_Contains(
    ST_MakeEnvelope(27.0, 36.5, 28.0, 37.0, 4326),
    ST_SetSRID(ST_MakePoint(27.5, 36.75), 4326)
  ) INTO inside;
  SELECT ST_Contains(
    ST_MakeEnvelope(27.0, 36.5, 28.0, 37.0, 4326),
    ST_SetSRID(ST_MakePoint(29.5, 36.75), 4326)
  ) INTO outside;
  IF NOT inside OR outside THEN RAISE EXCEPTION 'ST_Contains doğrulaması başarısız'; END IF;
  RAISE NOTICE 'OK 5: ST_Contains içi/dışı doğru ayırıyor';
END $$;

-- ---------------------------------------------------------------------------
-- 6) Cluster read-model temeli — ST_SnapToGrid aggregate (zoom<12, 24 §9)
-- ---------------------------------------------------------------------------
DO $$
DECLARE n int; total bigint;
BEGIN
  SELECT count(*), sum(cnt) INTO n, total FROM (
    SELECT ST_SnapToGrid(position::geometry, 0.1, 0.1) AS cell, count(*) AS cnt
    FROM locations
    WHERE slug LIKE 'sp-test-%'
      AND ST_Intersects(position, ST_MakeEnvelope(27.0, 36.5, 29.0, 37.1, 4326)::geography)
    GROUP BY 1
  ) g;
  IF n = 0 OR total <> 10000 THEN
    RAISE EXCEPTION 'cluster aggregate hatalı: % hücre, % toplam (10000 bekleniyordu)', n, total;
  END IF;
  RAISE NOTICE 'OK 6: cluster aggregate — % hücre, % nokta', n, total;
END $$;

-- ---------------------------------------------------------------------------
-- 7) Performans eşiği: 10K nokta üzerinde bbox sorgusu < 50 ms (CI donanımında)
--    (14-performans bütçesinin DB payı; API p95 250 ms hedefinin güvenli dilimi)
-- ---------------------------------------------------------------------------
DO $$
DECLARE t0 timestamptz; t1 timestamptz; ms double precision; i int;
BEGIN
  -- ısınma
  PERFORM count(*) FROM locations
   WHERE ST_Intersects(position, ST_MakeEnvelope(27.1, 36.55, 27.9, 36.95, 4326)::geography);
  t0 := clock_timestamp();
  FOR i IN 1..20 LOOP
    PERFORM id FROM locations
     WHERE deleted_at IS NULL AND status = 'published'
       AND ST_Intersects(position, ST_MakeEnvelope(27.1, 36.55, 27.9, 36.95, 4326)::geography)
     LIMIT 500;
  END LOOP;
  t1 := clock_timestamp();
  ms := extract(epoch FROM (t1 - t0)) * 1000 / 20;
  IF ms > 50 THEN
    RAISE EXCEPTION 'bbox sorgu ortalaması % ms — 50 ms eşiği aşıldı', round(ms::numeric, 1);
  END IF;
  RAISE NOTICE 'OK 7: bbox ortalama % ms (eşik 50 ms)', round(ms::numeric, 1);
END $$;

ROLLBACK;  -- test verisi kalıcı olmaz
\echo 'SPATIAL VALIDATION: ALL OK'
