# Dockly — Kanonik Temel Doküman (FOUNDATION)

> **Bu doküman tek doğruluk kaynağıdır (Single Source of Truth).**
> Diğer tüm dokümanlar buradaki adlandırmaları, enum değerlerini, tablo ve modül adlarını **birebir** kullanmak zorundadır. Bir doküman bu dosyayla çelişiyorsa, bu dosya geçerlidir.

---

## 1. Ürün Kimliği

| Alan | Değer |
|---|---|
| Ürün adı | **Dockly** |
| Slogan (çalışma) | "Denizdeki her bağlama noktası, tek uygulamada." |
| Platform | iOS + Android (Flutter), Admin: Flutter Web |
| Pazar (v1) | Yalnızca Türkiye (`country_code = TR`) |
| Müşteri | Yalnızca tekne sahipleri (B2C). Marinalar müşteri DEĞİLDİR. |
| Konumlandırma | Google Maps + TripAdvisor + Booking.com hissi; rezervasyon uygulaması gibi DEĞİL, denizcinin her gün açtığı harita uygulaması gibi. |
| Bundle ID | `com.dockly.app` (mobile), `com.dockly.admin` (admin web) |

### v1'de KESİNLİKLE OLMAYANLAR (Hard Exclusions)
Yapay zekâ, rota planlama, hava durumu, AIS, Garmin entegrasyonu, marina yönetim paneli, marina hesabı, online ödeme, canlı müsaitlik, gerçek (onaylı) rezervasyon.
**v1 = Keşif + Topluluk + Rezervasyon Talebi (request-only).**

---

## 2. Teknoloji Yığını (Kanonik)

| Katman | Teknoloji |
|---|---|
| Mobil | Flutter 3.x, Dart 3.x |
| State | Riverpod (hooks_riverpod + riverpod_generator) |
| Navigasyon | GoRouter |
| Mimari | Clean Architecture + Feature-First |
| Harita | Mapbox (`mapbox_maps_flutter`) |
| Backend | Supabase (PostgreSQL 15 + PostGIS, PostgREST, Edge Functions/Deno) |
| Auth | Firebase Authentication (Apple, Google, E-posta, Telefon, Anonim/Misafir) |
| Push | Firebase Cloud Messaging (FCM) |
| Depolama | AWS S3 (+ CloudFront CDN) — fotoğraflar |
| API | REST (`/v1`), JSON |
| Offline | Drift (SQLite) cache + cached_network_image |
| CI/CD | GitHub Actions + Fastlane + Codemagic (opsiyonel) |
| Container | Docker (Edge Function'lar ve admin web build/deploy) |
| İzleme | Sentry + Firebase Crashlytics + Supabase Logs |

---

## 3. Monorepo / Klasör Yapısı (Üst Seviye)

```
dockly/
├── apps/
│   ├── mobile/            # Flutter mobil uygulama
│   └── admin_web/         # Flutter Web admin paneli
├── packages/
│   ├── dockly_core/       # ortak domain modelleri, hata tipleri, utils
│   ├── dockly_api/        # API client (REST), DTO'lar
│   └── dockly_ui/         # design system, tema, ortak widget'lar
├── supabase/
│   ├── migrations/        # SQL migration'lar (sıralı, versiyonlu)
│   ├── functions/         # Edge Functions
│   └── seed/              # seed verisi
├── docs/                  # bu dokümantasyon
└── .github/workflows/     # CI/CD
```

### Feature Modülleri (apps/mobile/lib/features/)
`auth`, `onboarding`, `boats`, `map`, `search`, `locations`, `booking`, `reviews`, `favorites`, `notifications`, `profile`, `settings`
(+ `core/` altında: `router`, `theme`, `network`, `storage`, `analytics`, `l10n`)

Her feature içi katmanlar: `data/` (datasources, repositories impl, dto), `domain/` (entities, repositories abstract, usecases), `presentation/` (screens, widgets, providers).

---

## 4. Kanonik Enum'lar

### location_type (9 tip — harita ikonları da bu koda bağlı)
| Kod | TR Adı |
|---|---|
| `private_marina` | Özel Marina |
| `municipal_marina` | Belediye Marinası |
| `municipal_pier` | Belediye İskelesi |
| `guest_mooring` | Misafir Bağlama Noktası |
| `restaurant_pier` | Restoran İskelesi |
| `fuel_pier` | Yakıt İskelesi |
| `boat_club` | Tekne Kulübü |
| `mooring_point` | Bağlama Noktası |
| `buoy` | Şamandıra |

### boat_type
`motor_yacht`, `sailboat`, `daily_boat`, `fishing_boat`, `catamaran`, `gulet`, `superyacht`, `rib`, `other`

### engine_type
`inboard_diesel`, `inboard_gasoline`, `outboard`, `sail_aux`, `electric`, `none`

### booking_request_status
`pending` → `contacted` → `confirmed` | `cancelled` | `expired`
(v1'de onay marina tarafından DEĞİL, Dockly operasyon ekibi tarafından manuel işlenir)

### price_tier
`free`, `paid`, `unknown`

### moderation_status (fotoğraf, yorum, öneri için)
`pending`, `approved`, `rejected`

### user_role
`user`, `moderator`, `admin`, `super_admin`

### suggestion_type
`new_location`, `edit_location`

### report_reason
`wrong_info`, `closed_permanently`, `wrong_photo`, `wrong_position`, `other`

### notification_type
`booking_status`, `new_photo`, `new_review`, `favorite_update`, `system`

### Amenity kodları (filtreler bu listeden türetilir)
`electricity`, `water`, `fuel`, `restaurant`, `shower`, `market`, `laundry`, `wifi`, `security`, `open_24h`, `wc`, `pump_out`, `crane`, `travel_lift`, `technical_service`

---

## 5. Veritabanı — Kanonik Tablo Listesi

> ⚠️ **GÜNCELLEME (6 Temmuz 2026):** Veri modeli [22-veritabani-mimarisi.md](./22-veritabani-mimarisi.md) v2.0 olarak **dondurulmuştur** ve bu bölümü üstün kılar. Başlıca farklar: `boat_type`/`engine_type`/`location_type` enum'ları lookup tablosuna terfi etti; coğrafya `countries`/`admin_areas`/`water_bodies` hiyerarşisine taşındı; `photos` → `media` + typed köprüler; `booking_requests` → `reservation_requests` (+ `reservation_request_events`); i18n `_i18n` tablolarıyla; şema organizasyonu (identity/geo/catalog/community/booking/messaging/ops). Bu bölüm hızlı referans olarak korunur.

Tüm tablolarda: `id UUID PK (gen_random_uuid())`, `created_at`, `updated_at`; soft delete uygulanan tablolarda `deleted_at TIMESTAMPTZ NULL`.

| Tablo | Amaç | Soft Delete |
|---|---|---|
| `users` | Kullanıcı profili (Firebase UID eşleşmeli) | ✅ |
| `boats` | Tekne profilleri (1 kullanıcı → N tekne) | ✅ |
| `locations` | Tüm bağlama noktaları (PostGIS `geography(Point,4326)`) | ✅ |
| `amenities` | Hizmet sözlüğü (referans tablo) | ❌ |
| `location_amenities` | N-N köprü (location ↔ amenity) | ❌ |
| `photos` | Tüm fotoğraflar (location/boat/review sahipli, S3 key) | ✅ |
| `reviews` | Yorum + puan (1-5) | ✅ |
| `favorites` | Kullanıcı favorileri (user_id+location_id PK) | ❌ (hard delete) |
| `recently_viewed` | Son görüntülenenler (upsert) | ❌ |
| `booking_requests` | Rezervasyon talepleri | ✅ |
| `suggestions` | Topluluk yeni nokta / düzeltme önerileri (payload JSONB) | ✅ |
| `reports` | Hatalı bilgi bildirimleri | ✅ |
| `notifications` | Uygulama içi bildirim kayıtları | ❌ |
| `devices` | FCM token kayıtları | ❌ |
| `audit_logs` | Tüm kritik değişikliklerin kaydı (aylık partition'a hazır) | ❌ (append-only) |
| `app_settings` | Feature flag / uzaktan yapılandırma (key, value JSONB) | ❌ |

### Kritik kolonlar (kısa referans)
- `users`: `firebase_uid UNIQUE`, `email`, `phone`, `full_name`, `avatar_url`, `role user_role`, `locale`, `country_code`
- `boats`: `user_id FK`, `name`, `brand`, `model`, `year`, `length_m NUMERIC(5,2)`, `beam_m`, `draft_m`, `engine_type`, `boat_type`, `is_primary`
- `locations`: `slug UNIQUE`, `name`, `type location_type`, `status (draft/published/archived)`, `geo geography(Point,4326)`, `country_code`, `city`, `district`, `bay_name`, `phone`, `website`, `vhf_channel`, `max_boat_length_m`, `max_draft_m`, `capacity`, `price_tier`, `is_24h`, `rating_avg NUMERIC(3,2)`, `rating_count INT` (cache, trigger ile güncellenir)
- `booking_requests`: `user_id`, `location_id`, `boat_id`, `boat_length_m`, `boat_draft_m`, `check_in DATE`, `check_out DATE`, `phone`, `note`, `status booking_request_status`
- `reviews`: `location_id`, `user_id`, `rating SMALLINT (1-5)`, `body`, `status moderation_status`; aktif kayıt için `UNIQUE(location_id, user_id) WHERE deleted_at IS NULL`

### Kanonik index'ler
- `locations.geo` → GIST; `locations(name, city)` → GIN `pg_trgm`; `locations(type, status)` B-tree
- Tüm FK kolonlarına B-tree; soft-delete'li tablolarda partial index `WHERE deleted_at IS NULL`
- `booking_requests(status, created_at)`, `reviews(location_id, status)`, `notifications(user_id, read_at)`

---

## 6. API — Kanonik Yüzey

Base URL: `https://api.dockly.app/v1` (Supabase Edge Functions + PostgREST arkasında API Gateway).
Kimlik doğrulama: `Authorization: Bearer <Firebase ID Token>` — Edge tarafında doğrulanıp Supabase JWT'ye köprülenir.

| Kaynak | Endpoint kökü |
|---|---|
| Auth/oturum köprüsü | `POST /auth/session` |
| Profil | `GET/PATCH /users/me` |
| Tekneler | `GET/POST /boats`, `GET/PATCH/DELETE /boats/{id}` |
| Lokasyonlar | `GET /locations` (bbox, filtre, arama), `GET /locations/{id}` |
| Yorumlar | `GET/POST /locations/{id}/reviews`, `DELETE /reviews/{id}` |
| Fotoğraflar | `POST /photos/presign` (S3 presigned), `POST /photos/complete` |
| Favoriler | `GET /favorites`, `PUT/DELETE /favorites/{locationId}` |
| Son görüntülenen | `GET/POST /recently-viewed` |
| Rezervasyon talebi | `GET/POST /booking-requests`, `POST /booking-requests/{id}/cancel` |
| Öneriler | `POST /suggestions` |
| Bildirim | `GET /notifications`, `POST /notifications/read` |
| Hata bildirimi | `POST /reports` |
| Cihaz/FCM | `PUT /devices` |
| Admin | `/admin/*` (ayrı yetki katmanı, role >= moderator) |

Sayfalama: cursor-based (`?cursor=&limit=`). Hata formatı: `{ "error": { "code": "string", "message": "string", "details": {} } }`.

---

## 7. Design System — Kanonik Token'lar

### Renkler
| Token | Light | Dark | Kullanım |
|---|---|---|---|
| `brand.primary` | `#0C7BDC` | `#3B9DF2` | Ana marka, CTA |
| `brand.deep` | `#0A2540` | `#0A2540` | Logo, koyu zeminler |
| `accent.turquoise` | `#2EC4B6` | `#35D4C5` | Vurgu, başarı hisleri |
| `bg.base` | `#F7F9FC` | `#0B1220` | Sayfa zemini |
| `bg.surface` | `#FFFFFF` | `#141C2B` | Kart zemini |
| `bg.glass` | `rgba(255,255,255,0.72)` | `rgba(20,28,43,0.72)` | Glassmorphism (blur 20) |
| `text.primary` | `#0F1728` | `#F2F5F9` | |
| `text.secondary` | `#5B6B84` | `#93A1B8` | |
| `semantic.success` | `#30A46C` | — | |
| `semantic.warning` | `#FFB224` | — | |
| `semantic.error` | `#E5484D` | — | |

### Tipografi
iOS: SF Pro (system) / Android: Inter. Ölçek: Display 32/700, Title1 28/700, Title2 22/600, Headline 17/600, Body 16/400, Callout 15/400, Caption 13/400, Micro 11/500.

### Şekil & Boşluk
Radius: `sm 12`, `md 16`, `lg 24`, `full 999`. Spacing: 4pt grid (4/8/12/16/24/32). Kart gölgesi: y=8, blur=24, %8 opaklık. Glass blur: 20px.

### Harita ikon renkleri (location_type başına)
private_marina `#0C7BDC` · municipal_marina `#3B82F6` · municipal_pier `#6366F1` · guest_mooring `#2EC4B6` · restaurant_pier `#F97316` · fuel_pier `#EAB308` · boat_club `#8B5CF6` · mooring_point `#64748B` · buoy `#EF4444`

---

## 8. Kanonik Ekran Listesi (ID'ler)

| ID | Ekran | Feature |
|---|---|---|
| S-01 | Splash | core |
| S-02 | Onboarding (3 sayfa) | onboarding |
| S-03 | Giriş (Apple/Google/E-posta/Telefon/Misafir) | auth |
| S-04 | E-posta ile kayıt/giriş | auth |
| S-05 | Telefon doğrulama (OTP) | auth |
| S-06 | Ana Sayfa — Harita + alt kart sistemi | map |
| S-07 | Arama (marina, iskele, şehir, ilçe, koy, restoran, yakıt) | search |
| S-08 | Filtreler (bottom sheet) | search |
| S-09 | Lokasyon Detay | locations |
| S-10 | Fotoğraf Galerisi (tam ekran) | locations |
| S-11 | Yorumlar listesi | reviews |
| S-12 | Yorum yaz + puan ver | reviews |
| S-13 | Fotoğraf yükle | reviews |
| S-14 | Rezervasyon Talebi formu | booking |
| S-15 | Taleplerim (liste + detay) | booking |
| S-16 | Favoriler | favorites |
| S-17 | Tekne listem | boats |
| S-18 | Tekne ekle/düzenle | boats |
| S-19 | Profil | profile |
| S-20 | Ayarlar (tema, dil, bildirim) | settings |
| S-21 | Bildirimler | notifications |
| S-22 | Yeni nokta öner | reviews (community) |
| S-23 | Hatalı bilgi bildir | reviews (community) |
| A-01…A-08 | Admin: Dashboard, Lokasyon CRUD, Kategori/Amenity, Fotoğraf moderasyon, Yorum moderasyon, Talepler, Kullanıcılar, İstatistik | admin_web |

Alt navigasyon (mobil, 5 sekme): **Keşfet (harita) · Arama · Favoriler · Taleplerim · Profil**

---

## 9. Modülerlik Sözleşmesi (Gelecek Sürümler)

Aşağıdaki modüller, mevcut kod YENİDEN YAZILMADAN eklenebilecek şekilde tasarlanır. Mekanizma: feature-first modüller + repository arayüzleri + `app_settings` feature flag'leri + versiyonlu API.

| Gelecek modül | Hazırlık (v1'de yapılan) |
|---|---|
| Canlı rezervasyon | `booking_requests.status` genişletilebilir; `availability` tablosu için yer ayrıldı |
| Online ödeme | `payments` modülü için domain arayüzü boş bırakıldı; para alanları `NUMERIC + currency_code` |
| Hava durumu / AIS / Rota / Garmin | Harita katmanı plugin mimarisi (MapLayer arayüzü) |
| Avrupa / Global | Tüm içerik tablolarında `country_code`; i18n altyapısı (TR+EN hazır); tüm ölçüler metrik + birim alanı |
| Marina paneli | `user_role` genişletilebilir; RLS politikaları role-bazlı |

---

## 10. Doküman Yazım Kuralları

- Dil: Türkçe; teknik terimler (endpoint, migration, widget, cache...) İngilizce kalır.
- Dosya adları: `01-prd.md` … `20-mvp-gelistirme-plani.md` (bu klasörde).
- Enum, tablo, modül, ekran ID'leri **bu dokümandan** kopyalanır, asla yeniden icat edilmez.
- Diyagramlar Mermaid ile yazılır.
