-- =========================================================================
-- Dockly — Gerçek lokasyon verisi (Faz 5 veri edinimi)
-- Parti: 5.1-marinas + 5.2-municipal + 5.3-piers + 5.4-anchorages + 5.5-genisleme-istanbul-marmara-kuzeyege + 6-istanbul-genisleme-pilot + 7-dogu-akdeniz + 8-ege-marina-tamamlama + 9-yunanistan + 10-symi + 11-yunanistan-koylar-rihtimlar + 12-tr-tamamlama-kekova-yakit + 13-tr-tur2-ekincik-kekova-cevresi-bozcaada + 14-gr-tur2-halki-ucagiz-taslak + 15-gr-tur3-kalymnos-patmos-leros + 16-gr-tur4-kos-nisyros-lipsi + 17-gr-tur5-sakiz + 18-tr-gr-tur6-fethiye-hisaronu-midilli + 19-tr-tur7-icmeler-karaburun-selimiye + 20-gr-tur8-fourni-amorgos + 21-gr-tur9-naxos + 22-gr-tur10-paros + 23-gr-tur11-syros-mykonos + 24-gr-tur12-kefalonya-zakinthos + 25-gr-yakit-tur1 + 26-gr-tur13-girit-yakit2 + 27-gr-tur14-dogu-girit + 28-tr-tur15-bodrum-gokova-datca-fethiye + 29-ege-tur16-izmir-kuzey-ege-bodrum-dogu-hisaronu + 30-liman-tur17-marmara-marina-belediye + 32-gr-tur19-saronik-dogu-ege + 33-iskele-tur20-restoran-marina-liman + 34-ege-akdeniz-tur21-restoran-baglama · Toplama: 2026-07-07/08, 2026-07-11
-- Kaynak ve güven bilgisi: prisma/data/batch1_marinas.json (provenance)
-- Bu dosya generate_locations_seed.py ile üretilir; ELLE DÜZENLEME.
-- Tamamen idempotent: CI seed'i iki kez koşar (ON CONFLICT DO NOTHING).
-- =========================================================================

-- --- Ülke aktivasyonu (GR kayıtları varsa) ---
UPDATE countries SET is_active = true WHERE code = 'GR';

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
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'TR', 'province', 'Kocaeli', 'kocaeli')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Korfu', 'gr-korfu')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Preveza', 'gr-preveza')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Lefkada', 'gr-lefkada')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Mesolongi', 'gr-mesolongi')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Kalamata', 'gr-kalamata')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Atina', 'gr-atina')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Selanik', 'gr-selanik')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Halkidiki', 'gr-halkidiki')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Midilli', 'gr-midilli')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Samos', 'gr-samos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Leros', 'gr-leros')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Kos', 'gr-kos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Rodos', 'gr-rodos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Symi', 'gr-symi')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Meis (Kastellorizo)', 'gr-meis')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Tilos', 'gr-tilos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Halki (Herke)', 'gr-halki')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Kalymnos', 'gr-kalymnos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Patmos', 'gr-patmos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Nisyros', 'gr-nisyros')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Lipsi', 'gr-lipsi')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Sakız (Chios)', 'gr-sakiz')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Fourni', 'gr-fourni')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Amorgos', 'gr-amorgos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Naxos', 'gr-naxos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Paros', 'gr-paros')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Syros', 'gr-syros')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Mykonos', 'gr-mykonos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Kefalonya', 'gr-kefalonya')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Zakynthos', 'gr-zakinthos')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Girit', 'gr-girit')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Agathonisi', 'gr-agathonisi')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Astypalaia', 'gr-astypalaia')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Egina (Aegina)', 'gr-egina')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'İdra (Hydra)', 'gr-hydra')
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, level, name, slug)
VALUES (gen_random_uuid(), 'GR', 'province', 'Spetses', 'gr-spetses')
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
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Gazipaşa', 'antalya-gazipasa'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'antalya'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Erdemli', 'mersin-erdemli'
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
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Maltepe', 'istanbul-maltepe'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Silivri', 'istanbul-silivri'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'istanbul'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Aydıncık', 'mersin-aydincik'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mersin'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Anamur', 'mersin-anamur'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mersin'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Gülnar', 'mersin-gulnar'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'mersin'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'İzmit', 'kocaeli-izmit'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'kocaeli'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Gebze', 'kocaeli-gebze'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'kocaeli'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Darıca', 'kocaeli-darica'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'kocaeli'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Körfez', 'kocaeli-korfez'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'kocaeli'
ON CONFLICT (country_code, level, slug) DO NOTHING;
INSERT INTO admin_areas (id, country_code, parent_id, level, name, slug)
SELECT gen_random_uuid(), 'TR', p.id, 'district', 'Karamürsel', 'kocaeli-karamursel'
FROM admin_areas p WHERE p.country_code = 'TR' AND p.level = 'province' AND p.slug = 'kocaeli'
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'longoz-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sedir Adası Demirleme Alanı · güven: high · kaynak: turkeymarinas.blogspot.com, turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sedir-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-ula'),
  'Sedir Adası Demirleme Alanı', 'Antik Kedrai kentine ve Kleopatra Plajı''na ev sahipliği yapan Sedir Adası çevresinde doğu koyunda 8-12 m, güney koyunda 6-9 m derinliğe demirlenir. Ana demir yeri kuzey rüzgarlarına açıktır; güney koyu kuzey rüzgarlarına karşı daha korunaklıdır. YOĞUNLUK (kaynaklı): Kleopatra plajı yüksek sezonda özellikle 13:00''ten sonra aşırı kalabalıklaşır — mümkün olduğunca sabah erken gelin; plaj 19:00''da kapanır. İskele günübirlik teknelerce tutulur ve yazın çok kalabalıktır. Adaya çıkış biletli/ücretlidir; gece adaya çıkmak yasaktır (demirde gecelemek serbest).',
  ST_SetSRID(ST_MakePoint(28.207395, 36.994373), 4326)::geography,
  NULL, NULL, 6, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sedir Adası Demirleme Alanı', 'Antik Kedrai kentine ve Kleopatra Plajı''na ev sahipliği yapan Sedir Adası çevresinde doğu koyunda 8-12 m, güney koyunda 6-9 m derinliğe demirlenir. Ana demir yeri kuzey rüzgarlarına açıktır; güney koyu kuzey rüzgarlarına karşı daha korunaklıdır. YOĞUNLUK (kaynaklı): Kleopatra plajı yüksek sezonda özellikle 13:00''ten sonra aşırı kalabalıklaşır — mümkün olduğunca sabah erken gelin; plaj 19:00''da kapanır. İskele günübirlik teknelerce tutulur ve yazın çok kalabalıktır. Adaya çıkış biletli/ücretlidir; gece adaya çıkmak yasaktır (demirde gecelemek serbest).' FROM locations WHERE slug = 'sedir-adasi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
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

-- --- Kumkuyu Marina · güven: medium · kaynak: www.denizpazari.com, www.erdemlikumkuyumarina.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kumkuyu-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-erdemli'),
  'Kumkuyu Marina', 'Erdemli Kumkuyu''da 200 tekne kapasiteli özel marina; 80 tonluk travel-lift ve teknik servis atölyeleri bulunur.',
  ST_SetSRID(ST_MakePoint(34.2302, 36.5304), 4326)::geography,
  NULL, NULL, NULL, NULL,
  200, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kumkuyu Marina', 'Erdemli Kumkuyu''da 200 tekne kapasiteli özel marina; 80 tonluk travel-lift ve teknik servis atölyeleri bulunur.' FROM locations WHERE slug = 'kumkuyu-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 200, '72', NULL, 80, NULL
FROM locations WHERE slug = 'kumkuyu-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kumkuyu-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'security', 'restaurant', 'crane', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'kumkuyu-marina' AND sv.code IN ('technical_service', 'crane')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905436219383', NULL, true
FROM locations l WHERE l.slug = 'kumkuyu-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@erdemlikumkuyumarina.com', NULL, false
FROM locations l WHERE l.slug = 'kumkuyu-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.erdemlikumkuyumarina.com/', NULL, false
FROM locations l WHERE l.slug = 'kumkuyu-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Gazipaşa Gold Marina · güven: high · kaynak: www.denizticaretodasi.org.tr, gazipasagoldmarina.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gazipasa-gold-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-gazipasa'),
  'Gazipaşa Gold Marina', 'Gazipaşa''da yeni hizmete giren özel marina; Selinus Antik Kenti yakınında.',
  ST_SetSRID(ST_MakePoint(32.28, 36.2638), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gazipaşa Gold Marina', 'Gazipaşa''da yeni hizmete giren özel marina; Selinus Antik Kenti yakınında.' FROM locations WHERE slug = 'gazipasa-gold-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'gazipasa-gold-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902425107000', NULL, true
FROM locations l WHERE l.slug = 'gazipasa-gold-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@gazipasagoldmarina.com', NULL, false
FROM locations l WHERE l.slug = 'gazipasa-gold-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://gazipasagoldmarina.com/', NULL, false
FROM locations l WHERE l.slug = 'gazipasa-gold-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kairos Marina · güven: high · kaynak: marinakedisi.com, www.denizticaretodasi.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kairos-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Kairos Marina', 'Datça''da 246 deniz ve 256 kara kapasiteli özel marina.',
  ST_SetSRID(ST_MakePoint(27.6195, 36.7718), 4326)::geography,
  NULL, NULL, NULL, NULL,
  246, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kairos Marina', 'Datça''da 246 deniz ve 256 kara kapasiteli özel marina.' FROM locations WHERE slug = 'kairos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 246, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'kairos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905320642648', NULL, true
FROM locations l WHERE l.slug = 'kairos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Marintürk Göcek Exclusive Marina · güven: medium · kaynak: www.denizticaretodasi.org.tr, marinalar.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'marinturk-gocek-exclusive', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Marintürk Göcek Exclusive Marina', 'Göcek Poruklu Koyu''nda Marintürk tarafından işletilen özel marina.',
  ST_SetSRID(ST_MakePoint(28.9237, 36.7557), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Marintürk Göcek Exclusive Marina', 'Göcek Poruklu Koyu''nda Marintürk tarafından işletilen özel marina.' FROM locations WHERE slug = 'marinturk-gocek-exclusive'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '69/73', NULL, NULL, NULL
FROM locations WHERE slug = 'marinturk-gocek-exclusive'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902169991480', NULL, true
FROM locations l WHERE l.slug = 'marinturk-gocek-exclusive'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Aganlar Marina · güven: medium · kaynak: www.denizticaretodasi.org.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'aganlar-marina-bodrum', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Aganlar Marina', 'Bodrum''da marina ve yat çekek yeri.',
  ST_SetSRID(ST_MakePoint(27.4512, 37.0136), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Aganlar Marina', 'Bodrum''da marina ve yat çekek yeri.' FROM locations WHERE slug = 'aganlar-marina-bodrum'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '72/16', NULL, NULL, NULL
FROM locations WHERE slug = 'aganlar-marina-bodrum'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524444808', NULL, true
FROM locations l WHERE l.slug = 'aganlar-marina-bodrum'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Gouvia Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gouvia-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-korfu'),
  'Gouvia Marina', 'Korfu''da 1.235 bağlama ve 520 kara kapasiteli büyük marina; 80 m''ye kadar yat kabul eder.',
  ST_SetSRID(ST_MakePoint(19.8517, 39.6517), 4326)::geography,
  80, 5.5, NULL, NULL,
  1235, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gouvia Marina', 'Korfu''da 1.235 bağlama ve 520 kara kapasiteli büyük marina; 80 m''ye kadar yat kabul eder.' FROM locations WHERE slug = 'gouvia-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 1235, '69', NULL, NULL, NULL
FROM locations WHERE slug = 'gouvia-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302661091900', NULL, true
FROM locations l WHERE l.slug = 'gouvia-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kleopatra Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kleopatra-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-preveza'),
  'Kleopatra Marina', 'Aktion-Preveza''da marina ve 1.000 kapasiteli dev çekek sahası; kışlama merkezi.',
  ST_SetSRID(ST_MakePoint(20.7653, 38.9517), 4326)::geography,
  30, 8, NULL, NULL,
  100, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kleopatra Marina', 'Aktion-Preveza''da marina ve 1.000 kapasiteli dev çekek sahası; kışlama merkezi.' FROM locations WHERE slug = 'kleopatra-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 100, '67', NULL, NULL, NULL
FROM locations WHERE slug = 'kleopatra-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302682023015', NULL, true
FROM locations l WHERE l.slug = 'kleopatra-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Lefkas Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lefkas-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-lefkada'),
  'Lefkas Marina', 'Lefkada''da 620 bağlama ve 280 kara kapasiteli marina.',
  ST_SetSRID(ST_MakePoint(20.7133, 38.83), 4326)::geography,
  45, 4, NULL, NULL,
  620, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lefkas Marina', 'Lefkada''da 620 bağlama ve 280 kara kapasiteli marina.' FROM locations WHERE slug = 'lefkas-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 620, '69', NULL, NULL, NULL
FROM locations WHERE slug = 'lefkas-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302645026645', NULL, true
FROM locations l WHERE l.slug = 'lefkas-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Messolonghi Marina · güven: medium · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mesolongi-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-mesolongi'),
  'Messolonghi Marina', 'Mesolongi lagününde büyüyen marina; 230 kara kapasitesi.',
  ST_SetSRID(ST_MakePoint(21.4267, 38.3613), 4326)::geography,
  50, 6, NULL, NULL,
  180, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Messolonghi Marina', 'Mesolongi lagününde büyüyen marina; 230 kara kapasitesi.' FROM locations WHERE slug = 'mesolongi-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 180, '69', NULL, NULL, NULL
FROM locations WHERE slug = 'mesolongi-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302631050190', NULL, true
FROM locations l WHERE l.slug = 'mesolongi-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kalamata Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalamata-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kalamata'),
  'Kalamata Marina', 'Mora''nın güneyinde, Kalamata şehir merkezine bitişik marina.',
  ST_SetSRID(ST_MakePoint(22.1217, 37.0217), 4326)::geography,
  25, 3, NULL, NULL,
  250, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kalamata Marina', 'Mora''nın güneyinde, Kalamata şehir merkezine bitişik marina.' FROM locations WHERE slug = 'kalamata-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 250, '69', NULL, NULL, NULL
FROM locations WHERE slug = 'kalamata-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302721021037', NULL, true
FROM locations l WHERE l.slug = 'kalamata-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Zea Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'zea-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Zea Marina', 'Pire''nin tarihi marinası; 670 bağlama, kıçtankara 80 m''ye, aborda 150 m''ye kadar.',
  ST_SetSRID(ST_MakePoint(23.6483, 37.9367), 4326)::geography,
  80, 9, NULL, NULL,
  670, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Zea Marina', 'Pire''nin tarihi marinası; 670 bağlama, kıçtankara 80 m''ye, aborda 150 m''ye kadar.' FROM locations WHERE slug = 'zea-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 670, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'zea-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302104559000', NULL, true
FROM locations l WHERE l.slug = 'zea-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Athens Marina · güven: medium · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'athens-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Athens Marina', 'Neo Faliro''da mega ve süper yatlara özel marina; 130 m''ye kadar.',
  ST_SetSRID(ST_MakePoint(23.6655, 37.9414), 4326)::geography,
  130, NULL, NULL, NULL,
  130, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Athens Marina', 'Neo Faliro''da mega ve süper yatlara özel marina; 130 m''ye kadar.' FROM locations WHERE slug = 'athens-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 130, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'athens-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302104853200', NULL, true
FROM locations l WHERE l.slug = 'athens-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Flisvos Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'flisvos-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Flisvos Marina', 'Paleo Faliro''da mega yat odaklı marina; kapasitenin yarısı 35 m üzeri yatlara ayrılmıştır.',
  ST_SetSRID(ST_MakePoint(23.68, 37.9363), 4326)::geography,
  90, NULL, NULL, NULL,
  303, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Flisvos Marina', 'Paleo Faliro''da mega yat odaklı marina; kapasitenin yarısı 35 m üzeri yatlara ayrılmıştır.' FROM locations WHERE slug = 'flisvos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 303, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'flisvos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302109871000', NULL, true
FROM locations l WHERE l.slug = 'flisvos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Alimos Marina · güven: medium · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'alimos-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Alimos Marina', 'Atina''nın ve Yunanistan''ın en büyük marinalarından; 1.080 bağlama, 600 kara.',
  ST_SetSRID(ST_MakePoint(23.7005, 37.9113), 4326)::geography,
  40, NULL, NULL, 6.5,
  1080, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Alimos Marina', 'Atina''nın ve Yunanistan''ın en büyük marinalarından; 1.080 bağlama, 600 kara.' FROM locations WHERE slug = 'alimos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 1080, '71', NULL, NULL, NULL
FROM locations WHERE slug = 'alimos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302109880000', NULL, true
FROM locations l WHERE l.slug = 'alimos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Agios Kosmas Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agios-kosmas-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Agios Kosmas Marina', 'Elliniko''da (eski havalimanı sahili) 337 bağlama kapasiteli marina; 80 m''ye kadar.',
  ST_SetSRID(ST_MakePoint(23.7247, 37.8806), 4326)::geography,
  80, NULL, NULL, NULL,
  337, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agios Kosmas Marina', 'Elliniko''da (eski havalimanı sahili) 337 bağlama kapasiteli marina; 80 m''ye kadar.' FROM locations WHERE slug = 'agios-kosmas-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 337, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'agios-kosmas-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302109821787', NULL, true
FROM locations l WHERE l.slug = 'agios-kosmas-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Vouliagmeni Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'vouliagmeni-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Vouliagmeni Marina', 'Atina Rivierası''nın prestijli koy marinası.',
  ST_SetSRID(ST_MakePoint(23.775, 37.7217), 4326)::geography,
  50, NULL, NULL, 8,
  115, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Vouliagmeni Marina', 'Atina Rivierası''nın prestijli koy marinası.' FROM locations WHERE slug = 'vouliagmeni-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 115, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'vouliagmeni-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302108960012', NULL, true
FROM locations l WHERE l.slug = 'vouliagmeni-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Olympic Marine · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'olympic-marine', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Olympic Marine', 'Lavrio/Sounio''da 680 bağlama ve 700 kara kapasiteli büyük marina ve çekek merkezi.',
  ST_SetSRID(ST_MakePoint(24.055, 37.6983), 4326)::geography,
  40, NULL, NULL, NULL,
  680, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Olympic Marine', 'Lavrio/Sounio''da 680 bağlama ve 700 kara kapasiteli büyük marina ve çekek merkezi.' FROM locations WHERE slug = 'olympic-marine'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 680, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'olympic-marine'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302292063700', NULL, true
FROM locations l WHERE l.slug = 'olympic-marine'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Thessaloniki Aretsou Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'selanik-aretsou-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-selanik'),
  'Thessaloniki Aretsou Marina', 'Selanik Kalamaria''da şehir marinası.',
  ST_SetSRID(ST_MakePoint(22.9472, 40.5806), 4326)::geography,
  27, NULL, NULL, NULL,
  242, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Thessaloniki Aretsou Marina', 'Selanik Kalamaria''da şehir marinası.' FROM locations WHERE slug = 'selanik-aretsou-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 242, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'selanik-aretsou-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302310444595', NULL, true
FROM locations l WHERE l.slug = 'selanik-aretsou-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Sani Marina · güven: medium · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sani-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-halkidiki'),
  'Sani Marina', 'Halkidiki Kassandra''da Sani Resort bünyesinde butik marina.',
  ST_SetSRID(ST_MakePoint(23.3062, 40.0974), 4326)::geography,
  27, NULL, NULL, NULL,
  215, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sani Marina', 'Halkidiki Kassandra''da Sani Resort bünyesinde butik marina.' FROM locations WHERE slug = 'sani-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 215, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'sani-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302374099400', NULL, true
FROM locations l WHERE l.slug = 'sani-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Porto Carras Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'porto-carras-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-halkidiki'),
  'Porto Carras Marina', 'Sithonia Neos Marmaras''ta resort marinası; 55 m''ye kadar yat kabul eder.',
  ST_SetSRID(ST_MakePoint(23.7847, 40.0689), 4326)::geography,
  55, 5.5, NULL, NULL,
  315, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Porto Carras Marina', 'Sithonia Neos Marmaras''ta resort marinası; 55 m''ye kadar yat kabul eder.' FROM locations WHERE slug = 'porto-carras-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 315, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'porto-carras-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302375077000', NULL, true
FROM locations l WHERE l.slug = 'porto-carras-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mytilene Marina · güven: medium · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'midilli-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-midilli'),
  'Mytilene Marina', 'Midilli (Lesvos) adasında marina; Ayvalık''ın karşı kıyısı.',
  ST_SetSRID(ST_MakePoint(26.5578, 39.0987), 4326)::geography,
  25, NULL, NULL, NULL,
  222, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mytilene Marina', 'Midilli (Lesvos) adasında marina; Ayvalık''ın karşı kıyısı.' FROM locations WHERE slug = 'midilli-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 222, '71', NULL, NULL, NULL
FROM locations WHERE slug = 'midilli-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302251054000', NULL, true
FROM locations l WHERE l.slug = 'midilli-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Samos Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'samos-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-samos'),
  'Samos Marina', 'Pythagorio''da (Samos) 260 bağlama ve 170 kara kapasiteli marina; Kuşadası''nın karşısı.',
  ST_SetSRID(ST_MakePoint(26.9583, 37.6956), 4326)::geography,
  50, 4, NULL, NULL,
  260, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Samos Marina', 'Pythagorio''da (Samos) 260 bağlama ve 170 kara kapasiteli marina; Kuşadası''nın karşısı.' FROM locations WHERE slug = 'samos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 260, '9', NULL, NULL, NULL
FROM locations WHERE slug = 'samos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302273061600', NULL, true
FROM locations l WHERE l.slug = 'samos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Leros Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'leros-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-leros'),
  'Leros Marina', 'Lakki (Leros) doğal limanında marina ve 500 kapasiteli çekek sahası; 160 tonluk lift.',
  ST_SetSRID(ST_MakePoint(26.8567, 37.1293), 4326)::geography,
  NULL, NULL, NULL, NULL,
  220, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Leros Marina', 'Lakki (Leros) doğal limanında marina ve 500 kapasiteli çekek sahası; 160 tonluk lift.' FROM locations WHERE slug = 'leros-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 220, '10', NULL, NULL, NULL
FROM locations WHERE slug = 'leros-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302247024733', NULL, true
FROM locations l WHERE l.slug = 'leros-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kos Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kos-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kos'),
  'Kos Marina', 'Kos (İstanköy) adasında tam donanımlı marina; Bodrum''un karşı kıyısı. 100 tonluk travel-lift.',
  ST_SetSRID(ST_MakePoint(27.301, 36.8932), 4326)::geography,
  80, 5, NULL, NULL,
  250, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kos Marina', 'Kos (İstanköy) adasında tam donanımlı marina; Bodrum''un karşı kıyısı. 100 tonluk travel-lift.' FROM locations WHERE slug = 'kos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 250, '77', NULL, NULL, NULL
FROM locations WHERE slug = 'kos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kos-marina' AND a.code IN ('electricity', 'security', 'wifi', 'wc', 'shower', 'laundry', 'restaurant', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'kos-marina' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302242044150', NULL, true
FROM locations l WHERE l.slug = 'kos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@kosmarina.gr', NULL, false
FROM locations l WHERE l.slug = 'kos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://kosmarina.gr/', NULL, false
FROM locations l WHERE l.slug = 'kos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Rhodes Marina · güven: high · kaynak: greek-marinas.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'rodos-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-rodos'),
  'Rhodes Marina', 'Rodos adasında 600 bağlama kapasiteli marina; mega yat kabul eder.',
  ST_SetSRID(ST_MakePoint(28.2404, 36.4363), 4326)::geography,
  61, NULL, NULL, NULL,
  600, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Rhodes Marina', 'Rodos adasında 600 bağlama kapasiteli marina; mega yat kabul eder.' FROM locations WHERE slug = 'rodos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 600, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'rodos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302241039663', NULL, true
FROM locations l WHERE l.slug = 'rodos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Marina Symi (Pedi) · güven: high · kaynak: greek-marinas.gr, www.marina-symi.gr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'marina-symi-pedi', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Marina Symi (Pedi)', 'Symi adası Pedi koyunda 2021''de açılan marina; Gialos''a 2 km. Her tonozda elektrik ve su bağlantısı, ücretsiz Wi-Fi, duş/WC. Datça-Bozburun karşı kıyısı.',
  ST_SetSRID(ST_MakePoint(27.85778, 36.61639), 4326)::geography,
  NULL, NULL, NULL, NULL,
  50, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Marina Symi (Pedi)', 'Symi adası Pedi koyunda 2021''de açılan marina; Gialos''a 2 km. Her tonozda elektrik ve su bağlantısı, ücretsiz Wi-Fi, duş/WC. Datça-Bozburun karşı kıyısı.' FROM locations WHERE slug = 'marina-symi-pedi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 50, '71', NULL, NULL, NULL
FROM locations WHERE slug = 'marina-symi-pedi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'marina-symi-pedi' AND a.code IN ('electricity', 'water', 'wifi', 'wc', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302246071161', NULL, true
FROM locations l WHERE l.slug = 'marina-symi-pedi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@marina-symi.gr', NULL, false
FROM locations l WHERE l.slug = 'marina-symi-pedi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.marina-symi.gr/', NULL, false
FROM locations l WHERE l.slug = 'marina-symi-pedi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Symi Gialos Rıhtımı · güven: medium · kaynak: www.litando.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'symi-gialos-rihtimi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Symi Gialos Rıhtımı', 'Symi''nin ikonik ana limanı Gialos''ta kasaba rıhtımı; kıçtankara bağlama, liman görevlisi yönlendirir. Feribot neta''sına dikkat. Rıhtımda su/elektrik noktaları var ancak kullanılabilirlik değişken — varışta teyit edin.',
  ST_SetSRID(ST_MakePoint(27.83905, 36.61792), 4326)::geography,
  NULL, NULL, 3, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Symi Gialos Rıhtımı', 'Symi''nin ikonik ana limanı Gialos''ta kasaba rıhtımı; kıçtankara bağlama, liman görevlisi yönlendirir. Feribot neta''sına dikkat. Rıhtımda su/elektrik noktaları var ancak kullanılabilirlik değişken — varışta teyit edin.' FROM locations WHERE slug = 'symi-gialos-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302246070110', NULL, true
FROM locations l WHERE l.slug = 'symi-gialos-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@symi.gr', NULL, false
FROM locations l WHERE l.slug = 'symi-gialos-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.litando.gr/symi-island/', NULL, false
FROM locations l WHERE l.slug = 'symi-gialos-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Panormitis İskelesi (Symi) · güven: medium · kaynak: www.litando.gr, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'symi-panormitis-iskelesi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Panormitis İskelesi (Symi)', 'Symi''nin güneyinde, ünlü Panormitis Manastırı''nın korunaklı koyunda C-biçimli iskele (70 m) ve rıhtım (120 m). Yatlar ve yelkenliler için sakin bağlanma; derinlik iskele başında 5 m''ye kadar.',
  ST_SetSRID(ST_MakePoint(27.84868, 36.55169), 4326)::geography,
  NULL, NULL, 2, 5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Panormitis İskelesi (Symi)', 'Symi''nin güneyinde, ünlü Panormitis Manastırı''nın korunaklı koyunda C-biçimli iskele (70 m) ve rıhtım (120 m). Yatlar ve yelkenliler için sakin bağlanma; derinlik iskele başında 5 m''ye kadar.' FROM locations WHERE slug = 'symi-panormitis-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302246070110', NULL, true
FROM locations l WHERE l.slug = 'symi-panormitis-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.litando.gr/symi-island/', NULL, false
FROM locations l WHERE l.slug = 'symi-panormitis-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mandraki Limanı (Rodos) · güven: high · kaynak: www.rodosmarina.com, www.litando.gr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'rodos-mandraki-limani', 2, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-rodos'),
  'Mandraki Limanı (Rodos)', 'Rodos''un tarihî yat limanı — antik Kolossos''un yerinde, üç yel değirmeni manzaralı. Kıçtankara bağlama; rıhtımda su + 220V, tankerle yakıt, ofis yanında WC/sıcak duş. Yer ayırtma en az 48 saat önce önerilir; dipte eski tonoz hatları olduğundan bol kaloma bırakın.',
  ST_SetSRID(ST_MakePoint(28.22615, 36.45113), 4326)::geography,
  30, NULL, NULL, NULL,
  175, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mandraki Limanı (Rodos)', 'Rodos''un tarihî yat limanı — antik Kolossos''un yerinde, üç yel değirmeni manzaralı. Kıçtankara bağlama; rıhtımda su + 220V, tankerle yakıt, ofis yanında WC/sıcak duş. Yer ayırtma en az 48 saat önce önerilir; dipte eski tonoz hatları olduğundan bol kaloma bırakın.' FROM locations WHERE slug = 'rodos-mandraki-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 175, '09', NULL, NULL, NULL
FROM locations WHERE slug = 'rodos-mandraki-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'rodos-mandraki-limani' AND a.code IN ('electricity', 'water', 'fuel', 'wc', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302241037927', NULL, true
FROM locations l WHERE l.slug = 'rodos-mandraki-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.rodosmarina.com/', NULL, false
FROM locations l WHERE l.slug = 'rodos-mandraki-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kastellorizo (Meis) Rıhtımı · güven: medium · kaynak: www.litando.gr, www.predictwind.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kastellorizo-meis-rihtimi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-meis'),
  'Kastellorizo (Meis) Rıhtımı', 'Kaş''ın 2 deniz mili karşısındaki Meis adasının renkli kasaba rıhtımı; 82 m iskele, -6,3 m derinlik. Yunanistan''a GİRİŞ LİMANIDIR (gümrük/pasaport işlemi yapılır) — Türkiye''den geçiş yapan tekneler için ilk durak. Rıhtımda elektrik, su, Wi-Fi, duş/WC.',
  ST_SetSRID(ST_MakePoint(29.59206, 36.15103), 4326)::geography,
  NULL, NULL, NULL, 6.3,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kastellorizo (Meis) Rıhtımı', 'Kaş''ın 2 deniz mili karşısındaki Meis adasının renkli kasaba rıhtımı; 82 m iskele, -6,3 m derinlik. Yunanistan''a GİRİŞ LİMANIDIR (gümrük/pasaport işlemi yapılır) — Türkiye''den geçiş yapan tekneler için ilk durak. Rıhtımda elektrik, su, Wi-Fi, duş/WC.' FROM locations WHERE slug = 'kastellorizo-meis-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kastellorizo-meis-rihtimi' AND a.code IN ('electricity', 'water', 'wifi', 'shower', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302246049269', NULL, true
FROM locations l WHERE l.slug = 'kastellorizo-meis-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@megisti.gr', NULL, false
FROM locations l WHERE l.slug = 'kastellorizo-meis-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.litando.gr/kastellorizo-island-megisti/', NULL, false
FROM locations l WHERE l.slug = 'kastellorizo-meis-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Livadia Rıhtımı (Tilos) · güven: medium · kaynak: www.litando.gr, www.marinatips.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tilos-livadia-rihtimi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-tilos'),
  'Livadia Rıhtımı (Tilos)', 'Tilos adasının ana limanı Livadia''da belediye rıhtımı; 35 tekneye kadar yer, tatlı su ve elektrik bağlantısı. İskele güney kolu ~50 m, kullanılabilir derinlik -8 m. Liman duvarı içi iyi korunaklı; aborda bağlama alanı sınırlı.',
  ST_SetSRID(ST_MakePoint(27.3858, 36.4167), 4326)::geography,
  NULL, NULL, NULL, 8,
  35, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Livadia Rıhtımı (Tilos)', 'Tilos adasının ana limanı Livadia''da belediye rıhtımı; 35 tekneye kadar yer, tatlı su ve elektrik bağlantısı. İskele güney kolu ~50 m, kullanılabilir derinlik -8 m. Liman duvarı içi iyi korunaklı; aborda bağlama alanı sınırlı.' FROM locations WHERE slug = 'tilos-livadia-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'tilos-livadia-rihtimi' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302246044212', NULL, true
FROM locations l WHERE l.slug = 'tilos-livadia-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'dimtilos@otenet.gr', NULL, false
FROM locations l WHERE l.slug = 'tilos-livadia-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.litando.gr/tilos-island/', NULL, false
FROM locations l WHERE l.slug = 'tilos-livadia-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Lindos Koyu (Rodos) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lindos-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-rodos'),
  'Lindos Koyu (Rodos)', 'Rodos''un simgesi Lindos akropolünün altındaki demirleme koyu — rehberde ''Onikiadalar''ın en özel duraklarından'' diye geçer. Korunaklı, manzarası eşsiz; yaz aylarında kalabalık olabilir.',
  ST_SetSRID(ST_MakePoint(28.08342, 36.09539), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lindos Koyu (Rodos)', 'Rodos''un simgesi Lindos akropolünün altındaki demirleme koyu — rehberde ''Onikiadalar''ın en özel duraklarından'' diye geçer. Korunaklı, manzarası eşsiz; yaz aylarında kalabalık olabilir.' FROM locations WHERE slug = 'lindos-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'lindos-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Anthony Quinn Koyu (Rodos) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'anthony-quinn-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-rodos'),
  'Anthony Quinn Koyu (Rodos)', 'Rodos''un doğu kıyısında turkuaz suları ve kayalık kollarıyla ünlü küçük koy; adını 1961''de burada film çeken aktörden alır. 8-10 m kuma demirlenir, bol kaloma önerilir.',
  ST_SetSRID(ST_MakePoint(28.20977, 36.31991), 4326)::geography,
  NULL, NULL, 8, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Anthony Quinn Koyu (Rodos)', 'Rodos''un doğu kıyısında turkuaz suları ve kayalık kollarıyla ünlü küçük koy; adını 1961''de burada film çeken aktörden alır. 8-10 m kuma demirlenir, bol kaloma önerilir.' FROM locations WHERE slug = 'anthony-quinn-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'anthony-quinn-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Nanou Koyu (Symi) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'simi-nanou-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Nanou Koyu (Symi)', 'Symi''nin doğu kıyısında, yüksek kayalıklarla çevrili sakin demirleme koyu; rehberde ''mahremiyet noktası'' diye geçer. Kıyıda mevsimlik taverna bulunabilir.',
  ST_SetSRID(ST_MakePoint(27.86264, 36.58148), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Nanou Koyu (Symi)', 'Symi''nin doğu kıyısında, yüksek kayalıklarla çevrili sakin demirleme koyu; rehberde ''mahremiyet noktası'' diye geçer. Kıyıda mevsimlik taverna bulunabilir.' FROM locations WHERE slug = 'simi-nanou-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'simi-nanou-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Marathounta Koyu (Symi) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'simi-marathounta-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Marathounta Koyu (Symi)', 'Symi''nin güneydoğusunda çakıl plajlı, tenha demirleme koyu; Pedi ve Gialos''a tekneyle kısa mesafede.',
  ST_SetSRID(ST_MakePoint(27.86444, 36.5675), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Marathounta Koyu (Symi)', 'Symi''nin güneydoğusunda çakıl plajlı, tenha demirleme koyu; Pedi ve Gialos''a tekneyle kısa mesafede.' FROM locations WHERE slug = 'simi-marathounta-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'simi-marathounta-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Emporios Koyu (Symi) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'simi-emporios-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Emporios Koyu (Symi)', 'Gialos''un kuzeybatısındaki Emporios (Nimborios) koyu — ana limana yürüme mesafesinde, daha sakin bir demirleme alternatifi.',
  ST_SetSRID(ST_MakePoint(27.81858, 36.62482), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Emporios Koyu (Symi)', 'Gialos''un kuzeybatısındaki Emporios (Nimborios) koyu — ana limana yürüme mesafesinde, daha sakin bir demirleme alternatifi.' FROM locations WHERE slug = 'simi-emporios-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'simi-emporios-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Agios Vasileios Koyu (Symi) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'simi-agios-vasileios-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-symi'),
  'Agios Vasileios Koyu (Symi)', 'Symi''nin batı kıyısında, küçük şapeliyle bilinen korunaklı demirleme koyu; batı rüzgârlarında dikkatli olunmalı.',
  ST_SetSRID(ST_MakePoint(27.80502, 36.58747), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agios Vasileios Koyu (Symi)', 'Symi''nin batı kıyısında, küçük şapeliyle bilinen korunaklı demirleme koyu; batı rüzgârlarında dikkatli olunmalı.' FROM locations WHERE slug = 'simi-agios-vasileios-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'simi-agios-vasileios-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- İstinye Tekne Park Yakıt İskelesi (Türk Petrol) · güven: medium · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'istinye-tekne-park-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'istanbul'),
  'İstinye Tekne Park Yakıt İskelesi (Türk Petrol)', 'Boğaz''da İstinye koyundaki İstmarin Tekne Park içinde yakıt iskelesi (Türk Petrol).',
  ST_SetSRID(ST_MakePoint(29.058, 41.1146), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İstinye Tekne Park Yakıt İskelesi (Türk Petrol)', 'Boğaz''da İstinye koyundaki İstmarin Tekne Park içinde yakıt iskelesi (Türk Petrol).' FROM locations WHERE slug = 'istinye-tekne-park-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'istinye-tekne-park-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'istinye-tekne-park-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Setur Kuşadası Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-kusadasi-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'aydin'),
  'Setur Kuşadası Marina Yakıt İskelesi (OPET)', 'Setur Kuşadası Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(27.258333, 37.866667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Kuşadası Marina Yakıt İskelesi (OPET)', 'Setur Kuşadası Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'setur-kusadasi-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'setur-kusadasi-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-kusadasi-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Ece Saray Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ecesaray-fethiye-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Ece Saray Marina Yakıt İskelesi (OPET)', 'Fethiye Ece Saray Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(29.102778, 36.631944), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ece Saray Marina Yakıt İskelesi (OPET)', 'Fethiye Ece Saray Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'ecesaray-fethiye-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'ecesaray-fethiye-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ecesaray-fethiye-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Setur Kalamış Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-kalamis-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'istanbul'),
  'Setur Kalamış Marina Yakıt İskelesi (OPET)', 'Setur Kalamış-Fenerbahçe Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(29.036667, 40.978333), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Kalamış Marina Yakıt İskelesi (OPET)', 'Setur Kalamış-Fenerbahçe Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'setur-kalamis-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'setur-kalamis-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-kalamis-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Netsel Marmaris Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'netsel-marmaris-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Netsel Marmaris Marina Yakıt İskelesi (OPET)', 'Marmaris Netsel Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(28.268333, 36.850556), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Netsel Marmaris Marina Yakıt İskelesi (OPET)', 'Marmaris Netsel Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'netsel-marmaris-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'netsel-marmaris-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'netsel-marmaris-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Setur Ayvalık Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-ayvalik-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'balikesir'),
  'Setur Ayvalık Marina Yakıt İskelesi (OPET)', 'Setur Ayvalık Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(26.688056, 39.314167), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Ayvalık Marina Yakıt İskelesi (OPET)', 'Setur Ayvalık Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'setur-ayvalik-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'setur-ayvalik-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-ayvalik-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Setur Yalova Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-yalova-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'yalova'),
  'Setur Yalova Marina Yakıt İskelesi (OPET)', 'Setur Yalova Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(29.274, 40.661783), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Yalova Marina Yakıt İskelesi (OPET)', 'Setur Yalova Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'setur-yalova-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'setur-yalova-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-yalova-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Kaş Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kas-marina-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Kaş Marina Yakıt İskelesi (OPET)', 'Kaş Marina içinde OPET yakıt iskelesi — Meis/Kekova rotasının yakıt noktası.',
  ST_SetSRID(ST_MakePoint(29.624167, 36.205278), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kaş Marina Yakıt İskelesi (OPET)', 'Kaş Marina içinde OPET yakıt iskelesi — Meis/Kekova rotasının yakıt noktası.' FROM locations WHERE slug = 'kas-marina-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'kas-marina-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kas-marina-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Finike Marina Yakıt İskelesi (OPET) · güven: medium · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'finike-marina-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Finike Marina Yakıt İskelesi (OPET)', 'Setur Finike Marina içinde OPET yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(30.153333, 36.294), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Finike Marina Yakıt İskelesi (OPET)', 'Setur Finike Marina içinde OPET yakıt iskelesi.' FROM locations WHERE slug = 'finike-marina-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'finike-marina-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'finike-marina-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Mersin Yat Limanı Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mersin-yat-limani-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mersin'),
  'Mersin Yat Limanı Yakıt İskelesi (OPET)', 'Mersin Yat Limanı içinde OPET yakıt iskelesi — Doğu Akdeniz''in ana yakıt noktalarından.',
  ST_SetSRID(ST_MakePoint(34.575556, 36.771667), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mersin Yat Limanı Yakıt İskelesi (OPET)', 'Mersin Yat Limanı içinde OPET yakıt iskelesi — Doğu Akdeniz''in ana yakıt noktalarından.' FROM locations WHERE slug = 'mersin-yat-limani-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'mersin-yat-limani-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'mersin-yat-limani-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Ören Marina Yakıt İskelesi (OPET) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'oren-gokova-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Ören Marina Yakıt İskelesi (OPET)', 'Gökova Ören Marina içinde OPET yakıt iskelesi — Gökova Körfezi''nin kuzey kıyısı.',
  ST_SetSRID(ST_MakePoint(27.981972, 37.031417), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ören Marina Yakıt İskelesi (OPET)', 'Gökova Ören Marina içinde OPET yakıt iskelesi — Gökova Körfezi''nin kuzey kıyısı.' FROM locations WHERE slug = 'oren-gokova-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'oren-gokova-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'oren-gokova-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Ataköy Marina Yakıt İskelesi (Moil) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'atakoy-marina-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'istanbul'),
  'Ataköy Marina Yakıt İskelesi (Moil)', 'Ataköy Marina içinde Moil Deniz yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(28.881944, 40.972778), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ataköy Marina Yakıt İskelesi (Moil)', 'Ataköy Marina içinde Moil Deniz yakıt iskelesi.' FROM locations WHERE slug = 'atakoy-marina-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'atakoy-marina-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'atakoy-marina-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- City Port Marina Yakıt İskelesi (Shell) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'city-port-kartal-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'istanbul'),
  'City Port Marina Yakıt İskelesi (Shell)', 'Kartal City Port Marina içinde Shell yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(29.238056, 40.871389), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'City Port Marina Yakıt İskelesi (Shell)', 'Kartal City Port Marina içinde Shell yakıt iskelesi.' FROM locations WHERE slug = 'city-port-kartal-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'city-port-kartal-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'city-port-kartal-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Yalıkavak Marina Yakıt İskelesi (Lukoil) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yalikavak-marina-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Yalıkavak Marina Yakıt İskelesi (Lukoil)', 'Bodrum Yalıkavak Marina içinde Lukoil yakıt iskelesi — megayat kapasiteli.',
  ST_SetSRID(ST_MakePoint(27.284529, 37.102322), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yalıkavak Marina Yakıt İskelesi (Lukoil)', 'Bodrum Yalıkavak Marina içinde Lukoil yakıt iskelesi — megayat kapasiteli.' FROM locations WHERE slug = 'yalikavak-marina-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'yalikavak-marina-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yalikavak-marina-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Teos Marina Yakıt İskelesi (Petrol Ofisi) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'teos-marina-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'izmir'),
  'Teos Marina Yakıt İskelesi (Petrol Ofisi)', 'Sığacık Teos Marina içinde Petrol Ofisi yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(26.783083, 38.196075), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Teos Marina Yakıt İskelesi (Petrol Ofisi)', 'Sığacık Teos Marina içinde Petrol Ofisi yakıt iskelesi.' FROM locations WHERE slug = 'teos-marina-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'teos-marina-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'teos-marina-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Milta Bodrum Marina Yakıt İskelesi (Aytemiz) · güven: high · kaynak: marinakedisi.com, www.petrolofisi.com.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'milta-bodrum-yakit', 6, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Milta Bodrum Marina Yakıt İskelesi (Aytemiz)', 'Milta Bodrum Marina içinde Aytemiz yakıt iskelesi.',
  ST_SetSRID(ST_MakePoint(27.430556, 37.033333), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Milta Bodrum Marina Yakıt İskelesi (Aytemiz)', 'Milta Bodrum Marina içinde Aytemiz yakıt iskelesi.' FROM locations WHERE slug = 'milta-bodrum-yakit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'milta-bodrum-yakit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'milta-bodrum-yakit' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Gökkaya Koyu (Kekova) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gokkaya-koyu-kekova', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Gökkaya Koyu (Kekova)', 'Kekova''nın en büyük koyu; her yönden korunaklı. 7-8 m çamura demirlenir, tutuş iyidir. Koy içinde restoranlar var; dar boğazın başındaki Smugglers Inn tekneden alma servisi yapar. Dikkat: adacıkların batısında üzerinde 3,5 m su olan tekil kaya.',
  ST_SetSRID(ST_MakePoint(29.891167, 36.210667), 4326)::geography,
  NULL, NULL, 7, 8,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gökkaya Koyu (Kekova)', 'Kekova''nın en büyük koyu; her yönden korunaklı. 7-8 m çamura demirlenir, tutuş iyidir. Koy içinde restoranlar var; dar boğazın başındaki Smugglers Inn tekneden alma servisi yapar. Dikkat: adacıkların batısında üzerinde 3,5 m su olan tekil kaya.' FROM locations WHERE slug = 'gokkaya-koyu-kekova'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'gokkaya-koyu-kekova'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kaleköy (Simena) Restoran Pontonları · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalekoy-simena-restoran-pontonlari', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Kaleköy (Simena) Restoran Pontonları', 'Simena kalesinin altındaki Kaleköy''de üç restoran pontonu (Likya, Hasan''s Roma, Hassan Deniz) — her biri ~50 m, çift taraflı 2-3''er yat alır. Pontonlarda su, elektrik ve Wi-Fi; çamaşır hizmeti var. Ponton dipleri 4,5-14 m. Demirlemede tutuş zayıf (çamur/yosun üstü kaya) ve kuvvetli batı rüzgârı neta sokar — pontona bağlanmak ya da Üçağız''da demirleyip botla gelmek önerilir. Kaleköy, Kaş/Üçağız/Demre''den kalkan günübirlik teknelerin popüler durağıdır — gündüz saatlerinde hareketlidir.',
  ST_SetSRID(ST_MakePoint(29.847325, 36.195433), 4326)::geography,
  NULL, NULL, 4.5, 14,
  NULL, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kaleköy (Simena) Restoran Pontonları', 'Simena kalesinin altındaki Kaleköy''de üç restoran pontonu (Likya, Hasan''s Roma, Hassan Deniz) — her biri ~50 m, çift taraflı 2-3''er yat alır. Pontonlarda su, elektrik ve Wi-Fi; çamaşır hizmeti var. Ponton dipleri 4,5-14 m. Demirlemede tutuş zayıf (çamur/yosun üstü kaya) ve kuvvetli batı rüzgârı neta sokar — pontona bağlanmak ya da Üçağız''da demirleyip botla gelmek önerilir. Kaleköy, Kaş/Üçağız/Demre''den kalkan günübirlik teknelerin popüler durağıdır — gündüz saatlerinde hareketlidir.' FROM locations WHERE slug = 'kalekoy-simena-restoran-pontonlari'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'kalekoy-simena-restoran-pontonlari'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kalekoy-simena-restoran-pontonlari' AND a.code IN ('electricity', 'water', 'wifi', 'laundry', 'restaurant')
ON CONFLICT DO NOTHING;

-- --- Tersane Koyu (Kekova) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kekova-tersane-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Tersane Koyu (Kekova)', 'Kekova Adası''nın kuzeybatısında, koy başında Bizans kilisesi kalıntısı olan korunaklı koy. 4-5 m kuma demirlenir, tutuş iyi; kıç bağı için kayalarda halat delikleri var. Sezonda 09:00-20:00 arası günübirlik tekne trafiği yoğundur — geliş/gidiş saatini ona göre planlayın.',
  ST_SetSRID(ST_MakePoint(29.846333, 36.172167), 4326)::geography,
  NULL, NULL, 4, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Tersane Koyu (Kekova)', 'Kekova Adası''nın kuzeybatısında, koy başında Bizans kilisesi kalıntısı olan korunaklı koy. 4-5 m kuma demirlenir, tutuş iyi; kıç bağı için kayalarda halat delikleri var. Sezonda 09:00-20:00 arası günübirlik tekne trafiği yoğundur — geliş/gidiş saatini ona göre planlayın.' FROM locations WHERE slug = 'kekova-tersane-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'kekova-tersane-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Karalöz Limanı (Kekova) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'karaloz-limani-kekova', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Karalöz Limanı (Kekova)', 'Kekova Adası''nın güneyinde tamamen kara ile çevrili, dört yönden korunaklı gizli fiyort (Port Saint Stefano). Girişte 8-10 m, güney bölümde 7-14 m; dip çamur/yosun, tutuş iyi. Kıç bağı önerilir; sağanak rüzgâr hamleleri olabilir. Tamamen ıssızdır.',
  ST_SetSRID(ST_MakePoint(29.888333, 36.183333), 4326)::geography,
  NULL, NULL, 7, 14,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Karalöz Limanı (Kekova)', 'Kekova Adası''nın güneyinde tamamen kara ile çevrili, dört yönden korunaklı gizli fiyort (Port Saint Stefano). Girişte 8-10 m, güney bölümde 7-14 m; dip çamur/yosun, tutuş iyi. Kıç bağı önerilir; sağanak rüzgâr hamleleri olabilir. Tamamen ıssızdır.' FROM locations WHERE slug = 'karaloz-limani-kekova'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'karaloz-limani-kekova'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ekincik Köy Rıhtımı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ekincik-koy-rihtimi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Ekincik Köy Rıhtımı', 'Dalyan-Kaunos kapısı Ekincik''te kooperatifin işlettiği köy rıhtımı; baş-kıç bağlamayla ~15 tekne alır. Kuzeybatı köşedeki uzun iskelede su ve elektrik bağlantısı var. Yakıt Köyceğiz''den tankerle gelir. Kaunos antik kentine günübirlik tekneler buradan kalkar; Maden rıhtımındaki My Marina restoranı balığıyla ünlüdür.',
  ST_SetSRID(ST_MakePoint(28.54875, 36.828556), 4326)::geography,
  NULL, NULL, NULL, NULL,
  15, 'unknown', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ekincik Köy Rıhtımı', 'Dalyan-Kaunos kapısı Ekincik''te kooperatifin işlettiği köy rıhtımı; baş-kıç bağlamayla ~15 tekne alır. Kuzeybatı köşedeki uzun iskelede su ve elektrik bağlantısı var. Yakıt Köyceğiz''den tankerle gelir. Kaunos antik kentine günübirlik tekneler buradan kalkar; Maden rıhtımındaki My Marina restoranı balığıyla ünlüdür.' FROM locations WHERE slug = 'ekincik-koy-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ekincik-koy-rihtimi' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;

-- --- Ekincik Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ekincik-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Ekincik Koyu', 'Marmaris-Göcek arasının klasik molası; kuzey rüzgârlarından korunaklı geniş koy. 5-15 m kuma demirlenir, tutuş iyi. Kuzeydoğu bölümü meltemiye karşı en iyi korumayı verir ama kalabalık olur; güneybatı köşesi daha sakindir.',
  ST_SetSRID(ST_MakePoint(28.556333, 36.818083), 4326)::geography,
  NULL, NULL, 5, 15,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ekincik Koyu', 'Marmaris-Göcek arasının klasik molası; kuzey rüzgârlarından korunaklı geniş koy. 5-15 m kuma demirlenir, tutuş iyi. Kuzeydoğu bölümü meltemiye karşı en iyi korumayı verir ama kalabalık olur; güneybatı köşesi daha sakindir.' FROM locations WHERE slug = 'ekincik-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'ekincik-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Karacaören Adası Demirleme · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'karacaoren-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Karacaören Adası Demirleme', 'Gemiler Adası''nın batısında, Bizans kilise kalıntıları ve freskli mezar odalarıyla bilinen adacığın demirleme alanı. DİKKAT: geçitte su seviyesinde kayalar ve resifler var — adanın DOĞU yakasından yaklaşın; kayalar ile ada arasındaki geçit temizdir. Güneyden resifler koruma sağlar.',
  ST_SetSRID(ST_MakePoint(29.059238, 36.540464), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Karacaören Adası Demirleme', 'Gemiler Adası''nın batısında, Bizans kilise kalıntıları ve freskli mezar odalarıyla bilinen adacığın demirleme alanı. DİKKAT: geçitte su seviyesinde kayalar ve resifler var — adanın DOĞU yakasından yaklaşın; kayalar ile ada arasındaki geçit temizdir. Güneyden resifler koruma sağlar.' FROM locations WHERE slug = 'karacaoren-adasi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'karacaoren-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Yeşilköy Koyu (Fırnaz) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yesilkoy-firnaz-koyu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Yeşilköy Koyu (Fırnaz)', 'Kalkan''ın 2 mil batısında berrak sulu koy. Kuzeybatı köşede 5-10 m, plaj önünde 6-10 m; dip kum+yosun — çapayı kumlu yamaya atın, yosunda tutuş zayıftır. Hakim rüzgârlardan korunaklı ama güney/güneydoğuya açık. Kıyıda restoran, büfe ve market var.',
  ST_SetSRID(ST_MakePoint(29.36938, 36.261124), 4326)::geography,
  NULL, NULL, 5, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yeşilköy Koyu (Fırnaz)', 'Kalkan''ın 2 mil batısında berrak sulu koy. Kuzeybatı köşede 5-10 m, plaj önünde 6-10 m; dip kum+yosun — çapayı kumlu yamaya atın, yosunda tutuş zayıftır. Hakim rüzgârlardan korunaklı ama güney/güneydoğuya açık. Kıyıda restoran, büfe ve market var.' FROM locations WHERE slug = 'yesilkoy-firnaz-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'yesilkoy-firnaz-koyu'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yesilkoy-firnaz-koyu' AND a.code IN ('water', 'market')
ON CONFLICT DO NOTHING;

-- --- Emporios Rıhtımı (Halki) · güven: medium · kaynak: grecosailor.com, sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'halki-emporios-rihtimi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-halki'),
  'Emporios Rıhtımı (Halki)', 'Halki''nin (Herke) pastel renkli tek kasabası Emporios''ta rıhtım + mevsimlik T-ponton (Mayıs-Kasım). Kıçtankara/pontona bağlama; ücretsiz su, kasabada yakıt tedariki. Koy 12-18 m derinliğinde. Ücret örneği: 12,4 m tekne için ~15€. Rodos''un batı komşusu — sakin bir mola.',
  ST_SetSRID(ST_MakePoint(27.613056, 36.222806), 4326)::geography,
  NULL, NULL, 12, 18,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Emporios Rıhtımı (Halki)', 'Halki''nin (Herke) pastel renkli tek kasabası Emporios''ta rıhtım + mevsimlik T-ponton (Mayıs-Kasım). Kıçtankara/pontona bağlama; ücretsiz su, kasabada yakıt tedariki. Koy 12-18 m derinliğinde. Ücret örneği: 12,4 m tekne için ~15€. Rodos''un batı komşusu — sakin bir mola.' FROM locations WHERE slug = 'halki-emporios-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'halki-emporios-rihtimi' AND a.code IN ('water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302246045220', NULL, true
FROM locations l WHERE l.slug = 'halki-emporios-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.litando.gr/chalki-island/', NULL, false
FROM locations l WHERE l.slug = 'halki-emporios-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Üçağız Rıhtımı (Kekova) · güven: low · kaynak: sailparking.com, en.wikipedia.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ucagiz-rihtimi', 3, 'draft', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-demre'),
  'Üçağız Rıhtımı (Kekova)', 'Kekova''nın kalbi Üçağız''da kooperatifin işlettiği iki iskele; yatlar T-iskeleye bağlanır. İskelede 2-5 m derinlik, elektrik ve su; ücret karşılığı WC/duş. Dip çamur — demirlerken çapa yer yer kayabilir. Her rüzgârda iyi korunma. Kooperatif görevlileri bağlamada yardım eder.',
  ST_SetSRID(ST_MakePoint(29.85, 36.2), 4326)::geography,
  NULL, NULL, 2, 5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Üçağız Rıhtımı (Kekova)', 'Kekova''nın kalbi Üçağız''da kooperatifin işlettiği iki iskele; yatlar T-iskeleye bağlanır. İskelede 2-5 m derinlik, elektrik ve su; ücret karşılığı WC/duş. Dip çamur — demirlerken çapa yer yer kayabilir. Her rüzgârda iyi korunma. Kooperatif görevlileri bağlamada yardım eder.' FROM locations WHERE slug = 'ucagiz-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ucagiz-rihtimi' AND a.code IN ('electricity', 'water', 'wc', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'ucagiz-rihtimi' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;

-- --- Pothia Limanı (Kalymnos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalymnos-pothia-limani', 2, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kalymnos'),
  'Pothia Limanı (Kalymnos)', 'Sünger dalgıçlarının adası Kalymnos''un ana limanı Pothia''da rıhtımlı küçük marina. Su çekimi ~3 m; feribot giriş-çıkışlarında rıhtımda çalkantı olabilir. Bodrum''un karşı kıyısı — Türkiye''den kısa geçiş.',
  ST_SetSRID(ST_MakePoint(26.986167, 36.950194), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Pothia Limanı (Kalymnos)', 'Sünger dalgıçlarının adası Kalymnos''un ana limanı Pothia''da rıhtımlı küçük marina. Su çekimi ~3 m; feribot giriş-çıkışlarında rıhtımda çalkantı olabilir. Bodrum''un karşı kıyısı — Türkiye''den kısa geçiş.' FROM locations WHERE slug = 'kalymnos-pothia-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '11', NULL, NULL, NULL
FROM locations WHERE slug = 'kalymnos-pothia-limani'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302243024444', NULL, true
FROM locations l WHERE l.slug = 'kalymnos-pothia-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306947112679', NULL, false
FROM locations l WHERE l.slug = 'kalymnos-pothia-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Vlychadia Şamandıra Sahası (Kalymnos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'vlychadia-samandira-sahasi', 9, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kalymnos'),
  'Vlychadia Şamandıra Sahası (Kalymnos)', 'Kalymnos''un güney kıyısında Vlychadia plajı önünde 4 ÜCRETSİZ bağlama şamandırası. Dip kum/deniz çayırı; rehber, 25 knot üzeri hamlelerde bile tuttuğunu aktarıyor. Yunanistan verimizdeki ilk şamandıra sahası.',
  ST_SetSRID(ST_MakePoint(26.964972, 36.930167), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Vlychadia Şamandıra Sahası (Kalymnos)', 'Kalymnos''un güney kıyısında Vlychadia plajı önünde 4 ÜCRETSİZ bağlama şamandırası. Dip kum/deniz çayırı; rehber, 25 knot üzeri hamlelerde bile tuttuğunu aktarıyor. Yunanistan verimizdeki ilk şamandıra sahası.' FROM locations WHERE slug = 'vlychadia-samandira-sahasi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'vlychadia-samandira-sahasi'
ON CONFLICT (location_id) DO NOTHING;

-- --- Telendos Demirleme (Kalymnos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'telendos-demirleme', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kalymnos'),
  'Telendos Demirleme (Kalymnos)', 'Kalymnos ile heybetli Telendos adacığı arasındaki boğazda demirleme; 2,5-6 m. Dip kum/deniz çayırı — çayır yoğun, çapayı kumlu yamaya atmak için yer seçin.',
  ST_SetSRID(ST_MakePoint(26.921778, 36.996194), 4326)::geography,
  NULL, NULL, 2.5, 6,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Telendos Demirleme (Kalymnos)', 'Kalymnos ile heybetli Telendos adacığı arasındaki boğazda demirleme; 2,5-6 m. Dip kum/deniz çayırı — çayır yoğun, çapayı kumlu yamaya atmak için yer seçin.' FROM locations WHERE slug = 'telendos-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'telendos-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Skala Rıhtımı (Patmos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'patmos-skala-rihtimi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-patmos'),
  'Skala Rıhtımı (Patmos)', 'Vahiy Adası Patmos''un ana limanı Skala''da belediye rıhtımı; kıçtankara bağlama, ~5,5 m derinlik. Rıhtımda su ve elektrik (ücretli). Not: bağlama halatı ''yardımı'' için ~5€ isteyen görevliler olabilir.',
  ST_SetSRID(ST_MakePoint(26.545333, 37.328694), 4326)::geography,
  NULL, NULL, NULL, 5.5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Skala Rıhtımı (Patmos)', 'Vahiy Adası Patmos''un ana limanı Skala''da belediye rıhtımı; kıçtankara bağlama, ~5,5 m derinlik. Rıhtımda su ve elektrik (ücretli). Not: bağlama halatı ''yardımı'' için ~5€ isteyen görevliler olabilir.' FROM locations WHERE slug = 'patmos-skala-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'patmos-skala-rihtimi' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306934684668', NULL, true
FROM locations l WHERE l.slug = 'patmos-skala-rihtimi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kampos Koyu (Patmos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'patmos-kampos-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-patmos'),
  'Kampos Koyu (Patmos)', 'Patmos''un kuzeyinde berrak sulu plaj koyu; 5-7 m kuma demirlenir, kumda tutuş mükemmel — çayırlı bölgelerden kaçının.',
  ST_SetSRID(ST_MakePoint(26.567278, 37.350083), 4326)::geography,
  NULL, NULL, 5, 7,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kampos Koyu (Patmos)', 'Patmos''un kuzeyinde berrak sulu plaj koyu; 5-7 m kuma demirlenir, kumda tutuş mükemmel — çayırlı bölgelerden kaçının.' FROM locations WHERE slug = 'patmos-kampos-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'patmos-kampos-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Lakki Marina (Leros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lakki-marina-leros', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-leros'),
  'Lakki Marina (Leros)', 'Leros''un korunaklı Lakki körfezinde küçük, sakin marina; her tekneye iki tonoz halatı verilir. Derinlik ~7 m. WC/duş yok — sade ama güler yüzlü bir duraklama. (Aynı körfezdeki büyük Leros Marina ayrı kayıttır.)',
  ST_SetSRID(ST_MakePoint(26.849139, 37.129722), 4326)::geography,
  NULL, NULL, NULL, 7,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lakki Marina (Leros)', 'Leros''un korunaklı Lakki körfezinde küçük, sakin marina; her tekneye iki tonoz halatı verilir. Derinlik ~7 m. WC/duş yok — sade ama güler yüzlü bir duraklama. (Aynı körfezdeki büyük Leros Marina ayrı kayıttır.)' FROM locations WHERE slug = 'lakki-marina-leros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '11', NULL, NULL, NULL
FROM locations WHERE slug = 'lakki-marina-leros'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306909400488', NULL, true
FROM locations l WHERE l.slug = 'lakki-marina-leros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kos Eski Limanı (Mandraki) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kos-eski-liman-mandraki', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kos'),
  'Kos Eski Limanı (Mandraki)', 'Kos kalesinin dibindeki tarihî eski liman; özel işletmeli küçük marina — rehber ''gerçek bir mücevher, birinci sınıf hizmet'' diye aktarıyor. ~4 m derinlik; rıhtımda su ve elektrik. Bodrum karşısı. (Adanın büyük Kos Marina''sı ayrı kayıttır.)',
  ST_SetSRID(ST_MakePoint(27.288861, 36.895361), 4326)::geography,
  NULL, NULL, NULL, 4,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kos Eski Limanı (Mandraki)', 'Kos kalesinin dibindeki tarihî eski liman; özel işletmeli küçük marina — rehber ''gerçek bir mücevher, birinci sınıf hizmet'' diye aktarıyor. ~4 m derinlik; rıhtımda su ve elektrik. Bodrum karşısı. (Adanın büyük Kos Marina''sı ayrı kayıttır.)' FROM locations WHERE slug = 'kos-eski-liman-mandraki'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'kos-eski-liman-mandraki'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kos-eski-liman-mandraki' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302242307559', NULL, true
FROM locations l WHERE l.slug = 'kos-eski-liman-mandraki'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302242026594', NULL, false
FROM locations l WHERE l.slug = 'kos-eski-liman-mandraki'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kardamena Limanı (Kos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kardamena-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kos'),
  'Kardamena Limanı (Kos)', 'Kos''un güney kıyısında Kardamena kasaba limanı — rehber ''meltemide gerçek bir sığınak, güçlü rüzgârdan kusursuz korunma'' diyor. DİKKAT: derinlik ~2 m — derin su çeken tekneler için uygun değil.',
  ST_SetSRID(ST_MakePoint(27.144583, 36.781861), 4326)::geography,
  NULL, NULL, NULL, 2,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kardamena Limanı (Kos)', 'Kos''un güney kıyısında Kardamena kasaba limanı — rehber ''meltemide gerçek bir sığınak, güçlü rüzgârdan kusursuz korunma'' diyor. DİKKAT: derinlik ~2 m — derin su çeken tekneler için uygun değil.' FROM locations WHERE slug = 'kardamena-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302242029130', NULL, true
FROM locations l WHERE l.slug = 'kardamena-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kamari İskelesi (Kefalos, Kos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kamari-iskelesi-kefalos', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kos'),
  'Kamari İskelesi (Kefalos, Kos)', 'Kos''un batı ucunda Kefalos-Kamari koyunda iskele; ~4 m derinlik. Kuzey yüzü daha rahat yanaşılır; iskelenin ~20 m ilerisinde elektrik babalı iki tonoz var. Su noktası uzaktadır.',
  ST_SetSRID(ST_MakePoint(26.972667, 36.736667), 4326)::geography,
  NULL, NULL, NULL, 4,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kamari İskelesi (Kefalos, Kos)', 'Kos''un batı ucunda Kefalos-Kamari koyunda iskele; ~4 m derinlik. Kuzey yüzü daha rahat yanaşılır; iskelenin ~20 m ilerisinde elektrik babalı iki tonoz var. Su noktası uzaktadır.' FROM locations WHERE slug = 'kamari-iskelesi-kefalos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kamari-iskelesi-kefalos' AND a.code IN ('electricity')
ON CONFLICT DO NOTHING;

-- --- Mandraki Limanı (Nisyros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'nisyros-mandraki-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-nisyros'),
  'Mandraki Limanı (Nisyros)', 'Yanardağ adası Nisyros''un ana kasabası Mandraki''nin limanı; baş demiri + kıç halatıyla bağlanılır, ~5 m derinlik. Yer durumu için limandaki Popi yardımcı olur (ikinci telefon).',
  ST_SetSRID(ST_MakePoint(27.139444, 36.614), 4326)::geography,
  NULL, NULL, NULL, 5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mandraki Limanı (Nisyros)', 'Yanardağ adası Nisyros''un ana kasabası Mandraki''nin limanı; baş demiri + kıç halatıyla bağlanılır, ~5 m derinlik. Yer durumu için limandaki Popi yardımcı olur (ikinci telefon).' FROM locations WHERE slug = 'nisyros-mandraki-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302242031222', NULL, true
FROM locations l WHERE l.slug = 'nisyros-mandraki-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306986059610', NULL, false
FROM locations l WHERE l.slug = 'nisyros-mandraki-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Pali Limanı (Nisyros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'pali-limani-nisyros', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-nisyros'),
  'Pali Limanı (Nisyros)', 'Nisyros''un kuzey kıyısında Pali balıkçı limanı; baş demiri + kıç halatıyla kolay bağlanma. DİKKAT: giriş kara tarafında ve sığdır (~2,5 m) — tarama çalışması sürüyor.',
  ST_SetSRID(ST_MakePoint(27.171361, 36.619139), 4326)::geography,
  NULL, NULL, NULL, 2.5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Pali Limanı (Nisyros)', 'Nisyros''un kuzey kıyısında Pali balıkçı limanı; baş demiri + kıç halatıyla kolay bağlanma. DİKKAT: giriş kara tarafında ve sığdır (~2,5 m) — tarama çalışması sürüyor.' FROM locations WHERE slug = 'pali-limani-nisyros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302242031222', NULL, true
FROM locations l WHERE l.slug = 'pali-limani-nisyros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Lipsi Limanı · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lipsi-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-lipsi'),
  'Lipsi Limanı', 'Patmos-Leros arasındaki sakin Lipsi adasının limanı; ~3 m derinlik. Kuzey rüzgârından gerçek korunma limanın içindedir; alan dar — demir ve zincirlerin çaprazlanması olağandır, yan rüzgârda dikkat.',
  ST_SetSRID(ST_MakePoint(26.767389, 37.294389), 4326)::geography,
  NULL, NULL, NULL, 3,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lipsi Limanı', 'Patmos-Leros arasındaki sakin Lipsi adasının limanı; ~3 m derinlik. Kuzey rüzgârından gerçek korunma limanın içindedir; alan dar — demir ve zincirlerin çaprazlanması olağandır, yan rüzgârda dikkat.' FROM locations WHERE slug = 'lipsi-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302247041133', NULL, true
FROM locations l WHERE l.slug = 'lipsi-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Limia Marina (Sakız) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'limia-marina-sakiz', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-sakiz'),
  'Limia Marina (Sakız)', 'Sakız''ın kuzeybatısında, Volissos yakınındaki Limnia koyunda küçük marina; su ve elektrik ÜCRETSİZ. Su çekimi ~3,5 m. Çeşme-Karaburun karşısındaki sakin alternatif.',
  ST_SetSRID(ST_MakePoint(25.918, 38.469583), 4326)::geography,
  NULL, 3.5, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Limia Marina (Sakız)', 'Sakız''ın kuzeybatısında, Volissos yakınındaki Limnia koyunda küçük marina; su ve elektrik ÜCRETSİZ. Su çekimi ~3,5 m. Çeşme-Karaburun karşısındaki sakin alternatif.' FROM locations WHERE slug = 'limia-marina-sakiz'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'limia-marina-sakiz'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'limia-marina-sakiz' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306936775999', NULL, true
FROM locations l WHERE l.slug = 'limia-marina-sakiz'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mesta Limanı (Sakız) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mesta-limani-sakiz', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-sakiz'),
  'Mesta Limanı (Sakız)', 'Sakız''ın güneybatısında, ortaçağ mastika köyü Mesta''nın limanı (Limenas Meston); su çekimi ~5,5 m — adanın derin limanlarından.',
  ST_SetSRID(ST_MakePoint(25.930083, 38.289056), 4326)::geography,
  NULL, 5.5, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mesta Limanı (Sakız)', 'Sakız''ın güneybatısında, ortaçağ mastika köyü Mesta''nın limanı (Limenas Meston); su çekimi ~5,5 m — adanın derin limanlarından.' FROM locations WHERE slug = 'mesta-limani-sakiz'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302271076239', NULL, true
FROM locations l WHERE l.slug = 'mesta-limani-sakiz'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Agia Ermioni Limanı (Sakız) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agia-ermioni-limani-sakiz', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-sakiz'),
  'Agia Ermioni Limanı (Sakız)', 'Sakız kentinin güneyinde Agia Ermioni balıkçı limanı; Çeşme''nin tam karşısı. İki telefonla liman yetkilisine ulaşılır.',
  ST_SetSRID(ST_MakePoint(26.148944, 38.3005), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agia Ermioni Limanı (Sakız)', 'Sakız kentinin güneyinde Agia Ermioni balıkçı limanı; Çeşme''nin tam karşısı. İki telefonla liman yetkilisine ulaşılır.' FROM locations WHERE slug = 'agia-ermioni-limani-sakiz'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302271022770', NULL, true
FROM locations l WHERE l.slug = 'agia-ermioni-limani-sakiz'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302271023237', NULL, false
FROM locations l WHERE l.slug = 'agia-ermioni-limani-sakiz'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Limnos Plajı Demirleme (Sakız) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'limnos-plaji-sakiz', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-sakiz'),
  'Limnos Plajı Demirleme (Sakız)', 'Limnia koyu yanındaki Limnos plajı önünde demirleme; 3,5 m kuma atılır — rehber ''mükemmel tutuş'' diye aktarıyor.',
  ST_SetSRID(ST_MakePoint(25.909222, 38.472167), 4326)::geography,
  NULL, NULL, NULL, 3.5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Limnos Plajı Demirleme (Sakız)', 'Limnia koyu yanındaki Limnos plajı önünde demirleme; 3,5 m kuma atılır — rehber ''mükemmel tutuş'' diye aktarıyor.' FROM locations WHERE slug = 'limnos-plaji-sakiz'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'limnos-plaji-sakiz'
ON CONFLICT (location_id) DO NOTHING;

-- --- Agia Markella Demirleme (Sakız) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agia-markella-sakiz', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-sakiz'),
  'Agia Markella Demirleme (Sakız)', 'Sakız''ın kuzeybatısında, adanın koruyucu azizesinin manastırının önündeki plajda kumluk demirleme alanı.',
  ST_SetSRID(ST_MakePoint(25.884861, 38.47925), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agia Markella Demirleme (Sakız)', 'Sakız''ın kuzeybatısında, adanın koruyucu azizesinin manastırının önündeki plajda kumluk demirleme alanı.' FROM locations WHERE slug = 'agia-markella-sakiz'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'agia-markella-sakiz'
ON CONFLICT (location_id) DO NOTHING;

-- --- Uzun Liman (Hisarönü) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'uzun-liman-hisaronu', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Uzun Liman (Hisarönü)', 'Hisarönü Körfezi''nde, Küfre''nin komşusu uzun ve dar koy; plaj tarafı her yönden korunaklıdır. Ana koyda 8-10 m''ye demirlenir; iç uçta ''Saklı Liman'' denen 2 m''den sığ gizli havuz vardır — sazlık kıyılara dikkat. Tamamen doğal, tesissiz.',
  ST_SetSRID(ST_MakePoint(28.046812, 36.868878), 4326)::geography,
  NULL, NULL, 8, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Uzun Liman (Hisarönü)', 'Hisarönü Körfezi''nde, Küfre''nin komşusu uzun ve dar koy; plaj tarafı her yönden korunaklıdır. Ana koyda 8-10 m''ye demirlenir; iç uçta ''Saklı Liman'' denen 2 m''den sığ gizli havuz vardır — sazlık kıyılara dikkat. Tamamen doğal, tesissiz.' FROM locations WHERE slug = 'uzun-liman-hisaronu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'uzun-liman-hisaronu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Çoban Limanı (Kumluca) · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'coban-limani-kumluca', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'antalya'),
  'Çoban Limanı (Kumluca)', 'Adrasan-Taşlık Burnu arasında vahşi ve doğal büyük koy; gecelemek için korunma sağlar. Karadan yol ve su YOKTUR — tamamen ıssız. Berrak suları şnorkel ve dalış için ünlüdür (koy 60 m''ye kadar derinleşir). Taşlıkburnu ve Adrasan fenerleri seyir yardımcısıdır.',
  ST_SetSRID(ST_MakePoint(30.524414, 36.342172), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çoban Limanı (Kumluca)', 'Adrasan-Taşlık Burnu arasında vahşi ve doğal büyük koy; gecelemek için korunma sağlar. Karadan yol ve su YOKTUR — tamamen ıssız. Berrak suları şnorkel ve dalış için ünlüdür (koy 60 m''ye kadar derinleşir). Taşlıkburnu ve Adrasan fenerleri seyir yardımcısıdır.' FROM locations WHERE slug = 'coban-limani-kumluca'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'coban-limani-kumluca'
ON CONFLICT (location_id) DO NOTHING;

-- --- Soğuksu Koyu (Fethiye) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'soguksu-koyu-fethiye', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Soğuksu Koyu (Fethiye)', 'Fethiye Körfezi''nde ''Tatlısu'' diye de bilinen koy: dipteki kaynaklar yüzeyde serin bir tatlı su tabakası oluşturur — yüzmesi meşhurdur. Plaj önünde 6-8 m''ye demir + kıça uzun halat düzeni; restoran personeli bağlamada yardım eder. Tepedeki restoran manzarası ve ızgarasıyla bilinir; tekneden alma-bırakma servisi vardır. İç kol (Soğuksu Limanı) iyi korunaklı; ana koy güneye açıktır.',
  ST_SetSRID(ST_MakePoint(29.08339, 36.562924), 4326)::geography,
  NULL, NULL, 6, 8,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Soğuksu Koyu (Fethiye)', 'Fethiye Körfezi''nde ''Tatlısu'' diye de bilinen koy: dipteki kaynaklar yüzeyde serin bir tatlı su tabakası oluşturur — yüzmesi meşhurdur. Plaj önünde 6-8 m''ye demir + kıça uzun halat düzeni; restoran personeli bağlamada yardım eder. Tepedeki restoran manzarası ve ızgarasıyla bilinir; tekneden alma-bırakma servisi vardır. İç kol (Soğuksu Limanı) iyi korunaklı; ana koy güneye açıktır.' FROM locations WHERE slug = 'soguksu-koyu-fethiye'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'soguksu-koyu-fethiye'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'soguksu-koyu-fethiye' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Molyvos Limanı (Midilli) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'molyvos-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-midilli'),
  'Molyvos Limanı (Midilli)', 'Midilli''nin kuzeyinde, kale manzaralı taş kasaba Molyvos''un (Mithymna) rıhtımı — rehber ''kuvvetli karayelde bile mükemmel korunma'' diyor. ÜCRETSİZ bağlama ve ücretsiz su. Ayvalık-Dikili karşı kıyısı.',
  ST_SetSRID(ST_MakePoint(26.168528, 39.368389), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Molyvos Limanı (Midilli)', 'Midilli''nin kuzeyinde, kale manzaralı taş kasaba Molyvos''un (Mithymna) rıhtımı — rehber ''kuvvetli karayelde bile mükemmel korunma'' diyor. ÜCRETSİZ bağlama ve ücretsiz su. Ayvalık-Dikili karşı kıyısı.' FROM locations WHERE slug = 'molyvos-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'molyvos-limani' AND a.code IN ('water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302253071847', NULL, true
FROM locations l WHERE l.slug = 'molyvos-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Sigri Limanı (Midilli) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sigri-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-midilli'),
  'Sigri Limanı (Midilli)', 'Midilli''nin batı ucunda Sigri limanı; su ve elektrik ''Lesbos kartı'' ile kullanılır. DİKKAT: haritaya göre su çekimi 1,4 m ile SINIRLI — yelkenliler için uygun değil, sığ tekneler içindir.',
  ST_SetSRID(ST_MakePoint(25.852028, 39.212833), 4326)::geography,
  NULL, 1.4, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sigri Limanı (Midilli)', 'Midilli''nin batı ucunda Sigri limanı; su ve elektrik ''Lesbos kartı'' ile kullanılır. DİKKAT: haritaya göre su çekimi 1,4 m ile SINIRLI — yelkenliler için uygun değil, sığ tekneler içindir.' FROM locations WHERE slug = 'sigri-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'sigri-limani' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302253054321', NULL, true
FROM locations l WHERE l.slug = 'sigri-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Skala Kallonis Demirleme (Midilli) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'skala-kallonis-demirleme', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-midilli'),
  'Skala Kallonis Demirleme (Midilli)', 'Midilli''nin iç körfezi Kalloni''nin başındaki sardalyasıyla ünlü Skala Kallonis önünde demirleme; ~5 m, kum/çamur dip — rehber ''mükemmel tutuş'' ve kuzey rüzgârlarına iyi korunma aktarıyor.',
  ST_SetSRID(ST_MakePoint(26.209694, 39.202722), 4326)::geography,
  NULL, NULL, NULL, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Skala Kallonis Demirleme (Midilli)', 'Midilli''nin iç körfezi Kalloni''nin başındaki sardalyasıyla ünlü Skala Kallonis önünde demirleme; ~5 m, kum/çamur dip — rehber ''mükemmel tutuş'' ve kuzey rüzgârlarına iyi korunma aktarıyor.' FROM locations WHERE slug = 'skala-kallonis-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'skala-kallonis-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- İçmeler Rıhtımı (Marmaris) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'icmeler-rihtimi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'İçmeler Rıhtımı (Marmaris)', 'Marmaris İçmeler''de büyük rıhtım — 257 tekneye kadar kapasite. Rıhtımda su ve elektrik bağlantıları, duş/WC, sintine suyu boşaltma servisi. Kasabada restoran, market, banka/ATM, eczane, çamaşırhane — her ihtiyaç yürüme mesafesinde.',
  ST_SetSRID(ST_MakePoint(28.239423, 36.802375), 4326)::geography,
  NULL, NULL, NULL, NULL,
  257, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İçmeler Rıhtımı (Marmaris)', 'Marmaris İçmeler''de büyük rıhtım — 257 tekneye kadar kapasite. Rıhtımda su ve elektrik bağlantıları, duş/WC, sintine suyu boşaltma servisi. Kasabada restoran, market, banka/ATM, eczane, çamaşırhane — her ihtiyaç yürüme mesafesinde.' FROM locations WHERE slug = 'icmeler-rihtimi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'icmeler-rihtimi' AND a.code IN ('electricity', 'water', 'shower', 'wc', 'restaurant', 'market', 'laundry', 'pump_out')
ON CONFLICT DO NOTHING;

-- --- İçmeler Koyu Demirleme (Marmaris) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'icmeler-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'İçmeler Koyu Demirleme (Marmaris)', 'İçmeler koyunda demirleme alanı; 10-14 m, dip yosun+kum. Keçi Adası feneri ile Sarı Mehmet Burnu arasındaki geçit derindir (~36 m). Kuvvetli batı rüzgârı dağlardan neta itebilir.',
  ST_SetSRID(ST_MakePoint(28.237194, 36.804456), 4326)::geography,
  NULL, NULL, 10, 14,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İçmeler Koyu Demirleme (Marmaris)', 'İçmeler koyunda demirleme alanı; 10-14 m, dip yosun+kum. Keçi Adası feneri ile Sarı Mehmet Burnu arasındaki geçit derindir (~36 m). Kuvvetli batı rüzgârı dağlardan neta itebilir.' FROM locations WHERE slug = 'icmeler-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'icmeler-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Engeceli (Manal) Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'engeceli-manal-limani', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-karaburun'),
  'Engeceli (Manal) Limanı', 'Karaburun Yarımadası''nın batısında, üç koylu geniş doğal liman — bütünüyle her yönden korunma sağlar. Manal Koyu''nda 3-4 m kuma demirlenir (kuzeyliye korunaklı, güneye açık); batıdaki Körfez ve Gerence koyları her yönden korunaklıdır, kum dip iyi tutar.',
  ST_SetSRID(ST_MakePoint(26.596861, 38.463472), 4326)::geography,
  NULL, NULL, 3, 4,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Engeceli (Manal) Limanı', 'Karaburun Yarımadası''nın batısında, üç koylu geniş doğal liman — bütünüyle her yönden korunma sağlar. Manal Koyu''nda 3-4 m kuma demirlenir (kuzeyliye korunaklı, güneye açık); batıdaki Körfez ve Gerence koyları her yönden korunaklıdır, kum dip iyi tutar.' FROM locations WHERE slug = 'engeceli-manal-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'engeceli-manal-limani'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sığ Liman (Selimiye) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sig-liman-selimiye', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Sığ Liman (Selimiye)', 'Selimiye''ye 2 km''deki bu koyda su o kadar berraktır ki ''dibe değeceğim'' hissi verir. 4-12 m, yosun+kum — çapanın iyi gömüldüğünden emin olun, gecelemede kıça halat alın. Kuvvetli poyrazda neta girer. Gündüz günübirlik tekneler uğrar, geceleri sakindir; sığ kumlu plajı yüzme için idealdir.',
  ST_SetSRID(ST_MakePoint(28.090207, 36.726938), 4326)::geography,
  NULL, NULL, 4, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sığ Liman (Selimiye)', 'Selimiye''ye 2 km''deki bu koyda su o kadar berraktır ki ''dibe değeceğim'' hissi verir. 4-12 m, yosun+kum — çapanın iyi gömüldüğünden emin olun, gecelemede kıça halat alın. Kuvvetli poyrazda neta girer. Gündüz günübirlik tekneler uğrar, geceleri sakindir; sığ kumlu plajı yüzme için idealdir.' FROM locations WHERE slug = 'sig-liman-selimiye'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'sig-liman-selimiye'
ON CONFLICT (location_id) DO NOTHING;

-- --- Thymaina İskelesi (Fourni) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'thymaina-iskelesi', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-fourni'),
  'Thymaina İskelesi (Fourni)', 'Samos-İkarya arasındaki Fourni takımadasının sakin adası Thymaina''nın köy iskelesi; rehber ''rahat konaklama için iskeleye yanaşın'' diyor. Turizmin uğramadığı, otantik bir mola.',
  ST_SetSRID(ST_MakePoint(26.454528, 37.582444), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Thymaina İskelesi (Fourni)', 'Samos-İkarya arasındaki Fourni takımadasının sakin adası Thymaina''nın köy iskelesi; rehber ''rahat konaklama için iskeleye yanaşın'' diyor. Turizmin uğramadığı, otantik bir mola.' FROM locations WHERE slug = 'thymaina-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- --- Thymaina Güney Koyu · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'thymaina-guney-koyu', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-fourni'),
  'Thymaina Güney Koyu', 'Şapeller arasına saklanmış küçük koy — öğle molası için huzurlu bir nokta. 4,5 m, kum/deniz çayırı; sakin havada yeterli korunma.',
  ST_SetSRID(ST_MakePoint(26.454611, 37.580472), 4326)::geography,
  NULL, NULL, NULL, 4.5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Thymaina Güney Koyu', 'Şapeller arasına saklanmış küçük koy — öğle molası için huzurlu bir nokta. 4,5 m, kum/deniz çayırı; sakin havada yeterli korunma.' FROM locations WHERE slug = 'thymaina-guney-koyu'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'thymaina-guney-koyu'
ON CONFLICT (location_id) DO NOTHING;

-- --- Lakkos Koyu (Thymaina) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lakkos-koyu-thymaina', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-fourni'),
  'Lakkos Koyu (Thymaina)', 'Thymaina''nın güneyinde berraklığıyla ''olağanüstü'' diye anılan koy; koy ortasında 8 m, kumda güvenli tutuş. Poyraz/karayelden mükemmel korunma; cep telefonu çeker.',
  ST_SetSRID(ST_MakePoint(26.453306, 37.572167), 4326)::geography,
  NULL, NULL, NULL, 8,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lakkos Koyu (Thymaina)', 'Thymaina''nın güneyinde berraklığıyla ''olağanüstü'' diye anılan koy; koy ortasında 8 m, kumda güvenli tutuş. Poyraz/karayelden mükemmel korunma; cep telefonu çeker.' FROM locations WHERE slug = 'lakkos-koyu-thymaina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'lakkos-koyu-thymaina'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kleftolimano Koyu (Thymaina) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kleftolimano-koyu-thymaina', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-fourni'),
  'Kleftolimano Koyu (Thymaina)', 'Adı ''korsan limanı'' anlamına gelen tek teknelik ıssız koy; kıyıya halat alınabilir. DİKKAT: çapa tutuşu ZAYIF (kum/çayır/kaya karışık dip) ve meltemiye açık — yalnız uygun havada.',
  ST_SetSRID(ST_MakePoint(26.44025, 37.577056), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kleftolimano Koyu (Thymaina)', 'Adı ''korsan limanı'' anlamına gelen tek teknelik ıssız koy; kıyıya halat alınabilir. DİKKAT: çapa tutuşu ZAYIF (kum/çayır/kaya karışık dip) ve meltemiye açık — yalnız uygun havada.' FROM locations WHERE slug = 'kleftolimano-koyu-thymaina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'kleftolimano-koyu-thymaina'
ON CONFLICT (location_id) DO NOTHING;

-- --- Maltezi Plajı Demirleme (Amorgos) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'maltezi-plaji-amorgos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-amorgos'),
  'Maltezi Plajı Demirleme (Amorgos)', 'Katapola körfezinin kuzey rüzgârlarında tercih edilen demirlemesi — Hozoviotissa Manastırı''nın adasında. Derin körfez güvenli demirleme sağlar; feribot manevraları çapaları etkileyebilir.',
  ST_SetSRID(ST_MakePoint(25.8533, 36.83569), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Maltezi Plajı Demirleme (Amorgos)', 'Katapola körfezinin kuzey rüzgârlarında tercih edilen demirlemesi — Hozoviotissa Manastırı''nın adasında. Derin körfez güvenli demirleme sağlar; feribot manevraları çapaları etkileyebilir.' FROM locations WHERE slug = 'maltezi-plaji-amorgos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'maltezi-plaji-amorgos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Katapola Güney Demirleme (Amorgos) · güven: medium · kaynak: sailingissues.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'katapola-guney-demirleme', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-amorgos'),
  'Katapola Güney Demirleme (Amorgos)', 'Katapola''da güney rüzgârlarında tercih edilen demirleme (liman ile Panagia kilisesi arası). Kasaba rıhtımında kıçtankara yer, su ve elektrik vardır; feribot rıhtımının doğusu sığdır — uzak durun. Fazla kaloma zincir çaprazlanmasına yol açabilir.',
  ST_SetSRID(ST_MakePoint(25.85621, 36.82733), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Katapola Güney Demirleme (Amorgos)', 'Katapola''da güney rüzgârlarında tercih edilen demirleme (liman ile Panagia kilisesi arası). Kasaba rıhtımında kıçtankara yer, su ve elektrik vardır; feribot rıhtımının doğusu sığdır — uzak durun. Fazla kaloma zincir çaprazlanmasına yol açabilir.' FROM locations WHERE slug = 'katapola-guney-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'katapola-guney-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kalantos Marina (Naxos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalantos-marina-naxos', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-naxos'),
  'Kalantos Marina (Naxos)', 'Naxos''un güney ucunda, meltemiden saklanan Kalantos koyundaki küçük marina; su çekimi ~3 m. Kiklad geçişlerinde güney rotasının sığınağı.',
  ST_SetSRID(ST_MakePoint(25.473778, 36.935167), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kalantos Marina (Naxos)', 'Naxos''un güney ucunda, meltemiden saklanan Kalantos koyundaki küçük marina; su çekimi ~3 m. Kiklad geçişlerinde güney rotasının sığınağı.' FROM locations WHERE slug = 'kalantos-marina-naxos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'kalantos-marina-naxos'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306938690826', NULL, true
FROM locations l WHERE l.slug = 'kalantos-marina-naxos'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kalantos Koyu (Naxos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kalantos-koyu-naxos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-naxos'),
  'Kalantos Koyu (Naxos)', 'Naxos''un güneyindeki geniş Kalantos koyunda demirleme; derinlik 12 m''den 6 m''ye kademeli azalır, dip kum/kaya karışık — kumlu yamaları seçin.',
  ST_SetSRID(ST_MakePoint(25.468278, 36.934333), 4326)::geography,
  NULL, NULL, 6, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kalantos Koyu (Naxos)', 'Naxos''un güneyindeki geniş Kalantos koyunda demirleme; derinlik 12 m''den 6 m''ye kademeli azalır, dip kum/kaya karışık — kumlu yamaları seçin.' FROM locations WHERE slug = 'kalantos-koyu-naxos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'kalantos-koyu-naxos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Pyrgaki Plajı (Naxos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'pyrgaki-plaji-naxos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-naxos'),
  'Pyrgaki Plajı (Naxos)', 'Naxos''un güneybatısında sakin plaj demirlemesi; ~6,5 m, kum/kaya karışık dip.',
  ST_SetSRID(ST_MakePoint(25.398972, 36.976361), 4326)::geography,
  NULL, NULL, NULL, 6.5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Pyrgaki Plajı (Naxos)', 'Naxos''un güneybatısında sakin plaj demirlemesi; ~6,5 m, kum/kaya karışık dip.' FROM locations WHERE slug = 'pyrgaki-plaji-naxos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'pyrgaki-plaji-naxos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Agios Prokopios (Naxos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agios-prokopios-naxos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-naxos'),
  'Agios Prokopios (Naxos)', 'Naxos''un ünlü Agios Prokopios plajı önünde demirleme; ~10 m, kum dip. Naxos kasabasına yakın, yüzme molası için ideal.',
  ST_SetSRID(ST_MakePoint(25.3465, 37.075139), 4326)::geography,
  NULL, NULL, NULL, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agios Prokopios (Naxos)', 'Naxos''un ünlü Agios Prokopios plajı önünde demirleme; ~10 m, kum dip. Naxos kasabasına yakın, yüzme molası için ideal.' FROM locations WHERE slug = 'agios-prokopios-naxos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'agios-prokopios-naxos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Plaka Plajı (Naxos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'plaka-plaji-naxos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-naxos'),
  'Plaka Plajı (Naxos)', 'Kilometrelerce uzanan Plaka plajının önünde demirleme; ~7,9 m, kum/kaya karışık dip.',
  ST_SetSRID(ST_MakePoint(25.37775, 37.038222), 4326)::geography,
  NULL, NULL, NULL, 7.9,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Plaka Plajı (Naxos)', 'Kilometrelerce uzanan Plaka plajının önünde demirleme; ~7,9 m, kum/kaya karışık dip.' FROM locations WHERE slug = 'plaka-plaji-naxos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'plaka-plaji-naxos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Parikia Limanı (Paros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'parikia-limani-paros', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-paros'),
  'Parikia Limanı (Paros)', 'Paros''un başkenti Parikia''nın ana limanı; VHF 11, su çekimi ~3,5 m. Cuma-cumartesi rıhtım kiralık teknelere ayrılır; kuvvetli poyrazda dış rıhtım zorlayıcıdır — koyda demirlemek önerilir.',
  ST_SetSRID(ST_MakePoint(25.15275, 37.087806), 4326)::geography,
  NULL, 3.5, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Parikia Limanı (Paros)', 'Paros''un başkenti Parikia''nın ana limanı; VHF 11, su çekimi ~3,5 m. Cuma-cumartesi rıhtım kiralık teknelere ayrılır; kuvvetli poyrazda dış rıhtım zorlayıcıdır — koyda demirlemek önerilir.' FROM locations WHERE slug = 'parikia-limani-paros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306948431842', NULL, true
FROM locations l WHERE l.slug = 'parikia-limani-paros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306979982381', NULL, false
FROM locations l WHERE l.slug = 'parikia-limani-paros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Cabana Plajı (Paros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'cabana-plaji-paros', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-paros'),
  'Cabana Plajı (Paros)', 'Parikia koyunun kuzeyinde demirleme; ~14 m, kum/kaya. Kuzey, doğu ve batı rüzgârlarından mükemmel korunma.',
  ST_SetSRID(ST_MakePoint(25.150028, 37.093278), 4326)::geography,
  NULL, NULL, NULL, 14,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Cabana Plajı (Paros)', 'Parikia koyunun kuzeyinde demirleme; ~14 m, kum/kaya. Kuzey, doğu ve batı rüzgârlarından mükemmel korunma.' FROM locations WHERE slug = 'cabana-plaji-paros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'cabana-plaji-paros'
ON CONFLICT (location_id) DO NOTHING;

-- --- Krios Plajı (Paros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'krios-plaji-paros', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-paros'),
  'Krios Plajı (Paros)', 'Parikia''ya botla 10 dakikadaki korunaklı plaj demirlemesi; dip kum/deniz çayırı — kumlu yamaları seçin.',
  ST_SetSRID(ST_MakePoint(25.140167, 37.095), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Krios Plajı (Paros)', 'Parikia''ya botla 10 dakikadaki korunaklı plaj demirlemesi; dip kum/deniz çayırı — kumlu yamaları seçin.' FROM locations WHERE slug = 'krios-plaji-paros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'krios-plaji-paros'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kolympethres (Paros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kolympethres-paros', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-paros'),
  'Kolympethres (Paros)', 'Naoussa körfezindeki ünlü granit kayalıklı Kolympethres plajı önünde demirleme; ~6 m, kristal berraklıkta su, tutuş iyi.',
  ST_SetSRID(ST_MakePoint(25.216056, 37.127806), 4326)::geography,
  NULL, NULL, NULL, 6,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kolympethres (Paros)', 'Naoussa körfezindeki ünlü granit kayalıklı Kolympethres plajı önünde demirleme; ~6 m, kristal berraklıkta su, tutuş iyi.' FROM locations WHERE slug = 'kolympethres-paros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'kolympethres-paros'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ermoupoli Limanı (Syros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ermoupoli-limani-syros', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-syros'),
  'Ermoupoli Limanı (Syros)', 'Kiklad''ın başkenti, neoklasik Ermoupoli''nin ana limanı; VHF 10. Elektrik bağlamaya DAHİL (ücretsiz). Liman reisi yardımseverdir; rehber 30 knot lodosta bile kalındığını, feribot netasının yalpa yaptırabildiğini aktarıyor.',
  ST_SetSRID(ST_MakePoint(24.942389, 37.440528), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ermoupoli Limanı (Syros)', 'Kiklad''ın başkenti, neoklasik Ermoupoli''nin ana limanı; VHF 10. Elektrik bağlamaya DAHİL (ücretsiz). Liman reisi yardımseverdir; rehber 30 knot lodosta bile kalındığını, feribot netasının yalpa yaptırabildiğini aktarıyor.' FROM locations WHERE slug = 'ermoupoli-limani-syros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'ermoupoli-limani-syros' AND a.code IN ('electricity')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306932644072', NULL, true
FROM locations l WHERE l.slug = 'ermoupoli-limani-syros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306951892075', NULL, false
FROM locations l WHERE l.slug = 'ermoupoli-limani-syros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Finikas Marina (Syros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'finikas-marina-syros', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-syros'),
  'Finikas Marina (Syros)', 'Syros''un güneybatısındaki sakin Finikas koyunda marina; su çekimi ~6,5 m. Gündüz su, çağrıyla motorin, akşam 8''e dek duş. Ücret örneği: 45 ft yat için ~20€. Rehber ''gerçekten hoş ve sakin bir nokta'' diyor.',
  ST_SetSRID(ST_MakePoint(24.87625, 37.397306), 4326)::geography,
  NULL, 6.5, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Finikas Marina (Syros)', 'Syros''un güneybatısındaki sakin Finikas koyunda marina; su çekimi ~6,5 m. Gündüz su, çağrıyla motorin, akşam 8''e dek duş. Ücret örneği: 45 ft yat için ~20€. Rehber ''gerçekten hoş ve sakin bir nokta'' diyor.' FROM locations WHERE slug = 'finikas-marina-syros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'finikas-marina-syros'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'finikas-marina-syros' AND a.code IN ('water', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306937147248', NULL, true
FROM locations l WHERE l.slug = 'finikas-marina-syros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Lazaretta Tonozları (Ermoupoli) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lazaretta-tonozlari-syros', 4, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-syros'),
  'Lazaretta Tonozları (Ermoupoli)', 'Ermoupoli koyunun rüzgârüstü yakasındaki Lazaretta''da misafir tonozları; su çekimi ~3 m. Rehber ''rüzgârüstü tarafın en iyi noktası'' diyor; meltemide bir miktar neta girebilir.',
  ST_SetSRID(ST_MakePoint(24.941306, 37.430167), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lazaretta Tonozları (Ermoupoli)', 'Ermoupoli koyunun rüzgârüstü yakasındaki Lazaretta''da misafir tonozları; su çekimi ~3 m. Rehber ''rüzgârüstü tarafın en iyi noktası'' diyor; meltemide bir miktar neta girebilir.' FROM locations WHERE slug = 'lazaretta-tonozlari-syros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+31621266573', NULL, true
FROM locations l WHERE l.slug = 'lazaretta-tonozlari-syros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Galissas Koyu (Syros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'galissas-koyu-syros', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-syros'),
  'Galissas Koyu (Syros)', 'Syros''un batısında kristal berraklıkta koy; kum dip, rehber ''mükemmel tutuş'' diyor.',
  ST_SetSRID(ST_MakePoint(24.875861, 37.421333), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Galissas Koyu (Syros)', 'Syros''un batısında kristal berraklıkta koy; kum dip, rehber ''mükemmel tutuş'' diyor.' FROM locations WHERE slug = 'galissas-koyu-syros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'galissas-koyu-syros'
ON CONFLICT (location_id) DO NOTHING;

-- --- Azolimnos Koyu (Syros) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'azolimnos-koyu-syros', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-syros'),
  'Azolimnos Koyu (Syros)', 'Ermoupoli''nin güneyinde, limanın kalabalığından uzak sessiz koy; kum dipte mükemmel tutuş.',
  ST_SetSRID(ST_MakePoint(24.966028, 37.410528), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Azolimnos Koyu (Syros)', 'Ermoupoli''nin güneyinde, limanın kalabalığından uzak sessiz koy; kum dipte mükemmel tutuş.' FROM locations WHERE slug = 'azolimnos-koyu-syros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'azolimnos-koyu-syros'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ornos Koyu (Mykonos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ornos-koyu-mykonos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-mykonos'),
  'Ornos Koyu (Mykonos)', 'Mykonos''un güneyindeki gözde Ornos koyu; ~14 m, kum/çamur dip — rehber 30 knot üzeri rüzgârda bile tuttuğunu aktarıyor. Kıyıda restoran ve dükkânlara rahat erişim. Tonoz şamandıralarının hemen dışına demirlenir.',
  ST_SetSRID(ST_MakePoint(25.324472, 37.420028), 4326)::geography,
  NULL, NULL, NULL, 14,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ornos Koyu (Mykonos)', 'Mykonos''un güneyindeki gözde Ornos koyu; ~14 m, kum/çamur dip — rehber 30 knot üzeri rüzgârda bile tuttuğunu aktarıyor. Kıyıda restoran ve dükkânlara rahat erişim. Tonoz şamandıralarının hemen dışına demirlenir.' FROM locations WHERE slug = 'ornos-koyu-mykonos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'ornos-koyu-mykonos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Argostoli Marina (Kefalonya) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'argostoli-marina-kefalonya', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kefalonya'),
  'Argostoli Marina (Kefalonya)', 'Kefalonya''nın başkenti Argostoli''nin marinası; su çekimi ~3,5 m. DİKKAT: limana neta girer ve geri yıkama yapar — bol usturmaça ile bağlanın.',
  ST_SetSRID(ST_MakePoint(20.4955, 38.180833), 4326)::geography,
  NULL, 3.5, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Argostoli Marina (Kefalonya)', 'Kefalonya''nın başkenti Argostoli''nin marinası; su çekimi ~3,5 m. DİKKAT: limana neta girer ve geri yıkama yapar — bol usturmaça ile bağlanın.' FROM locations WHERE slug = 'argostoli-marina-kefalonya'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'argostoli-marina-kefalonya'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306944730789', NULL, true
FROM locations l WHERE l.slug = 'argostoli-marina-kefalonya'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Agia Pelagia Marina (Kefalonya) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agia-pelagia-marina-kefalonya', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kefalonya'),
  'Agia Pelagia Marina (Kefalonya)', 'Kefalonya''nın güneyinde küçük marina; su çekimi ~3 m, VHF 73. Gecelik ücret örneği ~20€ (elektrik hariç).',
  ST_SetSRID(ST_MakePoint(20.5145, 38.102), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agia Pelagia Marina (Kefalonya)', 'Kefalonya''nın güneyinde küçük marina; su çekimi ~3 m, VHF 73. Gecelik ücret örneği ~20€ (elektrik hariç).' FROM locations WHERE slug = 'agia-pelagia-marina-kefalonya'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'agia-pelagia-marina-kefalonya'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306980805000', NULL, true
FROM locations l WHERE l.slug = 'agia-pelagia-marina-kefalonya'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Poros Marina (Kefalonya) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'poros-marina-kefalonya', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kefalonya'),
  'Poros Marina (Kefalonya)', 'Kefalonya''nın doğu kıyısında Poros marinası; su çekimi ~2,8 m, VHF 12.',
  ST_SetSRID(ST_MakePoint(20.781167, 38.147167), 4326)::geography,
  NULL, 2.8, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Poros Marina (Kefalonya)', 'Kefalonya''nın doğu kıyısında Poros marinası; su çekimi ~2,8 m, VHF 12.' FROM locations WHERE slug = 'poros-marina-kefalonya'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '12', NULL, NULL, NULL
FROM locations WHERE slug = 'poros-marina-kefalonya'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306982947289', NULL, true
FROM locations l WHERE l.slug = 'poros-marina-kefalonya'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Assos Limanı (Kefalonya) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'assos-limani-kefalonya', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-kefalonya'),
  'Assos Limanı (Kefalonya)', 'Venedik kalesinin eteğindeki kartpostal köyü Assos''un küçük limanı; su çekimi ~3 m.',
  ST_SetSRID(ST_MakePoint(20.538833, 38.378833), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Assos Limanı (Kefalonya)', 'Venedik kalesinin eteğindeki kartpostal köyü Assos''un küçük limanı; su çekimi ~3 m.' FROM locations WHERE slug = 'assos-limani-kefalonya'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- --- Zakynthos Marina · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'zakinthos-marina', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-zakinthos'),
  'Zakynthos Marina', 'Zakynthos kentinin marinası; su çekimi ~7 m — derin tekneler için rahat. Rehber ''olağanüstü misafirperverlik, netadan ve rüzgârdan mükemmel korunma'' diye aktarıyor.',
  ST_SetSRID(ST_MakePoint(20.902194, 37.783944), 4326)::geography,
  NULL, 7, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Zakynthos Marina', 'Zakynthos kentinin marinası; su çekimi ~7 m — derin tekneler için rahat. Rehber ''olağanüstü misafirperverlik, netadan ve rüzgârdan mükemmel korunma'' diye aktarıyor.' FROM locations WHERE slug = 'zakinthos-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'zakinthos-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306993779646', NULL, true
FROM locations l WHERE l.slug = 'zakinthos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302695028117', NULL, false
FROM locations l WHERE l.slug = 'zakinthos-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Agios Nikolaos Limanı (Zakynthos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agios-nikolaos-limani-zakinthos', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-zakinthos'),
  'Agios Nikolaos Limanı (Zakynthos)', 'Zakynthos''un kuzeyinde, Mavi Mağaralar rotasının limanı; su çekimi ~5 m, VHF 72. Kıçtankara, aborda veya TONOZ ŞAMANDIRASI seçenekleri var — şamandırayı önceden ayırtın.',
  ST_SetSRID(ST_MakePoint(20.70675, 37.905972), 4326)::geography,
  NULL, 5, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agios Nikolaos Limanı (Zakynthos)', 'Zakynthos''un kuzeyinde, Mavi Mağaralar rotasının limanı; su çekimi ~5 m, VHF 72. Kıçtankara, aborda veya TONOZ ŞAMANDIRASI seçenekleri var — şamandırayı önceden ayırtın.' FROM locations WHERE slug = 'agios-nikolaos-limani-zakinthos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306947329835', NULL, true
FROM locations l WHERE l.slug = 'agios-nikolaos-limani-zakinthos'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mavi Mağaralar Demirleme (Zakynthos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mavi-magaralar-zakinthos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-zakinthos'),
  'Mavi Mağaralar Demirleme (Zakynthos)', 'Zakynthos''un ünlü Mavi Mağaraları önünde kısa mola demirlemesi; 8-15 m, kum/deniz çayırı. DİKKAT: tutuş ZAYIF — yalnız sakin havada, teknede gözcü bırakarak durun.',
  ST_SetSRID(ST_MakePoint(20.705472, 37.930083), 4326)::geography,
  NULL, NULL, 8, 15,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mavi Mağaralar Demirleme (Zakynthos)', 'Zakynthos''un ünlü Mavi Mağaraları önünde kısa mola demirlemesi; 8-15 m, kum/deniz çayırı. DİKKAT: tutuş ZAYIF — yalnız sakin havada, teknede gözcü bırakarak durun.' FROM locations WHERE slug = 'mavi-magaralar-zakinthos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'mavi-magaralar-zakinthos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Filippoi Plajı (Zakynthos) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'filippoi-plaji-zakinthos', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-zakinthos'),
  'Filippoi Plajı (Zakynthos)', 'Zakynthos''un kuzeybatı kıyısında sakin plaj demirlemesi; kum/deniz çayırı dip, tutuş iyi.',
  ST_SetSRID(ST_MakePoint(20.652472, 37.901556), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Filippoi Plajı (Zakynthos)', 'Zakynthos''un kuzeybatı kıyısında sakin plaj demirlemesi; kum/deniz çayırı dip, tutuş iyi.' FROM locations WHERE slug = 'filippoi-plaji-zakinthos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'filippoi-plaji-zakinthos'
ON CONFLICT (location_id) DO NOTHING;

-- --- Gouvia Marina Yakıt İstasyonu (Korfu) · güven: high · kaynak: www.d-marin.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gouvia-yakit-iskelesi', 6, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-korfu'),
  'Gouvia Marina Yakıt İstasyonu (Korfu)', 'Korfu Gouvia Marina içinde sabit yakıt istasyonu (D-Marin resmî tesis listesinde). Marina VHF 69''dan yardım alınır.',
  ST_SetSRID(ST_MakePoint(19.8525, 39.648611), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gouvia Marina Yakıt İstasyonu (Korfu)', 'Korfu Gouvia Marina içinde sabit yakıt istasyonu (D-Marin resmî tesis listesinde). Marina VHF 69''dan yardım alınır.' FROM locations WHERE slug = 'gouvia-yakit-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'gouvia-yakit-iskelesi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gouvia-yakit-iskelesi' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.d-marin.com/en/marinas/gouvia/', NULL, false
FROM locations l WHERE l.slug = 'gouvia-yakit-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Lefkas Marina Yakıt İstasyonu · güven: medium · kaynak: www.revolutionfuel.com, greek-marinas.gr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lefkas-yakit-iskelesi', 6, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-lefkada'),
  'Lefkas Marina Yakıt İstasyonu', 'Lefkas Marina içinde sabit yakıt istasyonu — deniz motorini ve gaz yağı; boru hattı/duba/tanker ikmal seçenekleri. İyon''un ana ikmal noktalarından.',
  ST_SetSRID(ST_MakePoint(20.7133, 38.83), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lefkas Marina Yakıt İstasyonu', 'Lefkas Marina içinde sabit yakıt istasyonu — deniz motorini ve gaz yağı; boru hattı/duba/tanker ikmal seçenekleri. İyon''un ana ikmal noktalarından.' FROM locations WHERE slug = 'lefkas-yakit-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'lefkas-yakit-iskelesi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'lefkas-yakit-iskelesi' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Kandiye (Heraklion) Limanı · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kandiye-limani-girit', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Kandiye (Heraklion) Limanı', 'Girit''in başkenti Kandiye''nin (Heraklion) kamu limanı; Venedik kalesi Koules''in gölgesinde. VHF 16/12, su çekimi ~3 m; 2-3 gecelik konaklamalara uygun. Ücret örneği: 2 gece ~14€. Knossos''a en yakın liman.',
  ST_SetSRID(ST_MakePoint(25.138194, 35.343361), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kandiye (Heraklion) Limanı', 'Girit''in başkenti Kandiye''nin (Heraklion) kamu limanı; Venedik kalesi Koules''in gölgesinde. VHF 16/12, su çekimi ~3 m; 2-3 gecelik konaklamalara uygun. Ücret örneği: 2 gece ~14€. Knossos''a en yakın liman.' FROM locations WHERE slug = 'kandiye-limani-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302810338000', NULL, true
FROM locations l WHERE l.slug = 'kandiye-limani-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302810338141', NULL, false
FROM locations l WHERE l.slug = 'kandiye-limani-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Gouves Limanı (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gouves-limani-girit', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Gouves Limanı (Girit)', 'Kandiye''nin doğusunda küçük Gouves limanı; su çekimi ~3 m. DİKKAT: misafir tekneler için tasarlanmamıştır — yer sınırlıdır, önceden telefonla sorun.',
  ST_SetSRID(ST_MakePoint(25.300306, 35.335667), 4326)::geography,
  NULL, 3, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gouves Limanı (Girit)', 'Kandiye''nin doğusunda küçük Gouves limanı; su çekimi ~3 m. DİKKAT: misafir tekneler için tasarlanmamıştır — yer sınırlıdır, önceden telefonla sorun.' FROM locations WHERE slug = 'gouves-limani-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302897041112', NULL, true
FROM locations l WHERE l.slug = 'gouves-limani-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Hersonissos Limanı (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'hersonissos-limani-girit', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Hersonissos Limanı (Girit)', 'Turistik Hersonissos''un limanı. CİDDİ UYARI: aşırı sığ (~1,6 m, yer yer sıfır okumaları) ve girişte kaya engelleri var — yalnız çok sığ su çeken tekneler, dikkatli seyirle.',
  ST_SetSRID(ST_MakePoint(25.393083, 35.321944), 4326)::geography,
  NULL, 1.6, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Hersonissos Limanı (Girit)', 'Turistik Hersonissos''un limanı. CİDDİ UYARI: aşırı sığ (~1,6 m, yer yer sıfır okumaları) ve girişte kaya engelleri var — yalnız çok sığ su çeken tekneler, dikkatli seyirle.' FROM locations WHERE slug = 'hersonissos-limani-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302897028700', NULL, true
FROM locations l WHERE l.slug = 'hersonissos-limani-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Alimos Marina Yakıt İstasyonu (Shell, Atina) · güven: medium · kaynak: my-sea.com, greek-marinas.gr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'alimos-yakit-iskelesi', 6, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-atina'),
  'Alimos Marina Yakıt İstasyonu (Shell, Atina)', 'Yunanistan''ın en büyük yat üssü Alimos (Kalamaki) Marina''da Shell yakıt istasyonu. Atina''dan çıkan kiralık filoların ana ikmal noktası.',
  ST_SetSRID(ST_MakePoint(23.7005, 37.9113), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Alimos Marina Yakıt İstasyonu (Shell, Atina)', 'Yunanistan''ın en büyük yat üssü Alimos (Kalamaki) Marina''da Shell yakıt istasyonu. Atina''dan çıkan kiralık filoların ana ikmal noktası.' FROM locations WHERE slug = 'alimos-yakit-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO fuel_dock_details (location_id, has_diesel, has_gasoline, has_adblue, min_depth_m, payment_note)
SELECT id, NULL, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'alimos-yakit-iskelesi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'alimos-yakit-iskelesi' AND a.code IN ('fuel')
ON CONFLICT DO NOTHING;

-- --- Agios Nikolaos Marina (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agios-nikolaos-marina-girit', 1, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Agios Nikolaos Marina (Girit)', 'Doğu Girit''in Mirabello körfezindeki Agios Nikolaos marinası; VHF 72, su çekimi ~8 m — derin tekneler için rahat. Rehber ''Yunanistan''da gerçek bir mücevher, personeli harika'' diye aktarıyor.',
  ST_SetSRID(ST_MakePoint(25.718444, 35.186056), 4326)::geography,
  NULL, 8, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agios Nikolaos Marina (Girit)', 'Doğu Girit''in Mirabello körfezindeki Agios Nikolaos marinası; VHF 72, su çekimi ~8 m — derin tekneler için rahat. Rehber ''Yunanistan''da gerçek bir mücevher, personeli harika'' diye aktarıyor.' FROM locations WHERE slug = 'agios-nikolaos-marina-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '72', NULL, NULL, NULL
FROM locations WHERE slug = 'agios-nikolaos-marina-girit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302841082384', NULL, true
FROM locations l WHERE l.slug = 'agios-nikolaos-marina-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Sitia Marina (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sitia-marina-girit', 2, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Sitia Marina (Girit)', 'Girit''in kuzeydoğu ucundaki Sitia limanı; VHF 12, rıhtımda elektrik ve su, restoranlar yakın. ÖNEMLİ: yer için varıştan bir gün önce liman kaptanını arayın (ikinci telefon).',
  ST_SetSRID(ST_MakePoint(26.108667, 35.207444), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sitia Marina (Girit)', 'Girit''in kuzeydoğu ucundaki Sitia limanı; VHF 12, rıhtımda elektrik ve su, restoranlar yakın. ÖNEMLİ: yer için varıştan bir gün önce liman kaptanını arayın (ikinci telefon).' FROM locations WHERE slug = 'sitia-marina-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '12', NULL, NULL, NULL
FROM locations WHERE slug = 'sitia-marina-girit'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'sitia-marina-girit' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302843022310', NULL, true
FROM locations l WHERE l.slug = 'sitia-marina-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+306984614513', NULL, false
FROM locations l WHERE l.slug = 'sitia-marina-girit'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Agiou Panteleimonos Koyu (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agiou-panteleimonos-girit', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Agiou Panteleimonos Koyu (Girit)', 'Agios Nikolaos''un güneyinde iyi korunaklı, ferah demirleme; 5 m kuma 20 m kaloma ile.',
  ST_SetSRID(ST_MakePoint(25.73425, 35.128111), 4326)::geography,
  NULL, NULL, NULL, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agiou Panteleimonos Koyu (Girit)', 'Agios Nikolaos''un güneyinde iyi korunaklı, ferah demirleme; 5 m kuma 20 m kaloma ile.' FROM locations WHERE slug = 'agiou-panteleimonos-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'agiou-panteleimonos-girit'
ON CONFLICT (location_id) DO NOTHING;

-- --- Vai Plajı (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'vai-plaji-girit', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Vai Plajı (Girit)', 'Girit''in kuzeydoğusundaki ünlü Vai plajı önünde demirleme; kum dipte mükemmel tutuş, kristal berraklıkta su.',
  ST_SetSRID(ST_MakePoint(26.266333, 35.25475), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Vai Plajı (Girit)', 'Girit''in kuzeydoğusundaki ünlü Vai plajı önünde demirleme; kum dipte mükemmel tutuş, kristal berraklıkta su.' FROM locations WHERE slug = 'vai-plaji-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'vai-plaji-girit'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kato Zakros (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kato-zakros-girit', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Kato Zakros (Girit)', 'Minos sarayının koyunda demirleme; 7 m kum — plaja yaklaştıkça kayalar var, açıkta kalın. Şnorkel için mükemmel.',
  ST_SetSRID(ST_MakePoint(26.265722, 35.097278), 4326)::geography,
  NULL, NULL, NULL, 7,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kato Zakros (Girit)', 'Minos sarayının koyunda demirleme; 7 m kum — plaja yaklaştıkça kayalar var, açıkta kalın. Şnorkel için mükemmel.' FROM locations WHERE slug = 'kato-zakros-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'kato-zakros-girit'
ON CONFLICT (location_id) DO NOTHING;

-- --- Black Kavos Koyu (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'black-kavos-girit', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Black Kavos Koyu (Girit)', 'Sitia''nın doğusunda korunaklı küçük koy; ~6 m''ye 20 m kaloma, tutuş iyi. Salınım alanı DAR — kıyıya halat almanız önerilir.',
  ST_SetSRID(ST_MakePoint(26.254972, 35.272917), 4326)::geography,
  NULL, NULL, NULL, 6,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Black Kavos Koyu (Girit)', 'Sitia''nın doğusunda korunaklı küçük koy; ~6 m''ye 20 m kaloma, tutuş iyi. Salınım alanı DAR — kıyıya halat almanız önerilir.' FROM locations WHERE slug = 'black-kavos-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'black-kavos-girit'
ON CONFLICT (location_id) DO NOTHING;

-- --- Analoukas Koyu (Girit) · güven: medium · kaynak: grecosailor.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'analoukas-koyu-girit', 8, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-girit'),
  'Analoukas Koyu (Girit)', 'Sitia''nın doğusunda kumluk koy; özellikle doğu-güneydoğu rüzgârlarından mükemmel korunma.',
  ST_SetSRID(ST_MakePoint(26.184417, 35.213917), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Analoukas Koyu (Girit)', 'Sitia''nın doğusunda kumluk koy; özellikle doğu-güneydoğu rüzgârlarından mükemmel korunma.' FROM locations WHERE slug = 'analoukas-koyu-girit'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'analoukas-koyu-girit'
ON CONFLICT (location_id) DO NOTHING;

-- --- Gümüşlük Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gumusluk-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Gümüşlük Koyu', 'Antik Myndos''un koyu; Bodrum yarımadasının batı ucu. Ortada 15-16 m, kıyıya ve koy başına doğru 5-10 m; yosun tabakasını geçince tutuş iyidir. Batı ve kuzeybatıya korunaklı; kuvvetli kuzey rüzgârı soluğan sokar. Arkeolojik sit — kıyı yapılaşması sıkı denetimlidir. Tavşan Adası''na antik yol üzerinden yürünür.',
  ST_SetSRID(ST_MakePoint(27.232513, 37.053706), 4326)::geography,
  NULL, NULL, 5, 16,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gümüşlük Koyu', 'Antik Myndos''un koyu; Bodrum yarımadasının batı ucu. Ortada 15-16 m, kıyıya ve koy başına doğru 5-10 m; yosun tabakasını geçince tutuş iyidir. Batı ve kuzeybatıya korunaklı; kuvvetli kuzey rüzgârı soluğan sokar. Arkeolojik sit — kıyı yapılaşması sıkı denetimlidir. Tavşan Adası''na antik yol üzerinden yürünür.' FROM locations WHERE slug = 'gumusluk-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'gumusluk-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Gümüşlük İskeleleri · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gumusluk-iskeleleri', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Gümüşlük İskeleleri', 'Koyun doğu kıyısındaki ahşap iskeleler; kıç ya da baş tarafından yanaşılır. Yaklaşık 8 tekne alır; su ve elektrik bağlantısı vardır. Kaynak, gece bağlama ücretinin yüksek tutulduğunu belirtir. Kıyıda balık restoranları sıralıdır.',
  ST_SetSRID(ST_MakePoint(27.235087, 37.054465), 4326)::geography,
  NULL, NULL, NULL, NULL,
  8, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gümüşlük İskeleleri', 'Koyun doğu kıyısındaki ahşap iskeleler; kıç ya da baş tarafından yanaşılır. Yaklaşık 8 tekne alır; su ve elektrik bağlantısı vardır. Kaynak, gece bağlama ücretinin yüksek tutulduğunu belirtir. Kıyıda balık restoranları sıralıdır.' FROM locations WHERE slug = 'gumusluk-iskeleleri'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gumusluk-iskeleleri' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;

-- --- Yalıkavak Balıkçı Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yalikavak-balikci-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Yalıkavak Balıkçı Limanı', 'Yalıkavak Marina''nın yanındaki kooperatif limanı; 65 tekne kapasitesi. Su, elektrik ve sintine alım hizmeti vardır; Sahil Güvenlik istasyonu ve gümrük bulunur. Liman ağzı batıya bakar; dağlardan inen kuvvetli meltem kısa boğuk dalga yapabilir. Dikkat: Karataş kayalıkları kıyıdan ~650 m açıktadır; dip yosunlu — demiri iyi kontrol edin.',
  ST_SetSRID(ST_MakePoint(27.292441, 37.108083), 4326)::geography,
  NULL, NULL, NULL, NULL,
  65, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yalıkavak Balıkçı Limanı', 'Yalıkavak Marina''nın yanındaki kooperatif limanı; 65 tekne kapasitesi. Su, elektrik ve sintine alım hizmeti vardır; Sahil Güvenlik istasyonu ve gümrük bulunur. Liman ağzı batıya bakar; dağlardan inen kuvvetli meltem kısa boğuk dalga yapabilir. Dikkat: Karataş kayalıkları kıyıdan ~650 m açıktadır; dip yosunlu — demiri iyi kontrol edin.' FROM locations WHERE slug = 'yalikavak-balikci-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yalikavak-balikci-limani' AND a.code IN ('electricity', 'water', 'pump_out')
ON CONFLICT DO NOTHING;

-- --- Turgutreis Balıkçı Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'turgutreis-balikci-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Turgutreis Balıkçı Limanı', 'D-Marin Turgutreis''in hemen yanındaki kooperatif limanı; 85 tekne. Rıhtımda su derinliği yaklaşık 3 m. Su ve elektrik bağlanır; sintine alımı, buz ve tüp gaz satışı vardır; Sahil Güvenlik istasyonu bulunur. Kuzey kıyıları sığ ve rüzgârlıdır; yaklaşma güneyden daha rahattır.',
  ST_SetSRID(ST_MakePoint(27.25575, 37.005222), 4326)::geography,
  NULL, NULL, 3, 3,
  85, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Turgutreis Balıkçı Limanı', 'D-Marin Turgutreis''in hemen yanındaki kooperatif limanı; 85 tekne. Rıhtımda su derinliği yaklaşık 3 m. Su ve elektrik bağlanır; sintine alımı, buz ve tüp gaz satışı vardır; Sahil Güvenlik istasyonu bulunur. Kuzey kıyıları sığ ve rüzgârlıdır; yaklaşma güneyden daha rahattır.' FROM locations WHERE slug = 'turgutreis-balikci-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'turgutreis-balikci-limani' AND a.code IN ('electricity', 'water', 'pump_out')
ON CONFLICT DO NOTHING;

-- --- Aspat Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'aspat-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Aspat Koyu', 'Akyarlar yakınında, tepesinde kale kalıntısı olan koy. 7 m''ye demirlenir; tutuş makuldür. Kuzeybatı rüzgârlarına kapalıdır. Kıyıda restoranlar vardır; tatlı su temin edilebilir. Yoğunluk (kaynaklı): gündüz Bodrum''dan çok sayıda günübirlik tekne gelir, akşam saatlerinde ayrılırlar — gece daha sakindir; akşamları kıyı tesislerinden müzik duyulabilir.',
  ST_SetSRID(ST_MakePoint(27.312312, 36.977533), 4326)::geography,
  NULL, NULL, 7, 7,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Aspat Koyu', 'Akyarlar yakınında, tepesinde kale kalıntısı olan koy. 7 m''ye demirlenir; tutuş makuldür. Kuzeybatı rüzgârlarına kapalıdır. Kıyıda restoranlar vardır; tatlı su temin edilebilir. Yoğunluk (kaynaklı): gündüz Bodrum''dan çok sayıda günübirlik tekne gelir, akşam saatlerinde ayrılırlar — gece daha sakindir; akşamları kıyı tesislerinden müzik duyulabilir.' FROM locations WHERE slug = 'aspat-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'aspat-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kadıkalesi Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kadikalesi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Kadıkalesi Koyu', 'Turgutreis''in 4 km kuzeyinde, Gümüşlük ile arasında kumsal önü demirleme. Kıyıda ahşap iskeleler ve balık restoranları vardır; Helenistik kale ve Bizans kilisesi kalıntıları koyun simgesidir. Sabah saatleri sakindir; öğleden sonra batı-kuzeybatı rüzgârı belirgin şekilde artar.',
  ST_SetSRID(ST_MakePoint(27.247231, 37.032124), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kadıkalesi Koyu', 'Turgutreis''in 4 km kuzeyinde, Gümüşlük ile arasında kumsal önü demirleme. Kıyıda ahşap iskeleler ve balık restoranları vardır; Helenistik kale ve Bizans kilisesi kalıntıları koyun simgesidir. Sabah saatleri sakindir; öğleden sonra batı-kuzeybatı rüzgârı belirgin şekilde artar.' FROM locations WHERE slug = 'kadikalesi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'kadikalesi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Çatal Adası · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'catal-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Çatal Adası', 'Turgutreis''in ~1,5 mil açığındaki fenerli ada. Tepeler arasındaki plaj tarafında 4-6 m''ye, kum-yosun zemine demirlenir; güney taraf daha korunaklıdır. Kuvvetli meltemde plaj tarafına soluğan girer; bölgede akıntı belirgindir. DİKKAT: kuzey tarafta işaretsiz kayalıklar ve sığlıklar, çevre adacıklarda (Çobanada, Tüllüceada, Sarıot) resifler vardır — gece seyri önerilmez.',
  ST_SetSRID(ST_MakePoint(27.215833, 36.998556), 4326)::geography,
  NULL, NULL, 4, 6,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çatal Adası', 'Turgutreis''in ~1,5 mil açığındaki fenerli ada. Tepeler arasındaki plaj tarafında 4-6 m''ye, kum-yosun zemine demirlenir; güney taraf daha korunaklıdır. Kuvvetli meltemde plaj tarafına soluğan girer; bölgede akıntı belirgindir. DİKKAT: kuzey tarafta işaretsiz kayalıklar ve sığlıklar, çevre adacıklarda (Çobanada, Tüllüceada, Sarıot) resifler vardır — gece seyri önerilmez.' FROM locations WHERE slug = 'catal-adasi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'catal-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Göltürkbükü Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'golturkbuku-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Göltürkbükü Balıkçı Barınağı', 'Türkbükü koyunun kooperatif barınağı; 55 tekne, 143 m ana mendirek. Mendirek tarafında 3-4 m derinlik; kıyı tarafı sığdır. Su, elektrik ve TANKERLE yakıt ikmali vardır; çekek yeri bulunur. Koyun doğusunda sakin havada 6-10 m''ye demirlenir; ortada 12-18 m ve yosunlu dip. Çevre tepeler ve adalar öğleden sonra meltemine ve kuzeydoğu rüzgârına karşı korur. DİKKAT: adalar ile anakara arasında şamandıralı balık çiftlikleri vardır.',
  ST_SetSRID(ST_MakePoint(27.379083, 37.128611), 4326)::geography,
  NULL, NULL, 3, 4,
  55, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Göltürkbükü Balıkçı Barınağı', 'Türkbükü koyunun kooperatif barınağı; 55 tekne, 143 m ana mendirek. Mendirek tarafında 3-4 m derinlik; kıyı tarafı sığdır. Su, elektrik ve TANKERLE yakıt ikmali vardır; çekek yeri bulunur. Koyun doğusunda sakin havada 6-10 m''ye demirlenir; ortada 12-18 m ve yosunlu dip. Çevre tepeler ve adalar öğleden sonra meltemine ve kuzeydoğu rüzgârına karşı korur. DİKKAT: adalar ile anakara arasında şamandıralı balık çiftlikleri vardır.' FROM locations WHERE slug = 'golturkbuku-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'golturkbuku-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;

-- --- Torba Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'torba-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Torba Balıkçı Barınağı', 'Bodrum merkezinin 5 km kuzeydoğusundaki korunaklı koyda kooperatif barınağı; 85 tekne. Dış mendireğe kıçtan 6-10 m''ye yanaşılır; koyda 5-10 m kumlu zemine demirlenir. Su, elektrik, sintine alımı ve tankerle yakıt ikmali vardır. Tepelerden inen meltem koyda rahatsız edici soluğan yapabilir.',
  ST_SetSRID(ST_MakePoint(27.455222, 37.087167), 4326)::geography,
  NULL, NULL, 5, 10,
  85, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Torba Balıkçı Barınağı', 'Bodrum merkezinin 5 km kuzeydoğusundaki korunaklı koyda kooperatif barınağı; 85 tekne. Dış mendireğe kıçtan 6-10 m''ye yanaşılır; koyda 5-10 m kumlu zemine demirlenir. Su, elektrik, sintine alımı ve tankerle yakıt ikmali vardır. Tepelerden inen meltem koyda rahatsız edici soluğan yapabilir.' FROM locations WHERE slug = 'torba-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'torba-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel', 'pump_out')
ON CONFLICT DO NOTHING;

-- --- Salih Adası · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'salih-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Salih Adası', 'Bodrum''un kuzeyinde, çam ve zeytin örtülü büyük ada. Birden fazla demirleme olanağı vardır; barınma iyidir. Ziyaretçi tekneler için en iyi nokta, kaynağa göre güneydoğudaki ''beyaz evli'' koydur — yüzme için de uygundur. Güney girintide yazlıklar bulunur.',
  ST_SetSRID(ST_MakePoint(27.534194, 37.160454), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Salih Adası', 'Bodrum''un kuzeyinde, çam ve zeytin örtülü büyük ada. Birden fazla demirleme olanağı vardır; barınma iyidir. Ziyaretçi tekneler için en iyi nokta, kaynağa göre güneydoğudaki ''beyaz evli'' koydur — yüzme için de uygundur. Güney girintide yazlıklar bulunur.' FROM locations WHERE slug = 'salih-adasi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'salih-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Güllük Limanı · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gulluk-marina', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Güllük Limanı', 'Güllük Körfezi''nin doğu yakasında belediye/kooperatif limanı; Milas-Bodrum Havalimanı''na 8 km. VHF 16''dan ''Güllük Marina'' çağrılır. Dönüş alanında 7-8 m, kum-çamur zeminde iyi tutuş; demir sahası ~20 m. Su, elektrik, sintine alımı ve tankerle yakıt vardır. Kaynağa (2016) göre gümrüklü giriş-çıkış limanıdır.',
  ST_SetSRID(ST_MakePoint(27.594036, 37.239943), 4326)::geography,
  NULL, NULL, 7, 8,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Güllük Limanı', 'Güllük Körfezi''nin doğu yakasında belediye/kooperatif limanı; Milas-Bodrum Havalimanı''na 8 km. VHF 16''dan ''Güllük Marina'' çağrılır. Dönüş alanında 7-8 m, kum-çamur zeminde iyi tutuş; demir sahası ~20 m. Su, elektrik, sintine alımı ve tankerle yakıt vardır. Kaynağa (2016) göre gümrüklü giriş-çıkış limanıdır.' FROM locations WHERE slug = 'gulluk-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '16', NULL, NULL, NULL
FROM locations WHERE slug = 'gulluk-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gulluk-marina' AND a.code IN ('electricity', 'water', 'fuel', 'pump_out')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902525121416', NULL, true
FROM locations l WHERE l.slug = 'gulluk-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Ovabükü (Mesudiye) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ovabuku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-datca'),
  'Ovabükü (Mesudiye)', 'Datça yarımadasının güney yüzünde, Mesudiye köyünün koyu; Palamutbükü''ne 5 km. Koyun batı yakasında 4-5 m''ye demirlenir. Kıyıda balık restoranları, fırın ve pansiyonlar; köyde PTT, sağlık ocağı ve çamaşırhane vardır. Yeşil yamaçlarla çevrili küçük ve korunaklı bir koydur.',
  ST_SetSRID(ST_MakePoint(27.555556, 36.678389), 4326)::geography,
  NULL, NULL, 4, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ovabükü (Mesudiye)', 'Datça yarımadasının güney yüzünde, Mesudiye köyünün koyu; Palamutbükü''ne 5 km. Koyun batı yakasında 4-5 m''ye demirlenir. Kıyıda balık restoranları, fırın ve pansiyonlar; köyde PTT, sağlık ocağı ve çamaşırhane vardır. Yeşil yamaçlarla çevrili küçük ve korunaklı bir koydur.' FROM locations WHERE slug = 'ovabuku-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'ovabuku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Karacasöğüt Halk İskelesi · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'karacasogut-halk-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Karacasöğüt Halk İskelesi', 'Gökova''nın güneydoğu köşesinde, ~800 m çapındaki yuvarlak koyun ortasındaki T-iskele. Kıçtan yanaşılır ya da demirleyip karaya halat verilir; koy ortasına doğru derinlik hızla artar. Su, elektrik, duş/WC, çamaşırhane, market ve restoran vardır. Barınma iyidir; ara ara kısa sağanak rüzgâr (gust) iner. Kaynağa göre küçük marina düzeni kurulduğundan kışlama için de kullanılır.',
  ST_SetSRID(ST_MakePoint(28.187965, 36.942128), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Karacasöğüt Halk İskelesi', 'Gökova''nın güneydoğu köşesinde, ~800 m çapındaki yuvarlak koyun ortasındaki T-iskele. Kıçtan yanaşılır ya da demirleyip karaya halat verilir; koy ortasına doğru derinlik hızla artar. Su, elektrik, duş/WC, çamaşırhane, market ve restoran vardır. Barınma iyidir; ara ara kısa sağanak rüzgâr (gust) iner. Kaynağa göre küçük marina düzeni kurulduğundan kışlama için de kullanılır.' FROM locations WHERE slug = 'karacasogut-halk-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'karacasogut-halk-iskelesi' AND a.code IN ('electricity', 'water', 'shower', 'wc', 'laundry', 'market', 'restaurant')
ON CONFLICT DO NOTHING;

-- --- Akyaka Balıkçı Barınağı · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'akyaka-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-ula'),
  'Akyaka Balıkçı Barınağı', 'Gökova Körfezi''nin en iç ucunda, Akyaka''nın kooperatif barınağı; 170 tekne kapasitesi. Hemen yanından Azmak deresi denize kavuşur — derin akarsu boyunca tekneler bir süre içeri girebilir; dere boyu restoranlar sıralıdır. Sardunya renkli Ula evleri ve ince kumlu halk plajıyla ünlü bir duraktır.',
  ST_SetSRID(ST_MakePoint(28.324694, 37.048889), 4326)::geography,
  NULL, NULL, NULL, NULL,
  170, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Akyaka Balıkçı Barınağı', 'Gökova Körfezi''nin en iç ucunda, Akyaka''nın kooperatif barınağı; 170 tekne kapasitesi. Hemen yanından Azmak deresi denize kavuşur — derin akarsu boyunca tekneler bir süre içeri girebilir; dere boyu restoranlar sıralıdır. Sardunya renkli Ula evleri ve ince kumlu halk plajıyla ünlü bir duraktır.' FROM locations WHERE slug = 'akyaka-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- --- Bördübet Koyu · güven: medium · kaynak: sail-friend.club ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bordubet-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Bördübet Koyu', 'Gökova''nın güney kıyısında, yoğun çam ormanıyla çevrili sakin koy; içine küçük bir dere dökülür. Marmaris''e 27 km, Datça''ya 55 km. Yakındaki Ada plajında duş, WC ve kabin hizmetleri vardır; orman içinde yürüyüş patikaları bulunur.',
  ST_SetSRID(ST_MakePoint(28.060926, 36.823393), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bördübet Koyu', 'Gökova''nın güney kıyısında, yoğun çam ormanıyla çevrili sakin koy; içine küçük bir dere dökülür. Marmaris''e 27 km, Datça''ya 55 km. Yakındaki Ada plajında duş, WC ve kabin hizmetleri vardır; orman içinde yürüyüş patikaları bulunur.' FROM locations WHERE slug = 'bordubet-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'bordubet-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kızılkuyruk Koyu · güven: high · kaynak: sail-friend.club ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kizilkuyruk-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'province' AND slug = 'mugla'),
  'Kızılkuyruk Koyu', 'Fethiye Körfezi''nin batı yakasında, Kapıdağı yarımadasının doğusunda, İnce Burun''un ~1 mil kuzeyinde. Ana bölümde 8-12 m''ye (kuzey kolda 10-15 m) demirlenir; kum-yosun zeminde tutuş iyidir — karaya halat verin. Hâkim rüzgârlara hayli korunaklı; güneydoğu ve doğu açıktır. Yoğunluk (kaynaklı): sık gulet uğrağı, sezonda kalabalık olur. ~30 dk yürüyüşle Lydae antik kenti.',
  ST_SetSRID(ST_MakePoint(28.871667, 36.618333), 4326)::geography,
  NULL, NULL, 8, 15,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kızılkuyruk Koyu', 'Fethiye Körfezi''nin batı yakasında, Kapıdağı yarımadasının doğusunda, İnce Burun''un ~1 mil kuzeyinde. Ana bölümde 8-12 m''ye (kuzey kolda 10-15 m) demirlenir; kum-yosun zeminde tutuş iyidir — karaya halat verin. Hâkim rüzgârlara hayli korunaklı; güneydoğu ve doğu açıktır. Yoğunluk (kaynaklı): sık gulet uğrağı, sezonda kalabalık olur. ~30 dk yürüyüşle Lydae antik kenti.' FROM locations WHERE slug = 'kizilkuyruk-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'kizilkuyruk-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Gemiler Adası · güven: high · kaynak: sail-friend.club ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gemiler-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Gemiler Adası', 'Ölüdeniz''in 3 mil batısında, Bizans kalıntılarıyla kaplı ada. Kuzey yakadaki hilal koyda 15-20 m''ye demirlenip karaya halat verilir; zemin yosun-kum-kaya karışımıdır — demiri kolay almak için şamandıralı irtifa halatı (trip line) önerilir. Yerleşik havada güzel bir duraktır. DİKKAT: kıyıdan 15-20 m açığa kadar su altında antik kalıntılar uzanır.',
  ST_SetSRID(ST_MakePoint(29.06849, 36.555177), 4326)::geography,
  NULL, NULL, 15, 20,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gemiler Adası', 'Ölüdeniz''in 3 mil batısında, Bizans kalıntılarıyla kaplı ada. Kuzey yakadaki hilal koyda 15-20 m''ye demirlenip karaya halat verilir; zemin yosun-kum-kaya karışımıdır — demiri kolay almak için şamandıralı irtifa halatı (trip line) önerilir. Yerleşik havada güzel bir duraktır. DİKKAT: kıyıdan 15-20 m açığa kadar su altında antik kalıntılar uzanır.' FROM locations WHERE slug = 'gemiler-adasi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'gemiler-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kuzbükü · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kuzbuku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Kuzbükü', 'Hisarönü Körfezi''nde, Koca Ada''nın güneyinde ıssız ve geniş koy. İki burun arasındaki girinti batı rüzgârlarına nispi koruma sağlar. 7-12 m''ye demirlenip karaya halat verilir. Germe köyü 1 mil güneydoğudadır; Bozburun''a 2,5 km yol bağlantısı vardır.',
  ST_SetSRID(ST_MakePoint(28.026732, 36.707273), 4326)::geography,
  NULL, NULL, 7, 12,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kuzbükü', 'Hisarönü Körfezi''nde, Koca Ada''nın güneyinde ıssız ve geniş koy. İki burun arasındaki girinti batı rüzgârlarına nispi koruma sağlar. 7-12 m''ye demirlenip karaya halat verilir. Germe köyü 1 mil güneydoğudadır; Bozburun''a 2,5 km yol bağlantısı vardır.' FROM locations WHERE slug = 'kuzbuku-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'kuzbuku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Girneyit Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'girneyit-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Girneyit Koyu', 'Hisarönü''nde, Kargı Adası''nın güneyindeki güneybatıya bakan ıssız koy. Sakin havada, düz vadinin önünde kıyıya yakın demirlenir. UYARI (kaynaklı): motoryat trafiği ve soluğan nedeniyle GECE DEMİRLEMESİ ÖNERİLMEZ — günlük mola için uygundur.',
  ST_SetSRID(ST_MakePoint(27.993406, 36.699401), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Girneyit Koyu', 'Hisarönü''nde, Kargı Adası''nın güneyindeki güneybatıya bakan ıssız koy. Sakin havada, düz vadinin önünde kıyıya yakın demirlenir. UYARI (kaynaklı): motoryat trafiği ve soluğan nedeniyle GECE DEMİRLEMESİ ÖNERİLMEZ — günlük mola için uygundur.' FROM locations WHERE slug = 'girneyit-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'girneyit-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ilıca Koyu (Sığacık) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ilica-koyu-sigacik', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Ilıca Koyu (Sığacık)', 'Sığacık Körfezi''nin kuzeyinde, kuzeye girintili ve kumlu plajda biten dar koy. 4-5 m''ye demirlenir; girinti dar olduğundan kayaya halat verilebilir; doğu yakasında az sayıda tekneye yer vardır. Dağlardan denize kuvvetli rüzgâr inebilir.',
  ST_SetSRID(ST_MakePoint(26.640787, 38.201968), 4326)::geography,
  NULL, NULL, 4, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ilıca Koyu (Sığacık)', 'Sığacık Körfezi''nin kuzeyinde, kuzeye girintili ve kumlu plajda biten dar koy. 4-5 m''ye demirlenir; girinti dar olduğundan kayaya halat verilebilir; doğu yakasında az sayıda tekneye yer vardır. Dağlardan denize kuvvetli rüzgâr inebilir.' FROM locations WHERE slug = 'ilica-koyu-sigacik'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'ilica-koyu-sigacik'
ON CONFLICT (location_id) DO NOTHING;

-- --- Papaz Boğazı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'papaz-bogazi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Papaz Boğazı', 'Sığacık Körfezi''nin kuzeybatısındaki güzel koy; güneyli rüzgârlar dışında güvenli barınak. 8-10 m derinlik; doğu ucundaki girintide yalnız 2-3 tekneye yer vardır. Kıyı açığındaki mineral su kaynağı ve çamuru ile bilinir.',
  ST_SetSRID(ST_MakePoint(26.653834, 38.207129), 4326)::geography,
  NULL, NULL, 8, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Papaz Boğazı', 'Sığacık Körfezi''nin kuzeybatısındaki güzel koy; güneyli rüzgârlar dışında güvenli barınak. 8-10 m derinlik; doğu ucundaki girintide yalnız 2-3 tekneye yer vardır. Kıyı açığındaki mineral su kaynağı ve çamuru ile bilinir.' FROM locations WHERE slug = 'papaz-bogazi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'papaz-bogazi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Taş Ada Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tas-ada-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Taş Ada Koyu', 'Sığacık Körfezi''nin kuzeyinde; adını girişin ortasındaki kayadan alır. Koya bu kayanın BATISINDAN girilir — kayanın doğusundan resifler uzanır. Kumsalda biten koyda 4-5 m''ye demirlenir; kuzeyli rüzgârlara yeterli korunak sağlar, güneye açıktır.',
  ST_SetSRID(ST_MakePoint(26.662085, 38.207332), 4326)::geography,
  NULL, NULL, 4, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Taş Ada Koyu', 'Sığacık Körfezi''nin kuzeyinde; adını girişin ortasındaki kayadan alır. Koya bu kayanın BATISINDAN girilir — kayanın doğusundan resifler uzanır. Kumsalda biten koyda 4-5 m''ye demirlenir; kuzeyli rüzgârlara yeterli korunak sağlar, güneye açıktır.' FROM locations WHERE slug = 'tas-ada-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'tas-ada-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kapıkaya Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kapikaya-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Kapıkaya Koyu', 'Demircili (Urla) kıyısında küçük koy. Plaj önünde 3-5 m''ye, yosun-kum zemine demirlenir; iç havza 2-3 m''dir. Kuvvetli kuzeyli rüzgârlar soluğan sokar.',
  ST_SetSRID(ST_MakePoint(26.665064, 38.20603), 4326)::geography,
  NULL, NULL, 3, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kapıkaya Koyu', 'Demircili (Urla) kıyısında küçük koy. Plaj önünde 3-5 m''ye, yosun-kum zemine demirlenir; iç havza 2-3 m''dir. Kuvvetli kuzeyli rüzgârlar soluğan sokar.' FROM locations WHERE slug = 'kapikaya-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'kapikaya-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Yarımada Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yarimada-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Yarımada Koyu', 'Sığacık Körfezi''nin kuzeyinde, oval kumsalda biten koy. Koya, kolay seçilen su seviyesindeki kayaların DOĞUSUNDAN girilir. 3-4 m''ye demirlenir; güney dışında her yöne korunak sağlar. Kuzey tepede kafe vardır; Demirci Limanı''na yürüyüş patikası uzanır.',
  ST_SetSRID(ST_MakePoint(26.689185, 38.204936), 4326)::geography,
  NULL, NULL, 3, 4,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yarımada Koyu', 'Sığacık Körfezi''nin kuzeyinde, oval kumsalda biten koy. Koya, kolay seçilen su seviyesindeki kayaların DOĞUSUNDAN girilir. 3-4 m''ye demirlenir; güney dışında her yöne korunak sağlar. Kuzey tepede kafe vardır; Demirci Limanı''na yürüyüş patikası uzanır.' FROM locations WHERE slug = 'yarimada-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'yarimada-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Düverlik (Merdivenli) Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'duverlik-merdivenli-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Düverlik (Merdivenli) Koyu', 'Sığacık Körfezi''nin kuzeybatısında, kumsalda biten koy. 4-6 m''ye kum-yosun zemine demirlenir; karaya halat verilebilir. Kuzeyli rüzgârlara iyi korunak, güneye açık. Kayalara oyulmuş denize inen antik merdivenleriyle ünlüdür.',
  ST_SetSRID(ST_MakePoint(26.63288, 38.198287), 4326)::geography,
  NULL, NULL, 4, 6,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Düverlik (Merdivenli) Koyu', 'Sığacık Körfezi''nin kuzeybatısında, kumsalda biten koy. 4-6 m''ye kum-yosun zemine demirlenir; karaya halat verilebilir. Kuzeyli rüzgârlara iyi korunak, güneye açık. Kayalara oyulmuş denize inen antik merdivenleriyle ünlüdür.' FROM locations WHERE slug = 'duverlik-merdivenli-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mixed', NULL, true
FROM locations WHERE slug = 'duverlik-merdivenli-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Gök Liman (Kokar) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gok-liman-kokar-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Gök Liman (Kokar)', 'Teke Burnu''nun ~2 mil kuzeydoğusunda, fiyort gibi derin koy; HER YÖNE korunak sağlar. Kuzey krek: ortada 9-11 m, kıyıya doğru sığlaşır — 4-6 m''ye kum zemine demirleyip doğu kıyısına baş halatı verin; tutuş iyidir (balık çiftlikleri manzarayı bozar). Doğu krek: ~10 m, 1-2 tekne; tutuş kuzey kreke göre zayıftır. DİKKAT: girişte gemi şamandırası var — gece dikkat.',
  ST_SetSRID(ST_MakePoint(26.613118, 38.136774), 4326)::geography,
  NULL, NULL, 4, 11,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Gök Liman (Kokar)', 'Teke Burnu''nun ~2 mil kuzeydoğusunda, fiyort gibi derin koy; HER YÖNE korunak sağlar. Kuzey krek: ortada 9-11 m, kıyıya doğru sığlaşır — 4-6 m''ye kum zemine demirleyip doğu kıyısına baş halatı verin; tutuş iyidir (balık çiftlikleri manzarayı bozar). Doğu krek: ~10 m, 1-2 tekne; tutuş kuzey kreke göre zayıftır. DİKKAT: girişte gemi şamandırası var — gece dikkat.' FROM locations WHERE slug = 'gok-liman-kokar-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'gok-liman-kokar-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Nergis Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'nergis-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Nergis Koyu', 'Sarpdere yakınında, kuzeye girintili koy. 4 m''ye, yer yer yosun yamalı kum zemine demirlenir; tutuş iyidir ama kum bazı yerlerde serttir — demiri motor gücüyle oturtun. Her yönden korunak sağlar; kuvvetli kuzeylide ~1 mil açıklık nedeniyle rahatsız edici dalgalanma olur. Dip o kadar berraktır ki mavinin tonları sayılır; içeride güzel bir plaj vardır.',
  ST_SetSRID(ST_MakePoint(26.51646, 38.171888), 4326)::geography,
  NULL, NULL, 4, 4,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Nergis Koyu', 'Sarpdere yakınında, kuzeye girintili koy. 4 m''ye, yer yer yosun yamalı kum zemine demirlenir; tutuş iyidir ama kum bazı yerlerde serttir — demiri motor gücüyle oturtun. Her yönden korunak sağlar; kuvvetli kuzeylide ~1 mil açıklık nedeniyle rahatsız edici dalgalanma olur. Dip o kadar berraktır ki mavinin tonları sayılır; içeride güzel bir plaj vardır.' FROM locations WHERE slug = 'nergis-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'nergis-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Zeytineli Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'zeytineli-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Zeytineli Koyu', 'İnmece Burnu ile Böğürtlen Burnu arasındaki körfez; Böğürtlen Adası ve Dümbelek Adaları yakınında. Bölge kristal berraklığındaki suları ve art arda koylarıyla bilinir.',
  ST_SetSRID(ST_MakePoint(26.484337, 38.189452), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Zeytineli Koyu', 'İnmece Burnu ile Böğürtlen Burnu arasındaki körfez; Böğürtlen Adası ve Dümbelek Adaları yakınında. Bölge kristal berraklığındaki suları ve art arda koylarıyla bilinir.' FROM locations WHERE slug = 'zeytineli-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'zeytineli-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Böğürtlen Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bogurtlen-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Böğürtlen Koyu', 'Dümbelek Adaları ile Dümbelek Dağı arasındaki koy; Böğürtlen Adası''nın yakınındadır. Zeytineli ile birlikte Urla''nın açık deniz koyları hattındadır.',
  ST_SetSRID(ST_MakePoint(26.456503, 38.200115), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Böğürtlen Koyu', 'Dümbelek Adaları ile Dümbelek Dağı arasındaki koy; Böğürtlen Adası''nın yakınındadır. Zeytineli ile birlikte Urla''nın açık deniz koyları hattındadır.' FROM locations WHERE slug = 'bogurtlen-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'bogurtlen-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Lakoz Koyları · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'lakoz-koylari-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-urla'),
  'Lakoz Koyları', 'Urla açıklarında kuzey ve güney olmak üzere ikiz koy. Sarpdere ile Teke Burnu arasındaki tenha demirleme hattındadır.',
  ST_SetSRID(ST_MakePoint(26.521944, 38.154556), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Lakoz Koyları', 'Urla açıklarında kuzey ve güney olmak üzere ikiz koy. Sarpdere ile Teke Burnu arasındaki tenha demirleme hattındadır.' FROM locations WHERE slug = 'lakoz-koylari-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'lakoz-koylari-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Çıplak Ada · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ciplak-ada-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Çıplak Ada', 'Ayvalık kanalının girişinde, Sarımsaklı yarımadasının batısındaki ada. Güney koyunda 2-5 m''ye kum zemine demirlenir; kuzeyli rüzgârlara korunak sağlar — geceleri sakindir; çoğunlukla öğle molası durağıdır. Adanın fenerinin özellikleri: 18 m odak düzlemi, 3 sn''de bir kırmızı çakar, 8 mil görünürlük.',
  ST_SetSRID(ST_MakePoint(26.592667, 39.281472), 4326)::geography,
  NULL, NULL, 2, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Çıplak Ada', 'Ayvalık kanalının girişinde, Sarımsaklı yarımadasının batısındaki ada. Güney koyunda 2-5 m''ye kum zemine demirlenir; kuzeyli rüzgârlara korunak sağlar — geceleri sakindir; çoğunlukla öğle molası durağıdır. Adanın fenerinin özellikleri: 18 m odak düzlemi, 3 sn''de bir kırmızı çakar, 8 mil görünürlük.' FROM locations WHERE slug = 'ciplak-ada-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'ciplak-ada-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sarımsaklı Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sarimsakli-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Sarımsaklı Koyu', 'Ayvalık''ın 7 km uzunluğa ulaşan ünlü kumsalının önü. 2-5 m''de kum zemin iyi tutar; derinlik kıyıya doğru hızla azalır. YALNIZ İYİ HAVADA demirleme yeridir — kötü havada korunak sınırlıdır. Kıyıda oteller, restoranlar ve kafeler sıralıdır.',
  ST_SetSRID(ST_MakePoint(26.632083, 39.270722), 4326)::geography,
  NULL, NULL, 2, 5,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sarımsaklı Koyu', 'Ayvalık''ın 7 km uzunluğa ulaşan ünlü kumsalının önü. 2-5 m''de kum zemin iyi tutar; derinlik kıyıya doğru hızla azalır. YALNIZ İYİ HAVADA demirleme yeridir — kötü havada korunak sınırlıdır. Kıyıda oteller, restoranlar ve kafeler sıralıdır.' FROM locations WHERE slug = 'sarimsakli-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'sarimsakli-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Altınova Balıkçı Barınağı · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'altinova-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'balikesir-ayvalik'),
  'Altınova Balıkçı Barınağı', 'Ayvalık''ın güneyinde, Altınova''nın kooperatif barınağı; 85 tekne. Doğal dalgakıranla korunur; su ve elektrik bağlantısı vardır. Anakaraya 450 m''lik köprüyle bağlı Kum Ada hemen yanındadır. Kasabada market, sağlık merkezi, otel ve restoranlar; yöresel zeytinyağı dükkânları bulunur.',
  ST_SetSRID(ST_MakePoint(26.734608, 39.210427), 4326)::geography,
  NULL, NULL, NULL, NULL,
  85, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Altınova Balıkçı Barınağı', 'Ayvalık''ın güneyinde, Altınova''nın kooperatif barınağı; 85 tekne. Doğal dalgakıranla korunur; su ve elektrik bağlantısı vardır. Anakaraya 450 m''lik köprüyle bağlı Kum Ada hemen yanındadır. Kasabada market, sağlık merkezi, otel ve restoranlar; yöresel zeytinyağı dükkânları bulunur.' FROM locations WHERE slug = 'altinova-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'altinova-balikci-barinagi' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;

-- --- Garip Adası · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'garip-adasi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-dikili'),
  'Garip Adası', 'Bademli (Dikili) açıklarındaki iki adadan biri (357 bin m²); Kalem Adası ile kuzey-güney hattında uzanır, Midilli''nin karşısındadır. Bademli köyünde (limana 1 km) pansiyonlar, restoranlar, fırın, sağlık merkezi ve Salı pazarı vardır.',
  ST_SetSRID(ST_MakePoint(26.78338, 39.007469), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Garip Adası', 'Bademli (Dikili) açıklarındaki iki adadan biri (357 bin m²); Kalem Adası ile kuzey-güney hattında uzanır, Midilli''nin karşısındadır. Bademli köyünde (limana 1 km) pansiyonlar, restoranlar, fırın, sağlık merkezi ve Salı pazarı vardır.' FROM locations WHERE slug = 'garip-adasi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'garip-adasi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Pissa Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'pissa-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-dikili'),
  'Pissa Koyu', 'Bademli (Dikili) kıyısında, Kalem ve Garip adalarının karşısındaki koy. Uzun kumsallarıyla bilinen Bademli köyü yakındadır; köyde konaklama, restoran ve sağlık hizmetleri bulunur.',
  ST_SetSRID(ST_MakePoint(26.79884, 39.018434), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Pissa Koyu', 'Bademli (Dikili) kıyısında, Kalem ve Garip adalarının karşısındaki koy. Uzun kumsallarıyla bilinen Bademli köyü yakındadır; köyde konaklama, restoran ve sağlık hizmetleri bulunur.' FROM locations WHERE slug = 'pissa-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'pissa-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kıyıkışlacık (İasos) Balıkçı Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kiyikislacik-balikci-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Kıyıkışlacık (İasos) Balıkçı Limanı', 'Antik İasos kentinin limanı; Milas''a 18 km. VHF 16''dan ''Kıyıkışlacık Harbour'' çağrılır. Ortalama derinlik 8 m; limanda 4 m''ye demirleme önerilir — çamur ve kum zemin iyi tutar. Antik dalgakıran kalıntıları güneyli dalgadan korur; koy her yönden korunaklıdır. Rıhtımda elektrik ve içme suyu; 500 litre üzeri için tankerle yakıt düzenlenir. Köyde restoran, kafe, pansiyon, balık pazarı ve eczane vardır. Port İasos Marina ayrı tesistir.',
  ST_SetSRID(ST_MakePoint(27.5825, 37.276944), 4326)::geography,
  NULL, NULL, 4, 8,
  40, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kıyıkışlacık (İasos) Balıkçı Limanı', 'Antik İasos kentinin limanı; Milas''a 18 km. VHF 16''dan ''Kıyıkışlacık Harbour'' çağrılır. Ortalama derinlik 8 m; limanda 4 m''ye demirleme önerilir — çamur ve kum zemin iyi tutar. Antik dalgakıran kalıntıları güneyli dalgadan korur; koy her yönden korunaklıdır. Rıhtımda elektrik ve içme suyu; 500 litre üzeri için tankerle yakıt düzenlenir. Köyde restoran, kafe, pansiyon, balık pazarı ve eczane vardır. Port İasos Marina ayrı tesistir.' FROM locations WHERE slug = 'kiyikislacik-balikci-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kiyikislacik-balikci-limani' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902525121416', NULL, true
FROM locations l WHERE l.slug = 'kiyikislacik-balikci-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Güvercinlik Balıkçı Barınağı · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'guvercinlik-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Güvercinlik Balıkçı Barınağı', 'Bodrum''a 18 km, havalimanına 12 km uzaklıkta, Pina yarımadası boyunca doğuya uzanan ormanlık koyun köy barınağı. Köy önünde 4-9 m''ye kum zemine demirlenir; tutuş iyidir — hâkim batılıya karşı karaya halat verin. Köyde pansiyonlar, ATM, eczane, devlet kliniği ve jandarma vardır; koydaki çiftliklerden taze levrek alınabilir. Antik Karyanda kalıntıları yol girişindedir.',
  ST_SetSRID(ST_MakePoint(27.580194, 37.135861), 4326)::geography,
  NULL, NULL, 4, 9,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Güvercinlik Balıkçı Barınağı', 'Bodrum''a 18 km, havalimanına 12 km uzaklıkta, Pina yarımadası boyunca doğuya uzanan ormanlık koyun köy barınağı. Köy önünde 4-9 m''ye kum zemine demirlenir; tutuş iyidir — hâkim batılıya karşı karaya halat verin. Köyde pansiyonlar, ATM, eczane, devlet kliniği ve jandarma vardır; koydaki çiftliklerden taze levrek alınabilir. Antik Karyanda kalıntıları yol girişindedir.' FROM locations WHERE slug = 'guvercinlik-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- --- Ilıcabükü (Cennet Koyu) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ilicabuku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Ilıcabükü (Cennet Koyu)', 'Çomca ve Gök burunları arasında, yerel adıyla ''Cennet Koyu''. Her iki burnun ucundan SIĞ KAYA YAMALARI uzanır — koya ortadaki kanaldan girin. 3-6 m''ye demirlenir, tutuş iyidir; emniyet için karaya halat verin. Güneybatı girinti hâkim rüzgârlara korunaklıdır; kuvvetli kuzeyli soluğan sokar. Çam kaplı yamaçlar ve koşu patikası; adını veren kuyu suları kıyıdadır.',
  ST_SetSRID(ST_MakePoint(27.424056, 37.126944), 4326)::geography,
  NULL, NULL, 3, 6,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ilıcabükü (Cennet Koyu)', 'Çomca ve Gök burunları arasında, yerel adıyla ''Cennet Koyu''. Her iki burnun ucundan SIĞ KAYA YAMALARI uzanır — koya ortadaki kanaldan girin. 3-6 m''ye demirlenir, tutuş iyidir; emniyet için karaya halat verin. Güneybatı girinti hâkim rüzgârlara korunaklıdır; kuvvetli kuzeyli soluğan sokar. Çam kaplı yamaçlar ve koşu patikası; adını veren kuyu suları kıyıdadır.' FROM locations WHERE slug = 'ilicabuku-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'ilicabuku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Demir Liman · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'demir-liman-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Demir Liman', 'Gök Burnu''nun güneyinde, Torba''nın 2,5 mil kuzeyinde ''saklı koy''. Derinlik 18-20 m''den hızla 7 m''ye düşer; 8-10 m''ye demirlenir. Meltemden iyi korunur. DİKKAT: girişte sağ taraftaki resiflerden mesafe alın; koyun kuzeyinde üzerinde 4 m su olan batık kayalık vardır. Kıyı palmiyelidir; özel ev ve özel iskele bulunur.',
  ST_SetSRID(ST_MakePoint(27.436518, 37.120873), 4326)::geography,
  NULL, NULL, 8, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Demir Liman', 'Gök Burnu''nun güneyinde, Torba''nın 2,5 mil kuzeyinde ''saklı koy''. Derinlik 18-20 m''den hızla 7 m''ye düşer; 8-10 m''ye demirlenir. Meltemden iyi korunur. DİKKAT: girişte sağ taraftaki resiflerden mesafe alın; koyun kuzeyinde üzerinde 4 m su olan batık kayalık vardır. Kıyı palmiyelidir; özel ev ve özel iskele bulunur.' FROM locations WHERE slug = 'demir-liman-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'rock', NULL, true
FROM locations WHERE slug = 'demir-liman-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kuyucakbükü · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kuyucakbuku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Kuyucakbükü', 'Güllük Körfezi''nin doğusunda, Salih Adası ile Kimse Burnu arasında çam kaplı doğal liman; HER RÜZGÂRDAN korunaklıdır. Kuzeybatı ve kuzeydoğu olmak üzere iki krekte demirlenir; orta su yolu her havada barınak verir. Kuzeybatı krekte otel iskelesine yanaşılabilir. DİKKAT: girişin iki yanındaki balık çiftliklerinin bağlantı halatlarına dikkat; bir bölüm bataklık olduğundan girilmez.',
  ST_SetSRID(ST_MakePoint(27.557472, 37.154833), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kuyucakbükü', 'Güllük Körfezi''nin doğusunda, Salih Adası ile Kimse Burnu arasında çam kaplı doğal liman; HER RÜZGÂRDAN korunaklıdır. Kuzeybatı ve kuzeydoğu olmak üzere iki krekte demirlenir; orta su yolu her havada barınak verir. Kuzeybatı krekte otel iskelesine yanaşılabilir. DİKKAT: girişin iki yanındaki balık çiftliklerinin bağlantı halatlarına dikkat; bir bölüm bataklık olduğundan girilmez.' FROM locations WHERE slug = 'kuyucakbuku-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'kuyucakbuku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ülelibük (Varvil) Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ulelibuk-varvil-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Ülelibük (Varvil) Koyu', 'Güllük Körfezi''nde güneye uzanan, ortadan sığlaşıp Bükgöl bataklığında biten koy. 3 m''ye çamur zemine demirlenir. Meltem ve batılı rüzgârlar soluğan sokar. Boğaziçi balıkçı köyünün iskelesi ~4 tekne alır; su ve elektrik vardır; köyde kâhya ve balık restoranları bulunur. Antik Bargylia kalıntıları batı yakadadır.',
  ST_SetSRID(ST_MakePoint(27.574004, 37.212674), 4326)::geography,
  NULL, NULL, 3, 3,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ülelibük (Varvil) Koyu', 'Güllük Körfezi''nde güneye uzanan, ortadan sığlaşıp Bükgöl bataklığında biten koy. 3 m''ye çamur zemine demirlenir. Meltem ve batılı rüzgârlar soluğan sokar. Boğaziçi balıkçı köyünün iskelesi ~4 tekne alır; su ve elektrik vardır; köyde kâhya ve balık restoranları bulunur. Antik Bargylia kalıntıları batı yakadadır.' FROM locations WHERE slug = 'ulelibuk-varvil-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'mud', NULL, true
FROM locations WHERE slug = 'ulelibuk-varvil-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kocabahçe Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kocabahce-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Kocabahçe Koyu', 'Hisarönü''nde Kargacık ve Ayı burunları arasında, güneybatıya yarım mil girintili daralan koy. 10-20 m''ye demirlenir; kıyıya doğru sığlaşır. Güneydeki dere ağzı tarafı meltemin dulundadır; kuvvetli kuzeyli hem soluğan sokar hem dağdan huni gibi iner. DİKKAT: girişte Kargacık burnu ucundan resifler uzanır. Koydaki ahşap restoran iskelesi ayrı kayıttır.',
  ST_SetSRID(ST_MakePoint(28.010833, 36.70375), 4326)::geography,
  NULL, NULL, 10, 20,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kocabahçe Koyu', 'Hisarönü''nde Kargacık ve Ayı burunları arasında, güneybatıya yarım mil girintili daralan koy. 10-20 m''ye demirlenir; kıyıya doğru sığlaşır. Güneydeki dere ağzı tarafı meltemin dulundadır; kuvvetli kuzeyli hem soluğan sokar hem dağdan huni gibi iner. DİKKAT: girişte Kargacık burnu ucundan resifler uzanır. Koydaki ahşap restoran iskelesi ayrı kayıttır.' FROM locations WHERE slug = 'kocabahce-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'kocabahce-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kocabahçe İskelesi · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kocabahce-iskelesi', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Kocabahçe İskelesi', 'Kocabahçe koyunun içindeki ahşap iskele; 11 tekneye kadar yanaşma kapasitesi. Hazır tonozlar (laid mooring) ve yüzer bağlama vardır. Kıyıda restoran ve tuvalet bulunur; elektrik jeneratörle sağlanır.',
  ST_SetSRID(ST_MakePoint(28.008139, 36.698111), 4326)::geography,
  NULL, NULL, NULL, NULL,
  11, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kocabahçe İskelesi', 'Kocabahçe koyunun içindeki ahşap iskele; 11 tekneye kadar yanaşma kapasitesi. Hazır tonozlar (laid mooring) ve yüzer bağlama vardır. Kıyıda restoran ve tuvalet bulunur; elektrik jeneratörle sağlanır.' FROM locations WHERE slug = 'kocabahce-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, 11, NULL, NULL
FROM locations WHERE slug = 'kocabahce-iskelesi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kocabahce-iskelesi' AND a.code IN ('restaurant', 'electricity', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'kocabahce-iskelesi' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;

-- --- Tavşanbükü · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tavsanbuku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Tavşanbükü', 'Bozburun yakınında büyük koy; ortasında Tavşanbükü Adası yer alır — koya adanın batısından ya da doğusundan girilir. 5-10 m''ye demirlenir; Değirmen Burnu''nun doğusunda karaya halat verilebilir. Bozburun''dan günübirlik tekne turlarının uğrağıdır. DİKKAT: ada ile kara arasındaki geçit DENENMEMELİDİR.',
  ST_SetSRID(ST_MakePoint(28.014794, 36.670937), 4326)::geography,
  NULL, NULL, 5, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Tavşanbükü', 'Bozburun yakınında büyük koy; ortasında Tavşanbükü Adası yer alır — koya adanın batısından ya da doğusundan girilir. 5-10 m''ye demirlenir; Değirmen Burnu''nun doğusunda karaya halat verilebilir. Bozburun''dan günübirlik tekne turlarının uğrağıdır. DİKKAT: ada ile kara arasındaki geçit DENENMEMELİDİR.' FROM locations WHERE slug = 'tavsanbuku-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'tavsanbuku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Ayaca Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'ayaca-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Ayaca Koyu', 'Bozburun''da Ortaca Burnu''nun kuzeydoğusundaki geniş, güneye açık ıssız koy; bir çıkıntı koyu iki kreke böler. Doğu krekte 10-15 m''ye demirlenir ya da karaya halat verilir; batılı rüzgârlara korunak sağlar. Kıyı çalılık ve kekik kaplıdır. DİKKAT: çıkıntının ucundaki kayalıklardan mesafe alın.',
  ST_SetSRID(ST_MakePoint(27.999778, 36.672722), 4326)::geography,
  NULL, NULL, 10, 15,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Ayaca Koyu', 'Bozburun''da Ortaca Burnu''nun kuzeydoğusundaki geniş, güneye açık ıssız koy; bir çıkıntı koyu iki kreke böler. Doğu krekte 10-15 m''ye demirlenir ya da karaya halat verilir; batılı rüzgârlara korunak sağlar. Kıyı çalılık ve kekik kaplıdır. DİKKAT: çıkıntının ucundaki kayalıklardan mesafe alın.' FROM locations WHERE slug = 'ayaca-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'ayaca-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Mercimek Bükü · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mercimek-buku-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Mercimek Bükü', 'Tavşanbükü Adası''nın doğusunda yarım mil uzanan dar koy; HER YÖNE korunak sağlar ama yalnız ~2 tekneye yer vardır — 18-22 m''ye demirleyip yer varsa karaya halat verin. Kıyıdaki vadide badem ağaçları ve kalıntılar vardır. Hemen yanındaki Bozen Koyu 10-13 m ile hâkim rüzgâra nispi korunak sunar.',
  ST_SetSRID(ST_MakePoint(28.025025, 36.669681), 4326)::geography,
  NULL, NULL, 18, 22,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mercimek Bükü', 'Tavşanbükü Adası''nın doğusunda yarım mil uzanan dar koy; HER YÖNE korunak sağlar ama yalnız ~2 tekneye yer vardır — 18-22 m''ye demirleyip yer varsa karaya halat verin. Kıyıdaki vadide badem ağaçları ve kalıntılar vardır. Hemen yanındaki Bozen Koyu 10-13 m ile hâkim rüzgâra nispi korunak sunar.' FROM locations WHERE slug = 'mercimek-buku-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'mercimek-buku-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Yeşilköy Marina · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yesilkoy-marina', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-bakirkoy'),
  'Yeşilköy Marina', 'Yeşilköy''de 350 m dış + 150 m iç mendirekli liman; balıkçı bölümü 95 tekne alır. VHF 16''dan ''Yeşilköy Marina'' çağrılır. Rıhtımda su, elektrik ve yakıt pompası; WC-duş ve idare ofisi vardır. Barınma yeterlidir; büyük ticari gemilerin soluğanı rahatsız edebilir. Yurda giriş-çıkış işlemleri Karaköy Yolcu Salonu''nda yapılır. Yanındaki fenerin özellikleri: 18 m kule, 10 sn''de beyaz çakar, 15 mil.',
  ST_SetSRID(ST_MakePoint(28.825833, 40.955278), 4326)::geography,
  NULL, NULL, NULL, NULL,
  95, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yeşilköy Marina', 'Yeşilköy''de 350 m dış + 150 m iç mendirekli liman; balıkçı bölümü 95 tekne alır. VHF 16''dan ''Yeşilköy Marina'' çağrılır. Rıhtımda su, elektrik ve yakıt pompası; WC-duş ve idare ofisi vardır. Barınma yeterlidir; büyük ticari gemilerin soluğanı rahatsız edebilir. Yurda giriş-çıkış işlemleri Karaköy Yolcu Salonu''nda yapılır. Yanındaki fenerin özellikleri: 18 m kule, 10 sn''de beyaz çakar, 15 mil.' FROM locations WHERE slug = 'yesilkoy-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'yesilkoy-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wc', 'shower')
ON CONFLICT DO NOTHING;

-- --- Bostancı Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'bostanci-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-maltepe'),
  'Bostancı Balıkçı Barınağı', 'Anadolu yakasının en işlek barınaklarından; 520 m ana mendirek, 100 tekne. Elektrik, içme suyu, yakıt pompası, soğuk hava deposu, çekek yeri ve balık hali vardır. Metro, minibüs, banliyö treni ve deniz otobüsü bağlantıları hemen yanındadır.',
  ST_SetSRID(ST_MakePoint(29.094833, 40.950139), 4326)::geography,
  NULL, NULL, NULL, NULL,
  100, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Bostancı Balıkçı Barınağı', 'Anadolu yakasının en işlek barınaklarından; 520 m ana mendirek, 100 tekne. Elektrik, içme suyu, yakıt pompası, soğuk hava deposu, çekek yeri ve balık hali vardır. Metro, minibüs, banliyö treni ve deniz otobüsü bağlantıları hemen yanındadır.' FROM locations WHERE slug = 'bostanci-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'bostanci-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902164589999', NULL, true
FROM locations l WHERE l.slug = 'bostanci-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Küçükyalı Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kucukyali-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-maltepe'),
  'Küçükyalı Balıkçı Barınağı', 'Maltepe Küçükyalı''da 250 m ana mendirekli kooperatif barınağı; 100 tekne. Elektrik, içme suyu, yakıt pompası, soğuk hava deposu, çekek yeri ve balık hali vardır. Kıyıdaki balık restoranları mevsim balığına göre çalışır.',
  ST_SetSRID(ST_MakePoint(29.105806, 40.942639), 4326)::geography,
  NULL, NULL, NULL, NULL,
  100, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Küçükyalı Balıkçı Barınağı', 'Maltepe Küçükyalı''da 250 m ana mendirekli kooperatif barınağı; 100 tekne. Elektrik, içme suyu, yakıt pompası, soğuk hava deposu, çekek yeri ve balık hali vardır. Kıyıdaki balık restoranları mevsim balığına göre çalışır.' FROM locations WHERE slug = 'kucukyali-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kucukyali-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902164589999', NULL, true
FROM locations l WHERE l.slug = 'kucukyali-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Heybeliada Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'heybeliada-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-adalar'),
  'Heybeliada Balıkçı Barınağı', 'Adalar''ın ikinci büyüğü Heybeliada''nın kooperatif barınağı; 70 tekne. Mendirek feneri 2 sn''de kırmızı çakar (7 mil). Adada restoranlar, oteller, tamirhaneler, sağlık ve banka hizmetleri vardır; Bostancı ve Kabataş''a deniz otobüsü, Kadıköy''e vapur kalkar. Çam Limanı koyu adanın güneybatısında ayrı kayıttır.',
  ST_SetSRID(ST_MakePoint(29.100361, 40.879611), 4326)::geography,
  NULL, NULL, NULL, NULL,
  70, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Heybeliada Balıkçı Barınağı', 'Adalar''ın ikinci büyüğü Heybeliada''nın kooperatif barınağı; 70 tekne. Mendirek feneri 2 sn''de kırmızı çakar (7 mil). Adada restoranlar, oteller, tamirhaneler, sağlık ve banka hizmetleri vardır; Bostancı ve Kabataş''a deniz otobüsü, Kadıköy''e vapur kalkar. Çam Limanı koyu adanın güneybatısında ayrı kayıttır.' FROM locations WHERE slug = 'heybeliada-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902163823382', NULL, true
FROM locations l WHERE l.slug = 'heybeliada-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'iletisim@adalar.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'heybeliada-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Selimpaşa Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'selimpasa-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-silivri'),
  'Selimpaşa Balıkçı Barınağı', 'İstanbul''un 50 km batısında, Silivri Selimpaşa''da 265 m ana mendirekli barınak. VHF 16''dan ''Selimpaşa Harbour'' çağrılır. Girişte 2-3,5 m; batı ve kuzey rıhtımlarında 0,5-1,5 m — SU ÇEKİMİ FAZLA TEKNELER DİKKAT. Doğu dışında her yöne iyi barınak. İçme suyu, elektrik, yakıt ve çekek yeri vardır; kuzey tarafta restoran bulunur.',
  ST_SetSRID(ST_MakePoint(28.367361, 41.051861), 4326)::geography,
  NULL, NULL, 1, 3,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Selimpaşa Balıkçı Barınağı', 'İstanbul''un 50 km batısında, Silivri Selimpaşa''da 265 m ana mendirekli barınak. VHF 16''dan ''Selimpaşa Harbour'' çağrılır. Girişte 2-3,5 m; batı ve kuzey rıhtımlarında 0,5-1,5 m — SU ÇEKİMİ FAZLA TEKNELER DİKKAT. Doğu dışında her yöne iyi barınak. İçme suyu, elektrik, yakıt ve çekek yeri vardır; kuzey tarafta restoran bulunur.' FROM locations WHERE slug = 'selimpasa-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'selimpasa-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902124442047', NULL, true
FROM locations l WHERE l.slug = 'selimpasa-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'sibim@silivri.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'selimpasa-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mimarsinan Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mimarsinan-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'istanbul-buyukcekmece'),
  'Mimarsinan Balıkçı Barınağı', 'Büyükçekmece Mimarsinan''da belediye işletmesindeki barınak; 290 m dış mendirek. VHF 73''ten ''Mimarsinan Marina'' çağrılır. Elektrik, içme suyu, yakıt, çekek yeri ve kara park sahası vardır. Mendirek feneri: 7 m kule, 3 mil görünürlük.',
  ST_SetSRID(ST_MakePoint(28.565796, 41.015403), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mimarsinan Balıkçı Barınağı', 'Büyükçekmece Mimarsinan''da belediye işletmesindeki barınak; 290 m dış mendirek. VHF 73''ten ''Mimarsinan Marina'' çağrılır. Elektrik, içme suyu, yakıt, çekek yeri ve kara park sahası vardır. Mendirek feneri: 7 m kule, 3 mil görünürlük.' FROM locations WHERE slug = 'mimarsinan-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'mimarsinan-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902124440340', NULL, true
FROM locations l WHERE l.slug = 'mimarsinan-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'danisma@bcekmece.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'mimarsinan-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- İzmit Belediye Marinası · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'izmit-belediye-marina', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'kocaeli-izmit'),
  'İzmit Belediye Marinası', 'İzmit Körfezi''nin doğu ucunda, İstanbul''a ~100 km mesafede belediye marinası; 400 yat kapasitesi, 7-10 m derinlik. VHF 16''dan ''İzmit Marina'' çağrılır. İçme suyu, elektrik, yakıt istasyonu, telefon/internet, kablolu TV, çekek yeri ve bakım-onarım hizmetleri vardır. Çevrede tersaneler, oteller, hastaneler ve alışveriş olanakları bulunur.',
  ST_SetSRID(ST_MakePoint(29.921752, 40.758762), 4326)::geography,
  NULL, NULL, 7, 10,
  400, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İzmit Belediye Marinası', 'İzmit Körfezi''nin doğu ucunda, İstanbul''a ~100 km mesafede belediye marinası; 400 yat kapasitesi, 7-10 m derinlik. VHF 16''dan ''İzmit Marina'' çağrılır. İçme suyu, elektrik, yakıt istasyonu, telefon/internet, kablolu TV, çekek yeri ve bakım-onarım hizmetleri vardır. Çevrede tersaneler, oteller, hastaneler ve alışveriş olanakları bulunur.' FROM locations WHERE slug = 'izmit-belediye-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 400, '16', NULL, NULL, NULL
FROM locations WHERE slug = 'izmit-belediye-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'izmit-belediye-marina' AND a.code IN ('electricity', 'water', 'fuel', 'wifi')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'izmit-belediye-marina' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902623181001', NULL, true
FROM locations l WHERE l.slug = 'izmit-belediye-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Darıca Balıkçı Barınağı ve Yat Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'darica-balikci-barinagi', 2, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'kocaeli-darica'),
  'Darıca Balıkçı Barınağı ve Yat Limanı', 'Darıca''da belediye işletmesinde barınak + yat limanı; 300 tekne. İçme suyu, elektrik, yakıt, teknik servis, çekek yeri, idare binası, ağ tamirhanesi ve balık hali vardır. Girişi 18 mil görünürlüklü Yelkenkaya Feneri işaretler. Kıyı balık restoranlarıyla ünlüdür.',
  ST_SetSRID(ST_MakePoint(29.388389, 40.752611), 4326)::geography,
  NULL, NULL, NULL, NULL,
  300, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Darıca Balıkçı Barınağı ve Yat Limanı', 'Darıca''da belediye işletmesinde barınak + yat limanı; 300 tekne. İçme suyu, elektrik, yakıt, teknik servis, çekek yeri, idare binası, ağ tamirhanesi ve balık hali vardır. Girişi 18 mil görünürlüklü Yelkenkaya Feneri işaretler. Kıyı balık restoranlarıyla ünlüdür.' FROM locations WHERE slug = 'darica-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 300, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'darica-balikci-barinagi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'darica-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'darica-balikci-barinagi' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902627452132', NULL, true
FROM locations l WHERE l.slug = 'darica-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'beyazmasa@darica.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'darica-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Eskihisar Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'eskihisar-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'kocaeli-gebze'),
  'Eskihisar Balıkçı Barınağı', 'Gebze Eskihisar''da, Topçular (Yalova) feribot iskelesinin yanındaki kooperatif barınağı; 95 tekne. VHF 16. İçme suyu, elektrik, yakıt, WC-duş ve gümrük ofisi vardır. Kıyı balık restoranları, Osman Hamdi Bey Müzesi ve kale yakındadır.',
  ST_SetSRID(ST_MakePoint(29.428056, 40.768611), 4326)::geography,
  NULL, NULL, NULL, NULL,
  95, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Eskihisar Balıkçı Barınağı', 'Gebze Eskihisar''da, Topçular (Yalova) feribot iskelesinin yanındaki kooperatif barınağı; 95 tekne. VHF 16. İçme suyu, elektrik, yakıt, WC-duş ve gümrük ofisi vardır. Kıyı balık restoranları, Osman Hamdi Bey Müzesi ve kale yakındadır.' FROM locations WHERE slug = 'eskihisar-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'eskihisar-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel', 'wc', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'bilgi@gebze.bel.tr', NULL, true
FROM locations l WHERE l.slug = 'eskihisar-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Atabay Marina · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'atabay-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'kocaeli-gebze'),
  'Atabay Marina', 'Eskihisar''da yıl boyu çalışan tersane-marina. VHF 16''dan ''Atabay Marina'' çağrılır. Yakıt, tatlı su ve elektrik; motor-pervane-tekne tamiri, fiberglas/ahşap onarım, elektronik, torna ve boya atölyeleri; 100 tonluk iki vinç vardır. Karada ~100 tekne kapasitesi; 25 odalı otel, restoran ve bar bulunur.',
  ST_SetSRID(ST_MakePoint(29.44, 40.770833), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Atabay Marina', 'Eskihisar''da yıl boyu çalışan tersane-marina. VHF 16''dan ''Atabay Marina'' çağrılır. Yakıt, tatlı su ve elektrik; motor-pervane-tekne tamiri, fiberglas/ahşap onarım, elektronik, torna ve boya atölyeleri; 100 tonluk iki vinç vardır. Karada ~100 tekne kapasitesi; 25 odalı otel, restoran ve bar bulunur.' FROM locations WHERE slug = 'atabay-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, NULL, '16', NULL, NULL, NULL
FROM locations WHERE slug = 'atabay-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'atabay-marina' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'atabay-marina' AND sv.code IN ('technical_service', 'crane', 'winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902626555854', NULL, true
FROM locations l WHERE l.slug = 'atabay-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@atabaymarina.com', NULL, false
FROM locations l WHERE l.slug = 'atabay-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.atabaymarina.com/', NULL, false
FROM locations l WHERE l.slug = 'atabay-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Hereke Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'hereke-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'kocaeli-korfez'),
  'Hereke Balıkçı Barınağı', 'İzmit Körfezi''nin kuzey kıyısında, ipek halısıyla ünlü Hereke''nin kooperatif barınağı; 60 tekne. Elektrik, içme suyu, yakıt istasyonu ve idare ofisi vardır; günün balığı barınaktaki halden alınabilir.',
  ST_SetSRID(ST_MakePoint(29.617639, 40.782528), 4326)::geography,
  NULL, NULL, NULL, NULL,
  60, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Hereke Balıkçı Barınağı', 'İzmit Körfezi''nin kuzey kıyısında, ipek halısıyla ünlü Hereke''nin kooperatif barınağı; 60 tekne. Elektrik, içme suyu, yakıt istasyonu ve idare ofisi vardır; günün balığı barınaktaki halden alınabilir.' FROM locations WHERE slug = 'hereke-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'hereke-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;

-- --- Karamürsel Ereğli Balıkçı Barınağı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'karamursel-eregli-balikci-barinagi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'kocaeli-karamursel'),
  'Karamürsel Ereğli Balıkçı Barınağı', 'İzmit Körfezi''nin güney kıyısında, Karamürsel''e 4 km uzaklıkta Ereğli köyünün barınağı; 85 tekne. VHF 16''dan ''Ereğli Marina'' çağrılır. Elektrik, içme suyu, yakıt istasyonu, balık restoranı, balık hali ve soğuk hava deposu vardır. Yenikapı''ya deniz otobüsü bağlantısı bulunur.',
  ST_SetSRID(ST_MakePoint(29.659722, 40.701944), 4326)::geography,
  NULL, NULL, NULL, NULL,
  85, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Karamürsel Ereğli Balıkçı Barınağı', 'İzmit Körfezi''nin güney kıyısında, Karamürsel''e 4 km uzaklıkta Ereğli köyünün barınağı; 85 tekne. VHF 16''dan ''Ereğli Marina'' çağrılır. Elektrik, içme suyu, yakıt istasyonu, balık restoranı, balık hali ve soğuk hava deposu vardır. Yenikapı''ya deniz otobüsü bağlantısı bulunur.' FROM locations WHERE slug = 'karamursel-eregli-balikci-barinagi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'karamursel-eregli-balikci-barinagi' AND a.code IN ('electricity', 'water', 'fuel', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902624521025', NULL, true
FROM locations l WHERE l.slug = 'karamursel-eregli-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@karamursel.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'karamursel-eregli-balikci-barinagi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Gökova Ören Marina · güven: high · kaynak: marinakedisi.com, tkygm.uab.gov.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gokova-oren-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-milas'),
  'Setur Gökova Ören Marina', 'Gökova Körfezi''nin kuzey kıyısında, Ören''de büyük marina: denizde 410, karada 150 tekne. VHF 73''ten (Setur çağrı düzeni 16/73) ulaşılır. Gökova''nın kuzey yakasında bu ölçekte tek tam donanımlı liman olması nedeniyle körfez rotalarının önemli durağıdır. Keramos antik kenti hemen ardındadır.',
  ST_SetSRID(ST_MakePoint(27.981972, 37.031417), 4326)::geography,
  NULL, NULL, NULL, NULL,
  410, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Gökova Ören Marina', 'Gökova Körfezi''nin kuzey kıyısında, Ören''de büyük marina: denizde 410, karada 150 tekne. VHF 73''ten (Setur çağrı düzeni 16/73) ulaşılır. Gökova''nın kuzey yakasında bu ölçekte tek tam donanımlı liman olması nedeniyle körfez rotalarının önemli durağıdır. Keramos antik kenti hemen ardındadır.' FROM locations WHERE slug = 'gokova-oren-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 410, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'gokova-oren-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'gokova-oren-marina' AND a.code IN ('electricity', 'water')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'gokova-oren-marina' AND sv.code IN ('winter_storage')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902525323361', NULL, true
FROM locations l WHERE l.slug = 'gokova-oren-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'gokovaoren@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'gokova-oren-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/', NULL, false
FROM locations l WHERE l.slug = 'gokova-oren-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Setur Çeşme Altınyunus Marina · güven: high · kaynak: marinalar.com, tkygm.uab.gov.tr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'setur-altinyunus-marina', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'izmir-cesme'),
  'Setur Çeşme Altınyunus Marina', 'Çeşme Boyalık ile Ilıca arasındaki Altınyunus koyunda marina: denizde 186, karada 60 tekne; maksimum boy 45 m, derinlik 4 m''ye kadar. Elektrik, su, Wi-Fi, güvenlik, yakıt ve dalgıç hizmeti; WC-duş, çamaşırhane, ATM, restoran-bar ve plaj vardır. Koy, rüzgâr sörfü için dünyanın elverişli koylarından sayılır — öğleden sonra termik rüzgâr belirgindir.',
  ST_SetSRID(ST_MakePoint(26.34201, 38.3231), 4326)::geography,
  45, NULL, NULL, 4,
  186, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Setur Çeşme Altınyunus Marina', 'Çeşme Boyalık ile Ilıca arasındaki Altınyunus koyunda marina: denizde 186, karada 60 tekne; maksimum boy 45 m, derinlik 4 m''ye kadar. Elektrik, su, Wi-Fi, güvenlik, yakıt ve dalgıç hizmeti; WC-duş, çamaşırhane, ATM, restoran-bar ve plaj vardır. Koy, rüzgâr sörfü için dünyanın elverişli koylarından sayılır — öğleden sonra termik rüzgâr belirgindir.' FROM locations WHERE slug = 'setur-altinyunus-marina'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 186, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'setur-altinyunus-marina'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'setur-altinyunus-marina' AND a.code IN ('electricity', 'water', 'wifi', 'security', 'fuel', 'wc', 'shower', 'laundry', 'restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'setur-altinyunus-marina' AND sv.code IN ('diver')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902327231434', NULL, true
FROM locations l WHERE l.slug = 'setur-altinyunus-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'cesme@seturmarinas.com', NULL, false
FROM locations l WHERE l.slug = 'setur-altinyunus-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://www.seturmarinas.com/', NULL, false
FROM locations l WHERE l.slug = 'setur-altinyunus-marina'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Pythagorio Limanı · güven: high · kaynak: www.cruiserswiki.org ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'pythagorio-limani-samos', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-samos'),
  'Pythagorio Limanı', 'Antik Samos''un limanı; Kuşadası-Dilek Yarımadası''nın tam karşısı. Liman içinde derinlik ~5 m; çamur zemin, 25 m zincirle iyi tutar. İç liman her havada güvenlidir; dış rıhtım güneydoğuya açıktır — kuvvetli D/GD rüzgârında iki demir önerilir. Su-elektrik rıhtımda; yakıt mini tankerle ya da 1,5 mil kuzeydeki Samos Marina''dan. Liman ücreti ~10 € /gece (2017). DİKKAT: iç liman girişinin ortasına yakın, şamandırayla işaretli TEHLİKELİ KAYA vardır — kuzey kenardan girin; 2021''den beri iç limanda demirleme yasaktır. Gece rıhtım kafeleri sabaha dek gürültülü olabilir.',
  ST_SetSRID(ST_MakePoint(26.95, 37.686667), 4326)::geography,
  NULL, NULL, 4, 5,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Pythagorio Limanı', 'Antik Samos''un limanı; Kuşadası-Dilek Yarımadası''nın tam karşısı. Liman içinde derinlik ~5 m; çamur zemin, 25 m zincirle iyi tutar. İç liman her havada güvenlidir; dış rıhtım güneydoğuya açıktır — kuvvetli D/GD rüzgârında iki demir önerilir. Su-elektrik rıhtımda; yakıt mini tankerle ya da 1,5 mil kuzeydeki Samos Marina''dan. Liman ücreti ~10 € /gece (2017). DİKKAT: iç liman girişinin ortasına yakın, şamandırayla işaretli TEHLİKELİ KAYA vardır — kuzey kenardan girin; 2021''den beri iç limanda demirleme yasaktır. Gece rıhtım kafeleri sabaha dek gürültülü olabilir.' FROM locations WHERE slug = 'pythagorio-limani-samos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'pythagorio-limani-samos' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302273061225', NULL, true
FROM locations l WHERE l.slug = 'pythagorio-limani-samos'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Vathy Limanı (Samos) · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'samos-vathy-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-samos'),
  'Vathy Limanı (Samos)', 'Samos''un başkenti Vathy''nin limanı. Rıhtım çevresinde hemen her yerde ~3 m su vardır; feribot rıhtımından uzağa bağlanılır. Ana körfez kuzey-kuzeybatıya tamamen açıktır — meltemde belirgin çapraz dalga girer; güneydoğu köşedeki küçük marina meltemden korunur (hafif soluğanla). Su marinada; yakıt mini tankerle. Kasabada market, banka ve restoranlar rıhtım boyundadır.',
  ST_SetSRID(ST_MakePoint(26.973063, 37.75536), 4326)::geography,
  NULL, NULL, 3, 3,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Vathy Limanı (Samos)', 'Samos''un başkenti Vathy''nin limanı. Rıhtım çevresinde hemen her yerde ~3 m su vardır; feribot rıhtımından uzağa bağlanılır. Ana körfez kuzey-kuzeybatıya tamamen açıktır — meltemde belirgin çapraz dalga girer; güneydoğu köşedeki küçük marina meltemden korunur (hafif soluğanla). Su marinada; yakıt mini tankerle. Kasabada market, banka ve restoranlar rıhtım boyundadır.' FROM locations WHERE slug = 'samos-vathy-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'samos-vathy-limani' AND a.code IN ('water', 'fuel')
ON CONFLICT DO NOTHING;

-- --- Agios Georgios Rıhtımı (Agathonisi) · güven: medium · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'agathonisi-agios-georgios', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-agathonisi'),
  'Agios Georgios Rıhtımı (Agathonisi)', 'Didim-Datça hattının karşısındaki küçük Agathonisi''nin tek limanı. Feribot rıhtımına 3-4 tek gövdeli tekne sığar (katamaran varsa daha az); koyda demir yeri sınırlıdır — batı ve doğu kollarında 7-12 m''ye demirlenir, tutuş iyidir. Meltemden iyi korunur; güneye açıktır; Temmuz-Eylül arası kuvvetli sağanak rüzgâr (gust) görülür. DİKKAT: yazın yüzme şamandıraları konur ve sıkı denetlenir. Köyde 3 restoran ve bakkallar vardır; SUYU İÇMEYİN (içme suyu değildir).',
  ST_SetSRID(ST_MakePoint(26.966928, 37.457523), 4326)::geography,
  NULL, NULL, 7, 12,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Agios Georgios Rıhtımı (Agathonisi)', 'Didim-Datça hattının karşısındaki küçük Agathonisi''nin tek limanı. Feribot rıhtımına 3-4 tek gövdeli tekne sığar (katamaran varsa daha az); koyda demir yeri sınırlıdır — batı ve doğu kollarında 7-12 m''ye demirlenir, tutuş iyidir. Meltemden iyi korunur; güneye açıktır; Temmuz-Eylül arası kuvvetli sağanak rüzgâr (gust) görülür. DİKKAT: yazın yüzme şamandıraları konur ve sıkı denetlenir. Köyde 3 restoran ve bakkallar vardır; SUYU İÇMEYİN (içme suyu değildir).' FROM locations WHERE slug = 'agathonisi-agios-georgios'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'agathonisi-agios-georgios' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;

-- --- Katapola Limanı (Amorgos) · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'katapola-limani-amorgos', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-amorgos'),
  'Katapola Limanı (Amorgos)', 'Amorgos''un ana limanı. Kuzeye demir atıp kıçtan rıhtıma bağlanılır. Geniş koy kuzey-kuzeydoğuya açıktır; kuvvetli batı rüzgârında koyda dalga 1,5 m''yi bulabilir. Elektrik rıhtımda; yakıt mini tankerle; tersane, market, banka ve restoranlar vardır. Liman ücreti ~14 €/gece (12 m tekne, 2017), su ~5 €. Koyun karşı (kuzey) yakası Xilokeratidi balıkçı limanıdır.',
  ST_SetSRID(ST_MakePoint(25.8652, 36.828701), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Katapola Limanı (Amorgos)', 'Amorgos''un ana limanı. Kuzeye demir atıp kıçtan rıhtıma bağlanılır. Geniş koy kuzey-kuzeydoğuya açıktır; kuvvetli batı rüzgârında koyda dalga 1,5 m''yi bulabilir. Elektrik rıhtımda; yakıt mini tankerle; tersane, market, banka ve restoranlar vardır. Liman ücreti ~14 €/gece (12 m tekne, 2017), su ~5 €. Koyun karşı (kuzey) yakası Xilokeratidi balıkçı limanıdır.' FROM locations WHERE slug = 'katapola-limani-amorgos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'katapola-limani-amorgos' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;

-- --- Tourlos Marina (Mykonos Yeni Limanı) · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'tourlos-marina-mykonos', 2, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-mykonos'),
  'Tourlos Marina (Mykonos Yeni Limanı)', 'Mykonos''un yeni limanındaki yat bölümü; ~40 ponton yeri, maksimum boy 25 m, derinlik 3-5 m. İki giriş vardır (güney kırmızı, kuzey yeşil fener); güney rıhtım daha korunaklıdır. Su-elektrik pontonlarda; yakıt mini tankerle; Wi-Fi, duş-WC ve mekanik tamir bulunur. DİKKAT: meltem K/KB''den doğrudan marinaya eser — Mykonos, Kikladlar''ın en rüzgârlı adalarındandır. Kasabaya 20 dk yürüyüş ya da otobüs.',
  ST_SetSRID(ST_MakePoint(25.322599, 37.465302), 4326)::geography,
  25, NULL, 3, 5,
  40, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Tourlos Marina (Mykonos Yeni Limanı)', 'Mykonos''un yeni limanındaki yat bölümü; ~40 ponton yeri, maksimum boy 25 m, derinlik 3-5 m. İki giriş vardır (güney kırmızı, kuzey yeşil fener); güney rıhtım daha korunaklıdır. Su-elektrik pontonlarda; yakıt mini tankerle; Wi-Fi, duş-WC ve mekanik tamir bulunur. DİKKAT: meltem K/KB''den doğrudan marinaya eser — Mykonos, Kikladlar''ın en rüzgârlı adalarındandır. Kasabaya 20 dk yürüyüş ya da otobüs.' FROM locations WHERE slug = 'tourlos-marina-mykonos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 40, '12', NULL, NULL, NULL
FROM locations WHERE slug = 'tourlos-marina-mykonos'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'tourlos-marina-mykonos' AND a.code IN ('electricity', 'water', 'fuel', 'wifi', 'shower', 'wc')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'tourlos-marina-mykonos' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302289022218', NULL, true
FROM locations l WHERE l.slug = 'tourlos-marina-mykonos'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Naoussa Limanı (Paros) · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'naoussa-limani-paros', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-paros'),
  'Naoussa Limanı (Paros)', 'Paros''un kuzeyindeki şirin balıkçı kasabası. Rıhtımda 3-5 m, dış kesimde 4-10 m; çamur-kum-yosun zemin iyi tutar; ~70 yer vardır. Meltemden iyi korunur; ama her yönden kuvvetli rüzgâr bağlamayı rahatsız eder. DİKKAT: rıhtımın bazı bölümlerinde su altı kaya çıkıntısı ve doğu-batı uzanan zincir vardır; feribot alanı boş bırakılır; yerin çoğunu yerel balıkçı tekneleri tutar. Yakıt mini tankerle; tamir/tersane, market ve restoranlar vardır. Çevre koylar (Langeri, Ag. Ioannou, Plastira) alternatif demirleme sunar.',
  ST_SetSRID(ST_MakePoint(25.237101, 37.124001), 4326)::geography,
  NULL, NULL, 3, 5,
  70, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Naoussa Limanı (Paros)', 'Paros''un kuzeyindeki şirin balıkçı kasabası. Rıhtımda 3-5 m, dış kesimde 4-10 m; çamur-kum-yosun zemin iyi tutar; ~70 yer vardır. Meltemden iyi korunur; ama her yönden kuvvetli rüzgâr bağlamayı rahatsız eder. DİKKAT: rıhtımın bazı bölümlerinde su altı kaya çıkıntısı ve doğu-batı uzanan zincir vardır; feribot alanı boş bırakılır; yerin çoğunu yerel balıkçı tekneleri tutar. Yakıt mini tankerle; tamir/tersane, market ve restoranlar vardır. Çevre koylar (Langeri, Ag. Ioannou, Plastira) alternatif demirleme sunar.' FROM locations WHERE slug = 'naoussa-limani-paros'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'naoussa-limani-paros' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'naoussa-limani-paros' AND sv.code IN ('technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302284052646', NULL, true
FROM locations l WHERE l.slug = 'naoussa-limani-paros'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- İdra (Hydra) Limanı · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'hydra-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-hydra'),
  'İdra (Hydra) Limanı', 'Saronik''in incisi, arabasız ada İdra''nın taş limanı. VHF 12. Su, elektrik ve yakıt vardır. DİKKAT: zemin ot-kaya-çamur karışımı ve TUTUŞ ZAYIFTIR; kuzeybatı rüzgârı tehlikeli dalgalanma yapar — K/KD rüzgârında kuzey mendireği tercih edilir. Yoğunluk (kaynaklı): yaz aylarında aşırı kalabalıktır, tekneler rıhtıma ÜÇ SIRA aborda bağlanır; dar girişte feribot ve hidrofiller hızlı geçer. Erken saatte gelin.',
  ST_SetSRID(ST_MakePoint(23.4659, 37.350601), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'İdra (Hydra) Limanı', 'Saronik''in incisi, arabasız ada İdra''nın taş limanı. VHF 12. Su, elektrik ve yakıt vardır. DİKKAT: zemin ot-kaya-çamur karışımı ve TUTUŞ ZAYIFTIR; kuzeybatı rüzgârı tehlikeli dalgalanma yapar — K/KD rüzgârında kuzey mendireği tercih edilir. Yoğunluk (kaynaklı): yaz aylarında aşırı kalabalıktır, tekneler rıhtıma ÜÇ SIRA aborda bağlanır; dar girişte feribot ve hidrofiller hızlı geçer. Erken saatte gelin.' FROM locations WHERE slug = 'hydra-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'hydra-limani' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302298052279', NULL, true
FROM locations l WHERE l.slug = 'hydra-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Egina (Aegina) Limanı · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'aegina-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-egina'),
  'Egina (Aegina) Limanı', 'Atina''ya en yakın adalardan Egina''nın ana limanı; batı mendireğindeki beyaz şapel uzaktan seçilir. Kanalda 8-9 m; zemin kaya+çamur. Girişte sancak tarafı marinadır; pontonlara dik bağlanılır; rıhtımda şamandıralı bağlama vardır (güney mendireği charter teknelerine ayrılır). VHF 12. Su, elektrik ve mini tankerle yakıt. Her yönden iyi korunur; güneyli rüzgâr rahatsız soluğan sokar; kuvvetli KB rüzgârında DGD kesiminde bağlama tehlikelidir — zinciri tam kaçırın. DİKKAT: feribot/hidrofil trafiği hızlıdır. Kuzeyde N. Metopi yönünde sığlık uzanır.',
  ST_SetSRID(ST_MakePoint(23.426901, 37.745098), 4326)::geography,
  NULL, NULL, 8, 9,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Egina (Aegina) Limanı', 'Atina''ya en yakın adalardan Egina''nın ana limanı; batı mendireğindeki beyaz şapel uzaktan seçilir. Kanalda 8-9 m; zemin kaya+çamur. Girişte sancak tarafı marinadır; pontonlara dik bağlanılır; rıhtımda şamandıralı bağlama vardır (güney mendireği charter teknelerine ayrılır). VHF 12. Su, elektrik ve mini tankerle yakıt. Her yönden iyi korunur; güneyli rüzgâr rahatsız soluğan sokar; kuvvetli KB rüzgârında DGD kesiminde bağlama tehlikelidir — zinciri tam kaçırın. DİKKAT: feribot/hidrofil trafiği hızlıdır. Kuzeyde N. Metopi yönünde sığlık uzanır.' FROM locations WHERE slug = 'aegina-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'aegina-limani' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+302297022328', NULL, true
FROM locations l WHERE l.slug = 'aegina-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Spetses Baltiza (Eski Liman) · güven: high · kaynak: www.sea-seek.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'spetses-baltiza-limani', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-spetses'),
  'Spetses Baltiza (Eski Liman)', 'Spetses''in geleneksel kayık tersaneleriyle çevrili eski limanı; doğu girişini Ak Fanari feneri işaretler. İç havza çamur zeminde iyi tutar ve TAM korunak sağlar; kıyıya bağlanılabilir. Dış liman kuvvetli KB rüzgârında rahatsızdır; güneybatı köşesinde büyük sahipsiz zincir vardır — demiri oraya atmayın. Yakıt, su ve elektrik vardır. Sezonda iç havza tıkanır. DİKKAT: Spetses ile Spetsopoula adası arasında çok sayıda resif vardır.',
  ST_SetSRID(ST_MakePoint(23.164801, 37.262199), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Spetses Baltiza (Eski Liman)', 'Spetses''in geleneksel kayık tersaneleriyle çevrili eski limanı; doğu girişini Ak Fanari feneri işaretler. İç havza çamur zeminde iyi tutar ve TAM korunak sağlar; kıyıya bağlanılabilir. Dış liman kuvvetli KB rüzgârında rahatsızdır; güneybatı köşesinde büyük sahipsiz zincir vardır — demiri oraya atmayın. Yakıt, su ve elektrik vardır. Sezonda iç havza tıkanır. DİKKAT: Spetses ile Spetsopoula adası arasında çok sayıda resif vardır.' FROM locations WHERE slug = 'spetses-baltiza-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'spetses-baltiza-limani' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;

-- --- Pera Gialos Limanı (Astypalaia) · güven: medium · kaynak: www.imaps.gr ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'astypalaia-pera-gialos', 3, 'published', 'GR',
  (SELECT id FROM admin_areas WHERE country_code = 'GR' AND level = 'province' AND slug = 'gr-astypalaia'),
  'Pera Gialos Limanı (Astypalaia)', 'Kelebek biçimli Astypalaia''nın Chora''nın eteğindeki geleneksel limanı. Ana feribot trafiği yeni Agios Andreas limanına taşındı; Pera Gialos''ta son yıllarda yelkenliler için küçük bir marina düzeni kuruldu; Kalymnos''tan yerel feribot yanaşır. Beyaz Chora evleri ve kale limanın hemen üzerindedir.',
  ST_SetSRID(ST_MakePoint(26.355408, 36.54716), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Pera Gialos Limanı (Astypalaia)', 'Kelebek biçimli Astypalaia''nın Chora''nın eteğindeki geleneksel limanı. Ana feribot trafiği yeni Agios Andreas limanına taşındı; Pera Gialos''ta son yıllarda yelkenliler için küçük bir marina düzeni kuruldu; Kalymnos''tan yerel feribot yanaşır. Beyaz Chora evleri ve kale limanın hemen üzerindedir.' FROM locations WHERE slug = 'astypalaia-pera-gialos'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;

-- --- Azmak İskelesi (Çiftlik Koyu) · güven: medium · kaynak: sail-friend.club ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'azmak-iskelesi-ciftlik', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Azmak İskelesi (Çiftlik Koyu)', 'Marmaris Çiftlik koyunun kuzeybatı yakasındaki restoran iskelesi. T-biçimli iskele hazır tonozludur (mooring line); su ve elektrik bağlanır. VHF 16''dan ''Azmak Jetty'' çağrılır. Kaynağa göre kapasite ~100 tekne, maksimum boy 10 m, maksimum su çekimi 5 m. Restoran ve bar hizmet verir.',
  ST_SetSRID(ST_MakePoint(28.238285, 36.716057), 4326)::geography,
  10, 5, NULL, NULL,
  100, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Azmak İskelesi (Çiftlik Koyu)', 'Marmaris Çiftlik koyunun kuzeybatı yakasındaki restoran iskelesi. T-biçimli iskele hazır tonozludur (mooring line); su ve elektrik bağlanır. VHF 16''dan ''Azmak Jetty'' çağrılır. Kaynağa göre kapasite ~100 tekne, maksimum boy 10 m, maksimum su çekimi 5 m. Restoran ve bar hizmet verir.' FROM locations WHERE slug = 'azmak-iskelesi-ciftlik'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, 100, NULL, NULL
FROM locations WHERE slug = 'azmak-iskelesi-ciftlik'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'azmak-iskelesi-ciftlik' AND a.code IN ('restaurant', 'water', 'electricity')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'azmak-iskelesi-ciftlik' AND sv.code IN ('mooring_assist')
ON CONFLICT DO NOTHING;

-- --- Karia Bel' Otel İskelesi (Bozburun) · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'karia-bel-iskelesi-bozburun', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Karia Bel'' Otel İskelesi (Bozburun)', 'Bozburun''da otel-restoran iskelesi; pontonlara yanaşılır, restoranda ağırlanırsınız. Ana binada 16 oda, üç dakika tekne mesafesindeki Beach House''ta 10 oda + 1 süit vardır. Bozburun köy merkezine tekneyle birkaç dakika.',
  ST_SetSRID(ST_MakePoint(28.048696, 36.67595), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Karia Bel'' Otel İskelesi (Bozburun)', 'Bozburun''da otel-restoran iskelesi; pontonlara yanaşılır, restoranda ağırlanırsınız. Ana binada 16 oda, üç dakika tekne mesafesindeki Beach House''ta 10 oda + 1 süit vardır. Bozburun köy merkezine tekneyle birkaç dakika.' FROM locations WHERE slug = 'karia-bel-iskelesi-bozburun'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'karia-bel-iskelesi-bozburun'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'karia-bel-iskelesi-bozburun' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524562056', NULL, true
FROM locations l WHERE l.slug = 'karia-bel-iskelesi-bozburun'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@kariabel.com', NULL, false
FROM locations l WHERE l.slug = 'karia-bel-iskelesi-bozburun'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://kariabel.com/', NULL, false
FROM locations l WHERE l.slug = 'karia-bel-iskelesi-bozburun'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Nuri's Beach İskelesi (Limanağzı) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'nuris-beach-iskelesi-kas', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-kas'),
  'Nuri''s Beach İskelesi (Limanağzı)', 'Kaş Limanağzı koyundaki plaj-restoran iskelesi; karadan yol yoktur, yalnız denizden ulaşılır. İskele TÜM TEKNELERE ÜCRETSİZDİR; elektrik, su, duş, WC ve soyunma kabinleri de ücretsizdir; Wi-Fi vardır. Akdeniz ve Türk mutfağı sunar; bungalov konaklama ve plaj barı bulunur; koyda caretta görülebilir.',
  ST_SetSRID(ST_MakePoint(29.650217, 36.172594), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Nuri''s Beach İskelesi (Limanağzı)', 'Kaş Limanağzı koyundaki plaj-restoran iskelesi; karadan yol yoktur, yalnız denizden ulaşılır. İskele TÜM TEKNELERE ÜCRETSİZDİR; elektrik, su, duş, WC ve soyunma kabinleri de ücretsizdir; Wi-Fi vardır. Akdeniz ve Türk mutfağı sunar; bungalov konaklama ve plaj barı bulunur; koyda caretta görülebilir.' FROM locations WHERE slug = 'nuris-beach-iskelesi-kas'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'nuris-beach-iskelesi-kas'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'nuris-beach-iskelesi-kas' AND a.code IN ('restaurant', 'water', 'electricity', 'shower', 'wc', 'wifi')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902428363816', NULL, true
FROM locations l WHERE l.slug = 'nuris-beach-iskelesi-kas'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@nurisbeach.com', NULL, false
FROM locations l WHERE l.slug = 'nuris-beach-iskelesi-kas'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://nurisbeach.com/', NULL, false
FROM locations l WHERE l.slug = 'nuris-beach-iskelesi-kas'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Adaköy Marina · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'adakoy-marina-marmaris', 1, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Adaköy Marina', 'Marmaris Adaköy yarımadasında özel marina; 200 bağlama yeri — 150 m''ye kadar teknelere kıçtan ya da aborda. VHF 73. 400 amperlik elektrik altyapısı, içme suyu, 75 ton kapasiteli travel lift ve 15.000 m² beton kara sahası; 7/24 güvenlik ve CCTV. Yat kulübü, restoran-bar, havuz, spor salonu ve tenis kortları vardır.',
  ST_SetSRID(ST_MakePoint(28.292989, 36.819405), 4326)::geography,
  150, NULL, NULL, NULL,
  200, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Adaköy Marina', 'Marmaris Adaköy yarımadasında özel marina; 200 bağlama yeri — 150 m''ye kadar teknelere kıçtan ya da aborda. VHF 73. 400 amperlik elektrik altyapısı, içme suyu, 75 ton kapasiteli travel lift ve 15.000 m² beton kara sahası; 7/24 güvenlik ve CCTV. Yat kulübü, restoran-bar, havuz, spor salonu ve tenis kortları vardır.' FROM locations WHERE slug = 'adakoy-marina-marmaris'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO marina_details (location_id, berth_count, vhf_channel, has_blue_flag,
  travel_lift_capacity_tons, winter_storage)
SELECT id, 200, '73', NULL, NULL, NULL
FROM locations WHERE slug = 'adakoy-marina-marmaris'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'adakoy-marina-marmaris' AND a.code IN ('electricity', 'water', 'security', 'restaurant', 'travel_lift')
ON CONFLICT DO NOTHING;
INSERT INTO location_services (location_id, service_id)
SELECT l.id, sv.id FROM locations l, services sv
WHERE l.slug = 'adakoy-marina-marmaris' AND sv.code IN ('winter_storage', 'technical_service')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902524125555', NULL, true
FROM locations l WHERE l.slug = 'adakoy-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@adakoymarina.com', NULL, false
FROM locations l WHERE l.slug = 'adakoy-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://adakoymarina.com/', NULL, false
FROM locations l WHERE l.slug = 'adakoy-marina-marmaris'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Aydıncık Balıkçı Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'aydincik-balikci-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-aydincik'),
  'Aydıncık Balıkçı Limanı', 'Silifke''nin 75 km batısında, antik Kelenderis''in limanı; 110 tekne, rıhtımda 3,8-4 m su; kum-çamur zemin. VHF 73''ten ''Aydıncık Harbour'' çağrılır. İçme suyu, elektrik, yakıt, çekek yeri, WC-duş ve dükkanlar vardır. Fener 9,5 mil görünürlüktedir. Alanya-Taşucu hattının ortasındaki ana sığınaktır.',
  ST_SetSRID(ST_MakePoint(33.32575, 36.145639), 4326)::geography,
  NULL, NULL, 3.8, 4,
  110, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Aydıncık Balıkçı Limanı', 'Silifke''nin 75 km batısında, antik Kelenderis''in limanı; 110 tekne, rıhtımda 3,8-4 m su; kum-çamur zemin. VHF 73''ten ''Aydıncık Harbour'' çağrılır. İçme suyu, elektrik, yakıt, çekek yeri, WC-duş ve dükkanlar vardır. Fener 9,5 mil görünürlüktedir. Alanya-Taşucu hattının ortasındaki ana sığınaktır.' FROM locations WHERE slug = 'aydincik-balikci-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'aydincik-balikci-limani' AND a.code IN ('electricity', 'water', 'fuel', 'wc', 'shower')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+903248413050', NULL, true
FROM locations l WHERE l.slug = 'aydincik-balikci-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'belediye@mersinaydincik.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'aydincik-balikci-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Anamur İskelesi · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'anamur-iskelesi', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-anamur'),
  'Anamur İskelesi', 'Türkiye''nin en güney ucu Anamur Burnu''nun doğusundaki kasaba iskelesi. VHF 16''dan ''Anamur İskele'' çağrılır. Kasabada tamirhane, teknik malzeme dükkanları, otel-pansiyon, restoran, eczane ve banka vardır; Anemurion antik kenti ve Mamure Kalesi yakındır. DİKKAT: bölge caretta caretta yuvalama alanıdır — plajlarda gece kısıtlamaları olabilir.',
  ST_SetSRID(ST_MakePoint(32.868, 36.068278), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Anamur İskelesi', 'Türkiye''nin en güney ucu Anamur Burnu''nun doğusundaki kasaba iskelesi. VHF 16''dan ''Anamur İskele'' çağrılır. Kasabada tamirhane, teknik malzeme dükkanları, otel-pansiyon, restoran, eczane ve banka vardır; Anemurion antik kenti ve Mamure Kalesi yakındır. DİKKAT: bölge caretta caretta yuvalama alanıdır — plajlarda gece kısıtlamaları olabilir.' FROM locations WHERE slug = 'anamur-iskelesi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+903248141115', NULL, true
FROM locations l WHERE l.slug = 'anamur-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'halklailiskiler@anamur.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'anamur-iskelesi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Alanya Balıkçı Limanı · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'alanya-balikci-limani', 3, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-alanya'),
  'Alanya Balıkçı Limanı', 'Alanya kalesinin altındaki belediye balıkçı limanı; 550 m dış + 240 m iç mendirek, 125 tekne. Rıhtımda su, elektrik ve motorin-benzin pompası vardır; derinlik ~3 m. VHF 16''dan ''Alanya Harbour'' çağrılır. 209 m odak düzlemli Alanya feneri 20 milden görünür. Alanya Marina 2,5 mil batıdadır (ayrı kayıt).',
  ST_SetSRID(ST_MakePoint(32.00386, 36.539532), 4326)::geography,
  NULL, NULL, 3, 3,
  125, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Alanya Balıkçı Limanı', 'Alanya kalesinin altındaki belediye balıkçı limanı; 550 m dış + 240 m iç mendirek, 125 tekne. Rıhtımda su, elektrik ve motorin-benzin pompası vardır; derinlik ~3 m. VHF 16''dan ''Alanya Harbour'' çağrılır. 209 m odak düzlemli Alanya feneri 20 milden görünür. Alanya Marina 2,5 mil batıdadır (ayrı kayıt).' FROM locations WHERE slug = 'alanya-balikci-limani'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'alanya-balikci-limani' AND a.code IN ('electricity', 'water', 'fuel')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902424448207', NULL, true
FROM locations l WHERE l.slug = 'alanya-balikci-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'kultur@alanya.bel.tr', NULL, false
FROM locations l WHERE l.slug = 'alanya-balikci-limani'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Mamure Kalesi Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'mamure-kalesi-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-anamur'),
  'Mamure Kalesi Koyu', 'Anamur''un doğusunda, denize sıfır ortaçağ kalesi Mamure''nin önündeki açık demirleme. Anamur iskelesi ~2 mil batıdadır. Bölge caretta caretta yuvalama alanıdır — kıyı kullanımında gece kısıtlamaları olabilir.',
  ST_SetSRID(ST_MakePoint(32.896323, 36.081569), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Mamure Kalesi Koyu', 'Anamur''un doğusunda, denize sıfır ortaçağ kalesi Mamure''nin önündeki açık demirleme. Anamur iskelesi ~2 mil batıdadır. Bölge caretta caretta yuvalama alanıdır — kıyı kullanımında gece kısıtlamaları olabilir.' FROM locations WHERE slug = 'mamure-kalesi-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'mamure-kalesi-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Hisarönü Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'hisaronu-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Hisarönü Koyu', 'Hisarönü Körfezi''nin iç ucunda, körfeze adını veren köyün önündeki geniş, sığ koy; kiremit rengi kumlu deniz uzun süre bel hizasında ilerler. Kıyıda iskele, market, kafeterya, restoran, WC-duş ve köy pazarı; hemen yanında 5.000 çadırlık Çubucak orman kampı vardır. Bölge rüzgârlıdır — sörfçülerin tercihi; demirlemede meltemi hesaba katın. Komşu duraklar: İnbükü, Kartal koyu, Tavşan adası, Bencik.',
  ST_SetSRID(ST_MakePoint(28.128341, 36.794572), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Hisarönü Koyu', 'Hisarönü Körfezi''nin iç ucunda, körfeze adını veren köyün önündeki geniş, sığ koy; kiremit rengi kumlu deniz uzun süre bel hizasında ilerler. Kıyıda iskele, market, kafeterya, restoran, WC-duş ve köy pazarı; hemen yanında 5.000 çadırlık Çubucak orman kampı vardır. Bölge rüzgârlıdır — sörfçülerin tercihi; demirlemede meltemi hesaba katın. Komşu duraklar: İnbükü, Kartal koyu, Tavşan adası, Bencik.' FROM locations WHERE slug = 'hisaronu-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, 'sand', NULL, true
FROM locations WHERE slug = 'hisaronu-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Günlüklü Koyu · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'gunluklu-koyu-demirleme', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-fethiye'),
  'Günlüklü Koyu', 'Fethiye ile Göcek arasında, adını kıyısını saran sığla (günlük) ormanından alan koy. ~10 m''ye demirlenir; ince çakıl-kum plajdan sonra deniz hızla derinleşir. Kıyıda tatlı su kuyusu ve tekneye su dolumu; kamp alanı, duş-WC ve The Bay Beach Club (46 bungalov, havuz, spa) vardır. Hafta sonları yerel ziyaretçilerle yoğunlaşır.',
  ST_SetSRID(ST_MakePoint(29.018506, 36.712994), 4326)::geography,
  NULL, NULL, 10, 10,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Günlüklü Koyu', 'Fethiye ile Göcek arasında, adını kıyısını saran sığla (günlük) ormanından alan koy. ~10 m''ye demirlenir; ince çakıl-kum plajdan sonra deniz hızla derinleşir. Kıyıda tatlı su kuyusu ve tekneye su dolumu; kamp alanı, duş-WC ve The Bay Beach Club (46 bungalov, havuz, spa) vardır. Hafta sonları yerel ziyaretçilerle yoğunlaşır.' FROM locations WHERE slug = 'gunluklu-koyu-demirleme'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'gunluklu-koyu-demirleme'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kayabaşı Restaurant (Mazı) · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kayabasi-restaurant-mazi', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-bodrum'),
  'Kayabaşı Restaurant (Mazı)', 'Gökova''nın kuzey kıyısında, Mazı koyunda 1959''dan beri hizmet veren balık restoranı; turizm öncesinde köyün balıkçı iskelesiydi. Kırsal kahvaltı, günlük balık ve yerel zeytinyağlı yemekler sunar. Gökova turlarının bilinen yemek durağıdır.',
  ST_SetSRID(ST_MakePoint(27.745775, 36.998075), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kayabaşı Restaurant (Mazı)', 'Gökova''nın kuzey kıyısında, Mazı koyunda 1959''dan beri hizmet veren balık restoranı; turizm öncesinde köyün balıkçı iskelesiydi. Kırsal kahvaltı, günlük balık ve yerel zeytinyağlı yemekler sunar. Gökova turlarının bilinen yemek durağıdır.' FROM locations WHERE slug = 'kayabasi-restaurant-mazi'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'kayabasi-restaurant-mazi'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kayabasi-restaurant-mazi' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+902523392050', NULL, true
FROM locations l WHERE l.slug = 'kayabasi-restaurant-mazi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://kayabasirestaurant.com/', NULL, false
FROM locations l WHERE l.slug = 'kayabasi-restaurant-mazi'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Cennet Marine Yacht Club (Turgutköy) · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'cennet-marine-yacht-club', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Cennet Marine Yacht Club (Turgutköy)', 'Hisarönü Körfezi''nde Turgutköy kıyısında otel-restoran iskelesi; iskeleye bağlanan tekne misafirleri otel olanaklarını kullanır. 14 odalı tesiste restoran (Türk-Akdeniz mutfağı, balık), havuz ve plaj vardır. Marmaris''e denizden 50 mil karadan 25 km; Symi''ye 15, Datça''ya 20 mildir.',
  ST_SetSRID(ST_MakePoint(28.129472, 36.753066), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Cennet Marine Yacht Club (Turgutköy)', 'Hisarönü Körfezi''nde Turgutköy kıyısında otel-restoran iskelesi; iskeleye bağlanan tekne misafirleri otel olanaklarını kullanır. 14 odalı tesiste restoran (Türk-Akdeniz mutfağı, balık), havuz ve plaj vardır. Marmaris''e denizden 50 mil karadan 25 km; Symi''ye 15, Datça''ya 20 mildir.' FROM locations WHERE slug = 'cennet-marine-yacht-club'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'cennet-marine-yacht-club'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'cennet-marine-yacht-club' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905322517107', NULL, true
FROM locations l WHERE l.slug = 'cennet-marine-yacht-club'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'info@cennetyachtclub.com', NULL, false
FROM locations l WHERE l.slug = 'cennet-marine-yacht-club'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://cennetyachtclub.com/', NULL, false
FROM locations l WHERE l.slug = 'cennet-marine-yacht-club'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Kuzbükü Yacht Club · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kuzbuku-yacht-club', 5, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Kuzbükü Yacht Club', 'Hisarönü Kuzbükü koyundaki iskeleli restoran-lounge. VHF 77''den çağrılır. Issız Kuzbükü demirlemesinin (ayrı kayıt) kıyı tesisidir; Bozburun''a 2,5 km yol bağlantısı vardır.',
  ST_SetSRID(ST_MakePoint(28.024444, 36.706111), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'paid', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kuzbükü Yacht Club', 'Hisarönü Kuzbükü koyundaki iskeleli restoran-lounge. VHF 77''den çağrılır. Issız Kuzbükü demirlemesinin (ayrı kayıt) kıyı tesisidir; Bozburun''a 2,5 km yol bağlantısı vardır.' FROM locations WHERE slug = 'kuzbuku-yacht-club'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO restaurant_dock_details (location_id, cuisine, berth_count_free, min_spend_policy, reservation_recommended)
SELECT id, NULL, NULL, NULL, NULL
FROM locations WHERE slug = 'kuzbuku-yacht-club'
ON CONFLICT (location_id) DO NOTHING;
INSERT INTO location_amenities (location_id, amenity_id)
SELECT l.id, a.id FROM locations l, amenities a
WHERE l.slug = 'kuzbuku-yacht-club' AND a.code IN ('restaurant')
ON CONFLICT DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'phone', '+905365017230', NULL, true
FROM locations l WHERE l.slug = 'kuzbuku-yacht-club'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'email', 'kaptan@kuzbuku.com', NULL, false
FROM locations l WHERE l.slug = 'kuzbuku-yacht-club'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;
INSERT INTO location_contacts (id, location_id, contact_type, value, label, is_primary)
SELECT gen_random_uuid(), l.id, 'website', 'https://kuzbuku.com/', NULL, false
FROM locations l WHERE l.slug = 'kuzbuku-yacht-club'
ON CONFLICT (location_id, contact_type, value) DO NOTHING;

-- --- Boncuk Koyu (Gökova) · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'boncuk-koyu-camli', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Boncuk Koyu (Gökova)', 'Gökova''nın güneydoğusunda, Sedir Adası yakınında korunaklı koy. ÖNEMLİ — KORUMA ALANI: koy, Akdeniz''in nadir kum köpekbalığı (Carcharhinus plumbeus) üreme alanıdır; 2010''dan beri balık avına kapalıdır ve üreme dönemi NİSAN-MAYIS-HAZİRAN aylarında ziyarete KAPATILIR. Köpekbalıkları insana zararsız ve ürkektir. Sezon dışında girişte ücret alınabilir (özel işletme kıyısı).',
  ST_SetSRID(ST_MakePoint(28.212655, 36.97682), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Boncuk Koyu (Gökova)', 'Gökova''nın güneydoğusunda, Sedir Adası yakınında korunaklı koy. ÖNEMLİ — KORUMA ALANI: koy, Akdeniz''in nadir kum köpekbalığı (Carcharhinus plumbeus) üreme alanıdır; 2010''dan beri balık avına kapalıdır ve üreme dönemi NİSAN-MAYIS-HAZİRAN aylarında ziyarete KAPATILIR. Köpekbalıkları insana zararsız ve ürkektir. Sezon dışında girişte ücret alınabilir (özel işletme kıyısı).' FROM locations WHERE slug = 'boncuk-koyu-camli'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'boncuk-koyu-camli'
ON CONFLICT (location_id) DO NOTHING;

-- --- Kameriye Adası · güven: high · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'kameriye-adasi-selimiye', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mugla-marmaris'),
  'Kameriye Adası', 'Selimiye açıklarında, 1.800 yıllık Ortodoks kilisesi ve manastır kalıntılarıyla ünlü adacık; Bozburun''a 20 dk. İyi havada güney yakasında ÖĞLE MOLASI demirlemesi ve şnorkelle yüzme için uygundur; gece için uygun değildir — Dirsek koyu önerilir. Yoğunluk (kaynaklı): sezonda günde ~1.000 ziyaretçi gelir; dilek ağacı ve mozaikler kalabalık çeker.',
  ST_SetSRID(ST_MakePoint(28.053117, 36.7301), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Kameriye Adası', 'Selimiye açıklarında, 1.800 yıllık Ortodoks kilisesi ve manastır kalıntılarıyla ünlü adacık; Bozburun''a 20 dk. İyi havada güney yakasında ÖĞLE MOLASI demirlemesi ve şnorkelle yüzme için uygundur; gece için uygun değildir — Dirsek koyu önerilir. Yoğunluk (kaynaklı): sezonda günde ~1.000 ziyaretçi gelir; dilek ağacı ve mozaikler kalabalık çeker.' FROM locations WHERE slug = 'kameriye-adasi-selimiye'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'kameriye-adasi-selimiye'
ON CONFLICT (location_id) DO NOTHING;

-- --- Yakacık Koyu (Gazipaşa) · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'yakacik-koyu-gazipasa', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'antalya-gazipasa'),
  'Yakacık Koyu (Gazipaşa)', 'Gazipaşa''nın doğusunda, Kaledran deresinin batısındaki koy; muz bahçeleriyle çevrili köyün önünde doğal plajlar vardır. Alanya-Anamur hattında ara mola noktasıdır.',
  ST_SetSRID(ST_MakePoint(32.560166, 36.096114), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Yakacık Koyu (Gazipaşa)', 'Gazipaşa''nın doğusunda, Kaledran deresinin batısındaki koy; muz bahçeleriyle çevrili köyün önünde doğal plajlar vardır. Alanya-Anamur hattında ara mola noktasıdır.' FROM locations WHERE slug = 'yakacik-koyu-gazipasa'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'yakacik-koyu-gazipasa'
ON CONFLICT (location_id) DO NOTHING;

-- --- Soğuksu Koyu (Aydıncık) · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'soguksu-koyu-aydincik', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-aydincik'),
  'Soğuksu Koyu (Aydıncık)', 'Aydıncık''ın hemen batısında, Soğuksu deresinin denize döküldüğü küçük koy. Aydıncık balıkçı limanı (ayrı kayıt) ~2 mil doğudadır.',
  ST_SetSRID(ST_MakePoint(33.289661, 36.13235), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Soğuksu Koyu (Aydıncık)', 'Aydıncık''ın hemen batısında, Soğuksu deresinin denize döküldüğü küçük koy. Aydıncık balıkçı limanı (ayrı kayıt) ~2 mil doğudadır.' FROM locations WHERE slug = 'soguksu-koyu-aydincik'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'soguksu-koyu-aydincik'
ON CONFLICT (location_id) DO NOTHING;

-- --- Sipahili Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'sipahili-koyu-gulnar', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-gulnar'),
  'Sipahili Koyu', 'Gülnar kıyısında, dere ağzının doğu yakasındaki koy; D-400 sahil yolu hemen ardından geçer. Aydıncık-Taşucu arasında ara mola noktasıdır.',
  ST_SetSRID(ST_MakePoint(33.461762, 36.159085), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Sipahili Koyu', 'Gülnar kıyısında, dere ağzının doğu yakasındaki koy; D-400 sahil yolu hemen ardından geçer. Aydıncık-Taşucu arasında ara mola noktasıdır.' FROM locations WHERE slug = 'sipahili-koyu-gulnar'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'sipahili-koyu-gulnar'
ON CONFLICT (location_id) DO NOTHING;

-- --- Büyükeceli Koyu · güven: medium · kaynak: turkeymarinas.blogspot.com ---
INSERT INTO locations (id, slug, location_type_id, status, country_code, admin_area_id,
  name, description, position, max_boat_length_m, max_draft_m, depth_min_m, depth_max_m,
  capacity, price_tier, source)
SELECT gen_random_uuid(), 'buyukeceli-koyu-gulnar', 8, 'published', 'TR',
  (SELECT id FROM admin_areas WHERE country_code = 'TR' AND level = 'district' AND slug = 'mersin-gulnar'),
  'Büyükeceli Koyu', 'Gülnar Büyükeceli köyünün koyu; kıyıya 3 km''lik vadiyle bağlanır. Doğusunda Bölükada feneri (iki beyaz çakar/5 sn, 18 mil) seyir referansıdır.',
  ST_SetSRID(ST_MakePoint(33.575833, 36.156028), 4326)::geography,
  NULL, NULL, NULL, NULL,
  NULL, 'free', 'import'
ON CONFLICT (slug) DO NOTHING;
INSERT INTO location_i18n (location_id, locale, name, description)
SELECT id, 'tr', 'Büyükeceli Koyu', 'Gülnar Büyükeceli köyünün koyu; kıyıya 3 km''lik vadiyle bağlanır. Doğusunda Bölükada feneri (iki beyaz çakar/5 sn, 18 mil) seyir referansıdır.' FROM locations WHERE slug = 'buyukeceli-koyu-gulnar'
ON CONFLICT (location_id, locale) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description;
INSERT INTO anchorage_details (location_id, holding_type, swell_exposure, is_free)
SELECT id, NULL, NULL, true
FROM locations WHERE slug = 'buyukeceli-koyu-gulnar'
ON CONFLICT (location_id) DO NOTHING;

