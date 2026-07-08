-- =====================================================================
-- Dockly — seed.sql
-- Deterministik, tekrar koşulabilir (ON CONFLICT DO NOTHING) başlangıç
-- verisi. Kaynak: docs/22-veritabani-mimarisi.md §4 + docs/00-foundation.md
-- §4 (location_type kodları) ve §7 (harita ikon renkleri).
-- Sıra: roles → currencies → countries → location_types(+i18n) →
-- boat_types(+i18n) → engine_types → amenities(+i18n) → services(+i18n)
-- → rating_dimensions(+i18n) → app_settings.
-- =====================================================================

-- ---------------------------------------------------------------------
-- roles
-- ---------------------------------------------------------------------
INSERT INTO roles (id, code, permissions, sort_order) VALUES
  (1, 'user',        '{}'::jsonb, 1),
  (2, 'moderator',   '{}'::jsonb, 2),
  (3, 'admin',       '{}'::jsonb, 3),
  (4, 'super_admin', '{}'::jsonb, 4)
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------------
-- currencies
-- ---------------------------------------------------------------------
INSERT INTO currencies (code, symbol, decimal_digits, sort_order) VALUES
  ('TRY', '₺', 2, 1),
  ('EUR', '€', 2, 2),
  ('USD', '$', 2, 3)
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------------
-- countries (TR aktif; GR, HR pasif — §5.5)
-- ---------------------------------------------------------------------
INSERT INTO countries (code, iso3, name, default_currency_code, default_locale, phone_prefix, is_active) VALUES
  ('TR', 'TUR', 'Türkiye',     'TRY', 'tr', '+90',  true),
  ('GR', 'GRC', 'Yunanistan',  'EUR', 'el', '+30',  false),
  ('HR', 'HRV', 'Hırvatistan', 'EUR', 'hr', '+385', false)
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------------
-- location_types (9 — foundation §4 kod sırası, §7 harita renkleri)
-- icon_key = code (kanonik ikon varlık adı henüz ayrı bir tasarım
-- dokümanında tanımlanmadığından, kod ile bire-bir eşlenir).
-- supports_reservation: talep akışına açık olan tipler (§8 genişleme
-- planındaki location_types.supports_reservation alanının v1 karşılığı).
-- ---------------------------------------------------------------------
INSERT INTO location_types (id, code, icon_key, color_hex, supports_reservation, sort_order) VALUES
  (1, 'private_marina',   'private_marina',   '#0C7BDC', true,  1),
  (2, 'municipal_marina', 'municipal_marina', '#3B82F6', true,  2),
  (3, 'municipal_pier',   'municipal_pier',   '#6366F1', false, 3),
  (4, 'guest_mooring',    'guest_mooring',    '#2EC4B6', true,  4),
  (5, 'restaurant_pier',  'restaurant_pier',  '#F97316', true,  5),
  (6, 'fuel_pier',        'fuel_pier',        '#EAB308', false, 6),
  (7, 'boat_club',        'boat_club',        '#8B5CF6', true,  7),
  (8, 'mooring_point',    'mooring_point',    '#64748B', false, 8),
  (9, 'buoy',             'buoy',             '#EF4444', false, 9)
ON CONFLICT (code) DO NOTHING;

INSERT INTO location_type_i18n (location_type_id, locale, name) VALUES
  (1, 'tr', 'Özel Marina'),                (1, 'en', 'Private Marina'),
  (2, 'tr', 'Belediye Marinası'),          (2, 'en', 'Municipal Marina'),
  (3, 'tr', 'Belediye İskelesi'),          (3, 'en', 'Municipal Pier'),
  (4, 'tr', 'Misafir Bağlama Noktası'),    (4, 'en', 'Guest Mooring'),
  (5, 'tr', 'Restoran İskelesi'),          (5, 'en', 'Restaurant Pier'),
  (6, 'tr', 'Yakıt İskelesi'),             (6, 'en', 'Fuel Pier'),
  (7, 'tr', 'Tekne Kulübü'),               (7, 'en', 'Boat Club'),
  (8, 'tr', 'Bağlama Noktası'),            (8, 'en', 'Mooring Point'),
  (9, 'tr', 'Şamandıra'),                  (9, 'en', 'Buoy')
ON CONFLICT (location_type_id, locale) DO NOTHING;

-- ---------------------------------------------------------------------
-- boat_types (9 — §4)
-- ---------------------------------------------------------------------
INSERT INTO boat_types (id, code, icon_key, sort_order) VALUES
  (1, 'motor_yacht',  'motor_yacht',  1),
  (2, 'sailboat',     'sailboat',     2),
  (3, 'daily_boat',   'daily_boat',   3),
  (4, 'fishing_boat', 'fishing_boat', 4),
  (5, 'catamaran',    'catamaran',    5),
  (6, 'gulet',        'gulet',        6),
  (7, 'superyacht',   'superyacht',   7),
  (8, 'rib',          'rib',          8),
  (9, 'other',        'other',        9)
ON CONFLICT (code) DO NOTHING;

INSERT INTO boat_type_i18n (boat_type_id, locale, name) VALUES
  (1, 'tr', 'Motoryat'),                (1, 'en', 'Motor Yacht'),
  (2, 'tr', 'Yelkenli'),                (2, 'en', 'Sailboat'),
  (3, 'tr', 'Günlük Tur Teknesi'),      (3, 'en', 'Daily Boat'),
  (4, 'tr', 'Balıkçı Teknesi'),         (4, 'en', 'Fishing Boat'),
  (5, 'tr', 'Katamaran'),               (5, 'en', 'Catamaran'),
  (6, 'tr', 'Gulet'),                   (6, 'en', 'Gulet'),
  (7, 'tr', 'Süperyat'),                (7, 'en', 'Superyacht'),
  (8, 'tr', 'RIB (Şişme Bot)'),         (8, 'en', 'RIB'),
  (9, 'tr', 'Diğer'),                   (9, 'en', 'Other')
ON CONFLICT (boat_type_id, locale) DO NOTHING;

-- ---------------------------------------------------------------------
-- engine_types (6 — §4; v1'de i18n tablosu tanımlı değildir, §1.6)
-- ---------------------------------------------------------------------
INSERT INTO engine_types (id, code, sort_order) VALUES
  (1, 'inboard_diesel',   1),
  (2, 'inboard_gasoline', 2),
  (3, 'outboard',         3),
  (4, 'sail_aux',         4),
  (5, 'electric',         5),
  (6, 'none',             6)
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------------
-- amenities (15 — §4; kategori: utility/comfort/food/safety)
-- ---------------------------------------------------------------------
INSERT INTO amenities (id, code, icon_key, category, sort_order) VALUES
  (1,  'electricity',        'electricity',        'utility', 1),
  (2,  'water',              'water',              'utility', 2),
  (3,  'fuel',                'fuel',               'utility', 3),
  (4,  'restaurant',          'restaurant',         'food',    4),
  (5,  'shower',              'shower',             'comfort', 5),
  (6,  'market',              'market',             'comfort', 6),
  (7,  'laundry',             'laundry',            'comfort', 7),
  (8,  'wifi',                'wifi',               'comfort', 8),
  (9,  'security',            'security',           'safety',  9),
  (10, 'open_24h',            'open_24h',           'safety',  10),
  (11, 'wc',                  'wc',                 'comfort', 11),
  (12, 'pump_out',            'pump_out',           'utility', 12),
  (13, 'crane',               'crane',              'utility', 13),
  (14, 'travel_lift',         'travel_lift',        'utility', 14),
  (15, 'technical_service',   'technical_service',  'utility', 15)
ON CONFLICT (code) DO NOTHING;

INSERT INTO amenity_i18n (amenity_id, locale, name) VALUES
  (1,  'tr', 'Elektrik'),               (1,  'en', 'Electricity'),
  (2,  'tr', 'Su'),                     (2,  'en', 'Water'),
  (3,  'tr', 'Yakıt'),                  (3,  'en', 'Fuel'),
  (4,  'tr', 'Restoran'),               (4,  'en', 'Restaurant'),
  (5,  'tr', 'Duş'),                    (5,  'en', 'Shower'),
  (6,  'tr', 'Market'),                 (6,  'en', 'Market'),
  (7,  'tr', 'Çamaşırhane'),            (7,  'en', 'Laundry'),
  (8,  'tr', 'Wi-Fi'),                  (8,  'en', 'Wi-Fi'),
  (9,  'tr', 'Güvenlik'),               (9,  'en', 'Security'),
  (10, 'tr', '7/24 Açık'),              (10, 'en', 'Open 24h'),
  (11, 'tr', 'Tuvalet'),                (11, 'en', 'WC'),
  (12, 'tr', 'Atık Su Tahliyesi'),      (12, 'en', 'Pump-Out'),
  (13, 'tr', 'Vinç'),                   (13, 'en', 'Crane'),
  (14, 'tr', 'Travel Lift'),            (14, 'en', 'Travel Lift'),
  (15, 'tr', 'Teknik Servis'),          (15, 'en', 'Technical Service')
ON CONFLICT (amenity_id, locale) DO NOTHING;

-- ---------------------------------------------------------------------
-- services (6 — §4: mooring_assist, technical_service, crane,
-- winter_storage, boat_wash, diver)
-- ---------------------------------------------------------------------
INSERT INTO services (id, code, icon_key, sort_order) VALUES
  (1, 'mooring_assist',    'mooring_assist',    1),
  (2, 'technical_service', 'technical_service', 2),
  (3, 'crane',             'crane',             3),
  (4, 'winter_storage',    'winter_storage',    4),
  (5, 'boat_wash',         'boat_wash',         5),
  (6, 'diver',             'diver',             6)
ON CONFLICT (code) DO NOTHING;

INSERT INTO service_i18n (service_id, locale, name) VALUES
  (1, 'tr', 'Palamar Yardımı'),   (1, 'en', 'Mooring Assist'),
  (2, 'tr', 'Teknik Servis'),     (2, 'en', 'Technical Service'),
  (3, 'tr', 'Vinç'),              (3, 'en', 'Crane'),
  (4, 'tr', 'Kışlama'),           (4, 'en', 'Winter Storage'),
  (5, 'tr', 'Tekne Yıkama'),      (5, 'en', 'Boat Wash'),
  (6, 'tr', 'Dalgıç'),            (6, 'en', 'Diver')
ON CONFLICT (service_id, locale) DO NOTHING;

-- ---------------------------------------------------------------------
-- rating_dimensions (5 — §4: shelter, staff, facilities,
-- value_for_money, cleanliness)
-- ---------------------------------------------------------------------
INSERT INTO rating_dimensions (id, code, sort_order) VALUES
  (1, 'shelter',          1),
  (2, 'staff',            2),
  (3, 'facilities',       3),
  (4, 'value_for_money',  4),
  (5, 'cleanliness',      5)
ON CONFLICT (code) DO NOTHING;

INSERT INTO rating_dimension_i18n (rating_dimension_id, locale, name) VALUES
  (1, 'tr', 'Korunaklılık'),          (1, 'en', 'Shelter'),
  (2, 'tr', 'Personel'),              (2, 'en', 'Staff'),
  (3, 'tr', 'Tesisler'),              (3, 'en', 'Facilities'),
  (4, 'tr', 'Fiyat/Performans'),      (4, 'en', 'Value for Money'),
  (5, 'tr', 'Temizlik'),              (5, 'en', 'Cleanliness')
ON CONFLICT (rating_dimension_id, locale) DO NOTHING;

-- ---------------------------------------------------------------------
-- app_settings (§5.10 — feature flag'ler)
-- ---------------------------------------------------------------------
INSERT INTO app_settings (key, value, description) VALUES
  ('rate_limits',  '{}'::jsonb, 'Endpoint bazlı hız sınırlama yapılandırması (v1: boş, API katmanı varsayılanları kullanır).'),
  ('banned_words',  '[]'::jsonb, 'Yorum/öneri metinlerinde otomatik reddedilecek kelime listesi (v1: boş, moderasyon manuel).')
ON CONFLICT (key) DO NOTHING;

-- =====================================================================
-- Gerçek lokasyon verisi (Faz 5 veri edinimi; kaynak/güven: prisma/data/*.json)
-- =====================================================================
\ir seed_locations.sql

-- =====================================================================
-- Seed sonu
-- =====================================================================
