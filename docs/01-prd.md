# Dockly — Product Requirements Document (PRD)

> **Doküman No:** 01 · **Sürüm:** 1.0 · **Durum:** Onaylı (v1 kapsamı)
> **Bağlı olduğu kanonik doküman:** [`00-foundation.md`](./00-foundation.md) — çelişki hâlinde foundation geçerlidir.
> **Kapsam:** Dockly v1 (yalnızca Türkiye, `country_code = TR`, B2C — yalnızca tekne sahipleri)

---

## 1. Vizyon ve Misyon

### 1.1 Vizyon
Türkiye kıyılarındaki **her bağlama noktasını** — özel marinadan tek şamandıraya kadar — denizcinin cebinde, güvenilir, güncel ve topluluk tarafından beslenen tek bir haritada toplamak. Uzun vadede Akdeniz çanağının "denizcinin her gün açtığı harita uygulaması" olmak.

### 1.2 Misyon
Tekne sahibinin **"Bu koyda bağlanabilir miyim? Kaça? Elektrik var mı? Kime yazarım?"** sorularını 30 saniyede cevaplamak. Dockly bunu üç sütunla yapar:

1. **Keşif** — 9 `location_type` kategorisinde tüm bağlama noktaları, Mapbox haritası üzerinde.
2. **Topluluk** — yorum, puan, fotoğraf, yeni nokta önerisi, hatalı bilgi bildirimi.
3. **Rezervasyon Talebi (request-only)** — bağlayıcı olmayan, Dockly operasyon ekibinin manuel işlediği talep akışı.

### 1.3 Konumlandırma cümlesi
> Google Maps + TripAdvisor + Booking.com hissi; **rezervasyon uygulaması gibi DEĞİL**, denizcinin her gün açtığı harita uygulaması gibi.

Uygulamanın açılış ekranı bir form ya da liste değil, **haritadır** (S-06). Rezervasyon talebi, keşif deneyiminin doğal bir devamı olarak sunulur; asla ana amaç gibi dayatılmaz.

---

## 2. Problem Tanımı

### 2.1 Mevcut durum
Türkiye'de tekne sahibi bir denizci bugün şu parçalanmış kaynaklarla yaşıyor:

| Kaynak | Sorun |
|---|---|
| Google Maps | Marinalar var ama belediye iskeleleri, restoran iskeleleri, şamandıralar, misafir bağlama noktaları yok ya da yanlış konumlu. Derinlik/maks. boy bilgisi yok. |
| WhatsApp / Facebook grupları | Bilgi güncel ama aranamaz, dağınık, doğrulanamaz. |
| Marina web siteleri | Sadece büyük özel marinalar; fiyat ve müsaitlik telefonla öğreniliyor. |
| Kâğıt kılavuzlar / pilot kitaplar | Yılda bir güncellenir, mobil değil. |
| Yabancı uygulamalar (Navily vb.) | Türkiye içeriği zayıf; belediye iskelesi/restoran iskelesi kültürünü modellemiyor. |

### 2.2 Kök problem
**Türkiye kıyılarındaki bağlama noktalarının %80'inden fazlası hiçbir dijital platformda yapılandırılmış veri olarak yok.** Var olan veri de tekne kısıtlarıyla (boy, su çekimi) eşleştirilemiyor. Sonuç: denizci koya girmeden yer olup olmadığını, teknesinin sığıp sığmayacağını, elektrik/su olup olmadığını bilmiyor.

### 2.3 Fırsat
- Türkiye'de ~110.000 kayıtlı özel tekne; amatör denizci belgesi sahibi ~600.000 kişi.
- Kıyı şeridinde 60+ marina, yüzlerce belediye iskelesi, binlerce restoran iskelesi ve şamandıra — hiçbiri tek çatı altında değil.
- Topluluk üretimi içerik (yorum + fotoğraf + öneri) veri açığını ölçeklenebilir şekilde kapatır; `suggestions` ve `reports` tabloları bu döngünün altyapısıdır.

---

## 3. Hedef Kitle ve Personalar

### 3.1 Segmentler
v1 hedef kitlesi **yalnızca tekne sahipleri (B2C)**'dir; marinalar müşteri DEĞİLDİR. Tekne sahipleri, `boat_type` enum'una dayalı 6 kullanım segmentine ayrılır:

| # | Segment | İlgili `boat_type` değerleri | Tipik davranış |
|---|---|---|---|
| 1 | Motoryat sahibi | `motor_yacht` | Hafta sonu kısa seyir, marina konforu arar |
| 2 | Yelkenli gezgini | `sailboat`, `catamaran` | Uzun seyir, koy/şamandıra odaklı, maliyet duyarlı |
| 3 | Günlük tekneci | `daily_boat`, `rib` | Gündüz çıkış, restoran iskelesi + yakıt iskelesi kullanıcısı |
| 4 | Balıkçı | `fishing_boat` | Sabah erken çıkış, belediye iskelesi/bağlama noktası kullanıcısı |
| 5 | Gulet / profesyonel işletici | `gulet` | Haftalık charter rotası, kapasite ve maks. boy kısıtı kritik |
| 6 | Süperyat / kaptanlı | `superyacht`, `other` | Kaptan kullanır; VHF kanalı, maks. su çekimi, teknik servis önemli |

### 3.2 Personalar (detaylı)

#### Persona 1 — "Hafta Sonu Kaptanı" Murat (42, İstanbul)
- **Tekne:** 2019 model 12,5 m motoryat (`boat_type = motor_yacht`, `engine_type = inboard_diesel`, `length_m = 12.50`, `draft_m = 1.10`)
- **Davranış:** Teknesi Fenerbahçe'de bağlı; cuma akşamı çıkıp Adalar–Erdek–Marmara hattında hafta sonu geçirir. Rotasını haritadan bakarak son dakika kurar. Konfor arar: elektrik (`electricity`), su (`water`), restoran (`restaurant`), güvenlik (`security`).
- **Pain point'ler:**
  - Gideceği belediye iskelesinin dolu olup olmadığını bilmiyor, telefon numarasını bulamıyor.
  - Google Maps'te iskele pini yanlış koyda; iki kez yanlış koya girdi.
  - Fiyat sürprizi: "ücretsiz sanıyordum, akşam para istediler" (`price_tier = unknown` problemi).
- **Dockly ile:** S-06 haritada `municipal_pier` ve `private_marina` pinlerini görür, S-09 detayda telefon + `vhf_channel` + `price_tier` bilgisine ulaşır, S-14 ile rezervasyon talebi bırakır.

#### Persona 2 — "Koydan Koya" Elif (35, İzmir)
- **Tekne:** 10,4 m yelkenli (`boat_type = sailboat`, `engine_type = sail_aux`, `draft_m = 1.90`)
- **Davranış:** Sezonda 6-8 haftalık seyir yapar; marina yerine korunaklı koy, şamandıra (`buoy`) ve misafir bağlama noktası (`guest_mooring`) tercih eder. Bütçe duyarlı; `price_tier = free` filtresini sürekli kullanır.
- **Pain point'ler:**
  - 1,90 m su çekimiyle hangi iskeleye yanaşabileceğini bilemiyor (`max_draft_m` verisi hiçbir yerde yok).
  - Şamandıraların kime ait olduğu, ücretli mi olduğu belirsiz.
  - Koy bilgisini Facebook gruplarından derliyor; arama yapamıyor.
- **Dockly ile:** S-08 filtrelerde `max_draft_m` uyumu + `price_tier = free` seçer; S-22 ile bildiği kayıtsız şamandıraları önerir (`suggestion_type = new_location`) — topluluğun en aktif içerik üreticisi profilidir.

#### Persona 3 — "Öğle Yemeği Rotası" Kaan (29, Bodrum)
- **Tekne:** 7,5 m günlük sürat teknesi (`boat_type = daily_boat`, `engine_type = outboard`)
- **Davranış:** Sabah çıkar, akşam döner. Kararları anlıktır: "bugün hangi restoran iskelesine gidelim?" Yakıt iskelesi (`fuel_pier`) konumları kritik. Fotoğrafa ve puana bakarak karar verir — TripAdvisor alışkanlığı.
- **Pain point'ler:**
  - Restoran iskelelerinin (`restaurant_pier`) hangilerinin tekneyle müşteri kabul ettiği bilinmiyor.
  - "İskeleye bağlarsan yemek zorunlu mu?" sorusunun cevabı yok — yorumlar bu bilgiyi taşımalı.
  - Yakıt iskelesi arayışında telefonla 3-4 yer arıyor.
- **Dockly ile:** S-07 aramada "restoran" yazar, S-09 detayda `rating_avg` + fotoğraf galerisi (S-10) + yorumlar (S-11) ile karar verir; navigasyonu tek dokunuşla başlatır.

#### Persona 4 — "Şafak Balıkçısı" Hasan (58, Çanakkale)
- **Tekne:** 8 m ahşap balıkçı teknesi (`boat_type = fishing_boat`, `engine_type = inboard_diesel`)
- **Davranış:** Teknolojiye mesafeli ama telefonda harita kullanır. Belediye iskelesi (`municipal_pier`) ve bağlama noktası (`mooring_point`) müdavimi. Uygulamaya kayıt olmadan bakmak ister → **misafir modu** birincil kullanıcısıdır.
- **Pain point'ler:**
  - Kayıt/şifre süreçleri caydırıcı; "önce göreyim, beğenirsem üye olurum".
  - Kıyı hattındaki küçük bağlama noktaları hiçbir haritada yok.
  - Yanlış bilgi gördüğünde düzeltecek kanal yok.
- **Dockly ile:** S-03'te **Misafir** ile girer, haritayı ve detayları özgürce gezer; yorum/talep/favori denediğinde kayıt duvarına yumuşak şekilde yönlendirilir (misafir→kayıtlı dönüşüm). Kayıt sonrası S-23 ile hatalı bilgi bildirir (`report_reason = wrong_position`).

#### Persona 5 — "Rota Ustası" Kaptan Serdar (47, Fethiye)
- **Tekne:** 24 m gulet (`boat_type = gulet`), haftalık charter işletir.
- **Davranış:** Sezonda her hafta aynı rotayı farklı misafir profiline göre varye eder. Kapasite (`capacity`), `max_boat_length_m` ve VHF kanalı (`vhf_channel`) olmazsa olmaz. Talebi 1-2 hafta önceden planlar; S-15 Taleplerim ekranını yoğun kullanır.
- **Pain point'ler:**
  - 24 m tekneyle hangi iskeleye sığacağını sezon başında tek tek telefonla teyit ediyor.
  - Talep/teyit süreçleri WhatsApp'ta kayboluyor; kayıt yok.
  - Misafir memnuniyeti için restoran iskelelerinin güncel puanına ihtiyacı var.
- **Dockly ile:** S-08 filtrede `max_boat_length_m ≥ 24` uyumlu noktaları görür; S-14 talep formunda tekne bilgisi otomatik dolar (`boats.is_primary`); S-21 bildirimlerle (`notification_type = booking_status`) talep durumunu takip eder.

#### Persona 6 — "Profesyonel Kaptan" Deniz (39, Göcek)
- **Tekne:** 38 m süperyat, sahibi adına kullanır (`boat_type = superyacht`, `draft_m = 3.20`)
- **Davranış:** Karar kriterleri teknik: `max_draft_m`, `travel_lift`, `technical_service`, `pump_out`, `crane`, 7/24 giriş (`open_24h` / `is_24h`). Telefon ve VHF ile ön teyit almadan asla yanaşmaz.
- **Pain point'ler:**
  - 3,20 m su çekimi için güvenilir derinlik/maks. su çekimi verisi yok.
  - Teknik servis ve travel lift kapasitesi bilgisi ancak telefonla öğreniliyor.
- **Dockly ile:** Amenity filtreleri (`travel_lift`, `technical_service`, `pump_out`) + `max_draft_m` ile ön eleme yapar; S-09'daki telefon/`vhf_channel` ile teyit eder. v1'de "canlı müsaitlik" beklemez — bunun v1'de olmadığı açıkça iletilir.

---

## 4. Değer Önerisi

| Kime | Vaat | Kanıt / mekanizma |
|---|---|---|
| Tüm tekne sahipleri | Türkiye'deki **tüm** bağlama noktaları tek haritada | 9 `location_type`, PostGIS tabanlı `locations` verisi, topluluk önerileriyle büyüyen kapsam |
| Bütçe duyarlı denizci | Sürprizsiz fiyat beklentisi | `price_tier` (`free`/`paid`/`unknown`) + topluluk yorumları |
| Büyük tekne / derin su çekimi | "Sığar mıyım?" sorusuna cevap | `max_boat_length_m`, `max_draft_m` + tekne profiliyle eşleşme |
| Plancı kullanıcı | Telefon trafiği yerine tek talep formu | `booking_requests` + `booking_status` bildirimleri |
| Topluluk katılımcısı | Katkısının haritaya işlendiğini görme | `suggestions`/`reports` → admin moderasyonu → yayın |

**Tek cümlelik değer önerisi:** *"Denizdeki her bağlama noktası, tek uygulamada."*

---

## 5. Ürün Felsefesi

1. **Harita önce gelir.** Uygulama haritaya açılır (S-06); liste, arama ve talep haritanın uydularıdır.
2. **Rezervasyon uygulaması gibi hissettirme.** CTA dili "Talep bırak"tır, "Rezervasyon yap" değildir; onay vaat edilmez. `booking_request_status` akışı (`pending → contacted → confirmed | cancelled | expired`) kullanıcıya şeffaf gösterilir ve onayın Dockly operasyon ekibince manuel işlendiği açıkça yazılır.
3. **Misafir dostu, kayıt duvarı geç.** Keşif (harita, arama, detay, galeri, yorum okuma) misafire tamamen açıktır. Kayıt yalnızca **yazma** eylemlerinde (yorum, fotoğraf, talep, favori, öneri, bildirim) istenir.
4. **Topluluk veriyi düzeltir, moderasyon korur.** Her kullanıcı katkısı (`photos`, `reviews`, `suggestions`) `moderation_status` (`pending/approved/rejected`) süzgecinden geçer; harita asla çöp veriyle kirlenmez.
5. **Türkiye gerçeğine göre modelle.** Belediye iskelesi, restoran iskelesi, şamandıra kültürü birinci sınıf vatandaştır — "marina" tek tip değildir.
6. **Bugün dar, yarın açık.** Hard Exclusions v1'de yoktur; ama modülerlik sözleşmesi (foundation §9) gereği ileride yeniden yazım olmadan eklenebilir.

---

## 6. v1 Kapsamı — In Scope (Detaylı)

### 6.1 Kimlik doğrulama (auth) — S-03, S-04, S-05
- Sağlayıcı: **Firebase Authentication**. Yöntemler: **Apple, Google, E-posta, Telefon (OTP), Anonim/Misafir**.
- Misafir modu: Firebase anonim oturum; keşif serbest, yazma eylemleri kilitli.
- Misafir→kayıtlı dönüşüm: anonim hesap, seçilen yönteme **linklenir**; `recently_viewed` ve oturum içi durum korunur.
- Oturum köprüsü: `POST /auth/session` ile Firebase ID Token → Supabase JWT.
- Hesap silme (App Store zorunluluğu): S-20 Ayarlar üzerinden; `users.deleted_at` soft delete.

### 6.2 Tekne profili — S-17, S-18
- 1 kullanıcı → N tekne (`boats` tablosu). Alanlar: `name`, `brand`, `model`, `year`, `length_m`, `beam_m`, `draft_m`, `engine_type`, `boat_type`, `is_primary`.
- `is_primary` tekne, rezervasyon talebi formunu (S-14) ve filtre uyum rozetlerini ("teknen sığar/sığmaz") besler.
- Tekne fotoğrafı: `photos` tablosu (boat sahipli), S3 presigned upload.

### 6.3 Ana sayfa — Harita + alt kart sistemi — S-06
- Tam ekran **Mapbox** haritası; pinler `location_type` başına kanonik renk/ikonla (foundation §7).
- Zoom seviyesine göre **cluster**; pin tap → alt **detay kartı** (bottom card) açılır: ad, tip, `rating_avg` (`rating_count`), `price_tier`, kapak fotoğrafı, "Detay" ve "Yol tarifi" aksiyonları.
- Kart sistemi yatay kaydırılabilir: yakındaki noktalar arasında swipe ile gezinme; kart değişince harita ilgili pine odaklanır.
- Üstte arama çubuğu (S-07'ye götürür) + filtre kısayolu (S-08 bottom sheet) + konumuma git düğmesi.
- Offline: Drift (SQLite) cache'ten son görüntülenen bölge verisi + `cached_network_image` ile görseller.

### 6.4 Arama — S-07
- Kapsam: marina, iskele, şehir, ilçe, koy (`bay_name`), restoran, yakıt.
- Backend: `GET /locations?search=` — `pg_trgm` GIN index (typo toleransı).
- Son aramalar + `recently_viewed` (upsert) listesi boş durumda gösterilir.
- Sonuç tap → S-09 detay ya da haritada odak.

### 6.5 Filtreler — S-08 (bottom sheet)
- `location_type` (9 tip, çoklu seçim), amenity kodları (15 adet, foundation §4 listesi), `price_tier`, minimum puan, `is_24h`, tekne uyumu (`max_boat_length_m` / `max_draft_m` — primary tekneyle karşılaştırma).
- Aktif filtre sayısı harita üstünde rozet olarak görünür; "Temizle" tek dokunuş.

### 6.6 Lokasyon detay — S-09, S-10
- Başlık bloğu: ad, `type`, şehir/ilçe/koy, `rating_avg` + `rating_count`, `price_tier`.
- Fotoğraf galerisi (S-10 tam ekran), amenity ızgarası, kapasite/`max_boat_length_m`/`max_draft_m`/`vhf_channel`/telefon/website, çalışma bilgisi (`is_24h`).
- Aksiyonlar: **Yol tarifi** (harici navigasyon), **Ara** (tel), **Talep bırak** (S-14), **Favorile**, **Fotoğraf ekle** (S-13), **Yorum yaz** (S-12), **Hata bildir** (S-23).
- Yorumların ilk 3'ü önizleme; "Tümü" → S-11.

### 6.7 Rezervasyon talebi (request-only) — S-14, S-15
- Form alanları (`booking_requests` kolonlarıyla birebir): tekne seçimi (`boat_id`, boy/su çekimi otomatik dolar; misafir tekneyle manuel `boat_length_m`/`boat_draft_m`), `check_in`/`check_out` (DATE), `phone`, `note`.
- Durum makinesi: `pending → contacted → confirmed | cancelled | expired`. Kullanıcı `POST /booking-requests/{id}/cancel` ile iptal edebilir.
- v1'de **onay marina tarafından DEĞİL, Dockly operasyon ekibi tarafından manuel işlenir** — bu bilgi formda ve talep detayında açıkça yazar.
- S-15 Taleplerim: sekmeli liste (aktif/geçmiş), her talepte durum rozeti + zaman çizgisi.

### 6.8 Topluluk — S-11, S-12, S-13, S-22, S-23
- **Yorum + puan** (S-12): `rating 1-5` zorunlu, `body` opsiyonel; kullanıcı başına lokasyonda tek aktif yorum (`UNIQUE(location_id, user_id) WHERE deleted_at IS NULL`); moderasyon `pending → approved/rejected`.
- **Fotoğraf yükleme** (S-13): `POST /photos/presign` → S3 → `POST /photos/complete`; moderasyon süreci aynı.
- **Yeni nokta önerme** (S-22): `suggestions` (`suggestion_type = new_location`, payload JSONB: ad, tip, konum pini, notlar, opsiyonel foto).
- **Hatalı bilgi bildirme** (S-23): `reports`, `report_reason` enum'u: `wrong_info`, `closed_permanently`, `wrong_photo`, `wrong_position`, `other`.

### 6.9 Favoriler ve son görüntülenenler — S-16
- `PUT/DELETE /favorites/{locationId}`; hard delete (soft delete yok).
- Liste + mini harita görünümü; `favorite_update` bildirimleriyle bağlantılı.
- `recently_viewed` upsert; arama boş durumunda ve profilde yüzeye çıkar.

### 6.10 Bildirimler — S-21
- FCM push + uygulama içi `notifications` listesi. Tipler: `booking_status`, `new_photo`, `new_review`, `favorite_update`, `system`.
- Cihaz kaydı `PUT /devices`; okundu işaretleme `POST /notifications/read`.
- S-20 Ayarlar'dan tip bazlı açma/kapama.

### 6.11 Profil ve ayarlar — S-19, S-20
- Profil: `full_name`, `avatar_url`, e-posta/telefon, tekne özeti, katkı sayaçları (yorum/fotoğraf/öneri).
- Ayarlar: tema (light/dark/sistem), dil (TR+EN), bildirim tercihleri, hesap silme, yasal metinler.

### 6.12 Admin panel (Flutter Web) — A-01…A-08
- A-01 Dashboard, A-02 Lokasyon CRUD (draft/published/archived), A-03 Kategori/Amenity yönetimi, A-04 Fotoğraf moderasyon, A-05 Yorum moderasyon, A-06 Talepler (operasyon ekibinin `booking_request_status` işlediği ekran), A-07 Kullanıcılar, A-08 İstatistik.
- Yetki: `role >= moderator`; kritik eylemler `audit_logs`'a yazılır.

### 6.13 Yatay gereksinimler
- Alt navigasyon 5 sekme: **Keşfet (harita) · Arama · Favoriler · Taleplerim · Profil**.
- Offline cache (Drift), i18n (TR+EN), analytics, Sentry/Crashlytics izleme, `app_settings` feature flag'leri.

---

## 7. Out of Scope — Hard Exclusions ve Gerekçeleri

Foundation §1'deki liste **v1'de kesinlikle yoktur**:

| Özellik | Neden v1'de yok | Gelecek hazırlığı (foundation §9) |
|---|---|---|
| Yapay zekâ | Veri tabanı henüz küçük; AI önerisi güven kaybettirir. Önce güvenilir ham veri. | — |
| Rota planlama | Ayrı bir ürün derinliği; seyir güvenliği sorumluluğu doğurur. | MapLayer plugin arayüzü |
| Hava durumu | Mevcut uygulamalar (Windy vb.) bu işi iyi yapıyor; entegrasyon v1'i şişirir. | MapLayer plugin arayüzü |
| AIS | Donanım/veri lisans maliyeti yüksek; hedef kitlenin çekirdek ihtiyacı değil. | MapLayer plugin arayüzü |
| Garmin entegrasyonu | Niş; API ortaklığı gerektirir. | MapLayer plugin arayüzü |
| Marina yönetim paneli | Marinalar v1'de müşteri değil; iki taraflı pazar karmaşıklığı ertelendi. | `user_role` genişletilebilir, RLS role-bazlı |
| Marina hesabı | Aynı gerekçe; içerik sahipliği v1'de Dockly'de. | Aynı |
| Online ödeme | PCI/finans yükü + gerçek rezervasyon olmadan anlamsız. | `payments` domain arayüzü boş; para alanları `NUMERIC + currency_code` |
| Canlı müsaitlik | Marinalardan gerçek zamanlı veri akışı yok; yanlış müsaitlik göstermek en büyük güven riski. | `availability` tablosu için yer ayrıldı |
| Gerçek (onaylı) rezervasyon | Müsaitlik ve marina hesabı olmadan taahhüt verilemez. | `booking_requests.status` genişletilebilir |

**İlke:** Bu özelliklerden herhangi biri için gelen istekler v2+ backlog'una alınır; v1 sprintlerine asla sızmaz.

---

## 8. Başarı Metrikleri

### 8.1 North Star Metric
> **Haftalık Aktif Keşifçi (WAE):** 7 gün içinde en az bir lokasyon detayı (S-09) görüntüleyen benzersiz kullanıcı sayısı.

Gerekçe: Ürün "her gün açılan harita" olarak konumlandığı için başarı, talep sayısından önce **keşif alışkanlığıyla** ölçülür.

### 8.2 KPI ağacı

| Alan | Metrik | v1 hedefi (lansmandan 6 ay sonra) |
|---|---|---|
| Bağlılık | DAU/MAU oranı | ≥ %25 (sezon içi) |
| Bağlılık | Harita oturum süresi (S-06 medyan) | ≥ 3 dk |
| Bağlılık | Haftada ≥3 gün açan kullanıcı oranı | ≥ %15 |
| Talep | Aylık rezervasyon talebi sayısı | ≥ 500/ay (sezon içi) |
| Talep | Talep dönüş hızı (pending → contacted medyan) | ≤ 24 saat |
| Talep | `confirmed` oranı | ≥ %40 |
| İçerik üretimi | Aylık onaylanan yorum sayısı | ≥ 400/ay |
| İçerik üretimi | Aylık onaylanan fotoğraf sayısı | ≥ 800/ay |
| İçerik üretimi | Aylık `new_location` önerisi | ≥ 120/ay |
| İçerik üretimi | Katkıda bulunan kullanıcı oranı (aylık) | ≥ %8 |
| Kapsam | Yayınlanmış (`status = published`) lokasyon sayısı | ≥ 2.500 |
| Dönüşüm | Misafir → kayıtlı dönüşüm oranı | ≥ %20 |
| Kalite | Moderasyon SLA (pending medyan) | ≤ 12 saat |
| Kalite | Crash-free session (Crashlytics) | ≥ %99,5 |
| Büyüme | Aylık yeni kayıt | ≥ 3.000/ay (sezon içi) |

### 8.3 Guardrail metrikleri
- `rejected` moderasyon oranı > %30 olursa içerik akışı UX'i gözden geçirilir.
- Haritada boş bölge tıklaması / "sonuç yok" oranı bölge bazında izlenir → içerik operasyonu önceliklendirmesi.
- Talep başına operasyon işleme süresi ölçülür; ölçeklenemezse v2 marina paneli iş gerekçesi olur.

---

## 9. Rekabet Analizi

| Rakip | Güçlü yanı | Zayıf yanı (Dockly fırsatı) |
|---|---|---|
| **Navily** | Akdeniz genelinde büyük topluluk, koy yorumları, marina rezervasyonu | Türkiye içeriği sığ; belediye iskelesi / restoran iskelesi / şamandıra kültürünü modellemiyor; arayüz rezervasyon odaklı |
| **MarinaNow** | Marina rezervasyonu, anlık fiyat | Yalnızca büyük marinalar; keşif/topluluk katmanı zayıf; Türkiye kapsamı sınırlı |
| **Setur Marinas app** | Kendi 10+ marinasında derin işlevsellik | Tek zincirle sınırlı; tarafsız pazar yeri değil; küçük noktalar yok |
| **Google Maps** | Herkeste var, navigasyon güçlü | Denizcilik verisi yok (derinlik, maks. boy, VHF); iskele/şamandıra kapsamı ve doğruluğu zayıf |
| **Facebook/WhatsApp grupları** | Güncel yerel bilgi, güven ilişkisi | Aranamaz, yapılandırılmamış, doğrulanamaz |

**Farklılaşma tezi:** Dockly, rakiplerin görmezden geldiği **uzun kuyruğu** (belediye iskelesi, restoran iskelesi, şamandıra, bağlama noktası) birinci sınıf veri olarak modelleyen ve rezervasyonu değil **keşfi** merkeze koyan tek Türkiye odaklı platformdur.

---

## 10. Riskler ve Varsayımlar

### 10.1 Varsayımlar
- V-1: Tekne sahipleri, onaylı rezervasyon olmasa bile "talep bırakma" akışını değerli bulur (Concierge doğrulaması: kapalı beta).
- V-2: Topluluk, moderasyonlu katkı akışıyla ayda ≥%8 katkı oranına ulaşır.
- V-3: Dockly operasyon ekibi, günde ~25 talebi 24 saat SLA ile manuel işleyebilir.
- V-4: Mapbox maliyeti, v1 kullanıcı hacminde sürdürülebilirdir.
- V-5: Marinalar, kendilerine yönlendirilen talepleri düşmanca karşılamaz (v2 iş ortaklığı zemini).

### 10.2 Riskler ve azaltımlar

| Risk | Olasılık | Etki | Azaltım |
|---|---|---|---|
| Soğuk başlangıç: içerik yoksa kullanıcı gelmez | Yüksek | Yüksek | Lansman öncesi editoryal seed: 60+ marina, ~1.000 nokta `supabase/seed` ile; pilot bölge (Muğla) derin doldurulur |
| Talep operasyonu ölçeklenemez | Orta | Yüksek | A-06 ekranında toplu işlem araçları; SLA metriği; hacim artarsa v2 marina paneli öne çekilir |
| Yanlış veri güven kaybettirir | Orta | Yüksek | S-23 hata bildirimi + moderasyon SLA ≤12 saat + `audit_logs` izlenebilirliği |
| Sezonluk kullanım (kış çukuru) | Yüksek | Orta | Kış içerik kampanyaları; metrik hedefleri "sezon içi" tanımlandı |
| Mapbox/Firebase maliyet artışı | Düşük | Orta | Kullanım kotaları izlenir; harita katmanı arayüzle soyutlandı |
| App Store reddi (misafir mod + hesap silme) | Düşük | Orta | Hesap silme S-20'de; misafir yazma kilitleri Apple kurallarına uygun |
| Rakip (Navily) Türkiye'ye agresif giriş | Düşük | Orta | Uzun kuyruk veri + Türkçe topluluk hendeği hızlı kazılır |

---

## 11. v1 Kabul Kriterleri

v1 "tamam" sayılır, ancak ve ancak:

1. **Auth:** 5 yöntemin (Apple, Google, E-posta, Telefon OTP, Misafir) tamamı iki platformda çalışır; misafir→kayıtlı dönüşümde oturum verisi kaybolmaz.
2. **Harita:** S-06'da ≥2.000 published lokasyon, cluster'lı, tip bazlı ikonlarla 60 fps'e yakın akıcılıkta yüklenir; pin tap → alt kart ≤300 ms.
3. **Arama/Filtre:** S-07 typo toleranslı arama ve S-08'deki tüm filtre boyutları (`location_type`, 15 amenity, `price_tier`, puan, `is_24h`, tekne uyumu) uçtan uca çalışır.
4. **Detay:** S-09 tüm kanonik kolonları gösterir; yol tarifi harici navigasyon uygulamasını doğru koordinatla açar.
5. **Talep:** S-14 → `booking_requests` kaydı; A-06'dan durum değişimi → FCM `booking_status` bildirimi → S-15'te durum güncellenir; kullanıcı iptali çalışır. Uçtan uca süre ≤ 5 dk test edilebilir.
6. **Topluluk:** Yorum, fotoğraf, öneri, rapor akışlarının tamamı moderasyon kuyruğuna düşer; `approved` içerik uygulamada, `rejected` içerik hiçbir yerde görünmez.
7. **Misafir modu:** Tüm okuma akışları açık; 6 yazma eylemi (yorum, fotoğraf, talep, favori, öneri, rapor) kayıt duvarına yönlendirir; duvar sonrası kullanıcı kaldığı yerden devam eder.
8. **Offline:** Uçak modunda son görüntülenen harita bölgesi ve ziyaret edilmiş detaylar cache'ten açılır; yazma eylemleri anlamlı hata verir.
9. **Bildirim:** 5 `notification_type` için push + in-app liste + okundu durumu çalışır; ayarlardan tip bazlı kapatma etkilidir.
10. **Admin:** A-01…A-08 ekranları `role >= moderator` yetkisiyle çalışır; tüm moderasyon ve talep işlemleri `audit_logs`'a yazılır.
11. **Kalite çubuğu:** Crash-free session ≥ %99,5 (beta), Sentry'de sıfır bilinen P0; TR+EN dil paketleri eksiksiz.
12. **Hard Exclusions denetimi:** Foundation §1 listesindeki hiçbir özellik, hiçbir ekranda ima dahi edilmez (ör. "yakında online ödeme" rozeti yasak).

---

## 12. Açık Sorular (v1 sırasında karara bağlanacak)

| # | Soru | Sahibi | Son tarih |
|---|---|---|---|
| 1 | Pilot derin-veri bölgesi Muğla mı, İstanbul+Marmara mı? | PM + İçerik Ops | Sprint 2 |
| 2 | Talep formunda `check_out` zorunlu mu, "tek gece" varsayılanı mı? | PM + Tasarım | Sprint 3 |
| 3 | Yorumda fotoğraf zorunluluğu teşviki (rozet?) v1'e girer mi? | PM | Sprint 4 |
| 4 | Misafir kullanıcının `recently_viewed` verisi cihazda mı, anonim UID'de mi tutulur? | Mobil Lead | Sprint 2 |

---

*Bu PRD, `00-foundation.md` ile birlikte okunmalıdır. Sonraki dokümanlar: `06-kullanici-akislari.md` (akışlar) ve `07-ekran-listesi.md` (ekran envanteri).*
