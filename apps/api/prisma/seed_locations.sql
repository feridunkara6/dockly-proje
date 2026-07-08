-- =========================================================================
-- Dockly — Gerçek lokasyon verisi (Faz 5 veri edinimi)
-- Parti: 5.1-marinas · Toplama: 2026-07-07
-- Kaynak ve güven bilgisi: prisma/data/batch1_marinas.json (provenance)
-- Bu dosya generate_locations_seed.py ile üretilir; ELLE DÜZENLEME.
-- Tamamen idempotent: CI seed'i iki kez koşar (ON CONFLICT DO NOTHING).
-- =========================================================================

-- --- İdari alanlar (il/ilçe) ---
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'İstanbul', 'istanbul')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Yalova', 'yalova')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Balıkesir', 'balikesir')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'İzmir', 'izmir')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Aydın', 'aydin')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Muğla', 'mugla')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Antalya', 'antalya')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Mersin', 'mersin')
ON CONFLICT (country_code, level, slug) DO NOTHING;

INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Kadıköy', 'istanbul-kadikoy'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Bakırköy', 'istanbul-bakirkoy'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Tuzla', 'istanbul-tuzla'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Beylikdüzü', 'istanbul-beylikduzu'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Pendik', 'istanbul-pendik'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Merkez', 'yalova-merkez'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'yalova'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Ayvalık', 'balikesir-ayvalik'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'balikesir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Çeşme', 'izmir-cesme'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Seferihisar', 'izmir-seferihisar'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Kuşadası', 'aydin-kusadasi'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'aydin'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Didim', 'aydin-didim'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'aydin'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Marmaris', 'mugla-marmaris'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Fethiye', 'mugla-fethiye'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Bodrum', 'mugla-bodrum'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Köyceğiz', 'mugla-koycegiz'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Milas', 'mugla-milas'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Finike', 'antalya-finike'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Konyaaltı', 'antalya-konyaalti'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Kaş', 'antalya-kas'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Kemer', 'antalya-kemer'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Alanya', 'antalya-alanya'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Yenişehir', 'mersin-yenisehir'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mersin'
ON CONFLICT (country_code, level, slug) DO NOTHING;

-- --- Setur Kalamış & Fenerbahçe Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-kalamis-fenerbahce-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-kadikoy'),
  'Setur Kalamış & Fenerbahçe Marina', 'İstanbul Kadıköy''de yer alan marina 1.278 deniz ve 220 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(29.0358, 40.9769), 4326)::geography,
  65, NULL, NULL, 6.5,
  1278, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Kalamış & Fenerbahçe Marina', 'İstanbul Kadıköy''de yer alan marina 1.278 deniz ve 220 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-kalamis-fenerbahce-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 1278, '72/16', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-kalamis-fenerbahce-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-kalamis-fenerbahce-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-kalamis-fenerbahce-marina' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902163462346', NULL, true
FROM locations l WHERE l.slug = 'setur-kalamis-fenerbahce-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'kalamis@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-kalamis-fenerbahce-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/kalamis-fenerbahce', NULL, false
FROM locations l WHERE l.slug = 'setur-kalamis-fenerbahce-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Yalova Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-yalova-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'yalova-merkez'),
  'Setur Yalova Marina', 'Yalova merkez sahilinde yer alan marina 225 deniz ve 70 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(29.2745, 40.6614), 4326)::geography,
  40, NULL, NULL, 5,
  225, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Yalova Marina', 'Yalova merkez sahilinde yer alan marina 225 deniz ve 70 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-yalova-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 225, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-yalova-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-yalova-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-yalova-marina' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902268131919', NULL, true
FROM locations l WHERE l.slug = 'setur-yalova-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'yalova@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-yalova-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/yalova', NULL, false
FROM locations l WHERE l.slug = 'setur-yalova-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Ayvalık Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-ayvalik-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Setur Ayvalık Marina', 'Ayvalık ilçe merkezinde yer alan marina 200 deniz ve 30 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(26.688, 39.3141), 4326)::geography,
  40, NULL, NULL, 4.7,
  200, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Ayvalık Marina', 'Ayvalık ilçe merkezinde yer alan marina 200 deniz ve 30 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-ayvalik-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 200, '73/16', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-ayvalik-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-ayvalik-marina' AND a.code IN ('fuel', 'wifi', 'wc', 'shower', 'security', 'market', 'restaurant', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-ayvalik-marina' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902663122696', NULL, true
FROM locations l WHERE l.slug = 'setur-ayvalik-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'ayvalik@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-ayvalik-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/ayvalik', NULL, false
FROM locations l WHERE l.slug = 'setur-ayvalik-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Çeşme Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-cesme-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Setur Çeşme Marina', 'Çeşme Altınyunus mevkiinde yer alan marina 186 deniz ve 60 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(26.3456, 38.3237), 4326)::geography,
  45, NULL, NULL, 5.5,
  186, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Çeşme Marina', 'Çeşme Altınyunus mevkiinde yer alan marina 186 deniz ve 60 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-cesme-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 186, '73/16', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-cesme-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-cesme-marina' AND a.code IN ('water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-cesme-marina' AND sv.code IN ('mooring_assist', 'boat_wash')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902327231434', NULL, true
FROM locations l WHERE l.slug = 'setur-cesme-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'cesme@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-cesme-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/cesme', NULL, false
FROM locations l WHERE l.slug = 'setur-cesme-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Kuşadası Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-kusadasi-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'aydin-kusadasi'),
  'Setur Kuşadası Marina', 'Kuşadası ilçe merkezinde yer alan marina 557 deniz ve 100 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(27.2605, 37.8685), 4326)::geography,
  90, NULL, NULL, 5,
  557, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Kuşadası Marina', 'Kuşadası ilçe merkezinde yer alan marina 557 deniz ve 100 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-kusadasi-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 557, '73/16', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-kusadasi-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-kusadasi-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'laundry', 'restaurant', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-kusadasi-marina' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902566181460', NULL, true
FROM locations l WHERE l.slug = 'setur-kusadasi-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'kusadasi@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-kusadasi-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/kusadasi', NULL, false
FROM locations l WHERE l.slug = 'setur-kusadasi-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Netsel Marmaris Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'netsel-marmaris-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Netsel Marmaris Marina', 'Marmaris ilçe merkezinde yer alan marina 701 tekne kapasiteli deniz bağlama alanına sahiptir. Setur Marinas bünyesinde işletilmektedir.',
  ST_SetSRID(ST_MakePoint(28.2772, 36.8506), 4326)::geography,
  90, NULL, 3.5, 18,
  701, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Netsel Marmaris Marina', 'Marmaris ilçe merkezinde yer alan marina 701 tekne kapasiteli deniz bağlama alanına sahiptir. Setur Marinas bünyesinde işletilmektedir.' FROM locations WHERE slug = 'netsel-marmaris-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 701, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'netsel-marmaris-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'netsel-marmaris-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'market', 'laundry', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'netsel-marmaris-marina' AND sv.code IN ('mooring_assist', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524122708', NULL, true
FROM locations l WHERE l.slug = 'netsel-marmaris-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@netselmarina.com', NULL, false
FROM locations l WHERE l.slug = 'netsel-marmaris-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/netsel-marmaris', NULL, false
FROM locations l WHERE l.slug = 'netsel-marmaris-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Finike Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-finike-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-finike'),
  'Setur Finike Marina', 'Finike ilçe merkezinde yer alan marina 284 deniz ve 100 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(30.1526, 36.2947), 4326)::geography,
  35, NULL, NULL, 4.5,
  284, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Finike Marina', 'Finike ilçe merkezinde yer alan marina 284 deniz ve 100 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-finike-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 284, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-finike-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-finike-marina' AND a.code IN ('electricity', 'water', 'wifi', 'wc', 'shower', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-finike-marina' AND sv.code IN ('mooring_assist', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902428555030', NULL, true
FROM locations l WHERE l.slug = 'setur-finike-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'finike@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-finike-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/finike', NULL, false
FROM locations l WHERE l.slug = 'setur-finike-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Antalya Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-antalya-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-konyaalti'),
  'Setur Antalya Marina', 'Antalya Konyaaltı''nda Büyük Liman mevkiinde yer alan marina 198 deniz ve 150 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(30.6148, 36.8348), 4326)::geography,
  90, NULL, NULL, 5.5,
  198, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Antalya Marina', 'Antalya Konyaaltı''nda Büyük Liman mevkiinde yer alan marina 198 deniz ve 150 kara kapasitesine sahiptir. Setur Marinas tarafından işletilmektedir.' FROM locations WHERE slug = 'setur-antalya-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 198, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-antalya-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-antalya-marina' AND a.code IN ('electricity', 'water', 'wifi', 'wc', 'shower', 'security', 'market', 'restaurant', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-antalya-marina' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902422593259', NULL, true
FROM locations l WHERE l.slug = 'setur-antalya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'antalya@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-antalya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/antalya', NULL, false
FROM locations l WHERE l.slug = 'setur-antalya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Kaş Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-kas-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-kas'),
  'Setur Kaş Marina', 'Kaş Bucak Denizi''nde yer alan marina 447 deniz ve 120 kara kapasitesine sahiptir. Setur Marinas bünyesinde Makmarin Kaş Marina adıyla işletilmektedir.',
  ST_SetSRID(ST_MakePoint(29.6242, 36.2053), 4326)::geography,
  120, NULL, NULL, 30,
  447, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Kaş Marina', 'Kaş Bucak Denizi''nde yer alan marina 447 deniz ve 120 kara kapasitesine sahiptir. Setur Marinas bünyesinde Makmarin Kaş Marina adıyla işletilmektedir.' FROM locations WHERE slug = 'setur-kas-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 447, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'setur-kas-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-kas-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'market', 'laundry', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-kas-marina' AND sv.code IN ('mooring_assist', 'boat_wash', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902428363700', NULL, true
FROM locations l WHERE l.slug = 'setur-kas-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@kasmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'setur-kas-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/makmarin-kas', NULL, false
FROM locations l WHERE l.slug = 'setur-kas-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mersin Marina · güven: low · kaynak: en.wikipedia.org, marinalar.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mersin-marina', 1, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-yenisehir'),
  'Mersin Marina', 'Mersin Yenişehir''de yer alan marina, Mersin Yat Limanı İşletmeleri A.Ş. tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(34.5707, 36.77), 4326)::geography,
  40, NULL, NULL, NULL,
  500, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mersin Marina', 'Mersin Yenişehir''de yer alan marina, Mersin Yat Limanı İşletmeleri A.Ş. tarafından işletilmektedir.' FROM locations WHERE slug = 'mersin-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 500, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'mersin-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'mersin-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'laundry', 'restaurant', 'travel_lift', 'crane', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'mersin-marina' AND sv.code IN ('diver', 'technical_service', 'crane')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+903243300300', NULL, true
FROM locations l WHERE l.slug = 'mersin-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@mersinmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'mersin-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.mersinmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'mersin-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- D-Marin Göcek · güven: high · kaynak: www.d-marin.com, www.d-marin.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'd-marin-gocek', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'D-Marin Göcek', 'Fethiye''nin Göcek mahallesinde yer alan marina 380 deniz bağlama ve 150 tekne kara park kapasitesine sahiptir. D-Marin tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(28.9428, 36.7483), 4326)::geography,
  70, NULL, NULL, NULL,
  380, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'D-Marin Göcek', 'Fethiye''nin Göcek mahallesinde yer alan marina 380 deniz bağlama ve 150 tekne kara park kapasitesine sahiptir. D-Marin tarafından işletilmektedir.' FROM locations WHERE slug = 'd-marin-gocek'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 380, '73', NULL, NULL, true
FROM locations WHERE slug = 'd-marin-gocek'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'd-marin-gocek' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'laundry', 'travel_lift', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'd-marin-gocek' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.d-marin.com/en/marinas/gocek/', NULL, false
FROM locations l WHERE l.slug = 'd-marin-gocek'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- D-Marin Turgutreis · güven: high · kaynak: www.d-marin.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'd-marin-turgutreis', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'D-Marin Turgutreis', 'Bodrum Turgutreis''te yer alan marina 532 deniz bağlama ve 150 çekek (kara) kapasitesine sahiptir. D-Marin tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(27.2561, 37.0019), 4326)::geography,
  75, NULL, NULL, NULL,
  532, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'D-Marin Turgutreis', 'Bodrum Turgutreis''te yer alan marina 532 deniz bağlama ve 150 çekek (kara) kapasitesine sahiptir. D-Marin tarafından işletilmektedir.' FROM locations WHERE slug = 'd-marin-turgutreis'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 532, '72', NULL, NULL, true
FROM locations WHERE slug = 'd-marin-turgutreis'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'd-marin-turgutreis' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'laundry', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'd-marin-turgutreis' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.d-marin.com/en/marinas/turgutreis/', NULL, false
FROM locations l WHERE l.slug = 'd-marin-turgutreis'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- D-Marin Didim · güven: high · kaynak: www.d-marin.com, www.dockwalk.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'd-marin-didim', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'aydin-didim'),
  'D-Marin Didim', 'Didim''de yer alan marina, 90''ı süperyat olmak üzere 591 deniz bağlama kapasitesine sahiptir. D-Marin tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(27.2594, 37.3406), 4326)::geography,
  70, 6, NULL, NULL,
  591, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'D-Marin Didim', 'Didim''de yer alan marina, 90''ı süperyat olmak üzere 591 deniz bağlama kapasitesine sahiptir. D-Marin tarafından işletilmektedir.' FROM locations WHERE slug = 'd-marin-didim'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 591, '16/72', NULL, NULL, true
FROM locations WHERE slug = 'd-marin-didim'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'd-marin-didim' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'wc', 'shower', 'security', 'laundry', 'restaurant', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'd-marin-didim' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'technical_service', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.d-marin.com/en/marinas/didim/', NULL, false
FROM locations l WHERE l.slug = 'd-marin-didim'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Yalıkavak Marina · güven: high · kaynak: yalikavakmarina.com.tr, www.globalgoldanchor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yalikavak-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Yalıkavak Marina', 'Bodrum Yalıkavak''ta yer alan 620 yat kapasiteli marina; daha önce Palmarina adıyla hizmet veren tesis Yalıkavak Marina adını almıştır.',
  ST_SetSRID(ST_MakePoint(27.2855, 37.105), 4326)::geography,
  140, NULL, NULL, NULL,
  620, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yalıkavak Marina', 'Bodrum Yalıkavak''ta yer alan 620 yat kapasiteli marina; daha önce Palmarina adıyla hizmet veren tesis Yalıkavak Marina adını almıştır.' FROM locations WHERE slug = 'yalikavak-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 620, '72', NULL, 260, NULL
FROM locations WHERE slug = 'yalikavak-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yalikavak-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'wc', 'pump_out', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'yalikavak-marina' AND sv.code IN ('mooring_assist', 'technical_service', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902523110600', NULL, true
FROM locations l WHERE l.slug = 'yalikavak-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@yalikavakmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'yalikavak-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://yalikavakmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'yalikavak-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/yalikavakmarina/', NULL, false
FROM locations l WHERE l.slug = 'yalikavak-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'facebook', 'https://www.facebook.com/yalikavakmarina/', NULL, false
FROM locations l WHERE l.slug = 'yalikavak-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Milta Bodrum Marina · güven: medium · kaynak: gotosailing.com, www.globalgoldanchor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'milta-bodrum-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Milta Bodrum Marina', 'Bodrum kent merkezinde yer alan marina Doğan Holding bünyesinde işletilmektedir. Mavi Bayrak ve 5 Altın Çıpa ödüllerine sahiptir.',
  ST_SetSRID(ST_MakePoint(27.4262, 37.0345), 4326)::geography,
  70, 7, NULL, NULL,
  425, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Milta Bodrum Marina', 'Bodrum kent merkezinde yer alan marina Doğan Holding bünyesinde işletilmektedir. Mavi Bayrak ve 5 Altın Çıpa ödüllerine sahiptir.' FROM locations WHERE slug = 'milta-bodrum-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 425, '73', true, 70, NULL
FROM locations WHERE slug = 'milta-bodrum-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'milta-bodrum-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'wc', 'pump_out', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'milta-bodrum-marina' AND sv.code IN ('technical_service', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902523161860', NULL, true
FROM locations l WHERE l.slug = 'milta-bodrum-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@miltabodrummarina.com', NULL, false
FROM locations l WHERE l.slug = 'milta-bodrum-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.miltabodrummarina.com', NULL, false
FROM locations l WHERE l.slug = 'milta-bodrum-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Ece Saray Marina & Resort · güven: high · kaynak: ecesaray.com.tr, marinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ece-saray-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Ece Saray Marina & Resort', 'Fethiye Karagözler mevkiinde yer alan marina, 50 metreye kadar tekneler için 350 bağlama kapasitesi sunmaktadır. Mavi Bayrak ve 5 Altın Çıpa sahibidir.',
  ST_SetSRID(ST_MakePoint(29.1016, 36.6244), 4326)::geography,
  50, NULL, NULL, NULL,
  350, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ece Saray Marina & Resort', 'Fethiye Karagözler mevkiinde yer alan marina, 50 metreye kadar tekneler için 350 bağlama kapasitesi sunmaktadır. Mavi Bayrak ve 5 Altın Çıpa sahibidir.' FROM locations WHERE slug = 'ece-saray-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 350, '73', true, NULL, NULL
FROM locations WHERE slug = 'ece-saray-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ece-saray-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'laundry', 'wifi', 'security', 'wc', 'pump_out', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'ece-saray-marina' AND sv.code IN ('mooring_assist', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902526128829', NULL, true
FROM locations l WHERE l.slug = 'ece-saray-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902526125005', NULL, false
FROM locations l WHERE l.slug = 'ece-saray-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'marina@ecemarina.com', NULL, false
FROM locations l WHERE l.slug = 'ece-saray-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://ecesaray.com.tr/marina/en/', NULL, false
FROM locations l WHERE l.slug = 'ece-saray-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Göcek Village Port Marina · güven: high · kaynak: www.seturmarinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gocek-village-port-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Göcek Village Port Marina', 'Göcek''te yer alan marina (eski adıyla Marintürk Göcek Village Port) Setur Marinas tarafından işletilmektedir. Denizde 220, karada 200 tekne kapasitesi ve çekek alanı bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.9283, 36.7567), 4326)::geography,
  NULL, NULL, NULL, NULL,
  220, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göcek Village Port Marina', 'Göcek''te yer alan marina (eski adıyla Marintürk Göcek Village Port) Setur Marinas tarafından işletilmektedir. Denizde 220, karada 200 tekne kapasitesi ve çekek alanı bulunmaktadır.' FROM locations WHERE slug = 'gocek-village-port-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 220, '69', NULL, 200, NULL
FROM locations WHERE slug = 'gocek-village-port-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gocek-village-port-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'market', 'shower', 'wifi', 'security', 'wc', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'gocek-village-port-marina' AND sv.code IN ('mooring_assist', 'technical_service', 'boat_wash', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902522771012', NULL, true
FROM locations l WHERE l.slug = 'gocek-village-port-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'villageport@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'gocek-village-port-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/en/marinas/gocek-village-port', NULL, false
FROM locations l WHERE l.slug = 'gocek-village-port-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Club Marina · güven: high · kaynak: www.clubmarina.com.tr, www.clubmarina.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'club-marina-gocek', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Club Marina', '1990 yılında kurulan Club Marina, Göcek Büngüş Koyu''nda yer alan doğal korunaklı bir marinadır ve mega yatlara hizmet verebilmektedir.',
  ST_SetSRID(ST_MakePoint(28.925, 36.7467), 4326)::geography,
  NULL, NULL, NULL, NULL,
  100, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Club Marina', '1990 yılında kurulan Club Marina, Göcek Büngüş Koyu''nda yer alan doğal korunaklı bir marinadır ve mega yatlara hizmet verebilmektedir.' FROM locations WHERE slug = 'club-marina-gocek'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 100, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'club-marina-gocek'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'club-marina-gocek' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'wc', 'pump_out', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'club-marina-gocek' AND sv.code IN ('mooring_assist', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902526451800', NULL, true
FROM locations l WHERE l.slug = 'club-marina-gocek'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905307675804', NULL, false
FROM locations l WHERE l.slug = 'club-marina-gocek'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@clubmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'club-marina-gocek'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.clubmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'club-marina-gocek'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Skopea Marina · güven: high · kaynak: www.skopeamarina.com.tr, gotosailing.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'skopea-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Skopea Marina', '1989 yılında kurulan Skopea Marina, Göcek merkez sahil şeridinde yer almaktadır ve 110 metreye kadar teknelere hizmet verebilmektedir.',
  ST_SetSRID(ST_MakePoint(28.9392, 36.7548), 4326)::geography,
  110, NULL, NULL, NULL,
  80, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Skopea Marina', '1989 yılında kurulan Skopea Marina, Göcek merkez sahil şeridinde yer almaktadır ve 110 metreye kadar teknelere hizmet verebilmektedir.' FROM locations WHERE slug = 'skopea-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 80, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'skopea-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'skopea-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'wc', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902526451794', NULL, true
FROM locations l WHERE l.slug = 'skopea-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@skopeamarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'skopea-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'skopeamarina@gmail.com', NULL, false
FROM locations l WHERE l.slug = 'skopea-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'http://www.skopeamarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'skopea-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Martı Marina · güven: high · kaynak: www.marti.com.tr, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'marti-marina-orhaniye', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Martı Marina', 'Marmaris''in Orhaniye mevkiinde yer alan marina Martı Hotels & Marinas tarafından işletilmektedir. Yakıt istasyonu ve teknik servis hizmetleri bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.1417, 36.7583), 4326)::geography,
  NULL, 4, NULL, NULL,
  380, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Martı Marina', 'Marmaris''in Orhaniye mevkiinde yer alan marina Martı Hotels & Marinas tarafından işletilmektedir. Yakıt istasyonu ve teknik servis hizmetleri bulunmaktadır.' FROM locations WHERE slug = 'marti-marina-orhaniye'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 380, '73/16', NULL, 60, NULL
FROM locations WHERE slug = 'marti-marina-orhaniye'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'marti-marina-orhaniye' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'wc', 'pump_out', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'marti-marina-orhaniye' AND sv.code IN ('technical_service', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524871063', NULL, true
FROM locations l WHERE l.slug = 'marti-marina-orhaniye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905301709093', NULL, false
FROM locations l WHERE l.slug = 'marti-marina-orhaniye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'marina@marti.com.tr', NULL, false
FROM locations l WHERE l.slug = 'marti-marina-orhaniye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.marti.com.tr/marti-marina', NULL, false
FROM locations l WHERE l.slug = 'marti-marina-orhaniye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- My Marina Yacht Club · güven: medium · kaynak: my-sea.com, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'my-marina-ekincik', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-koycegiz'),
  'My Marina Yacht Club', 'Köyceğiz''e bağlı Ekincik Koyu''nda restoran ve yat bağlama iskelesi hizmeti veren küçük bir tesistir. Nisan-Ekim döneminde sezonluk olarak faaliyet göstermektedir.',
  ST_SetSRID(ST_MakePoint(28.5655, 36.8242), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'My Marina Yacht Club', 'Köyceğiz''e bağlı Ekincik Koyu''nda restoran ve yat bağlama iskelesi hizmeti veren küçük bir tesistir. Nisan-Ekim döneminde sezonluk olarak faaliyet göstermektedir.' FROM locations WHERE slug = 'my-marina-ekincik'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'my-marina-ekincik'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'my-marina-ekincik' AND a.code IN ('electricity', 'water', 'restaurant', 'shower', 'laundry', 'wifi', 'security', 'wc', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902522660276', NULL, true
FROM locations l WHERE l.slug = 'my-marina-ekincik'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@mymarinayachtclub.com', NULL, false
FROM locations l WHERE l.slug = 'my-marina-ekincik'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.mymarinayachtclub.com/', NULL, false
FROM locations l WHERE l.slug = 'my-marina-ekincik'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO opening_seasons (id, location_id, opens_on_month, opens_on_day, closes_on_month, closes_on_day)
SELECT gen_random_uuid(), l.id, 4, 1, 10, 31 FROM locations l
WHERE l.slug = 'my-marina-ekincik'
  AND NOT EXISTS (SELECT 1 FROM opening_seasons os WHERE os.location_id = l.id)
;

-- --- Yacht Marin Marmaris · güven: medium · kaynak: www.tyha.co.uk, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yacht-marin-marmaris', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Yacht Marin Marmaris', 'Marmaris Adaköy Yalancı Boğaz mevkiinde yer alan büyük bir marinadır; Marmaris Yacht Marina adıyla da bilinir. Denizde 750 tekne kapasitesi ve büyük bir çekek sahası bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.3092, 36.8197), 4326)::geography,
  75, NULL, NULL, NULL,
  750, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yacht Marin Marmaris', 'Marmaris Adaköy Yalancı Boğaz mevkiinde yer alan büyük bir marinadır; Marmaris Yacht Marina adıyla da bilinir. Denizde 750 tekne kapasitesi ve büyük bir çekek sahası bulunmaktadır.' FROM locations WHERE slug = 'yacht-marin-marmaris'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 750, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'yacht-marin-marmaris'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yacht-marin-marmaris' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'wc', 'pump_out', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'yacht-marin-marmaris' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524220022', NULL, true
FROM locations l WHERE l.slug = 'yacht-marin-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@yachtmarin.com', NULL, false
FROM locations l WHERE l.slug = 'yacht-marin-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.yachtmarin.com', NULL, false
FROM locations l WHERE l.slug = 'yacht-marin-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Albatros Marina · güven: medium · kaynak: albatrosmarina.com, albatrosmarina.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'albatros-marina-marmaris', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Albatros Marina', 'Marmaris merkezinin yaklaşık 3 km doğusunda 1982''de kurulan marina, denizde 44 tekne bağlama kapasitesi ve karada 150 tekne için çekek alanı sunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.2856, 36.8439), 4326)::geography,
  NULL, NULL, NULL, NULL,
  44, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Albatros Marina', 'Marmaris merkezinin yaklaşık 3 km doğusunda 1982''de kurulan marina, denizde 44 tekne bağlama kapasitesi ve karada 150 tekne için çekek alanı sunmaktadır.' FROM locations WHERE slug = 'albatros-marina-marmaris'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 44, '73', NULL, NULL, true
FROM locations WHERE slug = 'albatros-marina-marmaris'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'albatros-marina-marmaris' AND a.code IN ('electricity', 'water', 'restaurant', 'shower', 'market', 'laundry', 'security', 'wc', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'albatros-marina-marmaris' AND sv.code IN ('technical_service', 'winter_storage', 'boat_wash')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524122456', NULL, true
FROM locations l WHERE l.slug = 'albatros-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'whatsapp', '+905302373852', NULL, false
FROM locations l WHERE l.slug = 'albatros-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@albatrosmarina.com', NULL, false
FROM locations l WHERE l.slug = 'albatros-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://albatrosmarina.com', NULL, false
FROM locations l WHERE l.slug = 'albatros-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Port Iasos Marina · güven: low · kaynak: marinakedisi.com, marinas.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'port-iasos-marina', 1, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Port Iasos Marina', 'Milas Kıyıkışlacık köyü Gökliman mevkiinde, antik Iasos kenti yakınında yer alan küçük bir marinadır.',
  ST_SetSRID(ST_MakePoint(27.5367, 37.2489), 4326)::geography,
  NULL, NULL, NULL, NULL,
  150, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Port Iasos Marina', 'Milas Kıyıkışlacık köyü Gökliman mevkiinde, antik Iasos kenti yakınında yer alan küçük bir marinadır.' FROM locations WHERE slug = 'port-iasos-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 150, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'port-iasos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'port-iasos-marina' AND a.code IN ('electricity', 'water', 'shower', 'wc', 'wifi')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905417604241', NULL, true
FROM locations l WHERE l.slug = 'port-iasos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@portiasos.com', NULL, false
FROM locations l WHERE l.slug = 'port-iasos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.portiasos.com', NULL, false
FROM locations l WHERE l.slug = 'port-iasos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Ataköy Marina · güven: high · kaynak: atakoymarina.com.tr, atakoymarina.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'atakoy-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-bakirkoy'),
  'Ataköy Marina', 'İstanbul Bakırköy''de yer alan marina denizde 1000 tekneye bağlama imkânı sunmaktadır. Akaryakıt istasyonu ve teknik bakım-onarım hizmetleri bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.8819, 40.9728), 4326)::geography,
  30, NULL, NULL, NULL,
  1000, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ataköy Marina', 'İstanbul Bakırköy''de yer alan marina denizde 1000 tekneye bağlama imkânı sunmaktadır. Akaryakıt istasyonu ve teknik bakım-onarım hizmetleri bulunmaktadır.' FROM locations WHERE slug = 'atakoy-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 1000, '73', NULL, 63, NULL
FROM locations WHERE slug = 'atakoy-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'atakoy-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'market', 'laundry', 'wifi', 'security', 'travel_lift', 'crane', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'atakoy-marina' AND sv.code IN ('mooring_assist', 'technical_service', 'crane', 'boat_wash', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902125604270', NULL, true
FROM locations l WHERE l.slug = 'atakoy-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'atakoymarina@atakoymarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'atakoy-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://atakoymarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'atakoy-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/marina_atakoy/', NULL, false
FROM locations l WHERE l.slug = 'atakoy-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'facebook', 'https://www.facebook.com/marina.atakoy', NULL, false
FROM locations l WHERE l.slug = 'atakoy-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Viaport Marina · güven: medium · kaynak: www.dockwalk.com, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'viaport-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-tuzla'),
  'Viaport Marina', 'İstanbul Tuzla''da Viaport alışveriş ve eğlence kompleksi içinde 2015 yılında açılan marinadır.',
  ST_SetSRID(ST_MakePoint(29.3188, 40.8158), 4326)::geography,
  80, NULL, NULL, NULL,
  750, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Viaport Marina', 'İstanbul Tuzla''da Viaport alışveriş ve eğlence kompleksi içinde 2015 yılında açılan marinadır.' FROM locations WHERE slug = 'viaport-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 750, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'viaport-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'viaport-marina' AND a.code IN ('electricity', 'water', 'fuel', 'shower', 'wc', 'wifi', 'laundry', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902165601842', NULL, true
FROM locations l WHERE l.slug = 'viaport-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'viaportmarina@viaportmarina.com', NULL, false
FROM locations l WHERE l.slug = 'viaport-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.viaportmarina.com/marina/en/', NULL, false
FROM locations l WHERE l.slug = 'viaport-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/viaportmarinatuzla/', NULL, false
FROM locations l WHERE l.slug = 'viaport-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- West Istanbul Marina · güven: high · kaynak: www.westistanbulmarina.com, www.westistanbulmarina.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'west-istanbul-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-beylikduzu'),
  'West Istanbul Marina', 'İstanbul Beylikdüzü''nde denizde 600 tekne bağlama, karada 300 tekne kapasitesine sahip marinadır. 75 ve 700 ton kapasiteli travel liftleri ile bakım-onarım ve refit hizmetleri sunar; gümrük kapısı bulunan giriş limanıdır.',
  ST_SetSRID(ST_MakePoint(28.6636, 40.9628), 4326)::geography,
  NULL, NULL, NULL, NULL,
  600, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'West Istanbul Marina', 'İstanbul Beylikdüzü''nde denizde 600 tekne bağlama, karada 300 tekne kapasitesine sahip marinadır. 75 ve 700 ton kapasiteli travel liftleri ile bakım-onarım ve refit hizmetleri sunar; gümrük kapısı bulunan giriş limanıdır.' FROM locations WHERE slug = 'west-istanbul-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 600, '72', NULL, 700, NULL
FROM locations WHERE slug = 'west-istanbul-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'west-istanbul-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'wc', 'wifi', 'security', 'pump_out', 'crane', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'west-istanbul-marina' AND sv.code IN ('mooring_assist', 'technical_service', 'crane', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902128502200', NULL, true
FROM locations l WHERE l.slug = 'west-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'marina@westistanbulmarina.com', NULL, false
FROM locations l WHERE l.slug = 'west-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.westistanbulmarina.com', NULL, false
FROM locations l WHERE l.slug = 'west-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/westistanbul_marina/', NULL, false
FROM locations l WHERE l.slug = 'west-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'facebook', 'https://www.facebook.com/westistanbul/', NULL, false
FROM locations l WHERE l.slug = 'west-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Marinturk İstanbul City Port · güven: high · kaynak: marinturk.com.tr, www.marinturk.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'marinturk-istanbul-city-port', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-pendik'),
  'Marinturk İstanbul City Port', 'İstanbul Pendik''te yer alan marina yüzer pontonlarla 785 bağlama kapasitesine sahiptir. 200 tona kadar tekne çekme-indirme imkânı ve bakım-onarım hizmetleri bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(29.2375, 40.8705), 4326)::geography,
  NULL, NULL, NULL, NULL,
  785, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Marinturk İstanbul City Port', 'İstanbul Pendik''te yer alan marina yüzer pontonlarla 785 bağlama kapasitesine sahiptir. 200 tona kadar tekne çekme-indirme imkânı ve bakım-onarım hizmetleri bulunmaktadır.' FROM locations WHERE slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 785, '73', NULL, 200, true
FROM locations WHERE slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'marinturk-istanbul-city-port' AND a.code IN ('electricity', 'water', 'fuel', 'shower', 'wc', 'wifi', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'marinturk-istanbul-city-port' AND sv.code IN ('technical_service', 'crane', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902169991234', NULL, true
FROM locations l WHERE l.slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'cityport@marinturk.com.tr', NULL, false
FROM locations l WHERE l.slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.marinturk.com.tr', NULL, false
FROM locations l WHERE l.slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/marinturkmarina', NULL, false
FROM locations l WHERE l.slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'facebook', 'https://www.facebook.com/MarinturkMarinas', NULL, false
FROM locations l WHERE l.slug = 'marinturk-istanbul-city-port'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Teos Marina · güven: medium · kaynak: marinakedisi.com, galayachtagency.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'teos-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-seferihisar'),
  'Teos Marina', 'İzmir''in Seferihisar ilçesi Sığacık''ta 2010 yılından beri hizmet veren yat limanıdır. Denizde yaklaşık 480, karada 80 tekne kapasitesine sahiptir.',
  ST_SetSRID(ST_MakePoint(26.7825, 38.1958), 4326)::geography,
  40, NULL, NULL, NULL,
  480, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Teos Marina', 'İzmir''in Seferihisar ilçesi Sığacık''ta 2010 yılından beri hizmet veren yat limanıdır. Denizde yaklaşık 480, karada 80 tekne kapasitesine sahiptir.' FROM locations WHERE slug = 'teos-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 480, '72/16', NULL, NULL, NULL
FROM locations WHERE slug = 'teos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'teos-marina' AND a.code IN ('fuel', 'restaurant', 'market', 'laundry', 'wifi', 'pump_out', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902327458080', NULL, true
FROM locations l WHERE l.slug = 'teos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@teosmarina.com', NULL, false
FROM locations l WHERE l.slug = 'teos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://teosmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'teos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Port Alaçatı Marina · güven: medium · kaynak: www.portalacati.com.tr, marinakedisi.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'port-alacati-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Port Alaçatı Marina', 'İzmir''in Çeşme ilçesi Alaçatı''da yat limanı ile konut ve otel alanlarını birleştiren bir deniz yerleşimidir.',
  ST_SetSRID(ST_MakePoint(26.37793, 38.25875), 4326)::geography,
  NULL, NULL, NULL, NULL,
  260, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Port Alaçatı Marina', 'İzmir''in Çeşme ilçesi Alaçatı''da yat limanı ile konut ve otel alanlarını birleştiren bir deniz yerleşimidir.' FROM locations WHERE slug = 'port-alacati-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 260, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'port-alacati-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902327166373', NULL, true
FROM locations l WHERE l.slug = 'port-alacati-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@portalacati.com.tr', NULL, false
FROM locations l WHERE l.slug = 'port-alacati-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'marina@portalacati.com.tr', NULL, false
FROM locations l WHERE l.slug = 'port-alacati-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.portalacati.com.tr', NULL, false
FROM locations l WHERE l.slug = 'port-alacati-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Levent Marina · güven: low · kaynak: marinakedisi.com, ytb.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'levent-marina-izmir', 1, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'izmir'),
  'Levent Marina', 'İzmir Üçkuyular''da yer alan marina; İzmir Büyükşehir Belediyesi''ne devredilerek İzmir Marina adıyla yenilendiği yönünde yayınlar bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(27.0692, 38.4067), 4326)::geography,
  25, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Levent Marina', 'İzmir Üçkuyular''da yer alan marina; İzmir Büyükşehir Belediyesi''ne devredilerek İzmir Marina adıyla yenilendiği yönünde yayınlar bulunmaktadır.' FROM locations WHERE slug = 'levent-marina-izmir'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'levent-marina-izmir'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'levent-marina-izmir' AND a.code IN ('electricity', 'water', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'levent-marina-izmir' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902322597070', NULL, true
FROM locations l WHERE l.slug = 'levent-marina-izmir'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@leventmarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'levent-marina-izmir'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Çeşme Marina · güven: high · kaynak: cnmarinas.com, sail-friend.club ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ic-cesme-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Çeşme Marina', 'Çeşme ilçe merkezinde IC Holding ve Camper & Nicholsons ortaklığında işletilen, 60 metreye kadar teknelere hizmet veren yat limanıdır. Gümrük ve pasaport işlemlerinin yapılabildiği bir giriş limanıdır.',
  ST_SetSRID(ST_MakePoint(26.3004, 38.3233), 4326)::geography,
  60, NULL, NULL, NULL,
  400, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çeşme Marina', 'Çeşme ilçe merkezinde IC Holding ve Camper & Nicholsons ortaklığında işletilen, 60 metreye kadar teknelere hizmet veren yat limanıdır. Gümrük ve pasaport işlemlerinin yapılabildiği bir giriş limanıdır.' FROM locations WHERE slug = 'ic-cesme-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 400, '72', NULL, 80, NULL
FROM locations WHERE slug = 'ic-cesme-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ic-cesme-marina' AND a.code IN ('water', 'fuel', 'restaurant', 'laundry', 'wifi', 'wc', 'pump_out', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'ic-cesme-marina' AND sv.code IN ('mooring_assist', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902327122500', NULL, true
FROM locations l WHERE l.slug = 'ic-cesme-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://cnmarinas.com/marinas/cesme-marina/', NULL, false
FROM locations l WHERE l.slug = 'ic-cesme-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- G-Marina Kemer · güven: high · kaynak: www.gmarinakemer.net, www.gmarinakemer.net ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'g-marina-kemer', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-kemer'),
  'G-Marina Kemer', 'Kemer ilçe merkezinde yer alan marina (eski adıyla Kemer Türkiz Marina) denizde 230 ve karada 140 tekne kapasitesine sahiptir. 2016''dan bu yana Mavi Yeşil International Tourism Ltd. tarafından işletilmektedir.',
  ST_SetSRID(ST_MakePoint(30.573331, 36.599625), 4326)::geography,
  NULL, NULL, NULL, NULL,
  230, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'G-Marina Kemer', 'Kemer ilçe merkezinde yer alan marina (eski adıyla Kemer Türkiz Marina) denizde 230 ve karada 140 tekne kapasitesine sahiptir. 2016''dan bu yana Mavi Yeşil International Tourism Ltd. tarafından işletilmektedir.' FROM locations WHERE slug = 'g-marina-kemer'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 230, '73', NULL, NULL, true
FROM locations WHERE slug = 'g-marina-kemer'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'g-marina-kemer' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'security', 'wc', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'g-marina-kemer' AND sv.code IN ('technical_service', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902428141490', NULL, true
FROM locations l WHERE l.slug = 'g-marina-kemer'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'whatsapp', '+905367179649', NULL, false
FROM locations l WHERE l.slug = 'g-marina-kemer'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'marina@gmarinakemer.net', NULL, false
FROM locations l WHERE l.slug = 'g-marina-kemer'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.gmarinakemer.net', NULL, false
FROM locations l WHERE l.slug = 'g-marina-kemer'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/gmarinakemer/', NULL, false
FROM locations l WHERE l.slug = 'g-marina-kemer'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Alanya Marina · güven: high · kaynak: www.alanyamarina.com.tr, www.alanyamarina.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'alanya-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-alanya'),
  'Alanya Marina', '10 Şubat 2011''de açılan Alanya Marina, denizde 287 ve karada 150 tekne kapasitesine sahiptir. 100 ton kapasiteli travel lift bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(31.9519, 36.5569), 4326)::geography,
  NULL, NULL, NULL, NULL,
  287, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Alanya Marina', '10 Şubat 2011''de açılan Alanya Marina, denizde 287 ve karada 150 tekne kapasitesine sahiptir. 100 ton kapasiteli travel lift bulunmaktadır.' FROM locations WHERE slug = 'alanya-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 287, '16/73', NULL, 100, true
FROM locations WHERE slug = 'alanya-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'alanya-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wifi', 'security', 'travel_lift', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'alanya-marina' AND sv.code IN ('technical_service', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902425113400', NULL, true
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902425121219', NULL, false
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@alanyamarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'office@alanyamarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.alanyamarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/alanyamarina/', NULL, false
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'facebook', 'https://www.facebook.com/ALANYA-MARINA-180783565338565', NULL, false
FROM locations l WHERE l.slug = 'alanya-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

