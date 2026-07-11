-- =========================================================================
-- Dockly — Gerçek lokasyon verisi (Faz 5 veri edinimi)
-- Parti: 5.1-marinas + 5.2-municipal + 5.3-piers + 5.4-anchorages + 5.5-genisleme-istanbul-marmara-kuzeyege + 6-istanbul-genisleme-pilot · Toplama: 2026-07-07/08, 2026-07-11
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
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Çanakkale', 'canakkale')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Bursa', 'bursa')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Tekirdağ', 'tekirdag')
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
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Balçova', 'izmir-balcova'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Foça', 'izmir-foca'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Merkez', 'canakkale-merkez'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'canakkale'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Gelibolu', 'canakkale-gelibolu'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'canakkale'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Erdek', 'balikesir-erdek'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'balikesir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Mudanya', 'bursa-mudanya'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'bursa'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Sarıyer', 'istanbul-sariyer'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Muratpaşa', 'antalya-muratpasa'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Demre', 'antalya-demre'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Silifke', 'mersin-silifke'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mersin'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Datça', 'mugla-datca'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Ula', 'mugla-ula'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mugla'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Beykoz', 'istanbul-beykoz'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Adalar', 'istanbul-adalar'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Büyükçekmece', 'istanbul-buyukcekmece'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Marmara', 'balikesir-marmara'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'balikesir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Bandırma', 'balikesir-bandirma'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'balikesir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Burhaniye', 'balikesir-burhaniye'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'balikesir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Biga', 'canakkale-biga'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'canakkale'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Bozcaada', 'canakkale-bozcaada'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'canakkale'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Gökçeada', 'canakkale-gokceada'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'canakkale'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Ayvacık', 'canakkale-ayvacik'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'canakkale'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Şarköy', 'tekirdag-sarkoy'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'tekirdag'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Dikili', 'izmir-dikili'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Karaburun', 'izmir-karaburun'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Urla', 'izmir-urla'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Menderes', 'izmir-menderes'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'izmir'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Söke', 'aydin-soke'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'aydin'
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

-- --- İzmir Marina · güven: high · kaynak: www.izmirmarina.com, www.izmirmarina.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'izmir-marina', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-balcova'),
  'İzmir Marina', 'Eski Levent Marina, İzmir Büyükşehir Belediyesi iştiraki İZDENİZ A.Ş. tarafından devralınarak İzmir Marina adıyla işletilmektedir. Balçova''daki tesiste 7/24 elektrik-su, güvenlik, dalgıç ve tekne yıkama hizmetleri bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(27.066, 38.4056), 4326)::geography,
  NULL, NULL, NULL, 5,
  71, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İzmir Marina', 'Eski Levent Marina, İzmir Büyükşehir Belediyesi iştiraki İZDENİZ A.Ş. tarafından devralınarak İzmir Marina adıyla işletilmektedir. Balçova''daki tesiste 7/24 elektrik-su, güvenlik, dalgıç ve tekne yıkama hizmetleri bulunmaktadır.' FROM locations WHERE slug = 'izmir-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 71, NULL, NULL, NULL, true
FROM locations WHERE slug = 'izmir-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'izmir-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'laundry', 'wifi', 'security', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'izmir-marina' AND sv.code IN ('mooring_assist', 'diver', 'boat_wash', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902322598920', NULL, true
FROM locations l WHERE l.slug = 'izmir-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905520358830', NULL, false
FROM locations l WHERE l.slug = 'izmir-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'izmirmarina@izdeniz.com.tr', NULL, false
FROM locations l WHERE l.slug = 'izmir-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.izmirmarina.com/', NULL, false
FROM locations l WHERE l.slug = 'izmir-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://www.instagram.com/marineizmir/', NULL, false
FROM locations l WHERE l.slug = 'izmir-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Foça Büyükdeniz Rıhtımı · güven: medium · kaynak: www.foca.bel.tr, www.feribotseferleri.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'foca-buyukdeniz-rihtimi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-foca'),
  'Foça Büyükdeniz Rıhtımı', 'Foça Belediyesi tarafından 1994''ten bu yana işletilen Büyükdeniz Rıhtımı''nda özel ve ticari yatlar sözleşmeyle bağlanmakta, misafir teknelere günlük konaklama ile elektrik ve su bağlantısı sağlanmaktadır.',
  ST_SetSRID(ST_MakePoint(26.7539, 38.6697), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Foça Büyükdeniz Rıhtımı', 'Foça Belediyesi tarafından 1994''ten bu yana işletilen Büyükdeniz Rıhtımı''nda özel ve ticari yatlar sözleşmeyle bağlanmakta, misafir teknelere günlük konaklama ile elektrik ve su bağlantısı sağlanmaktadır.' FROM locations WHERE slug = 'foca-buyukdeniz-rihtimi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'foca-buyukdeniz-rihtimi' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://foca.bel.tr/hizmetler/tekne-baglama-hizmetleri-ve-ucretleri', NULL, false
FROM locations l WHERE l.slug = 'foca-buyukdeniz-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Bozburun Yat Yanaşma Yeri · güven: high · kaynak: www.marmaris.bel.tr, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bozburun-yat-yanasma-yeri', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Bozburun Yat Yanaşma Yeri', 'Marmaris Belediyesi''nin ücret tarifesinde yer alan Bozburun Yat Yanaşma Yeri''nde sezonluk ve günlük bağlama hizmeti verilmektedir. 80 tekne kapasiteli tesiste elektrik ve su, ön ödemeli kartlı sistemle sağlanmakta, servis botu bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.0425, 36.692), 4326)::geography,
  NULL, NULL, NULL, NULL,
  80, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bozburun Yat Yanaşma Yeri', 'Marmaris Belediyesi''nin ücret tarifesinde yer alan Bozburun Yat Yanaşma Yeri''nde sezonluk ve günlük bağlama hizmeti verilmektedir. 80 tekne kapasiteli tesiste elektrik ve su, ön ödemeli kartlı sistemle sağlanmakta, servis botu bulunmaktadır.' FROM locations WHERE slug = 'bozburun-yat-yanasma-yeri'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'bozburun-yat-yanasma-yeri' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.marmaris.bel.tr/?Page=Ucret_Tarifeleri', NULL, false
FROM locations l WHERE l.slug = 'bozburun-yat-yanasma-yeri'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Marmaris Limanı · güven: high · kaynak: muttas.com.tr, muttas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'marmaris-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Marmaris Limanı', 'Muğla Büyükşehir Belediyesi iştiraki MUTTAŞ''ın işlettiği Marmaris Limanı''nda yaklaşık 1.700 metrelik rıhtımda 200 tekneye yanaşma hizmeti verilmektedir. Yatlara su, elektrik, atık alımı, güvenlik ve palamar hizmetleri sunulur; kruvaziyer trafiğiyle karma kullanımlıdır.',
  ST_SetSRID(ST_MakePoint(28.273902, 36.849968), 4326)::geography,
  NULL, NULL, NULL, NULL,
  200, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Marmaris Limanı', 'Muğla Büyükşehir Belediyesi iştiraki MUTTAŞ''ın işlettiği Marmaris Limanı''nda yaklaşık 1.700 metrelik rıhtımda 200 tekneye yanaşma hizmeti verilmektedir. Yatlara su, elektrik, atık alımı, güvenlik ve palamar hizmetleri sunulur; kruvaziyer trafiğiyle karma kullanımlıdır.' FROM locations WHERE slug = 'marmaris-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'marmaris-limani' AND a.code IN ('electricity', 'water', 'security', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'marmaris-limani' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524120265', NULL, true
FROM locations l WHERE l.slug = 'marmaris-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@muttas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'marmaris-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://muttas.com.tr/limanlar/', NULL, false
FROM locations l WHERE l.slug = 'marmaris-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- İçmeler İskelesi · güven: medium · kaynak: muttas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'icmeler-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'İçmeler İskelesi', 'Marmaris İçmeler''de MUTTAŞ tarafından işletilen iskelede 220 metrelik rıhtım ve 142 metrelik iskelede yaklaşık 40 tekneye yanaşma hizmeti verilmektedir. Atık su alım hizmeti bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(28.238995, 36.800371), 4326)::geography,
  NULL, NULL, NULL, NULL,
  40, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İçmeler İskelesi', 'Marmaris İçmeler''de MUTTAŞ tarafından işletilen iskelede 220 metrelik rıhtım ve 142 metrelik iskelede yaklaşık 40 tekneye yanaşma hizmeti verilmektedir. Atık su alım hizmeti bulunmaktadır.' FROM locations WHERE slug = 'icmeler-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'icmeler-iskelesi' AND a.code IN ('pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524120265', NULL, true
FROM locations l WHERE l.slug = 'icmeler-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905382330352', NULL, false
FROM locations l WHERE l.slug = 'icmeler-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@muttas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'icmeler-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://muttas.com.tr/limanlar/', NULL, false
FROM locations l WHERE l.slug = 'icmeler-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Turunç İskelesi · güven: medium · kaynak: muttas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'turunc-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Turunç İskelesi', 'Marmaris Turunç Cumhuriyet Meydanı''ndaki 183 metrelik iskelede MUTTAŞ tarafından yaklaşık 30 tekneye yanaşma hizmeti verilmektedir. Su, atık alımı, güvenlik ve palamar hizmeti sunulmaktadır.',
  ST_SetSRID(ST_MakePoint(28.249443, 36.772146), 4326)::geography,
  NULL, NULL, NULL, NULL,
  30, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Turunç İskelesi', 'Marmaris Turunç Cumhuriyet Meydanı''ndaki 183 metrelik iskelede MUTTAŞ tarafından yaklaşık 30 tekneye yanaşma hizmeti verilmektedir. Su, atık alımı, güvenlik ve palamar hizmeti sunulmaktadır.' FROM locations WHERE slug = 'turunc-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'turunc-iskelesi' AND a.code IN ('water', 'security', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'turunc-iskelesi' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524120265', NULL, true
FROM locations l WHERE l.slug = 'turunc-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905332502289', NULL, false
FROM locations l WHERE l.slug = 'turunc-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@muttas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'turunc-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://muttas.com.tr/limanlar/', NULL, false
FROM locations l WHERE l.slug = 'turunc-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Bodrum Limanı · güven: high · kaynak: muttas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bodrum-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Bodrum Limanı', 'Bodrum Barış Meydanı''ndaki liman MUTTAŞ tarafından işletilmekte olup 960 metrelik rıhtım ve 140 metrelik yüzer iskelede yaklaşık 230 tekneye yanaşma hizmeti verilmektedir. Kos''a uluslararası feribot kapısıdır.',
  ST_SetSRID(ST_MakePoint(27.426232, 37.031991), 4326)::geography,
  NULL, NULL, NULL, NULL,
  230, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bodrum Limanı', 'Bodrum Barış Meydanı''ndaki liman MUTTAŞ tarafından işletilmekte olup 960 metrelik rıhtım ve 140 metrelik yüzer iskelede yaklaşık 230 tekneye yanaşma hizmeti verilmektedir. Kos''a uluslararası feribot kapısıdır.' FROM locations WHERE slug = 'bodrum-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'bodrum-limani' AND a.code IN ('water', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'bodrum-limani' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902523169772', NULL, true
FROM locations l WHERE l.slug = 'bodrum-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905332510157', NULL, false
FROM locations l WHERE l.slug = 'bodrum-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@muttas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'bodrum-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://muttas.com.tr/limanlar/', NULL, false
FROM locations l WHERE l.slug = 'bodrum-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Gümbet İskelesi · güven: medium · kaynak: muttas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gumbet-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Gümbet İskelesi', 'Bodrum Gümbet''te MUTTAŞ tarafından işletilen, toplam 595 metre uzunluğunda üç iskeleden oluşan tesiste yaklaşık 200 tekneye bağlama hizmeti verilmektedir. Su, güvenlik ve palamar hizmeti sunulmaktadır.',
  ST_SetSRID(ST_MakePoint(27.401812, 37.023076), 4326)::geography,
  NULL, NULL, NULL, NULL,
  200, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gümbet İskelesi', 'Bodrum Gümbet''te MUTTAŞ tarafından işletilen, toplam 595 metre uzunluğunda üç iskeleden oluşan tesiste yaklaşık 200 tekneye bağlama hizmeti verilmektedir. Su, güvenlik ve palamar hizmeti sunulmaktadır.' FROM locations WHERE slug = 'gumbet-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gumbet-iskelesi' AND a.code IN ('water', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'gumbet-iskelesi' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902523169772', NULL, true
FROM locations l WHERE l.slug = 'gumbet-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905332510157', NULL, false
FROM locations l WHERE l.slug = 'gumbet-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@muttas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'gumbet-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://muttas.com.tr/limanlar/', NULL, false
FROM locations l WHERE l.slug = 'gumbet-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Fethiye Limanı · güven: high · kaynak: muttas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'fethiye-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Fethiye Limanı', 'Fethiye Karagözler''de MUTTAŞ tarafından işletilen limanda yaklaşık 50 tekneye yanaşma hizmeti verilmekte; su, atık alımı, güvenlik ve palamar hizmetleri sunulmaktadır. Rodos''a uluslararası feribot kapısıdır.',
  ST_SetSRID(ST_MakePoint(29.106163, 36.622984), 4326)::geography,
  NULL, NULL, NULL, NULL,
  50, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Fethiye Limanı', 'Fethiye Karagözler''de MUTTAŞ tarafından işletilen limanda yaklaşık 50 tekneye yanaşma hizmeti verilmekte; su, atık alımı, güvenlik ve palamar hizmetleri sunulmaktadır. Rodos''a uluslararası feribot kapısıdır.' FROM locations WHERE slug = 'fethiye-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'fethiye-limani' AND a.code IN ('water', 'security', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'fethiye-limani' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902526127557', NULL, true
FROM locations l WHERE l.slug = 'fethiye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905332505739', NULL, false
FROM locations l WHERE l.slug = 'fethiye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@muttas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'fethiye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://muttas.com.tr/limanlar/', NULL, false
FROM locations l WHERE l.slug = 'fethiye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Göcek Belediye İskelesi · güven: medium · kaynak: www.yatvitrini.com, panel.mugla.bel.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gocek-belediye-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Göcek Belediye İskelesi', 'Göcek köyiçindeki belediye iskelesi 1989''da inşa edilmiş olup bugün Fethiye Belediyesi tarafından işletilmektedir. Bağlama ücretleri belediye gelir tarifesinde metre başına belirlenmektedir.',
  ST_SetSRID(ST_MakePoint(28.946667, 36.754444), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göcek Belediye İskelesi', 'Göcek köyiçindeki belediye iskelesi 1989''da inşa edilmiş olup bugün Fethiye Belediyesi tarafından işletilmektedir. Bağlama ücretleri belediye gelir tarifesinde metre başına belirlenmektedir.' FROM locations WHERE slug = 'gocek-belediye-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.fethiye.bel.tr/', NULL, false
FROM locations l WHERE l.slug = 'gocek-belediye-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Çanakkale Yat Limanı · güven: high · kaynak: tkygm.uab.gov.tr, marinalar.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'canakkale-yat-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-merkez'),
  'Çanakkale Yat Limanı', 'Çanakkale kent merkezindeki kordonda yer alan, belediye tarafından işletilen 120 yat kapasiteli limandır. Geçici hudut kapısı statüsüyle transitlog işlemleri yapılabilmektedir.',
  ST_SetSRID(ST_MakePoint(26.406, 40.1534), 4326)::geography,
  NULL, NULL, NULL, NULL,
  120, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çanakkale Yat Limanı', 'Çanakkale kent merkezindeki kordonda yer alan, belediye tarafından işletilen 120 yat kapasiteli limandır. Geçici hudut kapısı statüsüyle transitlog işlemleri yapılabilmektedir.' FROM locations WHERE slug = 'canakkale-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 120, '73/16', NULL, NULL, NULL
FROM locations WHERE slug = 'canakkale-yat-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'canakkale-yat-limani' AND a.code IN ('electricity', 'water', 'fuel', 'shower', 'wc', 'laundry', 'wifi', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'canakkale-yat-limani' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902862128453', NULL, true
FROM locations l WHERE l.slug = 'canakkale-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'bilgi@canakkalebelediyesimarina.com', NULL, false
FROM locations l WHERE l.slug = 'canakkale-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Gelibolu Yat Limanı · güven: low · kaynak: www.sualtigazetesi.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gelibolu-yat-limani', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-gelibolu'),
  'Gelibolu Yat Limanı', 'Gelibolu''da kuzey rüzgarlarına kapalı doğal limanın iç kısmı yatların bağlanmasına uygundur; barınakta akaryakıt pompası bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(26.6694, 40.405), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gelibolu Yat Limanı', 'Gelibolu''da kuzey rüzgarlarına kapalı doğal limanın iç kısmı yatların bağlanmasına uygundur; barınakta akaryakıt pompası bulunmaktadır.' FROM locations WHERE slug = 'gelibolu-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gelibolu-yat-limani' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Erdek Yat Limanı · güven: low · kaynak: www.denizhaber.net ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'erdek-yat-limani', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-erdek'),
  'Erdek Yat Limanı', 'Erdek merkezdeki iskele ve liman yerel tekneler ile kotra ve yatların bağlanmasında kullanılmaktadır; Balıkesir Büyükşehir Belediyesi iskelenin yat limanına dönüştürülmesini planladığını açıklamıştır.',
  ST_SetSRID(ST_MakePoint(27.7892, 40.3933), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Erdek Yat Limanı', 'Erdek merkezdeki iskele ve liman yerel tekneler ile kotra ve yatların bağlanmasında kullanılmaktadır; Balıkesir Büyükşehir Belediyesi iskelenin yat limanına dönüştürülmesini planladığını açıklamıştır.' FROM locations WHERE slug = 'erdek-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Güzelyalı Yat Limanı · güven: high · kaynak: www.burulas.com.tr, www.burulas.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'guzelyali-yat-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'bursa-mudanya'),
  'Güzelyalı Yat Limanı', 'Mudanya Güzelyalı''daki liman 2020''den bu yana Bursa Büyükşehir Belediyesi iştiraki BURULAŞ tarafından işletilmektedir. 58 yat ve 60 balıkçı teknesi kapasiteli tesis 7/24 güvenlik ve kamera sistemiyle izlenmektedir.',
  ST_SetSRID(ST_MakePoint(28.932167, 40.356167), 4326)::geography,
  NULL, NULL, NULL, NULL,
  58, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Güzelyalı Yat Limanı', 'Mudanya Güzelyalı''daki liman 2020''den bu yana Bursa Büyükşehir Belediyesi iştiraki BURULAŞ tarafından işletilmektedir. 58 yat ve 60 balıkçı teknesi kapasiteli tesis 7/24 güvenlik ve kamera sistemiyle izlenmektedir.' FROM locations WHERE slug = 'guzelyali-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 58, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'guzelyali-yat-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'guzelyali-yat-limani' AND a.code IN ('security')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902244525244', NULL, true
FROM locations l WHERE l.slug = 'guzelyali-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'burulas@burulas.com.tr', NULL, false
FROM locations l WHERE l.slug = 'guzelyali-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.burulas.com.tr/hizmetler/yat-limani', NULL, false
FROM locations l WHERE l.slug = 'guzelyali-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- İSPARK İstinye Tekne Park · güven: high · kaynak: ispark.istanbul, www.wikiderya.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ispark-istinye-tekne-park', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-sariyer'),
  'İSPARK İstinye Tekne Park', 'İstinye Koyu''nda İBB iştiraki İSPARK tarafından işletilen, yüzer iskeleli 180 tekne kapasiteli tekne parktır. Su, elektrik, WC ve güvenlik hizmetleri sunulmakta; günlükten yıllığa abonelik uygulanmaktadır.',
  ST_SetSRID(ST_MakePoint(29.057167, 41.113667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  180, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İSPARK İstinye Tekne Park', 'İstinye Koyu''nda İBB iştiraki İSPARK tarafından işletilen, yüzer iskeleli 180 tekne kapasiteli tekne parktır. Su, elektrik, WC ve güvenlik hizmetleri sunulmakta; günlükten yıllığa abonelik uygulanmaktadır.' FROM locations WHERE slug = 'ispark-istinye-tekne-park'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 180, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'ispark-istinye-tekne-park'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ispark-istinye-tekne-park' AND a.code IN ('electricity', 'water', 'wc', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902166350045', NULL, true
FROM locations l WHERE l.slug = 'ispark-istinye-tekne-park'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'istinye.marina@ispark.istanbul', NULL, false
FROM locations l WHERE l.slug = 'ispark-istinye-tekne-park'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://istmarin.ispark.istanbul', NULL, false
FROM locations l WHERE l.slug = 'ispark-istinye-tekne-park'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- İSPARK Tarabya Tekne Park · güven: high · kaynak: ispark.istanbul, www.wikiderya.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ispark-tarabya-tekne-park', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-sariyer'),
  'İSPARK Tarabya Tekne Park', 'Tarabya Koyu''nda İBB iştiraki İSPARK tarafından işletilen yüzer iskeleli tekne parktır; işletmeci 265 tekne kapasitesi bildirmektedir. Su, elektrik, WC ve güvenlik hizmetleri sunulmaktadır.',
  ST_SetSRID(ST_MakePoint(29.057901, 41.138466), 4326)::geography,
  NULL, NULL, NULL, NULL,
  265, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İSPARK Tarabya Tekne Park', 'Tarabya Koyu''nda İBB iştiraki İSPARK tarafından işletilen yüzer iskeleli tekne parktır; işletmeci 265 tekne kapasitesi bildirmektedir. Su, elektrik, WC ve güvenlik hizmetleri sunulmaktadır.' FROM locations WHERE slug = 'ispark-tarabya-tekne-park'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 265, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'ispark-tarabya-tekne-park'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ispark-tarabya-tekne-park' AND a.code IN ('electricity', 'water', 'wc', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902166350045', NULL, true
FROM locations l WHERE l.slug = 'ispark-tarabya-tekne-park'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'tarabya.marina@ispark.istanbul', NULL, false
FROM locations l WHERE l.slug = 'ispark-tarabya-tekne-park'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://istmarin.ispark.istanbul', NULL, false
FROM locations l WHERE l.slug = 'ispark-tarabya-tekne-park'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Antalya Kaleiçi Yat Limanı · güven: high · kaynak: tkygm.uab.gov.tr, www.antalya.bel.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'antalya-kaleici-yat-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-muratpasa'),
  'Antalya Kaleiçi Yat Limanı', 'Antalya''nın tarihi Kaleiçi eski limanında yer alan, büyükşehir belediyesi şirketi tarafından işletilen 65 yat kapasiteli limandır. 24 saat palamar ve güvenlik hizmeti verilmekte, günübirlik gezi tekneleri de limanı yoğun kullanmaktadır.',
  ST_SetSRID(ST_MakePoint(30.703, 36.883833), 4326)::geography,
  NULL, NULL, NULL, NULL,
  65, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Antalya Kaleiçi Yat Limanı', 'Antalya''nın tarihi Kaleiçi eski limanında yer alan, büyükşehir belediyesi şirketi tarafından işletilen 65 yat kapasiteli limandır. 24 saat palamar ve güvenlik hizmeti verilmekte, günübirlik gezi tekneleri de limanı yoğun kullanmaktadır.' FROM locations WHERE slug = 'antalya-kaleici-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 65, '16/73', NULL, NULL, NULL
FROM locations WHERE slug = 'antalya-kaleici-yat-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'antalya-kaleici-yat-limani' AND a.code IN ('electricity', 'water', 'restaurant', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'antalya-kaleici-yat-limani' AND sv.code IN ('mooring_assist', 'diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902422484530', NULL, true
FROM locations l WHERE l.slug = 'antalya-kaleici-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'iletisim@antalyaulasim.com.tr', NULL, false
FROM locations l WHERE l.slug = 'antalya-kaleici-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kaş Belediye Limanı · güven: medium · kaynak: tkygm.uab.gov.tr, www.wikiderya.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kas-belediye-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-kas'),
  'Kaş Belediye Limanı', 'Kaş ilçe merkezinin yanındaki eski liman yaklaşık 100 tekne kapasitelidir; yerel gezi-dalış tekneleri ile uğrak yatlar kullanmaktadır. Bağlama tonoz zinciriyle yapılmakta, çevrede ücretli duş-WC ve çamaşırhane bulunmaktadır.',
  ST_SetSRID(ST_MakePoint(29.6404, 36.1993), 4326)::geography,
  NULL, NULL, NULL, NULL,
  100, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kaş Belediye Limanı', 'Kaş ilçe merkezinin yanındaki eski liman yaklaşık 100 tekne kapasitelidir; yerel gezi-dalış tekneleri ile uğrak yatlar kullanmaktadır. Bağlama tonoz zinciriyle yapılmakta, çevrede ücretli duş-WC ve çamaşırhane bulunmaktadır.' FROM locations WHERE slug = 'kas-belediye-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kas-belediye-limani' AND a.code IN ('shower', 'wc', 'laundry')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905325032673', 'Liman görevlisi (wikiderya)', true
FROM locations l WHERE l.slug = 'kas-belediye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905337295131', 'Liman görevlisi (wikiderya)', false
FROM locations l WHERE l.slug = 'kas-belediye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kalkan Belediye Limanı · güven: medium · kaynak: tkygm.uab.gov.tr, www.kas.bel.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalkan-belediye-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-kas'),
  'Kalkan Belediye Limanı', 'Kalkan''daki yaklaşık 50 tekne kapasiteli liman ve balıkçı barınağı yerel tekneler ile uğrak yatlara hizmet vermektedir. 2023''te zemin yenileme, çekek yeri ve bağlama halkaları yenileme çalışmaları tamamlanmıştır.',
  ST_SetSRID(ST_MakePoint(29.4151, 36.2611), 4326)::geography,
  NULL, NULL, NULL, NULL,
  50, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kalkan Belediye Limanı', 'Kalkan''daki yaklaşık 50 tekne kapasiteli liman ve balıkçı barınağı yerel tekneler ile uğrak yatlara hizmet vermektedir. 2023''te zemin yenileme, çekek yeri ve bağlama halkaları yenileme çalışmaları tamamlanmıştır.' FROM locations WHERE slug = 'kalkan-belediye-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902428443131', NULL, true
FROM locations l WHERE l.slug = 'kalkan-belediye-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Üçağız İskelesi · güven: medium · kaynak: gazeteoksijen.com, www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ucagiz-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-demre'),
  'Üçağız İskelesi', 'Kekova bölgesindeki Üçağız köy iskelesi yıllarca Demre Belediyesi tarafından işletilmiş, Haziran 2024''te bakanlık ihalesiyle 10 yıllığına özel bir gruba kiralanmıştır. Demre Belediyesi ihalenin iptali için hukuki süreç başlatmıştır.',
  ST_SetSRID(ST_MakePoint(29.846849, 36.195387), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Üçağız İskelesi', 'Kekova bölgesindeki Üçağız köy iskelesi yıllarca Demre Belediyesi tarafından işletilmiş, Haziran 2024''te bakanlık ihalesiyle 10 yıllığına özel bir gruba kiralanmıştır. Demre Belediyesi ihalenin iptali için hukuki süreç başlatmıştır.' FROM locations WHERE slug = 'ucagiz-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Demre Yat Limanı · güven: medium · kaynak: www.uab.gov.tr, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'demre-yat-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-demre'),
  'Demre Yat Limanı', 'Ulaştırma ve Altyapı Bakanlığı''nca Çayağzı mevkiinde yaptırılan Demre Yat Limanı 26 Temmuz 2025''te hizmete açılmıştır. 64.000 m² kara ve 120.000 m² korunaklı su alanına sahip tesisin 12 ay hizmet vermesi planlanmaktadır.',
  ST_SetSRID(ST_MakePoint(29.942, 36.223), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Demre Yat Limanı', 'Ulaştırma ve Altyapı Bakanlığı''nca Çayağzı mevkiinde yaptırılan Demre Yat Limanı 26 Temmuz 2025''te hizmete açılmıştır. 64.000 m² kara ve 120.000 m² korunaklı su alanına sahip tesisin 12 ay hizmet vermesi planlanmaktadır.' FROM locations WHERE slug = 'demre-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, true
FROM locations WHERE slug = 'demre-yat-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'demre-yat-limani' AND sv.code IN ('winter_storage')
ON CONFLICT DO NOTHING;

-- --- Taşucu Limanı · güven: low · kaynak: tasinmazhaber.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tasucu-limani', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-silifke'),
  'Taşucu Limanı', 'Taşucu''nda uğrak teknelerin ve balıkçı teknelerinin bağlandığı kasaba limanıdır. Mevcut alanda 100 yat + 76 balıkçı teknesi kapasiteli yat limanı ve barınak projesi yürütülmektedir.',
  ST_SetSRID(ST_MakePoint(33.8811, 36.3158), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Taşucu Limanı', 'Taşucu''nda uğrak teknelerin ve balıkçı teknelerinin bağlandığı kasaba limanıdır. Mevcut alanda 100 yat + 76 balıkçı teknesi kapasiteli yat limanı ve barınak projesi yürütülmektedir.' FROM locations WHERE slug = 'tasucu-limani'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Kapı Creek Restaurant · güven: high · kaynak: www.navily.com, sunseayachting.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kapi-creek-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Kapı Creek Restaurant', 'Skopea Körfezi girişindeki korunaklı Kapı Koyu''nda, iskelesinde yaklaşık 20 tekneye tonozlu bağlama imkânı sunan klasik koy restoranı. Personel bağlamada yardımcı olur.',
  ST_SetSRID(ST_MakePoint(28.8933, 36.645), 4326)::geography,
  NULL, NULL, 2, 2.5,
  20, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kapı Creek Restaurant', 'Skopea Körfezi girişindeki korunaklı Kapı Koyu''nda, iskelesinde yaklaşık 20 tekneye tonozlu bağlama imkânı sunan klasik koy restoranı. Personel bağlamada yardımcı olur.' FROM locations WHERE slug = 'kapi-creek-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri, Türk mutfağı', 20, NULL, NULL
FROM locations WHERE slug = 'kapi-creek-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kapi-creek-restaurant' AND a.code IN ('restaurant', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'kapi-creek-restaurant' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;

-- --- Göbün Restaurant · güven: high · kaynak: gotosailing.com, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gobun-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Göbün Restaurant', '1979''dan beri işletilen Göbün Koyu restoranı; iki iskelesinde 40 tekneye kadar bağlama kapasitesi vardır. Güneş enerjisiyle elektrik, su, duş/WC ve Wi-Fi sağlanır.',
  ST_SetSRID(ST_MakePoint(28.8933, 36.6416), 4326)::geography,
  NULL, NULL, NULL, NULL,
  40, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göbün Restaurant', '1979''dan beri işletilen Göbün Koyu restoranı; iki iskelesinde 40 tekneye kadar bağlama kapasitesi vardır. Güneş enerjisiyle elektrik, su, duş/WC ve Wi-Fi sağlanır.' FROM locations WHERE slug = 'gobun-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri, mezeler, kuzu tandır', 40, 'yemek yiyene bağlama ücretsiz', true
FROM locations WHERE slug = 'gobun-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gobun-restaurant' AND a.code IN ('restaurant', 'water', 'electricity', 'wifi', 'shower', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'gobun-restaurant' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905322474065', NULL, true
FROM locations l WHERE l.slug = 'gobun-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905553570987', NULL, false
FROM locations l WHERE l.slug = 'gobun-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@kapicreek.com', NULL, false
FROM locations l WHERE l.slug = 'gobun-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Adaia Göcek Restaurant · güven: high · kaynak: www.navily.com, www.gocekonline.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'adaia-gocek-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Adaia Göcek Restaurant', 'Wall Bay / Hamam (Kleopatra) Koyu''nda kendi iskelesi olan restoran; eski Wall Bay Restaurant''ın yerinde hizmet verir. İskelede su, duş ve WC mevcuttur.',
  ST_SetSRID(ST_MakePoint(28.8512, 36.6447), 4326)::geography,
  NULL, NULL, NULL, NULL,
  30, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Adaia Göcek Restaurant', 'Wall Bay / Hamam (Kleopatra) Koyu''nda kendi iskelesi olan restoran; eski Wall Bay Restaurant''ın yerinde hizmet verir. İskelede su, duş ve WC mevcuttur.' FROM locations WHERE slug = 'adaia-gocek-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'Akdeniz mutfağı', 30, 'yemek yiyene bağlama ücretsiz', NULL
FROM locations WHERE slug = 'adaia-gocek-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'adaia-gocek-restaurant' AND a.code IN ('restaurant', 'water', 'shower', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905333313854', NULL, true
FROM locations l WHERE l.slug = 'adaia-gocek-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Sarsala Restaurant · güven: high · kaynak: www.navily.com, boatscribe.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sarsala-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Sarsala Restaurant', 'Küçük Sarsala Koyu''ndaki restoran iskelesi yaklaşık 35 tekne kapasitelidir; su, duş ve WC imkânı bulunur.',
  ST_SetSRID(ST_MakePoint(28.857, 36.657), 4326)::geography,
  NULL, NULL, NULL, NULL,
  35, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sarsala Restaurant', 'Küçük Sarsala Koyu''ndaki restoran iskelesi yaklaşık 35 tekne kapasitelidir; su, duş ve WC imkânı bulunur.' FROM locations WHERE slug = 'sarsala-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'Türk mutfağı, deniz ürünleri', 35, 'yemek yiyene bağlama ücretsiz', NULL
FROM locations WHERE slug = 'sarsala-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'sarsala-restaurant' AND a.code IN ('restaurant', 'water', 'shower', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905324233345', NULL, true
FROM locations l WHERE l.slug = 'sarsala-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Boynuzbükü Restaurant · güven: medium · kaynak: www.navily.com, www.gocekonline.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'boynuzbuku-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Boynuzbükü Restaurant', 'Skopea Körfezi''nin kuzeyindeki Boynuzbükü Koyu''nda iskeleli koy restoranı; iskelede yaklaşık 18 tekneye yer vardır ve su temini mümkündür.',
  ST_SetSRID(ST_MakePoint(28.8967, 36.7112), 4326)::geography,
  NULL, NULL, NULL, NULL,
  18, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Boynuzbükü Restaurant', 'Skopea Körfezi''nin kuzeyindeki Boynuzbükü Koyu''nda iskeleli koy restoranı; iskelede yaklaşık 18 tekneye yer vardır ve su temini mümkündür.' FROM locations WHERE slug = 'boynuzbuku-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, 18, NULL, NULL
FROM locations WHERE slug = 'boynuzbuku-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'boynuzbuku-restaurant' AND a.code IN ('restaurant', 'water')
ON CONFLICT DO NOTHING;

-- --- Miori Restaurant · güven: medium · kaynak: www.gocekonline.com, irmakyachting.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'miori-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Miori Restaurant', 'Bedri Rahmi (Taşyaka / Tomb Bay) Koyu''nda kendi iskelesi olan modern Akdeniz restoranı.',
  ST_SetSRID(ST_MakePoint(28.8717, 36.6933), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Miori Restaurant', 'Bedri Rahmi (Taşyaka / Tomb Bay) Koyu''nda kendi iskelesi olan modern Akdeniz restoranı.' FROM locations WHERE slug = 'miori-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'modern Akdeniz mutfağı', NULL, 'yemek yiyene bağlama ücretsiz', true
FROM locations WHERE slug = 'miori-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'miori-restaurant' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905351080048', NULL, true
FROM locations l WHERE l.slug = 'miori-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Ersoy Restaurant · güven: medium · kaynak: www.navily.com, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ersoy-restaurant-orhaniye', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Ersoy Restaurant', 'Orhaniye Keçibükü''nde kendi iskelesi olan aile restoranı; iskelede elektrik, su, duş, WC ve Wi-Fi imkânı bulunur.',
  ST_SetSRID(ST_MakePoint(28.1295, 36.753), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ersoy Restaurant', 'Orhaniye Keçibükü''nde kendi iskelesi olan aile restoranı; iskelede elektrik, su, duş, WC ve Wi-Fi imkânı bulunur.' FROM locations WHERE slug = 'ersoy-restaurant-orhaniye'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'ersoy-restaurant-orhaniye'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ersoy-restaurant-orhaniye' AND a.code IN ('restaurant', 'electricity', 'water', 'shower', 'wc', 'wifi')
ON CONFLICT DO NOTHING;

-- --- Aurora Restaurant · güven: low · kaynak: www.harbourmaps.com, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'aurora-restaurant-selimiye', 5, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Aurora Restaurant', 'Selimiye kıyısında kendi iskelesi olan restoran; yemek yiyen teknelere bağlama, su, elektrik ve Wi-Fi sunulur.',
  ST_SetSRID(ST_MakePoint(28.092273, 36.707164), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Aurora Restaurant', 'Selimiye kıyısında kendi iskelesi olan restoran; yemek yiyen teknelere bağlama, su, elektrik ve Wi-Fi sunulur.' FROM locations WHERE slug = 'aurora-restaurant-selimiye'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'Türk mutfağı, deniz ürünleri', NULL, 'yemek yiyene bağlama ücretsiz', NULL
FROM locations WHERE slug = 'aurora-restaurant-selimiye'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'aurora-restaurant-selimiye' AND a.code IN ('restaurant', 'electricity', 'water', 'shower', 'wc', 'wifi')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524464097', NULL, true
FROM locations l WHERE l.slug = 'aurora-restaurant-selimiye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Poseidon Boutique Hotel & Yacht Club · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'poseidon-selimiye', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Poseidon Boutique Hotel & Yacht Club', 'Selimiye''de iskeleli butik otel ve restoran; misafir teknelere kendi iskelesinde bağlama imkânı sunar.',
  ST_SetSRID(ST_MakePoint(28.102339, 36.706601), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Poseidon Boutique Hotel & Yacht Club', 'Selimiye''de iskeleli butik otel ve restoran; misafir teknelere kendi iskelesinde bağlama imkânı sunar.' FROM locations WHERE slug = 'poseidon-selimiye'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'poseidon-selimiye'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'poseidon-selimiye' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524464080', NULL, true
FROM locations l WHERE l.slug = 'poseidon-selimiye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@poseidonselimiye.com', NULL, false
FROM locations l WHERE l.slug = 'poseidon-selimiye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://poseidonselimiye.com', NULL, false
FROM locations l WHERE l.slug = 'poseidon-selimiye'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Dirsek Bükü Restaurant · güven: high · kaynak: turkeymarinas.blogspot.com, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'dirsek-buku-restaurant', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Dirsek Bükü Restaurant', 'Karayolu bağlantısı olmayan Dirsek Bükü''ndeki tek restoran; taş iskelesine kıçtankara bağlanılır. Nisan-Ekim arası açıktır ve akşamları meze büfesiyle bilinir.',
  ST_SetSRID(ST_MakePoint(27.980973, 36.691718), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Dirsek Bükü Restaurant', 'Karayolu bağlantısı olmayan Dirsek Bükü''ndeki tek restoran; taş iskelesine kıçtankara bağlanılır. Nisan-Ekim arası açıktır ve akşamları meze büfesiyle bilinir.' FROM locations WHERE slug = 'dirsek-buku-restaurant'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri, mezeler, ev yemekleri, ızgara', NULL, NULL, NULL
FROM locations WHERE slug = 'dirsek-buku-restaurant'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'dirsek-buku-restaurant' AND a.code IN ('restaurant', 'water', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905323940001', NULL, true
FROM locations l WHERE l.slug = 'dirsek-buku-restaurant'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO opening_seasons (id, location_id, opens_on_month, opens_on_day, closes_on_month, closes_on_day)
SELECT gen_random_uuid(), l.id, 4, 1, 10, 31 FROM locations l
WHERE l.slug = 'dirsek-buku-restaurant'
  AND NOT EXISTS (SELECT 1 FROM opening_seasons os WHERE os.location_id = l.id)
;

-- --- Bozburun Yacht Club · güven: medium · kaynak: www.navily.com, www.harbourmaps.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bozburun-yacht-club', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Bozburun Yacht Club', 'Bozburun Koyu kıyısında iskelesi ve restoranı olan yat kulübü ve butik otel; misafir teknelere rıhtım bağlaması sunar.',
  ST_SetSRID(ST_MakePoint(28.0483, 36.6753), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bozburun Yacht Club', 'Bozburun Koyu kıyısında iskelesi ve restoranı olan yat kulübü ve butik otel; misafir teknelere rıhtım bağlaması sunar.' FROM locations WHERE slug = 'bozburun-yacht-club'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'bozburun-yacht-club'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'bozburun-yacht-club' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Octopus Restaurant · güven: medium · kaynak: www.navily.com, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'octopus-restaurant-sogut', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Octopus Restaurant', 'Söğüt Koyu''ndaki köklü restoran; teknelere kendi iskelesinde bağlama imkânı verir. Duş, WC ve Wi-Fi mevcuttur.',
  ST_SetSRID(ST_MakePoint(28.0833, 36.6587), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Octopus Restaurant', 'Söğüt Koyu''ndaki köklü restoran; teknelere kendi iskelesinde bağlama imkânı verir. Duş, WC ve Wi-Fi mevcuttur.' FROM locations WHERE slug = 'octopus-restaurant-sogut'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri', NULL, NULL, NULL
FROM locations WHERE slug = 'octopus-restaurant-sogut'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'octopus-restaurant-sogut' AND a.code IN ('restaurant', 'shower', 'wc', 'wifi')
ON CONFLICT DO NOTHING;

-- --- Loryma Restaurant · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'loryma-restaurant-bozukkale', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Loryma Restaurant', 'Bozukkale (Loryma) Koyu''nda 20''den fazla yat kapasiteli iskelesi ve tonozları olan restoran; personel yanaşmada yardım eder. İskele önü derinliği 8-10 m''dir.',
  ST_SetSRID(ST_MakePoint(28.011648, 36.576377), 4326)::geography,
  NULL, NULL, 8, 10,
  20, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Loryma Restaurant', 'Bozukkale (Loryma) Koyu''nda 20''den fazla yat kapasiteli iskelesi ve tonozları olan restoran; personel yanaşmada yardım eder. İskele önü derinliği 8-10 m''dir.' FROM locations WHERE slug = 'loryma-restaurant-bozukkale'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri, Türk mutfağı', 20, 'restoran misafirlerine bağlama ücretsiz', NULL
FROM locations WHERE slug = 'loryma-restaurant-bozukkale'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'loryma-restaurant-bozukkale' AND a.code IN ('restaurant', 'security')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'loryma-restaurant-bozukkale' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905333434264', NULL, true
FROM locations l WHERE l.slug = 'loryma-restaurant-bozukkale'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905372124339', NULL, false
FROM locations l WHERE l.slug = 'loryma-restaurant-bozukkale'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'paul@lorymarestaurant.com', NULL, false
FROM locations l WHERE l.slug = 'loryma-restaurant-bozukkale'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'http://lorymarestaurant.com', NULL, false
FROM locations l WHERE l.slug = 'loryma-restaurant-bozukkale'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Rosemary Yacht Harbour & Restaurant · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'rosemary-cokertme', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Rosemary Yacht Harbour & Restaurant', 'Çökertme Koyu''nda restoran iskelesi ve tonozlarıyla hizmet veren işletme; VHF 16''dan ''Rosemary Yacht Harbour'' çağrısıyla ulaşılır. İskelede su, elektrik, Wi-Fi ve duş/WC mevcuttur.',
  ST_SetSRID(ST_MakePoint(27.793611, 37.00544), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Rosemary Yacht Harbour & Restaurant', 'Çökertme Koyu''nda restoran iskelesi ve tonozlarıyla hizmet veren işletme; VHF 16''dan ''Rosemary Yacht Harbour'' çağrısıyla ulaşılır. İskelede su, elektrik, Wi-Fi ve duş/WC mevcuttur.' FROM locations WHERE slug = 'rosemary-cokertme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri, Türk mutfağı', NULL, NULL, NULL
FROM locations WHERE slug = 'rosemary-cokertme'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'rosemary-cokertme' AND a.code IN ('restaurant', 'water', 'electricity', 'wifi', 'shower', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'rosemary-cokertme' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902525310158', NULL, true
FROM locations l WHERE l.slug = 'rosemary-cokertme'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905324325731', NULL, false
FROM locations l WHERE l.slug = 'rosemary-cokertme'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'mahirvurmaz@superonline.com', NULL, false
FROM locations l WHERE l.slug = 'rosemary-cokertme'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'http://rosemarycokertme.com', NULL, false
FROM locations l WHERE l.slug = 'rosemary-cokertme'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Denizkızı Kaptan Restaurant · güven: low · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'denizkizi-kaptan-okluk', 5, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Denizkızı Kaptan Restaurant', 'Gökova''nın Okluk (Değirmen Bükü) Koyu''nda yaklaşık 20 tekne kapasiteli iskelesi olan restoran ve market; iskelede elektrik ve su sağlanır.',
  ST_SetSRID(ST_MakePoint(28.169722, 36.9175), 4326)::geography,
  NULL, NULL, NULL, NULL,
  20, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Denizkızı Kaptan Restaurant', 'Gökova''nın Okluk (Değirmen Bükü) Koyu''nda yaklaşık 20 tekne kapasiteli iskelesi olan restoran ve market; iskelede elektrik ve su sağlanır.' FROM locations WHERE slug = 'denizkizi-kaptan-okluk'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, 'deniz ürünleri, et yemekleri', 20, NULL, NULL
FROM locations WHERE slug = 'denizkizi-kaptan-okluk'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'denizkizi-kaptan-okluk' AND a.code IN ('restaurant', 'electricity', 'water', 'market')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'denizkizi-kaptan-okluk' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524655262', NULL, true
FROM locations l WHERE l.slug = 'denizkizi-kaptan-okluk'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905368622544', NULL, false
FROM locations l WHERE l.slug = 'denizkizi-kaptan-okluk'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@denizkizikaptan.com', NULL, false
FROM locations l WHERE l.slug = 'denizkizi-kaptan-okluk'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'http://denizkizikaptan.com', NULL, false
FROM locations l WHERE l.slug = 'denizkizi-kaptan-okluk'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Göcek Yakıt İskelesi (Petrol Ofisi) · güven: high · kaynak: www.sea-seek.com, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gocek-yakit-iskelesi-po', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Göcek Yakıt İskelesi (Petrol Ofisi)', 'Göcek köy rıhtımının kuzeydoğu başında yer alan Petrol Ofisi yakıt iskelesi. Pompa hortumu iskelenin tamamına yetişir; tekneler aborda olarak ikmal yapar.',
  ST_SetSRID(ST_MakePoint(28.939501, 36.751999), 4326)::geography,
  NULL, NULL, 2.5, 4,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göcek Yakıt İskelesi (Petrol Ofisi)', 'Göcek köy rıhtımının kuzeydoğu başında yer alan Petrol Ofisi yakıt iskelesi. Pompa hortumu iskelenin tamamına yetişir; tekneler aborda olarak ikmal yapar.' FROM locations WHERE slug = 'gocek-yakit-iskelesi-po'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, 'Nakit ve kredi kartı'
FROM locations WHERE slug = 'gocek-yakit-iskelesi-po'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gocek-yakit-iskelesi-po' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Göcek Lukoil Yakıt İskelesi · güven: medium · kaynak: my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gocek-lukoil-yakit-iskelesi', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Göcek Lukoil Yakıt İskelesi', 'Göcek koyunun batı kıyısında yüzer pontonlu Lukoil yakıt istasyonu. Tekneler pontona aborda olur; derinlik 4 m ve üzeridir, büyük yatlar için mobil tanker çağrılabilir.',
  ST_SetSRID(ST_MakePoint(28.924889, 36.748169), 4326)::geography,
  NULL, NULL, 4, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göcek Lukoil Yakıt İskelesi', 'Göcek koyunun batı kıyısında yüzer pontonlu Lukoil yakıt istasyonu. Tekneler pontona aborda olur; derinlik 4 m ve üzeridir, büyük yatlar için mobil tanker çağrılabilir.' FROM locations WHERE slug = 'gocek-lukoil-yakit-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, 4, 'Nakit ve kredi kartı'
FROM locations WHERE slug = 'gocek-lukoil-yakit-iskelesi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gocek-lukoil-yakit-iskelesi' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902526451458', NULL, true
FROM locations l WHERE l.slug = 'gocek-lukoil-yakit-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Datça Limanı Yakıt İkmal Noktası · güven: low · kaynak: www.cruiserswiki.org, my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'datca-yakit-iskelesi', 6, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Datça Limanı Yakıt İkmal Noktası', 'Datça yat limanındaki yakıt ikmal noktası; kaynaklar sabit iskele ile mini-tanker servisi konusunda çelişmektedir.',
  ST_SetSRID(ST_MakePoint(27.691667, 36.721667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Datça Limanı Yakıt İkmal Noktası', 'Datça yat limanındaki yakıt ikmal noktası; kaynaklar sabit iskele ile mini-tanker servisi konusunda çelişmektedir.' FROM locations WHERE slug = 'datca-yakit-iskelesi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'datca-yakit-iskelesi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'datca-yakit-iskelesi' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Palmiye Yakıt İskelesi · güven: low · kaynak: my-sea.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'palmiye-yakit-kecibuku', 6, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Palmiye Yakıt İskelesi', 'Keçi Bükü''nde (Orhaniye) kıyıda yakıt tankı ve iskeleye uzanan ikmal hortumu bulunan küçük tesis; yakıt için VHF 73 kanalından çağrı yapılır.',
  ST_SetSRID(ST_MakePoint(28.127146, 36.75876), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Palmiye Yakıt İskelesi', 'Keçi Bükü''nde (Orhaniye) kıyıda yakıt tankı ve iskeleye uzanan ikmal hortumu bulunan küçük tesis; yakıt için VHF 73 kanalından çağrı yapılır.' FROM locations WHERE slug = 'palmiye-yakit-kecibuku'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'palmiye-yakit-kecibuku'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'palmiye-yakit-kecibuku' AND a.code IN ('fuel', 'restaurant')
ON CONFLICT DO NOTHING;

-- --- Değirmen Bükü (İngiliz Limanı) · güven: high · kaynak: turkeymarinas.blogspot.com, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'degirmen-buku-ingiliz-limani', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Değirmen Bükü (İngiliz Limanı)', 'Gökova Körfezi''nin en büyük koyu olan Değirmen Bükü yaklaşık 3 km uzunluğunda olup çevresinde çok sayıda güvenli demirleme yeri barındırır; batı kolu İngiliz Limanı olarak bilinir. 6-7 m derinliğe demirlenir; dip çamurdur, tutuş iyidir ve koy iyi korunaklıdır.',
  ST_SetSRID(ST_MakePoint(28.164239, 36.92633), 4326)::geography,
  NULL, NULL, 6, 7,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Değirmen Bükü (İngiliz Limanı)', 'Gökova Körfezi''nin en büyük koyu olan Değirmen Bükü yaklaşık 3 km uzunluğunda olup çevresinde çok sayıda güvenli demirleme yeri barındırır; batı kolu İngiliz Limanı olarak bilinir. 6-7 m derinliğe demirlenir; dip çamurdur, tutuş iyidir ve koy iyi korunaklıdır.' FROM locations WHERE slug = 'degirmen-buku-ingiliz-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'degirmen-buku-ingiliz-limani'
ON CONFLICT (location_id) DO NOTHING;

-- --- Okluk Koyu · güven: high · kaynak: turkeymarinas.blogspot.com, coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'okluk-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Okluk Koyu', 'Değirmen Bükü''nün güneydoğusundaki Okluk Koyu her yönden korunaklı bir demirleme alanıdır ve kayalıklardaki deniz kızı heykeliyle bilinir. Derinlik iç kesimde 12 m''den kıyıya doğru 7-8 m''ye düşer; dip çamurdur ve tutuş mükemmeldir.',
  ST_SetSRID(ST_MakePoint(28.169167, 36.918333), 4326)::geography,
  NULL, NULL, 7, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Okluk Koyu', 'Değirmen Bükü''nün güneydoğusundaki Okluk Koyu her yönden korunaklı bir demirleme alanıdır ve kayalıklardaki deniz kızı heykeliyle bilinir. Derinlik iç kesimde 12 m''den kıyıya doğru 7-8 m''ye düşer; dip çamurdur ve tutuş mükemmeldir.' FROM locations WHERE slug = 'okluk-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'okluk-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Löngöz Koyu (Kargılı) · güven: medium · kaynak: www.navily.com, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'longoz-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Löngöz Koyu (Kargılı)', 'Gökova Körfezi''nin güney kıyısında, Değirmen Bükü''nün batısında yer alan dar ve derin bir koydur. Dip kum, kaya ve çamur karışımıdır; demirlemeye izin verilir ve koyda küçük bir iskele bulunur.',
  ST_SetSRID(ST_MakePoint(28.0975, 36.9375), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Löngöz Koyu (Kargılı)', 'Gökova Körfezi''nin güney kıyısında, Değirmen Bükü''nün batısında yer alan dar ve derin bir koydur. Dip kum, kaya ve çamur karışımıdır; demirlemeye izin verilir ve koyda küçük bir iskele bulunur.' FROM locations WHERE slug = 'longoz-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'longoz-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sedir Adası Demirleme Alanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sedir-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-ula'),
  'Sedir Adası Demirleme Alanı', 'Antik Kedrai kentine ve Kleopatra Plajı''na ev sahipliği yapan Sedir Adası çevresinde doğu koyunda 8-12 m, güney koyunda 6-9 m derinliğe demirlenir. Ana demir yeri kuzey rüzgarlarına açıktır; güney koyu kuzey rüzgarlarına karşı daha korunaklıdır.',
  ST_SetSRID(ST_MakePoint(28.207395, 36.994373), 4326)::geography,
  NULL, NULL, 6, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sedir Adası Demirleme Alanı', 'Antik Kedrai kentine ve Kleopatra Plajı''na ev sahipliği yapan Sedir Adası çevresinde doğu koyunda 8-12 m, güney koyunda 6-9 m derinliğe demirlenir. Ana demir yeri kuzey rüzgarlarına açıktır; güney koyu kuzey rüzgarlarına karşı daha korunaklıdır.' FROM locations WHERE slug = 'sedir-adasi-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'kuzey rüzgarlarına açıktır; kuvvetli rüzgarda belirgin dalga girer', true
FROM locations WHERE slug = 'sedir-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Akbük Koyu (Gökova) · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'akbuk-koyu-gokova', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Akbük Koyu (Gökova)', 'Gökova Körfezi''nin kuzey kıyısında, çam ormanlarıyla çevrili bir demirleme koyudur. Dip kumdur; demirlemeye izin verilir ve kıyıda plaj ile küçük işletmeler bulunur.',
  ST_SetSRID(ST_MakePoint(28.1005, 37.03333), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Akbük Koyu (Gökova)', 'Gökova Körfezi''nin kuzey kıyısında, çam ormanlarıyla çevrili bir demirleme koyudur. Dip kumdur; demirlemeye izin verilir ve kıyıda plaj ile küçük işletmeler bulunur.' FROM locations WHERE slug = 'akbuk-koyu-gokova'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'akbuk-koyu-gokova'
ON CONFLICT (location_id) DO NOTHING;

-- --- Tuzla (Çanak) Koyu · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tuzla-koyu-gokova', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Tuzla (Çanak) Koyu', 'Gökova Körfezi''nin güney kıyısında, Löngöz''ün batısında yer alan bir demirleme koyudur. Dip kumdur; demirlemeye izin verilir ve koyda iskele imkânı bulunur.',
  ST_SetSRID(ST_MakePoint(28.03167, 36.92383), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Tuzla (Çanak) Koyu', 'Gökova Körfezi''nin güney kıyısında, Löngöz''ün batısında yer alan bir demirleme koyudur. Dip kumdur; demirlemeye izin verilir ve koyda iskele imkânı bulunur.' FROM locations WHERE slug = 'tuzla-koyu-gokova'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'tuzla-koyu-gokova'
ON CONFLICT (location_id) DO NOTHING;

-- --- Bencik Koyu · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bencik-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Bencik Koyu', 'Hisarönü Körfezi''nin iç ucunda, Datça Yarımadası''nın en dar noktasında yer alan derin ve dar, fiyort görünümlü bir koydur. Dip çamurdur; demirleyip kıçtan karaya halat verilebilir.',
  ST_SetSRID(ST_MakePoint(28.042, 36.78217), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bencik Koyu', 'Hisarönü Körfezi''nin iç ucunda, Datça Yarımadası''nın en dar noktasında yer alan derin ve dar, fiyort görünümlü bir koydur. Dip çamurdur; demirleyip kıçtan karaya halat verilebilir.' FROM locations WHERE slug = 'bencik-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'bencik-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Selimiye Koyu Demirleme Alanı · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'selimiye-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Selimiye Koyu Demirleme Alanı', 'Bozburun Yarımadası''ndaki Selimiye köyünün önünde yer alan geniş bir demirleme alanıdır. Dip kum ve yosundur; demirlemeye ve kıçtan karaya bağlanmaya izin verilir.',
  ST_SetSRID(ST_MakePoint(28.09167, 36.7195), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Selimiye Koyu Demirleme Alanı', 'Bozburun Yarımadası''ndaki Selimiye köyünün önünde yer alan geniş bir demirleme alanıdır. Dip kum ve yosundur; demirlemeye ve kıçtan karaya bağlanmaya izin verilir.' FROM locations WHERE slug = 'selimiye-koyu-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'selimiye-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Keçi Bükü (Orhaniye) Demirleme Alanı · güven: medium · kaynak: gotosailing.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'keci-buku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Keçi Bükü (Orhaniye) Demirleme Alanı', 'Hisarönü Körfezi''nin ağzında yer alan Keçi Bükü, ortasındaki kale kalıntılı adacık ve Kızkumu kum setiyle bilinir. Koy tüm rüzgarlara karşı iyi korunaklıdır; girişin doğu geçidinden seyredilmesi önerilir.',
  ST_SetSRID(ST_MakePoint(28.1299, 36.751), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Keçi Bükü (Orhaniye) Demirleme Alanı', 'Hisarönü Körfezi''nin ağzında yer alan Keçi Bükü, ortasındaki kale kalıntılı adacık ve Kızkumu kum setiyle bilinir. Koy tüm rüzgarlara karşı iyi korunaklıdır; girişin doğu geçidinden seyredilmesi önerilir.' FROM locations WHERE slug = 'keci-buku-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'keci-buku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Dirsek Bükü Demirleme Alanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'dirsek-buku-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Dirsek Bükü Demirleme Alanı', 'Hisarönü Körfezi''nin güneybatı kıyısında, karayolu bağlantısı olmayan L şeklinde ıssız bir koydur ve bölge koyları arasında en iyi korunmayı sağlar. Dip kumdur ve tutuş iyidir.',
  ST_SetSRID(ST_MakePoint(27.980973, 36.691718), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Dirsek Bükü Demirleme Alanı', 'Hisarönü Körfezi''nin güneybatı kıyısında, karayolu bağlantısı olmayan L şeklinde ıssız bir koydur ve bölge koyları arasında en iyi korunmayı sağlar. Dip kumdur ve tutuş iyidir.' FROM locations WHERE slug = 'dirsek-buku-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'kuvvetli kuzey rüzgarlarında koya dalga girer', true
FROM locations WHERE slug = 'dirsek-buku-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Serçe Limanı · güven: high · kaynak: turkeymarinas.blogspot.com, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'serce-limani', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Serçe Limanı', 'Bozburun Yarımadası''nın güney kıyısında, yaklaşık 135 m genişliğinde dar bir girişle girilen fiyort benzeri bu doğal liman her havada korunma sağlar. Kuzey bölümde 10 m, güney bölümde 5-8 m derinlikte kıçtan karaya demirlenir; dip iyi tutar.',
  ST_SetSRID(ST_MakePoint(28.050651, 36.577845), 4326)::geography,
  NULL, NULL, 5, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Serçe Limanı', 'Bozburun Yarımadası''nın güney kıyısında, yaklaşık 135 m genişliğinde dar bir girişle girilen fiyort benzeri bu doğal liman her havada korunma sağlar. Kuzey bölümde 10 m, güney bölümde 5-8 m derinlikte kıçtan karaya demirlenir; dip iyi tutar.' FROM locations WHERE slug = 'serce-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'hakim rüzgar sert estiğinde bir miktar dalga girebilir', true
FROM locations WHERE slug = 'serce-limani'
ON CONFLICT (location_id) DO NOTHING;

-- --- Gerbekse Koyu · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gerbekse-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Gerbekse Koyu', 'Marmaris ile Bozburun arasında, kıyısından Bizans dönemi kilise kalıntıları görülen küçük bir koydur. Plaj önünde 5-7 m derinliğe demirlenir; koy meltemiye karşı iyi korunaklıdır.',
  ST_SetSRID(ST_MakePoint(28.22525, 36.700511), 4326)::geography,
  NULL, NULL, 5, 7,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gerbekse Koyu', 'Marmaris ile Bozburun arasında, kıyısından Bizans dönemi kilise kalıntıları görülen küçük bir koydur. Plaj önünde 5-7 m derinliğe demirlenir; koy meltemiye karşı iyi korunaklıdır.' FROM locations WHERE slug = 'gerbekse-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'gerbekse-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Söğüt Koyu Demirleme Alanı · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sogut-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Söğüt Koyu Demirleme Alanı', 'Bozburun Yarımadası''nın güneyindeki Söğüt köyünün önünde yer alan bir demirleme alanıdır. Dip kum, yosun ve çamur karışımıdır; demirlemeye izin verilir.',
  ST_SetSRID(ST_MakePoint(28.07967, 36.66), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Söğüt Koyu Demirleme Alanı', 'Bozburun Yarımadası''nın güneyindeki Söğüt köyünün önünde yer alan bir demirleme alanıdır. Dip kum, yosun ve çamur karışımıdır; demirlemeye izin verilir.' FROM locations WHERE slug = 'sogut-koyu-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'sogut-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kumlubük Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kumlubuk-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Kumlubük Koyu', 'Marmaris yakınında, Amos antik kentinin eteklerinde yer alan geniş kumlu bir koydur. Yat kulübü iskelesi önünde 3,5-4,5 m derinlik bulunur ve 15 m derinlikte 18 bağlama şamandırası mevcuttur.',
  ST_SetSRID(ST_MakePoint(28.274996, 36.745246), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kumlubük Koyu', 'Marmaris yakınında, Amos antik kentinin eteklerinde yer alan geniş kumlu bir koydur. Yat kulübü iskelesi önünde 3,5-4,5 m derinlik bulunur ve 15 m derinlikte 18 bağlama şamandırası mevcuttur.' FROM locations WHERE slug = 'kumlubuk-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'kumlubuk-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Çiftlik Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ciftlik-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Çiftlik Koyu', 'Marmaris''in yaklaşık 14 deniz mili güneybatısında yer alan koy, önündeki Çiftlik Adası sayesinde meltemiye karşı korunur. Kuzeybatıda 7-10 m, ada tarafında 5-9 m derinliğe demirlenir; kıyı açığındaki sığ resiflere dikkat edilmelidir.',
  ST_SetSRID(ST_MakePoint(28.241262, 36.715031), 4326)::geography,
  NULL, NULL, 5, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çiftlik Koyu', 'Marmaris''in yaklaşık 14 deniz mili güneybatısında yer alan koy, önündeki Çiftlik Adası sayesinde meltemiye karşı korunur. Kuzeybatıda 7-10 m, ada tarafında 5-9 m derinliğe demirlenir; kıyı açığındaki sığ resiflere dikkat edilmelidir.' FROM locations WHERE slug = 'ciftlik-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'güneye açıktır; koyda sağanak rüzgarlar görülür', true
FROM locations WHERE slug = 'ciftlik-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kuruca Bükü · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kuruca-buku', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Kuruca Bükü', 'Datça Yarımadası''nın güney kıyısında, çam ormanlarıyla çevrili kuzeybatıya girintili bir koydur. Kamp alanı önünde 6-10 m derinliğe demirlenir; güneydoğu rüzgarları dışında her yönden korunma sağlar.',
  ST_SetSRID(ST_MakePoint(27.903694, 36.748855), 4326)::geography,
  NULL, NULL, 6, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kuruca Bükü', 'Datça Yarımadası''nın güney kıyısında, çam ormanlarıyla çevrili kuzeybatıya girintili bir koydur. Kamp alanı önünde 6-10 m derinliğe demirlenir; güneydoğu rüzgarları dışında her yönden korunma sağlar.' FROM locations WHERE slug = 'kuruca-buku'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'girişte hakim rüzgar dalgası hissedilir; güneydoğu rüzgarlarına açıktır', true
FROM locations WHERE slug = 'kuruca-buku'
ON CONFLICT (location_id) DO NOTHING;

-- --- Knidos Antik Limanı · güven: medium · kaynak: www.navily.com, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'knidos-antik-limani', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Knidos Antik Limanı', 'Datça Yarımadası''nın batı ucunda, antik Knidos kentinin kalıntılarının önündeki tarihi limanda demirlenir. Dip kum, kaya ve yosun karışımıdır; demirlemeye izin verilir.',
  ST_SetSRID(ST_MakePoint(27.37667, 36.68367), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Knidos Antik Limanı', 'Datça Yarımadası''nın batı ucunda, antik Knidos kentinin kalıntılarının önündeki tarihi limanda demirlenir. Dip kum, kaya ve yosun karışımıdır; demirlemeye izin verilir.' FROM locations WHERE slug = 'knidos-antik-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'knidos-antik-limani'
ON CONFLICT (location_id) DO NOTHING;

-- --- Mersincik Koyu · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mersincik-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Mersincik Koyu', 'Datça Yarımadası''nın kuzeybatı ucunda yer alan ıssız bir demirleme koyudur. Dip kum ve yosundur; demirlemeye izin verilir ve kıyıda hizmet bulunmaz.',
  ST_SetSRID(ST_MakePoint(27.47783, 36.752), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mersincik Koyu', 'Datça Yarımadası''nın kuzeybatı ucunda yer alan ıssız bir demirleme koyudur. Dip kum ve yosundur; demirlemeye izin verilir ve kıyıda hizmet bulunmaz.' FROM locations WHERE slug = 'mersincik-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'mersincik-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sıralıbük Koyu · güven: high · kaynak: www.navily.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'siralibuk-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Sıralıbük Koyu', 'Göcek Körfezi''nin batı kıyısında, Sarsala ile Taşyaka arasında yer alan doğal bir demirleme koyudur. Zemin kum, çamur, kaya ve yosun karışımıdır; demirleme ve kıçtan karaya halat verme uygulanır.',
  ST_SetSRID(ST_MakePoint(28.8588, 36.6762), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sıralıbük Koyu', 'Göcek Körfezi''nin batı kıyısında, Sarsala ile Taşyaka arasında yer alan doğal bir demirleme koyudur. Zemin kum, çamur, kaya ve yosun karışımıdır; demirleme ve kıçtan karaya halat verme uygulanır.' FROM locations WHERE slug = 'siralibuk-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, false
FROM locations WHERE slug = 'siralibuk-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kille Bükü · güven: high · kaynak: www.navily.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kille-buku', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Kille Bükü', 'Göcek Körfezi''nin batı kıyısında, Boynuzbükü''nün güneyinde yer alan sakin bir demirleme koyudur. Zemin kumdur; demirleme ve kıçtan karaya bağlama yapılır, koyda tesis bulunmaz.',
  ST_SetSRID(ST_MakePoint(28.8778, 36.6997), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kille Bükü', 'Göcek Körfezi''nin batı kıyısında, Boynuzbükü''nün güneyinde yer alan sakin bir demirleme koyudur. Zemin kumdur; demirleme ve kıçtan karaya bağlama yapılır, koyda tesis bulunmaz.' FROM locations WHERE slug = 'kille-buku'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, false
FROM locations WHERE slug = 'kille-buku'
ON CONFLICT (location_id) DO NOTHING;

-- --- Yassıca Adaları Demirleme Alanı · güven: high · kaynak: www.navily.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yassica-adalari', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Yassıca Adaları Demirleme Alanı', 'Göcek önünde yer alan alçak ada grubudur; tekneler adalar arasındaki sığ kumluk alanda demirler veya kıçtan karaya bağlanır. Zemin kum ve kayadır; bölgede az sayıda misafir şamandırası bildirilmiştir.',
  ST_SetSRID(ST_MakePoint(28.9322, 36.7105), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yassıca Adaları Demirleme Alanı', 'Göcek önünde yer alan alçak ada grubudur; tekneler adalar arasındaki sığ kumluk alanda demirler veya kıçtan karaya bağlanır. Zemin kum ve kayadır; bölgede az sayıda misafir şamandırası bildirilmiştir.' FROM locations WHERE slug = 'yassica-adalari'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, false
FROM locations WHERE slug = 'yassica-adalari'
ON CONFLICT (location_id) DO NOTHING;

-- --- Tersane Adası Koyu · güven: high · kaynak: www.sea-seek.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tersane-adasi-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Tersane Adası Koyu', 'Tersane Adası''nın koyunda, girişinde Bizans-Osmanlı dönemi tersane kalıntıları bulunan tarihi bir demirleme yeri vardır. Yaklaşık 14 m derinlikte demirlenip kıçtan karaya bağlanılır, tutuş iyidir; koyun dibindeki iki küçük ağız sığdır.',
  ST_SetSRID(ST_MakePoint(28.9153, 36.6754), 4326)::geography,
  NULL, NULL, 2, 14,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Tersane Adası Koyu', 'Tersane Adası''nın koyunda, girişinde Bizans-Osmanlı dönemi tersane kalıntıları bulunan tarihi bir demirleme yeri vardır. Yaklaşık 14 m derinlikte demirlenip kıçtan karaya bağlanılır, tutuş iyidir; koyun dibindeki iki küçük ağız sığdır.' FROM locations WHERE slug = 'tersane-adasi-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'kuzey-kuzeybatı rüzgarlarına açık', false
FROM locations WHERE slug = 'tersane-adasi-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Hamam Koyu (Manastır Koyu) Demirleme Alanı · güven: high · kaynak: www.sea-seek.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'hamam-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Hamam Koyu (Manastır Koyu) Demirleme Alanı', 'Manastır Koyu olarak da bilinen koy, kıyısındaki ''Kleopatra Hamamı'' kalıntılarıyla ünlü bir demirleme alanıdır. Güney/batı kesiminde 10-12 m derinlikte kumlu zemine demirlenir; koy kuzeye açıktır ve güneydoğu adacığından uzanan resif tehlike oluşturur.',
  ST_SetSRID(ST_MakePoint(28.8553, 36.641), 4326)::geography,
  NULL, NULL, 10, 12,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Hamam Koyu (Manastır Koyu) Demirleme Alanı', 'Manastır Koyu olarak da bilinen koy, kıyısındaki ''Kleopatra Hamamı'' kalıntılarıyla ünlü bir demirleme alanıdır. Güney/batı kesiminde 10-12 m derinlikte kumlu zemine demirlenir; koy kuzeye açıktır ve güneydoğu adacığından uzanan resif tehlike oluşturur.' FROM locations WHERE slug = 'hamam-koyu-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'kuzeye açık', false
FROM locations WHERE slug = 'hamam-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Katrancı Koyu · güven: high · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'katranci-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Katrancı Koyu', 'Fethiye Körfezi''nin doğu kıyısında, ormanlık tabiat parkı içinde yer alan bir koydur. Zemin çamurdur ve demirlemeye izin verilir; kıyıda plaj ve mevsimlik büfe bulunur.',
  ST_SetSRID(ST_MakePoint(29.0333, 36.7053), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Katrancı Koyu', 'Fethiye Körfezi''nin doğu kıyısında, ormanlık tabiat parkı içinde yer alan bir koydur. Zemin çamurdur ve demirlemeye izin verilir; kıyıda plaj ve mevsimlik büfe bulunur.' FROM locations WHERE slug = 'katranci-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'katranci-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Küçük Kargı Koyu · güven: high · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kucuk-kargi-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Küçük Kargı Koyu', 'Fethiye Körfezi''nin doğu kıyısında, Katrancı yakınında çam ormanlarıyla çevrili bir demirleme koyudur. Zemin çamurdur ve demirlemeye izin verilir; kıyıda plaj vardır.',
  ST_SetSRID(ST_MakePoint(29.02, 36.7145), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Küçük Kargı Koyu', 'Fethiye Körfezi''nin doğu kıyısında, Katrancı yakınında çam ormanlarıyla çevrili bir demirleme koyudur. Zemin çamurdur ve demirlemeye izin verilir; kıyıda plaj vardır.' FROM locations WHERE slug = 'kucuk-kargi-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'kucuk-kargi-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Turunç Pınarı Koyu · güven: medium · kaynak: gocekfethiyediveguide.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'turunc-pinari-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Turunç Pınarı Koyu', 'Fethiye liman girişinin yaklaşık 2 mil batısında, körfezin kuzey kıyısında restoranıyla bilinen bir koydur. Yaz aylarında genellikle sakindir ve demirlemeye uygundur; koy dışında zemin 45-50 m''ye dik iner.',
  ST_SetSRID(ST_MakePoint(29.0527, 36.6155), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Turunç Pınarı Koyu', 'Fethiye liman girişinin yaklaşık 2 mil batısında, körfezin kuzey kıyısında restoranıyla bilinen bir koydur. Yaz aylarında genellikle sakindir ve demirlemeye uygundur; koy dışında zemin 45-50 m''ye dik iner.' FROM locations WHERE slug = 'turunc-pinari-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'yaz döneminde genellikle sakin', true
FROM locations WHERE slug = 'turunc-pinari-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Göbün Koyu Şamandıra Sahası · güven: medium · kaynak: www.navily.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gobun-samandira-sahasi', 9, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Göbün Koyu Şamandıra Sahası', 'Kapıdağ Yarımadası''nın güneydoğusundaki Göbün (Kapı Creek) koyu, Göcek Özel Çevre Koruma Bölgesi''nde ücretli bağlama sistemine dahildir. 2025 rejimiyle koylarda serbest demirleme yerine Türkiye Çevre Ajansı işletimindeki mapa/tonoz/şamandıra sistemleri kullanılmaktadır; koy zemini kumdur.',
  ST_SetSRID(ST_MakePoint(28.8937, 36.6438), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göbün Koyu Şamandıra Sahası', 'Kapıdağ Yarımadası''nın güneydoğusundaki Göbün (Kapı Creek) koyu, Göcek Özel Çevre Koruma Bölgesi''nde ücretli bağlama sistemine dahildir. 2025 rejimiyle koylarda serbest demirleme yerine Türkiye Çevre Ajansı işletimindeki mapa/tonoz/şamandıra sistemleri kullanılmaktadır; koy zemini kumdur.' FROM locations WHERE slug = 'gobun-samandira-sahasi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, false
FROM locations WHERE slug = 'gobun-samandira-sahasi'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sarsala Koyu Şamandıra Sahası · güven: medium · kaynak: www.sea-seek.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sarsala-samandira-sahasi', 9, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Sarsala Koyu Şamandıra Sahası', 'Göcek Körfezi''nin batı kıyısındaki büyük Sarsala koyu, 2025 Göcek bağlama rejiminde şamandıra/tonoz sistemi kurulan koylar arasındadır ve sistem Türkiye Çevre Ajansı tarafından ücretli işletilmektedir. Koy kuzeydoğuya açıktır.',
  ST_SetSRID(ST_MakePoint(28.8596, 36.661), 4326)::geography,
  NULL, NULL, NULL, 15,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sarsala Koyu Şamandıra Sahası', 'Göcek Körfezi''nin batı kıyısındaki büyük Sarsala koyu, 2025 Göcek bağlama rejiminde şamandıra/tonoz sistemi kurulan koylar arasındadır ve sistem Türkiye Çevre Ajansı tarafından ücretli işletilmektedir. Koy kuzeydoğuya açıktır.' FROM locations WHERE slug = 'sarsala-samandira-sahasi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'kuzeydoğuya açık', false
FROM locations WHERE slug = 'sarsala-samandira-sahasi'
ON CONFLICT (location_id) DO NOTHING;

-- --- Boynuzbükü Şamandıra Sahası · güven: medium · kaynak: www.navily.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'boynuzbuku-samandira-sahasi', 9, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Boynuzbükü Şamandıra Sahası', 'Göcek Körfezi''nin kuzeybatısındaki ağaçlıklı ve derin Boynuzbükü, 2025 Göcek bağlama rejiminde ücretli şamandıra/tonoz sistemine dahildir; sistem Türkiye Çevre Ajansı tarafından işletilmektedir. Koy zemini çamurdur.',
  ST_SetSRID(ST_MakePoint(28.8967, 36.7112), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Boynuzbükü Şamandıra Sahası', 'Göcek Körfezi''nin kuzeybatısındaki ağaçlıklı ve derin Boynuzbükü, 2025 Göcek bağlama rejiminde ücretli şamandıra/tonoz sistemine dahildir; sistem Türkiye Çevre Ajansı tarafından işletilmektedir. Koy zemini çamurdur.' FROM locations WHERE slug = 'boynuzbuku-samandira-sahasi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, false
FROM locations WHERE slug = 'boynuzbuku-samandira-sahasi'
ON CONFLICT (location_id) DO NOTHING;

-- --- Bedri Rahmi (Taşyaka) Şamandıra Sahası · güven: medium · kaynak: karyayolu.wordpress.com, www.adf.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bedri-rahmi-samandira-sahasi', 9, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Bedri Rahmi (Taşyaka) Şamandıra Sahası', 'Taşyaka olarak da bilinen koy, Likya kaya mezarları ve Bedri Rahmi Eyüboğlu''nun balık figürüyle tanınır; 2025 Göcek bağlama rejiminde Türkiye Çevre Ajansı''nın ücretli şamandıra/tonoz sistemi kurulan koyları arasındadır. Taşkaya adacığının kuzeybatısında geniş ve korunaklı bir bağlama alanı sunar.',
  ST_SetSRID(ST_MakePoint(28.8668, 36.6905), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bedri Rahmi (Taşyaka) Şamandıra Sahası', 'Taşyaka olarak da bilinen koy, Likya kaya mezarları ve Bedri Rahmi Eyüboğlu''nun balık figürüyle tanınır; 2025 Göcek bağlama rejiminde Türkiye Çevre Ajansı''nın ücretli şamandıra/tonoz sistemi kurulan koyları arasındadır. Taşkaya adacığının kuzeybatısında geniş ve korunaklı bir bağlama alanı sunar.' FROM locations WHERE slug = 'bedri-rahmi-samandira-sahasi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, false
FROM locations WHERE slug = 'bedri-rahmi-samandira-sahasi'
ON CONFLICT (location_id) DO NOTHING;

-- --- Poyrazköy Balıkçı Barınağı ve Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'poyrazkoy-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-beykoz'),
  'Poyrazköy Balıkçı Barınağı ve Koyu', 'İstanbul Boğazı''nın Karadeniz çıkışına 1,5 mil mesafede, 470 m ana mendirekle korunan barınak; tekneler mendirek gerisinde demirler veya rıhtıma bağlanır. Tutuş iyi, her yönden korunaklıdır. Talep üzerine yakıt getirtilebildiği ve küçük onarım imkânı bildirilmektedir.',
  ST_SetSRID(ST_MakePoint(29.12526, 41.203694), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Poyrazköy Balıkçı Barınağı ve Koyu', 'İstanbul Boğazı''nın Karadeniz çıkışına 1,5 mil mesafede, 470 m ana mendirekle korunan barınak; tekneler mendirek gerisinde demirler veya rıhtıma bağlanır. Tutuş iyi, her yönden korunaklıdır. Talep üzerine yakıt getirtilebildiği ve küçük onarım imkânı bildirilmektedir.' FROM locations WHERE slug = 'poyrazkoy-balikci-barinagi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'poyrazkoy-balikci-barinagi' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'poyrazkoy-balikci-barinagi' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902163201488', NULL, false
FROM locations l WHERE l.slug = 'poyrazkoy-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Çam Limanı Koyu (Heybeliada) · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'cam-limani-koyu-heybeliada', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-adalar'),
  'Çam Limanı Koyu (Heybeliada)', 'Heybeliada''nın güneybatısında, Adalar''ın hâkim kuzey/kuzeydoğu rüzgârlarına karşı gerçek anlamda korunaklı tek doğal demir yeri. Kum ve yosun zeminde tutuş iyidir; hafta sonları İstanbul''dan gelen 50-60 tekneyi ağırlar.',
  ST_SetSRID(ST_MakePoint(29.085, 40.87), 4326)::geography,
  NULL, NULL, 5, 15,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çam Limanı Koyu (Heybeliada)', 'Heybeliada''nın güneybatısında, Adalar''ın hâkim kuzey/kuzeydoğu rüzgârlarına karşı gerçek anlamda korunaklı tek doğal demir yeri. Kum ve yosun zeminde tutuş iyidir; hafta sonları İstanbul''dan gelen 50-60 tekneyi ağırlar.' FROM locations WHERE slug = 'cam-limani-koyu-heybeliada'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'K/KD rüzgârlarında korunaklı, G rüzgârlarına açık', true
FROM locations WHERE slug = 'cam-limani-koyu-heybeliada'
ON CONFLICT (location_id) DO NOTHING;

-- --- Büyükada Kuzey Kıyısı Demirleme · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'buyukada-kuzey-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-adalar'),
  'Büyükada Kuzey Kıyısı Demirleme', 'Büyükada''nın kuzey kıyısında, vapur iskelesinin batısında 3-5 m derinlikte, kum-yosun zeminli demirleme alanı. Hâkim kuzey/kuzeydoğu rüzgârlarına açık olduğundan yalnızca durgun havada uygundur; gece kalış tavsiye edilmez.',
  ST_SetSRID(ST_MakePoint(29.1112, 40.859), 4326)::geography,
  NULL, NULL, 3, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Büyükada Kuzey Kıyısı Demirleme', 'Büyükada''nın kuzey kıyısında, vapur iskelesinin batısında 3-5 m derinlikte, kum-yosun zeminli demirleme alanı. Hâkim kuzey/kuzeydoğu rüzgârlarına açık olduğundan yalnızca durgun havada uygundur; gece kalış tavsiye edilmez.' FROM locations WHERE slug = 'buyukada-kuzey-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'K/KD rüzgârlarına açık', true
FROM locations WHERE slug = 'buyukada-kuzey-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Burgazada Restoran Bağlama Şamandıraları · güven: low · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'burgazada-restoran-samandiralari', 5, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-adalar'),
  'Burgazada Restoran Bağlama Şamandıraları', 'Burgazada''da doğu iskelesinin güneyinde kıyı restoranlarının döşediği yaklaşık 15 bağlama şamandırası bulunur; iskele rüzgâraltında makul korunma sağlar. Çok durgun hava dışında gece kalışa uygun değildir, ağırlıkla öğle yemeği durağıdır.',
  ST_SetSRID(ST_MakePoint(29.07, 40.8825), 4326)::geography,
  NULL, NULL, 3.5, 5.5,
  15, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Burgazada Restoran Bağlama Şamandıraları', 'Burgazada''da doğu iskelesinin güneyinde kıyı restoranlarının döşediği yaklaşık 15 bağlama şamandırası bulunur; iskele rüzgâraltında makul korunma sağlar. Çok durgun hava dışında gece kalışa uygun değildir, ağırlıkla öğle yemeği durağıdır.' FROM locations WHERE slug = 'burgazada-restoran-samandiralari'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, 15, NULL, NULL
FROM locations WHERE slug = 'burgazada-restoran-samandiralari'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'burgazada-restoran-samandiralari' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Büyükada Balıkçı Barınağı · güven: low · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'buyukada-balikci-barinagi', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-adalar'),
  'Büyükada Balıkçı Barınağı', 'Büyükada''da yaklaşık 80 tekne kapasiteli, 115 m mendirekli barınak; elektrik, su ve yakıt imkânı bildirilmektedir. Ağırlıklı olarak yerel ve balıkçı tekneleri kullanır.',
  ST_SetSRID(ST_MakePoint(29.137278, 40.873417), 4326)::geography,
  NULL, NULL, NULL, NULL,
  80, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Büyükada Balıkçı Barınağı', 'Büyükada''da yaklaşık 80 tekne kapasiteli, 115 m mendirekli barınak; elektrik, su ve yakıt imkânı bildirilmektedir. Ağırlıklı olarak yerel ve balıkçı tekneleri kullanır.' FROM locations WHERE slug = 'buyukada-balikci-barinagi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'buyukada-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902163823382', NULL, false
FROM locations l WHERE l.slug = 'buyukada-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'iletisim@adalar.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'buyukada-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://adalar.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'buyukada-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Marmara Adası Limanı · güven: high · kaynak: turkeymarinas.blogspot.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'marmara-adasi-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-marmara'),
  'Marmara Adası Limanı', 'Marmara Adası merkez yerleşimindeki belediye limanı; yaklaşık 125 tekne kapasitelidir ve kuzey rıhtımda 6-8 misafir yat baştan/kıçtan kara bağlanabilir. Hâkim kuzey/kuzeydoğu rüzgârlarında korunma iyidir, dağdan sağanak rüzgâr inebilir. Rıhtım dibi 1,5-2,5 m; su çekimi büyük tekneler rıhtım açığında demirlemelidir.',
  ST_SetSRID(ST_MakePoint(27.561121, 40.583862), 4326)::geography,
  NULL, NULL, 1.5, 7,
  125, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Marmara Adası Limanı', 'Marmara Adası merkez yerleşimindeki belediye limanı; yaklaşık 125 tekne kapasitelidir ve kuzey rıhtımda 6-8 misafir yat baştan/kıçtan kara bağlanabilir. Hâkim kuzey/kuzeydoğu rüzgârlarında korunma iyidir, dağdan sağanak rüzgâr inebilir. Rıhtım dibi 1,5-2,5 m; su çekimi büyük tekneler rıhtım açığında demirlemelidir.' FROM locations WHERE slug = 'marmara-adasi-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 125, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'marmara-adasi-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'marmara-adasi-limani' AND a.code IN ('water', 'electricity', 'fuel', 'crane', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902668855489', NULL, false
FROM locations l WHERE l.slug = 'marmara-adasi-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@marmara.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'marmara-adasi-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://marmara.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'marmara-adasi-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Saraylar Limanı (Marmara Adası) · güven: high · kaynak: turkeymarinas.blogspot.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'saraylar-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-marmara'),
  'Saraylar Limanı (Marmara Adası)', 'Marmara Adası''nın kuzeyindeki mermer bloklarla inşa edilmiş belediye barınağı; yaklaşık 50 yat (azami 15 m) doğu mendireğine aborda veya kıçtan kara bağlanabilir. Çamur zeminde tutuş iyi, korunma çok iyidir. Batı rıhtımı sığdır (~1,5 m).',
  ST_SetSRID(ST_MakePoint(27.662976, 40.657747), 4326)::geography,
  15, NULL, 1.5, 6,
  50, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Saraylar Limanı (Marmara Adası)', 'Marmara Adası''nın kuzeyindeki mermer bloklarla inşa edilmiş belediye barınağı; yaklaşık 50 yat (azami 15 m) doğu mendireğine aborda veya kıçtan kara bağlanabilir. Çamur zeminde tutuş iyi, korunma çok iyidir. Batı rıhtımı sığdır (~1,5 m).' FROM locations WHERE slug = 'saraylar-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'saraylar-limani' AND a.code IN ('water', 'electricity', 'fuel', 'restaurant', 'market')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902668855489', NULL, false
FROM locations l WHERE l.slug = 'saraylar-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@marmara.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'saraylar-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Yiğitler Limanı (Avşa Adası) · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yigitler-limani-avsa', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-marmara'),
  'Yiğitler Limanı (Avşa Adası)', 'Avşa Adası''nın doğu kıyısındaki Yiğitler köyü limanı; misafir tekneler doğu havuzunun batı duvarına kıçtan kara bağlanır veya çift demirle yanaşır, belediye görevlisi bağlama ücreti toplar. Kum zeminde tutuş iyi, doğu havuzunda korunma iyidir.',
  ST_SetSRID(ST_MakePoint(27.52533, 40.5), 4326)::geography,
  NULL, NULL, 2, 6,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yiğitler Limanı (Avşa Adası)', 'Avşa Adası''nın doğu kıyısındaki Yiğitler köyü limanı; misafir tekneler doğu havuzunun batı duvarına kıçtan kara bağlanır veya çift demirle yanaşır, belediye görevlisi bağlama ücreti toplar. Kum zeminde tutuş iyi, doğu havuzunda korunma iyidir.' FROM locations WHERE slug = 'yigitler-limani-avsa'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yigitler-limani-avsa' AND a.code IN ('water', 'electricity', 'restaurant', 'market')
ON CONFLICT DO NOTHING;

-- --- Avşa Türkeli Önü Demirleme · güven: low · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'avsa-turkeli-demirleme', 8, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-marmara'),
  'Avşa Türkeli Önü Demirleme', 'Avşa Adası''nın batı kıyısındaki Türkeli merkez yerleşimi önünde demirleme alanı; kasabada market, restoran ve pansiyon imkânları geniştir. İstanbul''a deniz otobüsü/feribot bağlantısı vardır. Batı sektör rüzgârlarına açıktır.',
  ST_SetSRID(ST_MakePoint(27.494681, 40.509209), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Avşa Türkeli Önü Demirleme', 'Avşa Adası''nın batı kıyısındaki Türkeli merkez yerleşimi önünde demirleme alanı; kasabada market, restoran ve pansiyon imkânları geniştir. İstanbul''a deniz otobüsü/feribot bağlantısı vardır. Batı sektör rüzgârlarına açıktır.' FROM locations WHERE slug = 'avsa-turkeli-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'batı sektör rüzgârlarına açık', true
FROM locations WHERE slug = 'avsa-turkeli-demirleme'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'avsa-turkeli-demirleme' AND a.code IN ('restaurant', 'market')
ON CONFLICT DO NOTHING;

-- --- Ekinlik Adası Demirleme · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ekinlik-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-marmara'),
  'Ekinlik Adası Demirleme', 'Avşa''nın kuzeybatısındaki Ekinlik (Koutali) Adası önünde kum zeminli demirleme alanı; demirleme serbesttir. Kıyıda küçük büfe ve plaj imkânı vardır, su ve iskele hizmeti yoktur.',
  ST_SetSRID(ST_MakePoint(27.466667, 40.537833), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ekinlik Adası Demirleme', 'Avşa''nın kuzeybatısındaki Ekinlik (Koutali) Adası önünde kum zeminli demirleme alanı; demirleme serbesttir. Kıyıda küçük büfe ve plaj imkânı vardır, su ve iskele hizmeti yoktur.' FROM locations WHERE slug = 'ekinlik-adasi-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'ekinlik-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Paşalimanı Adası Demirleme · güven: medium · kaynak: www.cruiserswiki.org, turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'pasalimani-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-marmara'),
  'Paşalimanı Adası Demirleme', 'Paşalimanı Adası önünde 5-10 m derinlikte, kum-yosun zeminli açık demirleme; demir zemine oturduğunda tutuş iyidir. Kıyıda restoran ve fırın bulunur.',
  ST_SetSRID(ST_MakePoint(27.6, 40.49), 4326)::geography,
  NULL, NULL, 5, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Paşalimanı Adası Demirleme', 'Paşalimanı Adası önünde 5-10 m derinlikte, kum-yosun zeminli açık demirleme; demir zemine oturduğunda tutuş iyidir. Kıyıda restoran ve fırın bulunur.' FROM locations WHERE slug = 'pasalimani-adasi-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'pasalimani-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'pasalimani-adasi-demirleme' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Karabiga Limanı · güven: medium · kaynak: www.navily.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'karabiga-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-biga'),
  'Karabiga Limanı', 'Biga''ya bağlı Karabiga''da balıkçı ve kuruyük iskelesi olarak çalışan liman; yatlar genellikle balıkçı rıhtımının dış yüzüne kıçtan kara bağlanır, gerekirse kuzeydeki ticari rıhtım kullanılır. Doğu/kuzeydoğu rüzgârlarında rahatsız edici soluğan girer, demir tutuşu zayıf bildirilmiştir. Su ve elektrik yoktur.',
  ST_SetSRID(ST_MakePoint(27.3075, 40.402167), 4326)::geography,
  NULL, NULL, 3, 7,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Karabiga Limanı', 'Biga''ya bağlı Karabiga''da balıkçı ve kuruyük iskelesi olarak çalışan liman; yatlar genellikle balıkçı rıhtımının dış yüzüne kıçtan kara bağlanır, gerekirse kuzeydeki ticari rıhtım kullanılır. Doğu/kuzeydoğu rüzgârlarında rahatsız edici soluğan girer, demir tutuşu zayıf bildirilmiştir. Su ve elektrik yoktur.' FROM locations WHERE slug = 'karabiga-limani'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Çakılköy Balıkçı Barınağı (Kapıdağ) · güven: low · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'cakilkoy-balikci-barinagi', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-bandirma'),
  'Çakılköy Balıkçı Barınağı (Kapıdağ)', 'Kapıdağ Yarımadası''nın doğu kıyısında, Bandırma''nın 6 mil kuzeydoğusunda 695 m mendirekli büyük barınak; rıhtım trol tekneleriyle dolu olduğundan misafir tekneler barınağın kuzey ucunda demirler. Tutuş iyidir ve korunaklı bir mola noktasıdır.',
  ST_SetSRID(ST_MakePoint(28.029944, 40.465083), 4326)::geography,
  NULL, NULL, NULL, NULL,
  350, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çakılköy Balıkçı Barınağı (Kapıdağ)', 'Kapıdağ Yarımadası''nın doğu kıyısında, Bandırma''nın 6 mil kuzeydoğusunda 695 m mendirekli büyük barınak; rıhtım trol tekneleriyle dolu olduğundan misafir tekneler barınağın kuzey ucunda demirler. Tutuş iyidir ve korunaklı bir mola noktasıdır.' FROM locations WHERE slug = 'cakilkoy-balikci-barinagi'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'cakilkoy-balikci-barinagi' AND a.code IN ('fuel', 'water', 'electricity', 'market', 'restaurant')
ON CONFLICT DO NOTHING;

-- --- Şarköy Limanı · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sarkoy-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'tekirdag-sarkoy'),
  'Şarköy Limanı', 'Şarköy ilçe merkezindeki liman; misafir tekneler kıçtan kara veya aborda bağlanabilir. Elektrik, su, duş, WC ve yakıt (dizel/benzin) imkânı bildirilmektedir.',
  ST_SetSRID(ST_MakePoint(27.111333, 40.609167), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Şarköy Limanı', 'Şarköy ilçe merkezindeki liman; misafir tekneler kıçtan kara veya aborda bağlanabilir. Elektrik, su, duş, WC ve yakıt (dizel/benzin) imkânı bildirilmektedir.' FROM locations WHERE slug = 'sarkoy-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'sarkoy-limani' AND a.code IN ('electricity', 'water', 'shower', 'wc', 'fuel')
ON CONFLICT DO NOTHING;

-- --- Bozcaada Limanı · güven: high · kaynak: turkeymarinas.blogspot.com, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bozcaada-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-bozcaada'),
  'Bozcaada Limanı', 'Bozcaada''nın kuzeydoğusunda, kalenin dibindeki ana liman. Ziyaretçi tekneler dalgakıran boyunca kıçtan kara veya aborda bağlanır; kıyıdan ~40 m açıkta zincir donanımı vardır. Doğu-güneydoğu rüzgârları dışında her yönden yeterli korunak sağlar. Rıhtımda 13 su/elektrik noktası bulunur. Resmî yat kapasitesi 30 (TKYGM listesi); balıkçı tekneleriyle birlikte toplam ~125 tekne barındırır. Azami su çekimi ~3 m. Tankerle yakıt ikmali, kızak/çekek, buz ve halat temini bildirilmektedir.',
  ST_SetSRID(ST_MakePoint(26.076004, 39.834725), 4326)::geography,
  NULL, 3, NULL, 3,
  30, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bozcaada Limanı', 'Bozcaada''nın kuzeydoğusunda, kalenin dibindeki ana liman. Ziyaretçi tekneler dalgakıran boyunca kıçtan kara veya aborda bağlanır; kıyıdan ~40 m açıkta zincir donanımı vardır. Doğu-güneydoğu rüzgârları dışında her yönden yeterli korunak sağlar. Rıhtımda 13 su/elektrik noktası bulunur. Resmî yat kapasitesi 30 (TKYGM listesi); balıkçı tekneleriyle birlikte toplam ~125 tekne barındırır. Azami su çekimi ~3 m. Tankerle yakıt ikmali, kızak/çekek, buz ve halat temini bildirilmektedir.' FROM locations WHERE slug = 'bozcaada-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 30, '16', NULL, NULL, NULL
FROM locations WHERE slug = 'bozcaada-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'bozcaada-limani' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'shower', 'market', 'laundry', 'wc', 'crane', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902866978081', NULL, false
FROM locations l WHERE l.slug = 'bozcaada-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@bozcaada.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'bozcaada-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.bozcaada.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'bozcaada-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Gökçeada Kaleköy Limanı · güven: low · kaynak: www.cruiserswiki.org, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gokceada-kalekoy-limani', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-gokceada'),
  'Gökçeada Kaleköy Limanı', 'Gökçeada''nın kuzey kıyısındaki yeni liman; adada yatlara en uygun bağlama yeri. Kuzey dalgakıranı boyunca aborda bağlanılır, doluysa balıkçı teknelerine aborda gerekebilir. Girişte 5,0-5,5 m, kuzey rıhtımda 3,0-3,5 m derinlik; girişte kuzey dalgakıran ucundaki kum sığlığına dikkat. Her yönden mükemmel korunak. Rıhtım boyunca su ve elektrik noktaları, kıyıda balık restoranları vardır; yakıt yoktur. Merkeze saat başı minibüs kalkar.',
  ST_SetSRID(ST_MakePoint(25.8912, 40.231), 4326)::geography,
  NULL, NULL, 3, 5.5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gökçeada Kaleköy Limanı', 'Gökçeada''nın kuzey kıyısındaki yeni liman; adada yatlara en uygun bağlama yeri. Kuzey dalgakıranı boyunca aborda bağlanılır, doluysa balıkçı teknelerine aborda gerekebilir. Girişte 5,0-5,5 m, kuzey rıhtımda 3,0-3,5 m derinlik; girişte kuzey dalgakıran ucundaki kum sığlığına dikkat. Her yönden mükemmel korunak. Rıhtım boyunca su ve elektrik noktaları, kıyıda balık restoranları vardır; yakıt yoktur. Merkeze saat başı minibüs kalkar.' FROM locations WHERE slug = 'gokceada-kalekoy-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gokceada-kalekoy-limani' AND a.code IN ('electricity', 'water', 'wc', 'restaurant', 'wifi')
ON CONFLICT DO NOTHING;

-- --- Gökçeada Kuzu Limanı · güven: medium · kaynak: www.cruiserswiki.org, www.tdi.gov.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gokceada-kuzu-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-gokceada'),
  'Gökçeada Kuzu Limanı', 'Adanın kuzeydoğu ucundaki eski ana liman ve feribot iskelesi; TDİ işletmesindedir. Yatlar için imkânları kısıtlı, sıkışık bir liman olup özellikle kuzey-kuzeydoğu rüzgârlarında iyi korunak sağlar; kötü havada sığınma limanı olarak kullanılır. Yerel teknelerle dolu olabilir. Su temini sınırlı, yakıt istasyonu yoktur. Kaleköy 3 mil mesafede daha iyi alternatiftir.',
  ST_SetSRID(ST_MakePoint(25.9525, 40.2288), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gökçeada Kuzu Limanı', 'Adanın kuzeydoğu ucundaki eski ana liman ve feribot iskelesi; TDİ işletmesindedir. Yatlar için imkânları kısıtlı, sıkışık bir liman olup özellikle kuzey-kuzeydoğu rüzgârlarında iyi korunak sağlar; kötü havada sığınma limanı olarak kullanılır. Yerel teknelerle dolu olabilir. Su temini sınırlı, yakıt istasyonu yoktur. Kaleköy 3 mil mesafede daha iyi alternatiftir.' FROM locations WHERE slug = 'gokceada-kuzu-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.tdi.gov.tr/gokceada-kuzu-limani/', NULL, false
FROM locations l WHERE l.slug = 'gokceada-kuzu-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Behramkale (Assos) Antik Limanı · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'behramkale-assos-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-ayvacik'),
  'Behramkale (Assos) Antik Limanı', 'Assos antik kentinin altındaki küçük tarihi taş liman; rıhtım boyunca balık restoranları sıralanır ve ziyaretçi tekneler restoran önlerine bağlanır. Kapasite ~50 tekne (çoğu yerel/gezi teknesi). Dalgakıranlar kuzey rüzgârlarına kapalıdır; giriş dar olduğundan gece yaklaşımda dikkat gerekir. Güneybatı sektör rüzgârlarında rahatsız olabilir. Elektrik, içme suyu ve WC mevcuttur.',
  ST_SetSRID(ST_MakePoint(26.339133, 39.485354), 4326)::geography,
  NULL, NULL, NULL, NULL,
  50, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Behramkale (Assos) Antik Limanı', 'Assos antik kentinin altındaki küçük tarihi taş liman; rıhtım boyunca balık restoranları sıralanır ve ziyaretçi tekneler restoran önlerine bağlanır. Kapasite ~50 tekne (çoğu yerel/gezi teknesi). Dalgakıranlar kuzey rüzgârlarına kapalıdır; giriş dar olduğundan gece yaklaşımda dikkat gerekir. Güneybatı sektör rüzgârlarında rahatsız olabilir. Elektrik, içme suyu ve WC mevcuttur.' FROM locations WHERE slug = 'behramkale-assos-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'behramkale-assos-limani' AND a.code IN ('electricity', 'water', 'wc', 'restaurant')
ON CONFLICT DO NOTHING;

-- --- Küçükkuyu Limanı · güven: low · kaynak: www.harbourmaps.com, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kucukkuyu-limani', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'canakkale-ayvacik'),
  'Küçükkuyu Limanı', 'Edremit Körfezi''nin kuzey kıyısında, Kazdağı eteklerindeki Küçükkuyu beldesinin dalgakıranlı limanı. Ağırlıklı balıkçı ve gezi teknesi barınağı olmakla birlikte iskeleye/rıhtıma bağlanma mümkündür. Kuzey sektör rüzgârlarında korunaklıdır. Kasabada market ve restoranlar yürüme mesafesindedir.',
  ST_SetSRID(ST_MakePoint(26.6031, 39.5456), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Küçükkuyu Limanı', 'Edremit Körfezi''nin kuzey kıyısında, Kazdağı eteklerindeki Küçükkuyu beldesinin dalgakıranlı limanı. Ağırlıklı balıkçı ve gezi teknesi barınağı olmakla birlikte iskeleye/rıhtıma bağlanma mümkündür. Kuzey sektör rüzgârlarında korunaklıdır. Kasabada market ve restoranlar yürüme mesafesindedir.' FROM locations WHERE slug = 'kucukkuyu-limani'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Burhaniye (Ören) Yat Limanı · güven: high · kaynak: turkeymarinas.blogspot.com, www.wikiderya.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'burhaniye-oren-yat-limani', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-burhaniye'),
  'Burhaniye (Ören) Yat Limanı', 'Edremit Körfezi''nin güneydoğusunda, Burhaniye İskele/Ören mevkiindeki belediye işletmeli yat limanı ve bitişik balıkçı barınağı. Kapasite ~250 tekne; giriş sorunsuz, liman içinde 3-4 m derinlik. Ana dalgakıran 537 m; kızak mevcuttur. Bölgede kuzey sektör rüzgârları hâkimdir, bağlanırken yardım alınması tavsiye edilir. 2023-24''te yenileme çalışmaları yapılmış ve kıyı tesisi işletme belgesi alınmıştır. Tankerle yakıt ikmali yapılabilir, çevrede yat malzemecisi vardır.',
  ST_SetSRID(ST_MakePoint(26.9267, 39.4847), 4326)::geography,
  NULL, NULL, 3, 4,
  250, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Burhaniye (Ören) Yat Limanı', 'Edremit Körfezi''nin güneydoğusunda, Burhaniye İskele/Ören mevkiindeki belediye işletmeli yat limanı ve bitişik balıkçı barınağı. Kapasite ~250 tekne; giriş sorunsuz, liman içinde 3-4 m derinlik. Ana dalgakıran 537 m; kızak mevcuttur. Bölgede kuzey sektör rüzgârları hâkimdir, bağlanırken yardım alınması tavsiye edilir. 2023-24''te yenileme çalışmaları yapılmış ve kıyı tesisi işletme belgesi alınmıştır. Tankerle yakıt ikmali yapılabilir, çevrede yat malzemecisi vardır.' FROM locations WHERE slug = 'burhaniye-oren-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 250, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'burhaniye-oren-yat-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'burhaniye-oren-yat-limani' AND a.code IN ('electricity', 'water', 'fuel', 'wc', 'shower', 'laundry', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'burhaniye-oren-yat-limani' AND sv.code IN ('mooring_assist', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902664129950', NULL, false
FROM locations l WHERE l.slug = 'burhaniye-oren-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.burhaniye.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'burhaniye-oren-yat-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Alibey (Cunda) Adası Limanı · güven: high · kaynak: turkeymarinas.blogspot.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'alibey-cunda-adasi-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Alibey (Cunda) Adası Limanı', 'Ayvalık iç denizinin kuzeybatısında, Cunda (Alibey) adası kasaba rıhtımı. Ziyaretçi yatlar için rıhtıma bağlı 15 hazır tonoz ve ilave şamandıralar vardır; rıhtım önü restoranlarla çevrilidir. Liman içi derinlik 2-3 m, iskelenin güneyindeki demirleme alanı ~5 m ve tutuş iyidir. Kapasite ~145 tekne. İç denizde olduğundan her yönden iyi korunaklıdır. 25 m''ye kadar çekek imkânı ve tankerle yakıt ikmali bildirilmektedir.',
  ST_SetSRID(ST_MakePoint(26.658333, 39.33), 4326)::geography,
  NULL, NULL, 2, 5,
  145, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Alibey (Cunda) Adası Limanı', 'Ayvalık iç denizinin kuzeybatısında, Cunda (Alibey) adası kasaba rıhtımı. Ziyaretçi yatlar için rıhtıma bağlı 15 hazır tonoz ve ilave şamandıralar vardır; rıhtım önü restoranlarla çevrilidir. Liman içi derinlik 2-3 m, iskelenin güneyindeki demirleme alanı ~5 m ve tutuş iyidir. Kapasite ~145 tekne. İç denizde olduğundan her yönden iyi korunaklıdır. 25 m''ye kadar çekek imkânı ve tankerle yakıt ikmali bildirilmektedir.' FROM locations WHERE slug = 'alibey-cunda-adasi-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'alibey-cunda-adasi-limani' AND a.code IN ('electricity', 'water', 'shower', 'fuel', 'restaurant', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'alibey-cunda-adasi-limani' AND sv.code IN ('winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902663122308', NULL, false
FROM locations l WHERE l.slug = 'alibey-cunda-adasi-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'danisma@ayvalik.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'alibey-cunda-adasi-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Patriça (Gökçeliman) Koyu · güven: medium · kaynak: www.cruiserswiki.org, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'patrica-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Patriça (Gökçeliman) Koyu', 'Cunda (Alibey) adasının kuzeyindeki geniş, iyi korunaklı demirleme koyu; pilot kaynaklarda Patricia Liman / Gökçeliman olarak geçer, yerelde Patriça koyu olarak bilinir. Doğal sit alanı içindedir; kıyıda tesis yoktur, günübirlik tekneler ve yatlar demirler. Ayvalık iç denizi girişine yakındır.',
  ST_SetSRID(ST_MakePoint(26.63, 39.375), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Patriça (Gökçeliman) Koyu', 'Cunda (Alibey) adasının kuzeyindeki geniş, iyi korunaklı demirleme koyu; pilot kaynaklarda Patricia Liman / Gökçeliman olarak geçer, yerelde Patriça koyu olarak bilinir. Doğal sit alanı içindedir; kıyıda tesis yoktur, günübirlik tekneler ve yatlar demirler. Ayvalık iç denizi girişine yakındır.' FROM locations WHERE slug = 'patrica-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'geniş koy, iyi korunaklı', true
FROM locations WHERE slug = 'patrica-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Maden Adası (Gümüş Koyu) Demirleme · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'maden-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Maden Adası (Gümüş Koyu) Demirleme', 'Ayvalık''ın kuzeybatısındaki Maden Adası''nda, meltemiye karşı iyi korunak veren demirleme koyu. Yaklaşık 5 m derinlikte kum zemine demirlenir, tutuş iyidir. Koy girişinde sığlık bulunduğundan yaklaşırken dikkat edilmelidir. Kıyıda tesis yoktur.',
  ST_SetSRID(ST_MakePoint(26.5933, 39.3767), 4326)::geography,
  NULL, NULL, NULL, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Maden Adası (Gümüş Koyu) Demirleme', 'Ayvalık''ın kuzeybatısındaki Maden Adası''nda, meltemiye karşı iyi korunak veren demirleme koyu. Yaklaşık 5 m derinlikte kum zemine demirlenir, tutuş iyidir. Koy girişinde sığlık bulunduğundan yaklaşırken dikkat edilmelidir. Kıyıda tesis yoktur.' FROM locations WHERE slug = 'maden-adasi-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'meltemiye karşı iyi korunaklı', true
FROM locations WHERE slug = 'maden-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Moska Adası Demirleme · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'moska-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Moska Adası Demirleme', 'Ayvalık iç denizinde, Moska adası ile Alibey adası arasındaki kanalın güney ucunda demirleme yeri. Güney sektör rüzgârlarında iyi korunak sağlar. Kıyıda tesis yoktur; günübirlik ve gecelik demirleme için kullanılır.',
  ST_SetSRID(ST_MakePoint(26.615, 39.335), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Moska Adası Demirleme', 'Ayvalık iç denizinde, Moska adası ile Alibey adası arasındaki kanalın güney ucunda demirleme yeri. Güney sektör rüzgârlarında iyi korunak sağlar. Kıyıda tesis yoktur; günübirlik ve gecelik demirleme için kullanılır.' FROM locations WHERE slug = 'moska-adasi-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'G rüzgârlarında korunaklı', true
FROM locations WHERE slug = 'moska-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kumru Koyu Demirleme · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kumru-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Kumru Koyu Demirleme', 'Ayvalık iç denizinin güneyinde, kara ile tamamen çevrili ve çok cazip bir demirleme koyu. Her yönden korunak sağlar. Kıyıda tesis yoktur.',
  ST_SetSRID(ST_MakePoint(26.64, 39.2967), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kumru Koyu Demirleme', 'Ayvalık iç denizinin güneyinde, kara ile tamamen çevrili ve çok cazip bir demirleme koyu. Her yönden korunak sağlar. Kıyıda tesis yoktur.' FROM locations WHERE slug = 'kumru-koyu-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'her yönden korunaklı', true
FROM locations WHERE slug = 'kumru-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Çamlık Koyu Demirleme (Ayvalık) · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'camlik-koyu-demirleme-ayvalik', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Çamlık Koyu Demirleme (Ayvalık)', 'Ayvalık''ın güneyinde, Çamlık mevkiinde demirleme koyu; Çanak Tepe manzaralıdır. Güneyden esen rüzgâr dışında iyi korunak sağlar. Kıyıda restoran bulunur; kendi iskelesi teyit edilemediğinden demirleyip botla çıkılır.',
  ST_SetSRID(ST_MakePoint(26.66, 39.29), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çamlık Koyu Demirleme (Ayvalık)', 'Ayvalık''ın güneyinde, Çamlık mevkiinde demirleme koyu; Çanak Tepe manzaralıdır. Güneyden esen rüzgâr dışında iyi korunak sağlar. Kıyıda restoran bulunur; kendi iskelesi teyit edilemediğinden demirleyip botla çıkılır.' FROM locations WHERE slug = 'camlik-koyu-demirleme-ayvalik'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'güneye açık', true
FROM locations WHERE slug = 'camlik-koyu-demirleme-ayvalik'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'camlik-koyu-demirleme-ayvalik' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Dikili Limanı · güven: high · kaynak: turkeymarinas.blogspot.com, www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'dikili-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-dikili'),
  'Dikili Limanı', 'Midilli adasının karşısındaki Dikili ilçe limanı; ticari iskelenin yanındaki barınak bölümünde ziyaretçi yatlara 6-7 teknelik yer bulunur. Demir atıp rıhtıma kıçtan/baştan kara bağlanılır; hazır tonoz yoktur. Liman içi derinlik 4-5 m; yaklaşma engelsiz ve kolaydır. Rıhtımda elektrik, içme suyu ve yakıt alınabilir; kordonda balık restoranları vardır. Toplam kapasite ~160 tekne.',
  ST_SetSRID(ST_MakePoint(26.884735, 39.071934), 4326)::geography,
  NULL, NULL, 4, 5,
  160, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Dikili Limanı', 'Midilli adasının karşısındaki Dikili ilçe limanı; ticari iskelenin yanındaki barınak bölümünde ziyaretçi yatlara 6-7 teknelik yer bulunur. Demir atıp rıhtıma kıçtan/baştan kara bağlanılır; hazır tonoz yoktur. Liman içi derinlik 4-5 m; yaklaşma engelsiz ve kolaydır. Rıhtımda elektrik, içme suyu ve yakıt alınabilir; kordonda balık restoranları vardır. Toplam kapasite ~160 tekne.' FROM locations WHERE slug = 'dikili-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'dikili-limani' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902326714020', NULL, false
FROM locations l WHERE l.slug = 'dikili-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'sekreterlik@izmir-dikili.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'dikili-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Bademli Deniz Ilıcası Koyu · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bademli-deniz-ilicasi-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-dikili'),
  'Bademli Deniz Ilıcası Koyu', 'Dikili Bademli kıyısında, Kalem Adası''nın hemen kuzeyindeki demirleme koyu. Kum ve kaya karışımı zemine demirlenir; kıyıya halat verilebilir. Botla çıkılabilen plajı vardır; kıyıda tesis, su veya iskele yoktur. Sığ ılıca kaynaklarıyla bilinir.',
  ST_SetSRID(ST_MakePoint(26.7988, 38.9972), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bademli Deniz Ilıcası Koyu', 'Dikili Bademli kıyısında, Kalem Adası''nın hemen kuzeyindeki demirleme koyu. Kum ve kaya karışımı zemine demirlenir; kıyıya halat verilebilir. Botla çıkılabilen plajı vardır; kıyıda tesis, su veya iskele yoktur. Sığ ılıca kaynaklarıyla bilinir.' FROM locations WHERE slug = 'bademli-deniz-ilicasi-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'bademli-deniz-ilicasi-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kalem Adası Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalem-adasi-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-dikili'),
  'Kalem Adası Koyu', 'Dikili Bademli açığında, karadan ~450 m mesafedeki özel işletmeli Kalem Adası''nın demirleme koyu; ''Ege''nin Maldivleri'' olarak anılır. Adanın farklı yüzleri farklı korunma sunar; batı yüzü açık denize bakar. Adada otel, plaj kulübü ve restoran vardır (karaya çıkış işletme iznine tabidir). Bademli köyünde market ve restoranlara ulaşılabilir.',
  ST_SetSRID(ST_MakePoint(26.793163, 39.003946), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kalem Adası Koyu', 'Dikili Bademli açığında, karadan ~450 m mesafedeki özel işletmeli Kalem Adası''nın demirleme koyu; ''Ege''nin Maldivleri'' olarak anılır. Adanın farklı yüzleri farklı korunma sunar; batı yüzü açık denize bakar. Adada otel, plaj kulübü ve restoran vardır (karaya çıkış işletme iznine tabidir). Bademli köyünde market ve restoranlara ulaşılabilir.' FROM locations WHERE slug = 'kalem-adasi-koyu'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'yüzüne göre değişken; batı yüzü açık', true
FROM locations WHERE slug = 'kalem-adasi-koyu'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kalem-adasi-koyu' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Çandarlı Limanı · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'candarli-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-dikili'),
  'Çandarlı Limanı', 'Çandarlı Körfezi''nde, ünlü Ceneviz kalesinin dibindeki kasaba limanı. Kale önündeki demirleme alanında 4-8 m derinlikte çamur zemine demirlenir; tutuş çok iyidir ancak yumuşak çamurda pulluk tipi çapalar kayabilir. Güney sektör dışında her yönden korunak sağlar; hâkim kuzeyliler deniz kabartmaz. Rıhtımda elektrik, basınçlı su, içme suyu ve yakıt vardır; kasabada restoran, market, tamir atölyeleri, dalış merkezi ve yelken kulübü bulunur.',
  ST_SetSRID(ST_MakePoint(26.936167, 38.935922), 4326)::geography,
  NULL, NULL, 4, 8,
  150, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çandarlı Limanı', 'Çandarlı Körfezi''nde, ünlü Ceneviz kalesinin dibindeki kasaba limanı. Kale önündeki demirleme alanında 4-8 m derinlikte çamur zemine demirlenir; tutuş çok iyidir ancak yumuşak çamurda pulluk tipi çapalar kayabilir. Güney sektör dışında her yönden korunak sağlar; hâkim kuzeyliler deniz kabartmaz. Rıhtımda elektrik, basınçlı su, içme suyu ve yakıt vardır; kasabada restoran, market, tamir atölyeleri, dalış merkezi ve yelken kulübü bulunur.' FROM locations WHERE slug = 'candarli-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'candarli-limani' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant', 'market', 'laundry')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'candarli-limani' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902326714020', NULL, false
FROM locations l WHERE l.slug = 'candarli-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'sekreterlik@izmir-dikili.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'candarli-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mordoğan Yeni Limanı · güven: medium · kaynak: www.navily.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mordogan-yeni-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-karaburun'),
  'Mordoğan Yeni Limanı', 'Mordoğan''ın 2003''te inşa edilen yeni barınağı; eski liman balıkçı tekneleri içindir, yeni liman tamamlanmamış olsa da barınmak için kullanılabilir. Mendirek gerisinde korunma sağlar. Liman ile Mordoğan kasabası arasındaki yaklaşımda çok sayıda resif bulunur, dikkatli yaklaşılmalıdır. Elektrik ve su hizmeti bildirilmemektedir.',
  ST_SetSRID(ST_MakePoint(26.632, 38.5145), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mordoğan Yeni Limanı', 'Mordoğan''ın 2003''te inşa edilen yeni barınağı; eski liman balıkçı tekneleri içindir, yeni liman tamamlanmamış olsa da barınmak için kullanılabilir. Mendirek gerisinde korunma sağlar. Liman ile Mordoğan kasabası arasındaki yaklaşımda çok sayıda resif bulunur, dikkatli yaklaşılmalıdır. Elektrik ve su hizmeti bildirilmemektedir.' FROM locations WHERE slug = 'mordogan-yeni-limani'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Eğri Liman Demirleme Koyu · güven: low · kaynak: my-sea.com, turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'egri-liman-demirleme', 8, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-karaburun'),
  'Eğri Liman Demirleme Koyu', 'Karaburun yarımadasının batı kıyısında, Gerence Körfezi ağzında doğal demirleme koyu. Meltem dahil hemen her yönden korunma sağlar; ancak kuvvetli kuzey ve güney rüzgârlarında koya soluğan girebilir. Giriş yaklaşık 300 m genişliğinde, girişte 20 m derinlik; çevrede resifler ve açıkta üç kayalık adacık vardır, gece girişi önerilmez. Dip çamur ve yosun; dip eğimi dik, ani derinleşmeye dikkat.',
  ST_SetSRID(ST_MakePoint(26.376671, 38.54344), 4326)::geography,
  NULL, NULL, 5, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Eğri Liman Demirleme Koyu', 'Karaburun yarımadasının batı kıyısında, Gerence Körfezi ağzında doğal demirleme koyu. Meltem dahil hemen her yönden korunma sağlar; ancak kuvvetli kuzey ve güney rüzgârlarında koya soluğan girebilir. Giriş yaklaşık 300 m genişliğinde, girişte 20 m derinlik; çevrede resifler ve açıkta üç kayalık adacık vardır, gece girişi önerilmez. Dip çamur ve yosun; dip eğimi dik, ani derinleşmeye dikkat.' FROM locations WHERE slug = 'egri-liman-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', 'kuvvetli K/G rüzgârlarında soluğan girer', true
FROM locations WHERE slug = 'egri-liman-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Oasis Marina Yeni Foça · güven: high · kaynak: oasismarina.com.tr, www.coastguidetr.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'oasis-marina-yeni-foca', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-foca'),
  'Oasis Marina Yeni Foça', 'Yeni Foça''daki eski yat limanında hizmete giren özel marina; 8-30 m arası teknelere hizmet verir. 7/24 palamar, elektrik-su, güvenlik/kamera, duş-WC, çamaşırhane, yakıt ve atık su istasyonu, çekek ve bakım hizmetleri mevcuttur. Deniz hudut kapısı (Port of Entry) statüsündedir. Koy batıya açıktır; marina mendirek içinde korunaklıdır.',
  ST_SetSRID(ST_MakePoint(26.838722, 38.743667), 4326)::geography,
  30, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Oasis Marina Yeni Foça', 'Yeni Foça''daki eski yat limanında hizmete giren özel marina; 8-30 m arası teknelere hizmet verir. 7/24 palamar, elektrik-su, güvenlik/kamera, duş-WC, çamaşırhane, yakıt ve atık su istasyonu, çekek ve bakım hizmetleri mevcuttur. Deniz hudut kapısı (Port of Entry) statüsündedir. Koy batıya açıktır; marina mendirek içinde korunaklıdır.' FROM locations WHERE slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'oasis-marina-yeni-foca' AND a.code IN ('electricity', 'water', 'shower', 'wc', 'laundry', 'fuel', 'security', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'oasis-marina-yeni-foca' AND sv.code IN ('mooring_assist', 'technical_service', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902323263301', NULL, false
FROM locations l WHERE l.slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'yenifoca@oasismarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://oasismarina.com.tr', NULL, false
FROM locations l WHERE l.slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'instagram', 'https://instagram.com/oasismarinalife', NULL, false
FROM locations l WHERE l.slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'facebook', 'https://facebook.com/oasismarinalife', NULL, false
FROM locations l WHERE l.slug = 'oasis-marina-yeni-foca'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Yeni Foça Halk Plajı Demirleme · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yeni-foca-halk-plaji-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-foca'),
  'Yeni Foça Halk Plajı Demirleme', 'Yeni Foça koyunda, halk plajı önünde demirleme alanı. Dip kum ve deniz çayırı karışıktır; çayır bantlarından kaçınıp kum yamalarına demirlenmelidir. Kasaba merkezine ve büfelere botla ulaşılabilir. Koy batı-güneybatı yönüne açıktır; meltemde kıyıya yakın kesim nispeten sakindir.',
  ST_SetSRID(ST_MakePoint(26.835833, 38.743667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yeni Foça Halk Plajı Demirleme', 'Yeni Foça koyunda, halk plajı önünde demirleme alanı. Dip kum ve deniz çayırı karışıktır; çayır bantlarından kaçınıp kum yamalarına demirlenmelidir. Kasaba merkezine ve büfelere botla ulaşılabilir. Koy batı-güneybatı yönüne açıktır; meltemde kıyıya yakın kesim nispeten sakindir.' FROM locations WHERE slug = 'yeni-foca-halk-plaji-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'batı-güneybatıya açık', true
FROM locations WHERE slug = 'yeni-foca-halk-plaji-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Urla İskele Limanı (Çeşmealtı) · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'urla-iskele-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Urla İskele Limanı (Çeşmealtı)', 'Urla İskele mahallesinde, Karantina Adası ve Çiçek Adaları''nın güneyindeki liman. Balıkçı tekneleri ve yerel tekne sahipleri tarafından kullanılır; her sezon genellikle doludur, boş yer bulmak zordur. Adalar ile ana kara arasındaki geçişte sığlıklara dikkat edilmelidir. Çevresinde restoranlar ve kafeler vardır.',
  ST_SetSRID(ST_MakePoint(26.775333, 38.372), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Urla İskele Limanı (Çeşmealtı)', 'Urla İskele mahallesinde, Karantina Adası ve Çiçek Adaları''nın güneyindeki liman. Balıkçı tekneleri ve yerel tekne sahipleri tarafından kullanılır; her sezon genellikle doludur, boş yer bulmak zordur. Adalar ile ana kara arasındaki geçişte sığlıklara dikkat edilmelidir. Çevresinde restoranlar ve kafeler vardır.' FROM locations WHERE slug = 'urla-iskele-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'urla-iskele-limani' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Dalyanköy Koyu Demirleme · güven: medium · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'dalyankoy-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Dalyanköy Koyu Demirleme', 'Çeşme''nin kuzeyinde, Dalyanköy koyunda kum zeminli demirleme alanı; Alev Adası yakınındadır. Plaja ve büfelere botla çıkılabilir. Koy kuzey-kuzeybatı sektöre açıktır; iç kesimi meltemde makul korunma sağlar. Dalyanköy''ün balık restoranları kıyıdadır.',
  ST_SetSRID(ST_MakePoint(26.317, 38.359667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Dalyanköy Koyu Demirleme', 'Çeşme''nin kuzeyinde, Dalyanköy koyunda kum zeminli demirleme alanı; Alev Adası yakınındadır. Plaja ve büfelere botla çıkılabilir. Koy kuzey-kuzeybatı sektöre açıktır; iç kesimi meltemde makul korunma sağlar. Dalyanköy''ün balık restoranları kıyıdadır.' FROM locations WHERE slug = 'dalyankoy-koyu-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'kuzey-kuzeybatı sektöre açık', true
FROM locations WHERE slug = 'dalyankoy-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Dalyanköy Yat Limanı (Dalyan Marina) · güven: low · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'dalyankoy-yat-limani', 2, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Dalyanköy Yat Limanı (Dalyan Marina)', 'Dalyanköy''deki küçük yat limanı; rıhtım/iskeleye bağlanılır, liman içinde demirleme yasaktır. Su ve iskele hizmeti mevcuttur; kıyıda restoranlar vardır. Dar dalyan girişinden girilir; liman içi korunaklıdır.',
  ST_SetSRID(ST_MakePoint(26.3125, 38.353667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Dalyanköy Yat Limanı (Dalyan Marina)', 'Dalyanköy''deki küçük yat limanı; rıhtım/iskeleye bağlanılır, liman içinde demirleme yasaktır. Su ve iskele hizmeti mevcuttur; kıyıda restoranlar vardır. Dar dalyan girişinden girilir; liman içi korunaklıdır.' FROM locations WHERE slug = 'dalyankoy-yat-limani'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'dalyankoy-yat-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'dalyankoy-yat-limani' AND a.code IN ('water', 'restaurant')
ON CONFLICT DO NOTHING;

-- --- Mersin Körfezi Demirleme (Çeşme) · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mersin-korfezi-demirleme-cesme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Mersin Körfezi Demirleme (Çeşme)', 'Çeşme yarımadasının güney kıyısında, Alaçatı koyu girişinin doğusundaki Mersin Körfezi. Her yönden iyi korunma sağlayan doğal demirleme alanıdır; meltemde güvenlidir. Kıyıda tesis yoktur.',
  ST_SetSRID(ST_MakePoint(26.4325, 38.212667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mersin Körfezi Demirleme (Çeşme)', 'Çeşme yarımadasının güney kıyısında, Alaçatı koyu girişinin doğusundaki Mersin Körfezi. Her yönden iyi korunma sağlayan doğal demirleme alanıdır; meltemde güvenlidir. Kıyıda tesis yoktur.' FROM locations WHERE slug = 'mersin-korfezi-demirleme-cesme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'her yönden iyi korunaklı', true
FROM locations WHERE slug = 'mersin-korfezi-demirleme-cesme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sarpdere Limanı Demirleme · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sarpdere-limani-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Sarpdere Limanı Demirleme', 'Urla Zeytineli kıyısında, üç koldan oluşan doğal liman (batı koyu, doğu koyu ve Nergis). Dip kum, yer yer yosun yamalı; tutuş iyidir, yaklaşık 4 m derinlik. Meltemde iyi korunma sağlar; kuvvetli kuzey rüzgârlarında Nergis kolunda rahatsız edici kısa dalga oluşabilir. Kıyıda tesis yoktur.',
  ST_SetSRID(ST_MakePoint(26.520667, 38.182), 4326)::geography,
  NULL, NULL, 4, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sarpdere Limanı Demirleme', 'Urla Zeytineli kıyısında, üç koldan oluşan doğal liman (batı koyu, doğu koyu ve Nergis). Dip kum, yer yer yosun yamalı; tutuş iyidir, yaklaşık 4 m derinlik. Meltemde iyi korunma sağlar; kuvvetli kuzey rüzgârlarında Nergis kolunda rahatsız edici kısa dalga oluşabilir. Kıyıda tesis yoktur.' FROM locations WHERE slug = 'sarpdere-limani-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'kuvvetli kuzeylilerde kısa dalga (Nergis kolu)', true
FROM locations WHERE slug = 'sarpdere-limani-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kırkdilim Limanı Demirleme · güven: low · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kirkdilim-limani-demirleme', 8, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Kırkdilim Limanı Demirleme', 'Çeşme-Sığacık arasındaki güney kıyıda (Zeytineli sahili) derin girintili doğal liman. Yaklaşık 7 m derinlikte demirlenir, tutuş iyidir. Meltemden çok iyi korunma sağlar. Kıyıda tesis yoktur.',
  ST_SetSRID(ST_MakePoint(26.571667, 38.133333), 4326)::geography,
  NULL, NULL, NULL, 7,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kırkdilim Limanı Demirleme', 'Çeşme-Sığacık arasındaki güney kıyıda (Zeytineli sahili) derin girintili doğal liman. Yaklaşık 7 m derinlikte demirlenir, tutuş iyidir. Meltemden çok iyi korunma sağlar. Kıyıda tesis yoktur.' FROM locations WHERE slug = 'kirkdilim-limani-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'meltemde çok iyi korunaklı', true
FROM locations WHERE slug = 'kirkdilim-limani-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Teos Limanı Demirleme (Sığacık) · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'teos-limani-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-seferihisar'),
  'Teos Limanı Demirleme (Sığacık)', 'Sığacık''ın güneyinde, Teos antik kentinin doğal limanı. Meltemden mükemmel korunma sağlar ancak güneye açıktır. Dip yoğun posidonya çayırıdır; kum yamalarına demirlendiğinde tutuş iyidir. Koyun doğusu sığlaşır. Teos Marina''ya 1-2 mil mesafededir.',
  ST_SetSRID(ST_MakePoint(26.801667, 38.16), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Teos Limanı Demirleme (Sığacık)', 'Sığacık''ın güneyinde, Teos antik kentinin doğal limanı. Meltemden mükemmel korunma sağlar ancak güneye açıktır. Dip yoğun posidonya çayırıdır; kum yamalarına demirlendiğinde tutuş iyidir. Koyun doğusu sığlaşır. Teos Marina''ya 1-2 mil mesafededir.' FROM locations WHERE slug = 'teos-limani-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', 'güneye açık', true
FROM locations WHERE slug = 'teos-limani-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ahmetbeyli (Claros) Demirleme · güven: medium · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ahmetbeyli-claros-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-menderes'),
  'Ahmetbeyli (Claros) Demirleme', 'Kuşadası''nın yaklaşık 5 mil kuzeybatısında, Ahmetbeyli koyu (Claros antik kenti sahili). Kuzey meltemden ve batı dalgasından korunma sağlar, güneye açıktır. Yaklaşık 5 m derinlikte kum zemin; kum serttir, çapanın tutması için birkaç deneme gerekebilir. Gümüldür-Özdere sahil şeridinin tekneyle kullanılabilen başlıca demirleme noktasıdır.',
  ST_SetSRID(ST_MakePoint(27.185, 37.988333), 4326)::geography,
  NULL, NULL, 5, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ahmetbeyli (Claros) Demirleme', 'Kuşadası''nın yaklaşık 5 mil kuzeybatısında, Ahmetbeyli koyu (Claros antik kenti sahili). Kuzey meltemden ve batı dalgasından korunma sağlar, güneye açıktır. Yaklaşık 5 m derinlikte kum zemin; kum serttir, çapanın tutması için birkaç deneme gerekebilir. Gümüldür-Özdere sahil şeridinin tekneyle kullanılabilen başlıca demirleme noktasıdır.' FROM locations WHERE slug = 'ahmetbeyli-claros-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', 'güneye açık', true
FROM locations WHERE slug = 'ahmetbeyli-claros-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kuşadası Sahil Demirleme · güven: low · kaynak: www.harbourmaps.com, www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kusadasi-sahil-demirleme', 8, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'aydin-kusadasi'),
  'Kuşadası Sahil Demirleme', 'Kuşadası kent önü sahilinde, Güvercinada''nın kuzeyindeki doğal demirleme alanı; iskele bağlaması olmayan, yalnızca demirlenen doğal liman olarak kayıtlıdır. Batı-güneybatı yönüne açıktır. Ana liman kruvaziyer ve balıkçı tekneleri içindir, yatlara kapalıdır; yatlar Setur Marina''yı kullanır. Güneyden yaklaşırken Yılancı Burnu açığındaki resiflere dikkat edilmelidir.',
  ST_SetSRID(ST_MakePoint(27.2624, 37.867), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kuşadası Sahil Demirleme', 'Kuşadası kent önü sahilinde, Güvercinada''nın kuzeyindeki doğal demirleme alanı; iskele bağlaması olmayan, yalnızca demirlenen doğal liman olarak kayıtlıdır. Batı-güneybatı yönüne açıktır. Ana liman kruvaziyer ve balıkçı tekneleri içindir, yatlara kapalıdır; yatlar Setur Marina''yı kullanır. Güneyden yaklaşırken Yılancı Burnu açığındaki resiflere dikkat edilmelidir.' FROM locations WHERE slug = 'kusadasi-sahil-demirleme'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, 'batı-güneybatıya açık', true
FROM locations WHERE slug = 'kusadasi-sahil-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Port Saint Paul / Saint Nikolo (Dilek Yarımadası) · güven: low · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'port-saint-paul-saint-nikolo', 8, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'aydin-soke'),
  'Port Saint Paul / Saint Nikolo (Dilek Yarımadası)', 'Dilek Yarımadası''nın (Samsun Dağı) batı ucu güney kıyısındaki iki tarihi doğal demirleme alanı; ikisinden Saint Nikolo daha iyi korunma sağlar. Bölge Dilek Yarımadası-Büyük Menderes Deltası Millî Parkı deniz alanı içindedir; özel teknelerin demirleme/giriş koşulları (ücret, izin, şamandıra düzeni) resmî kaynaktan doğrulanamamıştır — kullanmadan önce Millî Park müdürlüğü ile teyit edilmelidir.',
  ST_SetSRID(ST_MakePoint(27.01, 37.65), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Port Saint Paul / Saint Nikolo (Dilek Yarımadası)', 'Dilek Yarımadası''nın (Samsun Dağı) batı ucu güney kıyısındaki iki tarihi doğal demirleme alanı; ikisinden Saint Nikolo daha iyi korunma sağlar. Bölge Dilek Yarımadası-Büyük Menderes Deltası Millî Parkı deniz alanı içindedir; özel teknelerin demirleme/giriş koşulları (ücret, izin, şamandıra düzeni) resmî kaynaktan doğrulanamamıştır — kullanmadan önce Millî Park müdürlüğü ile teyit edilmelidir.' FROM locations WHERE slug = 'port-saint-paul-saint-nikolo'
ON CONFLICT (location_id, locale) DO NOTHING;

-- --- Didim Akbük Marina · güven: low · kaynak: www.navily.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'didim-akbuk-marina', 1, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'aydin-didim'),
  'Didim Akbük Marina', 'Akbük koyunun (Mandalya/Güllük Körfezi kuzeyi) içindeki küçük marina ve bağlama tesisi; demir + kıçtan kara rıhtım bağlaması sunar, yer rezervasyonu yapılabilmektedir. Akbük koyu kuzey rüzgârlarında korunaklıdır, güney sektöre açıktır.',
  ST_SetSRID(ST_MakePoint(27.431333, 37.387), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Didim Akbük Marina', 'Akbük koyunun (Mandalya/Güllük Körfezi kuzeyi) içindeki küçük marina ve bağlama tesisi; demir + kıçtan kara rıhtım bağlaması sunar, yer rezervasyonu yapılabilmektedir. Akbük koyu kuzey rüzgârlarında korunaklıdır, güney sektöre açıktır.' FROM locations WHERE slug = 'didim-akbuk-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'didim-akbuk-marina'
ON CONFLICT (location_id) DO NOTHING;

-- --- Güzelce Marina · güven: high · kaynak: guzelcemarina.com, www.denizticaretodasi.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'guzelce-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-buyukcekmece'),
  'Güzelce Marina', 'Büyükçekmece''de özel marina; 250 deniz ve 120 kara bağlama kapasitesiyle 60 m''ye kadar yat kabul eder.',
  ST_SetSRID(ST_MakePoint(28.5097, 40.9998), 4326)::geography,
  60, NULL, NULL, NULL,
  250, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Güzelce Marina', 'Büyükçekmece''de özel marina; 250 deniz ve 120 kara bağlama kapasitesiyle 60 m''ye kadar yat kabul eder.' FROM locations WHERE slug = 'guzelce-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 250, '72/16', NULL, NULL, NULL
FROM locations WHERE slug = 'guzelce-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'guzelce-marina' AND a.code IN ('electricity', 'water', 'crane', 'wifi', 'wc', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902122443333', NULL, true
FROM locations l WHERE l.slug = 'guzelce-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@guzelcemarina.com', NULL, false
FROM locations l WHERE l.slug = 'guzelce-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://guzelcemarina.com/', NULL, false
FROM locations l WHERE l.slug = 'guzelce-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kıyı İstanbul Marina · güven: medium · kaynak: www.denizticaretodasi.org.tr, kiyimarina.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kiyi-istanbul-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-buyukcekmece'),
  'Kıyı İstanbul Marina', 'Büyükçekmece Kıyı İstanbul kompleksinde yer alan özel marina.',
  ST_SetSRID(ST_MakePoint(28.5822, 41.0156), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kıyı İstanbul Marina', 'Büyükçekmece Kıyı İstanbul kompleksinde yer alan özel marina.' FROM locations WHERE slug = 'kiyi-istanbul-marina'
ON CONFLICT (location_id, locale) DO NOTHING;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'kiyi-istanbul-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902128820090', NULL, true
FROM locations l WHERE l.slug = 'kiyi-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@kiyiistanbul.com', NULL, false
FROM locations l WHERE l.slug = 'kiyi-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://kiyimarina.com/', NULL, false
FROM locations l WHERE l.slug = 'kiyi-istanbul-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

