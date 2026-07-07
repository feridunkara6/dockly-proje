# Dockly — API Dokümantasyonu

> Bu doküman [00-foundation.md](./00-foundation.md) dokümanına tabidir. Endpoint yolları, enum değerleri ve alan adları foundation Bölüm 4, 5 ve 6'dan **birebir** alınmıştır. Şema detayları için bkz. [04-veritabani-tasarimi.md](./04-veritabani-tasarimi.md).

---

## 1. Genel Kurallar

### 1.1 Base URL ve versiyonlama

```
https://api.dockly.app/v1
```

- Supabase Edge Functions + PostgREST arkasında API Gateway. Tüm istek/yanıt gövdeleri JSON (`Content-Type: application/json; charset=utf-8`).
- Versiyon path'te taşınır (`/v1`). Kırıcı değişiklik → `/v2`; `/v1` en az 12 ay desteklenir. Kırıcı olmayan ekleme (yeni opsiyonel alan, yeni endpoint) aynı versiyonda yapılır — istemciler bilinmeyen alanları yok saymalıdır.

### 1.2 Kimlik doğrulama

```
Authorization: Bearer <Firebase ID Token>
```

- Edge tarafında Firebase ID Token doğrulanır ve Supabase JWT'ye köprülenir (`POST /auth/session`, Bölüm 3.1).
- **Misafir erişimi:** Firebase anonim oturum token'ı geçerli bir Bearer token'dır. Misafirler yalnızca okuma endpoint'lerine (`GET /locations*`, `GET .../reviews`) erişebilir; yazma denemesi `403 AUTH_FULL_ACCOUNT_REQUIRED` döner. Her endpoint'in "Auth" satırında hangi seviye gerektiği yazılıdır: `Yok` (token'sız da çalışır) / `Misafir+` (anonim dahil herhangi bir token) / `Kullanıcı` (tam hesap) / `Staff` (role >= moderator).
- Admin endpoint'leri (`/admin/*`) ek olarak `role >= moderator` claim'i ister; bazıları `admin` veya `super_admin` ister (her endpoint'te belirtilir).

### 1.3 Cursor pagination

Liste endpoint'leri cursor-based sayfalama kullanır:

```
GET /v1/locations?limit=20&cursor=eyJjcmVhdGVkX2F0IjoiMjAyNi0wNy0wMSJ9
```

| Parametre | Tip | Varsayılan | Açıklama |
|---|---|---|---|
| `limit` | int | 20 | 1–100 arası; aşımı `VALIDATION_ERROR` |
| `cursor` | string | — | Önceki yanıttaki `next_cursor` değeri; opak base64 (istemci parse ETMEZ) |

Liste yanıt zarfı:

```json
{
  "data": [ ... ],
  "pagination": { "next_cursor": "eyJ...", "has_more": true }
}
```

`has_more=false` iken `next_cursor` null'dur. Geçersiz/eskimiş cursor → `400 INVALID_CURSOR`.

### 1.4 Hata formatı ve hata kodu kataloğu

Foundation Bölüm 6 formatı:

```json
{ "error": { "code": "string", "message": "string", "details": {} } }
```

`message` insan-okur (istemci `Accept-Language`'a göre TR/EN), `code` makine-okur ve stabildir; istemci mantığı yalnızca `code`'a bağlanır.

| HTTP | code | Anlam |
|---|---|---|
| 400 | `VALIDATION_ERROR` | Gövde/parametre doğrulama hatası; `details.fields` alan bazlı mesajlar içerir |
| 400 | `INVALID_CURSOR` | Cursor çözümlenemedi/eskidi |
| 400 | `INVALID_STATUS_TRANSITION` | booking_request_status akış dışı geçiş (`pending → contacted → confirmed \| cancelled \| expired`) |
| 401 | `AUTH_REQUIRED` | Token yok/geçersiz/süresi dolmuş |
| 401 | `AUTH_TOKEN_EXPIRED` | Firebase ID Token süresi doldu; istemci token yenileyip tekrar dener |
| 403 | `AUTH_FULL_ACCOUNT_REQUIRED` | Misafir (anonim) hesabın erişemeyeceği işlem |
| 403 | `FORBIDDEN` | RLS/rol engeli (başkasının kaydı, yetersiz rol) |
| 404 | `NOT_FOUND` | Kaynak yok, soft-delete edilmiş veya kullanıcının görme yetkisi yok |
| 409 | `CONFLICT` | Benzersizlik ihlali (genel) |
| 409 | `REVIEW_ALREADY_EXISTS` | Aynı lokasyona ikinci aktif yorum (`UNIQUE(location_id, user_id) WHERE deleted_at IS NULL`) |
| 409 | `IDEMPOTENCY_CONFLICT` | Aynı `Idempotency-Key` farklı gövdeyle tekrar kullanıldı |
| 413 | `PAYLOAD_TOO_LARGE` | Gövde > 1 MB veya foto > 15 MB |
| 422 | `BUSINESS_RULE_VIOLATION` | Şemaya uygun ama iş kuralına aykırı (örn. `check_out <= check_in`); `details.rule` kural kodunu taşır |
| 429 | `RATE_LIMITED` | Limit aşıldı; `Retry-After` başlığına bakılır |
| 500 | `INTERNAL_ERROR` | Beklenmeyen sunucu hatası (Sentry'ye raporlanır) |
| 503 | `SERVICE_UNAVAILABLE` | Bakım/geçici kesinti (`app_settings maintenance.banner` ile koordineli) |

### 1.5 Rate limit başlıkları

Her yanıtta:

```
X-RateLimit-Limit: 120
X-RateLimit-Remaining: 87
X-RateLimit-Reset: 1751791200
```

Varsayılan limitler: okuma 120 istek/dk, yazma 30 istek/dk, `POST /photos/presign` 20/saat, `POST /booking-requests` 10/saat (kullanıcı başına). 429 yanıtı ayrıca `Retry-After: <saniye>` taşır.

### 1.6 Idempotency-Key

Yan etkili POST'larda (özellikle `POST /booking-requests`, `POST /photos/complete`, `POST /suggestions`, `POST /reports`) istemci başlık gönderir:

```
Idempotency-Key: 7f9c2e1a-4b6d-4f0e-9a1c-3d5e7f9b2c4d
```

- UUID v4 önerilir; anahtar + kullanıcı bazında 24 saat saklanır.
- Aynı anahtar + aynı gövde → ilk yanıtın kopyası döner (yeniden kayıt oluşmaz).
- Aynı anahtar + farklı gövde → `409 IDEMPOTENCY_CONFLICT`.

### 1.7 Ortak DTO'lar

Alan adları DB kolonlarıyla birebirdir (bkz. 04 dokümanı).

**LocationSummary** — liste/harita kartlarında döner:
`id, slug, name, type, geo {lat, lng}, city, district, bay_name, price_tier, is_24h, rating_avg, rating_count, max_boat_length_m, max_draft_m, cover_photo_url, is_favorite (girişliyse), distance_m (center araması yapıldıysa)`

**LocationDetail** — LocationSummary + :
`country_code, description, phone, website, vhf_channel, capacity, amenities [{code, name, icon}], photos [PhotoDto], created_at, updated_at`

**PhotoDto:** `id, url, thumb_url, width, height, owner_type, created_at`
**BoatDto:** `id, name, brand, model, year, length_m, beam_m, draft_m, engine_type, boat_type, is_primary, created_at, updated_at`
**ReviewDto:** `id, location_id, rating, body, status, created_at, user {id, full_name, avatar_url}, photos [PhotoDto]`
**BookingRequestDto:** `id, location {LocationSummary-kısa}, boat_id, boat_length_m, boat_draft_m, check_in, check_out, phone, note, status, created_at, updated_at`
**UserDto:** `id, email, phone, full_name, avatar_url, role, locale, country_code, is_anonymous, created_at`
**NotificationDto:** `id, type, title, body, data, read_at, created_at`

---

## 2. Endpoint Kataloğu (Özet)

Foundation Bölüm 6 yüzeyi:

| # | Method + Path | Auth | Bölüm |
|---|---|---|---|
| 1 | `POST /auth/session` | Firebase token | 3.1 |
| 2 | `GET /users/me` | Misafir+ | 3.2 |
| 3 | `PATCH /users/me` | Kullanıcı | 3.2 |
| 4 | `GET /boats` · `POST /boats` | Kullanıcı | 3.3 |
| 5 | `GET/PATCH/DELETE /boats/{id}` | Kullanıcı | 3.3 |
| 6 | `GET /locations` | Yok | 4.1 |
| 7 | `GET /locations/{id}` | Yok | 4.2 |
| 8 | `GET /locations/{id}/reviews` | Yok | 5.1 |
| 9 | `POST /locations/{id}/reviews` | Kullanıcı | 5.2 |
| 10 | `DELETE /reviews/{id}` | Kullanıcı | 5.3 |
| 11 | `POST /photos/presign` | Kullanıcı | 6.1 |
| 12 | `POST /photos/complete` | Kullanıcı | 6.2 |
| 13 | `GET /favorites` | Kullanıcı | 7.1 |
| 14 | `PUT /favorites/{locationId}` · `DELETE /favorites/{locationId}` | Kullanıcı | 7.1 |
| 15 | `GET /recently-viewed` · `POST /recently-viewed` | Misafir+ | 7.2 |
| 16 | `GET /booking-requests` · `POST /booking-requests` | Kullanıcı | 8 |
| 17 | `POST /booking-requests/{id}/cancel` | Kullanıcı | 8.3 |
| 18 | `POST /suggestions` | Kullanıcı | 9.1 |
| 19 | `POST /reports` | Kullanıcı | 9.2 |
| 20 | `GET /notifications` · `POST /notifications/read` | Kullanıcı | 10 |
| 21 | `PUT /devices` | Kullanıcı | 10.3 |
| 22 | `/admin/*` | Staff | 11 |

---

## 3. Auth, Profil, Tekneler

### 3.1 POST /auth/session — Firebase token köprüsü

- **Auth:** Geçerli Firebase ID Token (anonim dahil). 
- **Amaç:** Firebase ID Token'ı doğrular, `users` kaydını bulur/oluşturur (`firebase_uid` üzerinden upsert), rol claim'li Supabase JWT üretir. İstemci uygulama açılışında ve token yenilemede çağırır.

Request:

```json
{
  "firebase_id_token": "eyJhbGciOiJSUzI1NiIs...",
  "locale": "tr-TR",
  "country_code": "TR"
}
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `firebase_id_token` | string | ✅ | Firebase Admin SDK ile imza+audience doğrulaması |
| `locale` | string | — | BCP-47; varsayılan `tr-TR` |
| `country_code` | string | — | ISO 3166-1 alpha-2; varsayılan `TR` |

Success `200`:

```json
{
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "expires_in": 3600,
    "user": {
      "id": "0d9f3c2e-...",
      "email": "deniz@ornek.com",
      "phone": null,
      "full_name": "Deniz Yılmaz",
      "avatar_url": null,
      "role": "user",
      "locale": "tr-TR",
      "country_code": "TR",
      "is_anonymous": false,
      "created_at": "2026-07-01T09:12:00Z"
    },
    "is_new_user": false
  }
}
```

Hatalar: `401 AUTH_REQUIRED` (token imzası geçersiz), `401 AUTH_TOKEN_EXPIRED`, `429 RATE_LIMITED`.

### 3.2 GET /users/me · PATCH /users/me

**GET /users/me** — Auth: Misafir+. Parametre yok. Success `200`: `{ "data": UserDto }`. Hatalar: `401 AUTH_REQUIRED`, `404 NOT_FOUND` (soft-delete edilmiş hesap).

**PATCH /users/me** — Auth: Kullanıcı (misafir → `403 AUTH_FULL_ACCOUNT_REQUIRED`).

```json
{ "full_name": "Deniz Yılmaz", "avatar_url": "https://cdn.dockly.app/u/....jpg", "locale": "tr-TR" }
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `full_name` | string | — | 2–100 karakter |
| `avatar_url` | string | — | https URL, dockly CDN domain'i |
| `locale` | string | — | BCP-47 (`tr-TR`, `en-GB`, ...) |
| `phone` | string | — | E.164 (`^\+[1-9][0-9]{6,14}$`); değişince yeniden OTP doğrulaması tetiklenir |

`email`, `role`, `country_code` bu endpoint'ten DEĞİŞTİRİLEMEZ (gönderilirse `400 VALIDATION_ERROR`). Success `200`: güncel `UserDto`.

### 3.3 Tekneler — /boats

**GET /boats** — Auth: Kullanıcı. Query: `limit`, `cursor`. Kullanıcının silinmemiş tekneleri, `is_primary DESC, created_at DESC`. Success `200`: `{ "data": [BoatDto], "pagination": {...} }`.

**POST /boats** — Auth: Kullanıcı.

```json
{
  "name": "Mavi Rüzgar", "brand": "Beneteau", "model": "Oceanis 40.1", "year": 2022,
  "length_m": 12.87, "beam_m": 4.18, "draft_m": 2.24,
  "engine_type": "sail_aux", "boat_type": "sailboat", "is_primary": true
}
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `name` | string | ✅ | 1–100 karakter |
| `brand`, `model` | string | — | ≤80 karakter |
| `year` | int | — | 1900–2100 |
| `length_m` | number | — | 0 < x ≤ 200, 2 ondalık |
| `beam_m` | number | — | 0 < x ≤ 50 |
| `draft_m` | number | — | 0 < x ≤ 20 |
| `engine_type` | enum | — | `inboard_diesel, inboard_gasoline, outboard, sail_aux, electric, none` |
| `boat_type` | enum | — | `motor_yacht, sailboat, daily_boat, fishing_boat, catamaran, gulet, superyacht, rib, other` |
| `is_primary` | bool | — | `true` gönderilirse mevcut birincil tekne otomatik `false` yapılır |

Success `201`: `{ "data": BoatDto }`. Hatalar: `400 VALIDATION_ERROR`, `403 AUTH_FULL_ACCOUNT_REQUIRED`.

**GET /boats/{id}** — Auth: Kullanıcı (yalnız sahibi). `200 BoatDto` / `404 NOT_FOUND`.
**PATCH /boats/{id}** — POST ile aynı alanlar, tümü opsiyonel. `200 BoatDto`.
**DELETE /boats/{id}** — Soft delete (`deleted_at = now()`). Success `204` (gövdesiz). Birincil tekne silinirse en yeni tekne birincil yapılmaz; kullanıcı seçer. Hatalar: `404 NOT_FOUND`, `403 FORBIDDEN`.

---

## 4. Lokasyonlar

### 4.1 GET /locations — harita/arama/filtre (EN KRİTİK ENDPOINT)

- **Auth:** Yok (misafir ve token'sız erişim serbest; token varsa `is_favorite` alanı hesaplanır).
- Yalnızca `status='published' AND deleted_at IS NULL` kayıtlar döner.
- **Coğrafi kapsam zorunlu:** `bbox` VEYA (`center` + `radius`) verilmelidir; ikisi birden verilirse `400 VALIDATION_ERROR`. İstisna: `q` verilmişse coğrafi parametre opsiyoneldir (metin araması TR genelinde çalışır).

Query parametreleri:

| Parametre | Tip | Zorunlu | Validasyon / Açıklama |
|---|---|---|---|
| `bbox` | string | koşullu | `minLng,minLat,maxLng,maxLat` (4 float); harita görünümü sorgusu; alan ≤ 25.000 km² (aşımı `422 BUSINESS_RULE_VIOLATION`, `details.rule="BBOX_TOO_LARGE"`) |
| `center` | string | koşullu | `lng,lat`; `radius` ile birlikte zorunlu |
| `radius` | int | koşullu | metre, 100–100000; `ST_DWithin(geo, center, radius)` |
| `type[]` | enum[] | — | `location_type` değerleri (çoklu): `private_marina, municipal_marina, municipal_pier, guest_mooring, restaurant_pier, fuel_pier, boat_club, mooring_point, buoy`; OR mantığı |
| `amenity[]` | string[] | — | Amenity kodları (`electricity, water, fuel, restaurant, shower, market, laundry, wifi, security, open_24h, wc, pump_out, crane, travel_lift, technical_service`); **AND** mantığı (hepsi bulunmalı) |
| `max_boat_length` | number | — | Tekne boyu (m); `max_boat_length_m IS NULL OR max_boat_length_m >= değer` olan lokasyonlar döner |
| `max_draft` | number | — | Tekne draft'ı (m); `max_draft_m IS NULL OR max_draft_m >= değer` |
| `price_tier` | enum | — | `free, paid, unknown` |
| `is_24h` | bool | — | `true` → yalnız 7/24 açık |
| `min_rating` | number | — | 0–5; `rating_avg >= değer AND rating_count > 0` |
| `q` | string | — | 2–100 karakter; `name`, `city`, `district`, `bay_name` üzerinde pg_trgm bulanık arama; `similarity` skoru sıralamaya katılır |
| `sort` | enum | — | `distance` (center varsa varsayılan), `rating` (rating_avg DESC, rating_count DESC), `name` (A→Z), `newest` (created_at DESC); bbox modunda varsayılan `rating` |
| `cursor`, `limit` | — | — | Bölüm 1.3 |

Örnek istek:

```
GET /v1/locations?bbox=27.20,36.90,27.60,37.15&type[]=private_marina&type[]=guest_mooring
    &amenity[]=electricity&amenity[]=water&max_boat_length=13&max_draft=2.3
    &price_tier=paid&is_24h=true&min_rating=4&sort=rating&limit=20
```

Success `200`:

```json
{
  "data": [
    {
      "id": "7c1b9e4d-...",
      "slug": "mugla-bodrum-ornek-marina",
      "name": "Örnek Marina",
      "type": "private_marina",
      "geo": { "lat": 37.0298, "lng": 27.4241 },
      "city": "Muğla",
      "district": "Bodrum",
      "bay_name": null,
      "price_tier": "paid",
      "is_24h": true,
      "rating_avg": 4.62,
      "rating_count": 128,
      "max_boat_length_m": 40.00,
      "max_draft_m": 5.50,
      "cover_photo_url": "https://cdn.dockly.app/locations/7c1b.../cover.jpg",
      "is_favorite": false,
      "distance_m": null
    }
  ],
  "pagination": { "next_cursor": "eyJyIjo0LjYyLCJpZCI6Ijdj...", "has_more": true }
}
```

Hatalar: `400 VALIDATION_ERROR` (coğrafi kapsam eksik/çift, bilinmeyen enum, `radius` aralık dışı), `400 INVALID_CURSOR`, `422 BUSINESS_RULE_VIOLATION` (BBOX_TOO_LARGE), `429 RATE_LIMITED`.

### 4.2 GET /locations/{id}

- **Auth:** Yok. Path: `id` — UUID **veya** `slug` kabul edilir.
- `draft/archived` veya soft-delete edilmiş kayıt public istemciye `404 NOT_FOUND` (staff token'ıyla görünür).
- Girişli kullanıcıda yan etki: `recently_viewed` upsert edilir (asenkron, yanıtı geciktirmez).

Success `200` — `LocationDetail`:

```json
{
  "data": {
    "id": "7c1b9e4d-...",
    "slug": "mugla-bodrum-ornek-marina",
    "name": "Örnek Marina",
    "type": "private_marina",
    "status": "published",
    "geo": { "lat": 37.0298, "lng": 27.4241 },
    "country_code": "TR",
    "city": "Muğla",
    "district": "Bodrum",
    "bay_name": null,
    "description": "450 yat kapasiteli, tam donanımlı marina...",
    "phone": "+902523160000",
    "website": "https://ornekmarina.com",
    "vhf_channel": "73",
    "max_boat_length_m": 40.00,
    "max_draft_m": 5.50,
    "capacity": 450,
    "price_tier": "paid",
    "is_24h": true,
    "rating_avg": 4.62,
    "rating_count": 128,
    "amenities": [
      { "code": "electricity", "name": "Elektrik", "icon": "bolt" },
      { "code": "water", "name": "Su", "icon": "droplet" },
      { "code": "fuel", "name": "Yakıt", "icon": "fuel-pump" }
    ],
    "photos": [
      { "id": "a1...", "url": "https://cdn.dockly.app/locations/7c1b.../a1.jpg",
        "thumb_url": "https://cdn.dockly.app/locations/7c1b.../a1_thumb.jpg",
        "width": 1920, "height": 1080, "owner_type": "location",
        "created_at": "2026-06-10T08:00:00Z" }
    ],
    "is_favorite": true,
    "created_at": "2026-05-01T10:00:00Z",
    "updated_at": "2026-07-01T14:30:00Z"
  }
}
```

Hatalar: `404 NOT_FOUND`.

---

## 5. Yorumlar

### 5.1 GET /locations/{id}/reviews

- **Auth:** Yok. Yalnız `status='approved' AND deleted_at IS NULL`; girişli kullanıcının kendi `pending/rejected` yorumu da (kendine) `my_review` alanında döner.
- Query: `cursor`, `limit`, `sort` (`newest` varsayılan | `rating_high` | `rating_low`).

Success `200`:

```json
{
  "data": [
    {
      "id": "3e8a...", "location_id": "7c1b9e4d-...", "rating": 5,
      "body": "Personel çok ilgili, elektrik-su sorunsuz.",
      "status": "approved", "created_at": "2026-06-20T18:45:00Z",
      "user": { "id": "0d9f...", "full_name": "Deniz Y.", "avatar_url": null },
      "photos": []
    }
  ],
  "my_review": null,
  "pagination": { "next_cursor": null, "has_more": false }
}
```

### 5.2 POST /locations/{id}/reviews

- **Auth:** Kullanıcı (misafir → `403 AUTH_FULL_ACCOUNT_REQUIRED`).

```json
{ "rating": 5, "body": "Personel çok ilgili, elektrik-su sorunsuz." }
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `rating` | int | ✅ | 1–5 |
| `body` | string | — | ≤2000 karakter; boş string `null` sayılır |

Kurallar: Yorum `status='pending'` doğar (moderation_status); onaylanınca `rating_avg/rating_count` trigger ile güncellenir. Kullanıcı başına lokasyonda 1 aktif yorum. Fotoğraf eklemek için yorum oluşturduktan sonra `POST /photos/presign` (`owner_type='review'`) akışı kullanılır.

Success `201`: `{ "data": ReviewDto }` (`status: "pending"`). Hatalar: `404 NOT_FOUND` (lokasyon), `409 REVIEW_ALREADY_EXISTS`, `400 VALIDATION_ERROR`.

### 5.3 DELETE /reviews/{id}

- **Auth:** Kullanıcı (yalnız kendi yorumu; staff her yorumu silebilir — admin tarafı için Bölüm 11.3).
- Soft delete; trigger `rating_avg/rating_count`'u yeniden hesaplar. Success `204`. Hatalar: `404 NOT_FOUND`, `403 FORBIDDEN`.

---

## 6. Fotoğraflar — iki adımlı S3 yükleme akışı

Akış: **(1) presign → (2) istemci S3'e PUT → (3) complete**. Fotoğraf `complete` çağrısına kadar sistemde görünmez; `complete` sonrası `moderation_status='pending'` ile moderasyon kuyruğuna girer.

### 6.1 POST /photos/presign

- **Auth:** Kullanıcı. Rate limit: 20/saat.

```json
{
  "owner_type": "location",
  "owner_id": "7c1b9e4d-...",
  "content_type": "image/jpeg",
  "size_bytes": 2481303
}
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `owner_type` | enum | ✅ | `location, boat, review` |
| `owner_id` | uuid | ✅ | Var olan ve erişilebilir kayıt; `boat`/`review` için sahiplik denetimi (kendi kaydı olmalı) |
| `content_type` | string | ✅ | `image/jpeg, image/png, image/webp, image/heic` |
| `size_bytes` | int | ✅ | 1 – 15.728.640 (15 MB) |

Success `200`:

```json
{
  "data": {
    "photo_id": "b4c7...",
    "s3_key": "locations/7c1b9e4d/b4c7....jpg",
    "upload_url": "https://dockly-photos.s3.eu-central-1.amazonaws.com/locations/7c1b9e4d/b4c7....jpg?X-Amz-Algorithm=...",
    "expires_in": 900,
    "required_headers": { "Content-Type": "image/jpeg" }
  }
}
```

İstemci `upload_url`'e ham dosyayı `PUT` eder (`required_headers` ile). URL 15 dk geçerlidir; süresi dolarsa yeni presign alınır. Hatalar: `400 VALIDATION_ERROR`, `403 FORBIDDEN` (başkasının teknesi/yorumu), `404 NOT_FOUND` (owner), `429 RATE_LIMITED`.

### 6.2 POST /photos/complete

- **Auth:** Kullanıcı. `Idempotency-Key` önerilir.

```json
{ "photo_id": "b4c7...", "width": 1920, "height": 1080 }
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `photo_id` | uuid | ✅ | Aynı kullanıcının presign'ı; henüz complete edilmemiş |
| `width`, `height` | int | — | >0; sunucu S3 `HEAD` ile varlığı + boyutu doğrular |

Success `201`: `{ "data": PhotoDto }` (`status: "pending"` — moderasyon onayına kadar galeride görünmez, yükleyen kendi profilinde görür). Hatalar: `404 NOT_FOUND` (presign kaydı yok/expired), `422 BUSINESS_RULE_VIOLATION` (`details.rule="S3_OBJECT_MISSING"` — dosya S3'e yüklenmemiş), `409 IDEMPOTENCY_CONFLICT`.

---

## 7. Favoriler ve Son Görüntülenenler

### 7.1 Favoriler

**GET /favorites** — Auth: Kullanıcı. Query: `cursor`, `limit`. Success `200`: `{ "data": [LocationSummary], "pagination": {...} }` (favori eklenme sırasına göre yeni→eski).

**PUT /favorites/{locationId}** — Auth: Kullanıcı. Path: `locationId` UUID. İdempotent upsert (zaten favoriyse yine `204`). Hatalar: `404 NOT_FOUND` (published olmayan lokasyon). Success `204`.

**DELETE /favorites/{locationId}** — Auth: Kullanıcı. Hard delete, idempotent (yoksa da `204`). Success `204`.

### 7.2 Son görüntülenenler

**GET /recently-viewed** — Auth: Misafir+ (misafirde cihaz-yerel Drift cache birleşimi istemcide yapılır; sunucu yalnız hesaba bağlı kayıtları döner). Query: `limit` (varsayılan 20, max 50; cursor yok — cap'li liste). Success `200`: `{ "data": [ { "location": LocationSummary, "viewed_at": "..." } ] }`.

**POST /recently-viewed** — Auth: Misafir+.

```json
{ "location_id": "7c1b9e4d-..." }
```

Upsert (`ON CONFLICT (user_id, location_id) DO UPDATE SET viewed_at = now()`). Success `204`. Hata: `404 NOT_FOUND`.

---

## 8. Rezervasyon Talepleri (request-only — v1)

> v1'de gerçek rezervasyon YOKTUR; talepler Dockly operasyon ekibi tarafından manuel işlenir. Akış: `pending → contacted → confirmed | cancelled | expired`.

### 8.1 GET /booking-requests

- **Auth:** Kullanıcı. Kendi talepleri.
- Query: `status` (opsiyonel, `booking_request_status` değeri), `cursor`, `limit`. Sıralama `created_at DESC`.
- Success `200`: `{ "data": [BookingRequestDto], "pagination": {...} }`.

### 8.2 POST /booking-requests

- **Auth:** Kullanıcı (misafir → `403 AUTH_FULL_ACCOUNT_REQUIRED`). `Idempotency-Key` ŞİDDETLE önerilir. Rate limit 10/saat.

Request:

```json
{
  "location_id": "7c1b9e4d-...",
  "boat_id": "5a2f...",
  "boat_length_m": 12.87,
  "boat_draft_m": 2.24,
  "check_in": "2026-07-15",
  "check_out": "2026-07-18",
  "phone": "+905321234567",
  "note": "3 gece, kıç-kıçtan bağlama tercih ederiz."
}
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `location_id` | uuid | ✅ | `published` ve silinmemiş lokasyon |
| `boat_id` | uuid | — | Kullanıcının kendi teknesi; verilirse `boat_length_m`/`boat_draft_m` boş bırakılabilir (tekneden snapshot kopyalanır) |
| `boat_length_m` | number | koşullu | `boat_id` yoksa ✅; 0 < x ≤ 200 |
| `boat_draft_m` | number | — | 0 < x ≤ 20 |
| `check_in` | date | ✅ | `YYYY-MM-DD`; bugün veya sonrası |
| `check_out` | date | ✅ | **`check_out > check_in`** (eşitse/küçükse `422`, `details.rule="CHECK_OUT_BEFORE_CHECK_IN"`); max konaklama 90 gece |
| `phone` | string | ✅ | E.164; profil telefonu varsa ön-dolu gelir ama gövdede yine zorunlu |
| `note` | string | — | ≤1000 karakter |

**Boy/draft limit uyarısı (soft-block):** `boat_length_m > locations.max_boat_length_m` veya `boat_draft_m > locations.max_draft_m` ise talep REDDEDİLMEZ (marina bilgileri eskimiş olabilir; karar operasyon ekibinin) — yanıtta `warnings` dizisi döner:

```json
{
  "data": {
    "id": "9b3d...",
    "location": { "id": "7c1b9e4d-...", "name": "Örnek Marina", "type": "private_marina", "city": "Muğla" },
    "boat_id": "5a2f...",
    "boat_length_m": 12.87,
    "boat_draft_m": 2.24,
    "check_in": "2026-07-15",
    "check_out": "2026-07-18",
    "phone": "+905321234567",
    "note": "3 gece, kıç-kıçtan bağlama tercih ederiz.",
    "status": "pending",
    "created_at": "2026-07-06T11:20:00Z",
    "updated_at": "2026-07-06T11:20:00Z"
  },
  "warnings": [
    { "code": "BOAT_LENGTH_EXCEEDS_LIMIT", "message": "Tekne boyunuz (12.87 m) lokasyonun maksimum boy limitini (12.00 m) aşıyor. Talebiniz yine de iletildi." }
  ]
}
```

Success `201`. Hatalar: `400 VALIDATION_ERROR` (tarih formatı, telefon), `422 BUSINESS_RULE_VIOLATION` (`CHECK_OUT_BEFORE_CHECK_IN`, `CHECK_IN_IN_PAST`, `STAY_TOO_LONG`), `404 NOT_FOUND` (lokasyon/tekne), `409 IDEMPOTENCY_CONFLICT`, `429 RATE_LIMITED`.

Yan etki: operasyon ekibine bildirim; kullanıcıya durum değişimlerinde `notification_type='booking_status'` bildirimi + FCM push.

### 8.3 POST /booking-requests/{id}/cancel

- **Auth:** Kullanıcı (yalnız kendi talebi). Gövde opsiyonel: `{ "reason": "Plan değişti" }` (≤500 karakter).
- Yalnız `pending` veya `contacted` durumdaki talep iptal edilebilir; `confirmed/cancelled/expired` → `400 INVALID_STATUS_TRANSITION`.
- Success `200`: güncel `BookingRequestDto` (`status: "cancelled"`). Hatalar: `404 NOT_FOUND`, `403 FORBIDDEN`.

---

## 9. Topluluk: Öneriler ve Hata Bildirimi

### 9.1 POST /suggestions

- **Auth:** Kullanıcı. `Idempotency-Key` önerilir.

```json
{
  "type": "new_location",
  "location_id": null,
  "payload": {
    "name": "Kısebükü Koyu Şamandıraları",
    "type": "buoy",
    "geo": { "lat": 36.9812, "lng": 27.5634 },
    "city": "Muğla",
    "district": "Bodrum",
    "bay_name": "Kısebükü",
    "note": "8 adet ücretsiz şamandıra var."
  }
}
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `type` | enum | ✅ | `new_location, edit_location` |
| `location_id` | uuid | koşullu | `edit_location` için ✅ (var olan lokasyon); `new_location` için `null` |
| `payload` | object | ✅ | ≤16 KB JSONB; `new_location` için en az `name`, `type`, `geo` zorunlu; `edit_location` için değişen alanların diff'i |

Success `201`: `{ "data": { "id": "...", "type": "new_location", "status": "pending", "created_at": "..." } }`. Hatalar: `400 VALIDATION_ERROR`, `404 NOT_FOUND` (edit hedefi), `403 AUTH_FULL_ACCOUNT_REQUIRED`.

### 9.2 POST /reports

- **Auth:** Kullanıcı.

```json
{ "location_id": "7c1b9e4d-...", "reason": "wrong_position", "description": "İskele 200 m daha batıda." }
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `location_id` | uuid | ✅ | Var olan lokasyon |
| `reason` | enum | ✅ | `wrong_info, closed_permanently, wrong_photo, wrong_position, other` |
| `description` | string | `reason='other'` ise ✅ | ≤1000 karakter |

Success `201`: `{ "data": { "id": "...", "status": "pending", "created_at": "..." } }`. Hatalar: `400`, `404`, `403 AUTH_FULL_ACCOUNT_REQUIRED`, `429`.

---

## 10. Bildirimler ve Cihazlar

### 10.1 GET /notifications

- **Auth:** Kullanıcı. Query: `cursor`, `limit`, `unread_only` (bool). `created_at DESC`.
- Success `200`: `{ "data": [NotificationDto], "unread_count": 3, "pagination": {...} }`.

### 10.2 POST /notifications/read

- **Auth:** Kullanıcı.

```json
{ "notification_ids": ["1a...", "2b..."], "all": false }
```

`all=true` → tüm okunmamışlar; aksi halde `notification_ids` (1–100 UUID) zorunlu. Success `200`: `{ "data": { "updated_count": 2 } }`.

### 10.3 PUT /devices

- **Auth:** Kullanıcı. FCM token upsert'i (idempotent; `fcm_token` üzerinden `ON CONFLICT`). Uygulama açılışında ve token rotasyonunda çağrılır.

```json
{ "fcm_token": "fXk9...:APA91b...", "platform": "ios", "app_version": "1.4.0", "device_model": "iPhone 15 Pro" }
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `fcm_token` | string | ✅ | 100–4096 karakter |
| `platform` | enum | ✅ | `ios, android` |
| `app_version`, `device_model` | string | — | ≤50 karakter |

Success `204`. Token başka kullanıcıya kayıtlıysa sahiplik yeni kullanıcıya devredilir (cihaz el değiştirmiş demektir).

---

## 11. Admin Endpoint'leri (/admin/*)

Tümü **Staff** (role >= moderator) ister; satırda daha yüksek rol belirtilmişse o geçerlidir. Tüm admin yazma işlemleri `audit_logs`'a düşer. Sayfalama/hata kuralları aynıdır.

### 11.1 Lokasyon CRUD — /admin/locations

| Method + Path | Rol | Açıklama |
|---|---|---|
| `GET /admin/locations` | moderator | Public filtrelerin tamamı + `status` (`draft/published/archived`), `country_code`, `include_deleted` (bool, admin+) |
| `POST /admin/locations` | admin | Yeni lokasyon; `status='draft'` doğar |
| `GET /admin/locations/{id}` | moderator | Her durumdaki kaydı görür (draft/archived/silinmiş) |
| `PATCH /admin/locations/{id}` | admin | Alan güncelleme + `status` geçişi (`draft→published→archived`) |
| `DELETE /admin/locations/{id}` | admin | Soft delete |
| `PUT /admin/locations/{id}/amenities` | admin | Amenity setini komple değiştirir: `{ "amenity_codes": ["electricity","water"] }` |

`POST /admin/locations` gövdesi (validasyonlar DB constraint'leriyle birebir):

```json
{
  "slug": "mugla-bodrum-ornek-marina",
  "name": "Örnek Marina",
  "type": "private_marina",
  "geo": { "lat": 37.0298, "lng": 27.4241 },
  "country_code": "TR",
  "city": "Muğla",
  "district": "Bodrum",
  "bay_name": null,
  "description": "...",
  "phone": "+902523160000",
  "website": "https://ornekmarina.com",
  "vhf_channel": "73",
  "max_boat_length_m": 40.0,
  "max_draft_m": 5.5,
  "capacity": 450,
  "price_tier": "paid",
  "is_24h": true
}
```

Zorunlu: `slug` (kebab-case, unique — çakışmada `409 CONFLICT`), `name` (2–150), `type` (location_type), `geo` (lat -90..90, lng -180..180), `city`. `rating_avg`/`rating_count` gövdede KABUL EDİLMEZ (trigger cache'i). Success `201`: `LocationDetail` (+ `status`).

### 11.2 Fotoğraf moderasyonu — /admin/photos

| Method + Path | Rol | Açıklama |
|---|---|---|
| `GET /admin/photos` | moderator | Kuyruk; query: `status` (varsayılan `pending`), `owner_type`, `cursor`, `limit` |
| `POST /admin/photos/{id}/moderate` | moderator | Karar |

```json
{ "action": "approve" }
```
veya
```json
{ "action": "reject", "reason": "Konum ile ilgisiz görsel" }
```

`action`: `approve | reject` (✅); `reject` için `reason` ✅ (≤500). Onay → `status='approved'`, fotoğraf galeride görünür, yükleyene `notification_type='new_photo'` üzerinden değil — kendi fotoğrafı onaylandı bildirimi `system` tipiyle gider; lokasyonu favorileyenlere `new_photo` bildirimi gider. Success `200`: `PhotoDto`. Hatalar: `404`, `409 CONFLICT` (zaten karar verilmiş).

### 11.3 Yorum moderasyonu — /admin/reviews

| Method + Path | Rol | Açıklama |
|---|---|---|
| `GET /admin/reviews` | moderator | Query: `status` (varsayılan `pending`), `location_id`, `user_id`, `cursor`, `limit` |
| `POST /admin/reviews/{id}/moderate` | moderator | `{ "action": "approve" \| "reject", "reason": "..." }` — approve → rating cache trigger'ı çalışır; yazara `new_review` değil `system` bildirimi; lokasyonu favorileyenlere `new_review` |
| `DELETE /admin/reviews/{id}` | admin | Soft delete (kural dışı içerik) |

### 11.4 Talep yönetimi — /admin/booking-requests

| Method + Path | Rol | Açıklama |
|---|---|---|
| `GET /admin/booking-requests` | moderator | Query: `status`, `location_id`, `date_from`, `date_to`, `q` (kullanıcı adı/telefon), `cursor`, `limit`; varsayılan sıralama `status='pending'` öncelikli, `created_at ASC` (FIFO) |
| `GET /admin/booking-requests/{id}` | moderator | Tam detay + kullanıcı/tekne bilgisi + durum geçmişi (audit'ten) |
| `POST /admin/booking-requests/{id}/status` | moderator | Durum güncelleme |

```json
{ "status": "contacted", "status_note": "Marina arandı, yer var, kullanıcıya dönülecek." }
```

| Alan | Tip | Zorunlu | Validasyon |
|---|---|---|---|
| `status` | enum | ✅ | Akış kuralı zorunlu: `pending→contacted`, `contacted→confirmed`, her ikisinden `cancelled`/`expired`; ihlal → `400 INVALID_STATUS_TRANSITION` |
| `status_note` | string | — | ≤1000 karakter; kullanıcıya GÖSTERİLMEZ (iç not) |

Yan etki: kullanıcıya `booking_status` bildirimi + FCM push; `handled_by` işlem yapan admin olarak set edilir. Success `200`: `BookingRequestDto`.

### 11.5 Öneri ve rapor moderasyonu

| Method + Path | Rol | Açıklama |
|---|---|---|
| `GET /admin/suggestions` | moderator | Query: `status`, `type` (`new_location/edit_location`), `cursor`, `limit` |
| `POST /admin/suggestions/{id}/moderate` | admin | `approve` → `new_location` ise payload'dan taslak lokasyon oluşturur (`status='draft'`), `edit_location` ise diff uygulanır; `reject` + `reason` |
| `GET /admin/reports` | moderator | Query: `status`, `reason`, `location_id`, `cursor`, `limit` |
| `POST /admin/reports/{id}/resolve` | moderator | `{ "action": "approve" \| "reject", "note": "..." }` (approve = rapor haklı, düzeltme yapıldı) |

### 11.6 Kullanıcı yönetimi — /admin/users

| Method + Path | Rol | Açıklama |
|---|---|---|
| `GET /admin/users` | admin | Query: `q` (ad/e-posta/telefon), `role`, `cursor`, `limit` |
| `GET /admin/users/{id}` | admin | Profil + içerik sayaçları |
| `PATCH /admin/users/{id}` | super_admin | Yalnız `role` değişimi; kendi rolünü düşüremez, `super_admin` atamasını yalnız `super_admin` yapar |
| `DELETE /admin/users/{id}` | super_admin | Soft delete + oturum iptali |

### 11.7 GET /admin/stats

- **Rol:** moderator. Query: `date_from`, `date_to` (varsayılan son 30 gün), `granularity` (`day/week/month`).

Success `200`:

```json
{
  "data": {
    "totals": {
      "users": 28450, "boats": 21200, "locations_published": 1140,
      "reviews_approved": 54300, "photos_approved": 81200,
      "booking_requests": 38900, "favorites": 141000
    },
    "pending_queues": { "photos": 42, "reviews": 17, "suggestions": 9, "reports": 4, "booking_requests": 23 },
    "booking_requests_by_status": { "pending": 23, "contacted": 118, "confirmed": 3120, "cancelled": 890, "expired": 410 },
    "series": [
      { "date": "2026-07-01", "new_users": 310, "new_booking_requests": 145, "new_reviews": 220 }
    ]
  }
}
```

---

## 12. Sürümleme ve Uyum Notları

- DTO alan adları DB kolonlarıyla birebirdir (bkz. 04-veritabani-tasarimi.md); `LocationSummary` liste/harita için hafif, `LocationDetail` detay ekranı (S-09) için tam settir — istemci (packages/dockly_api) iki ayrı DTO tanımlar.
- Yeni `location_type` / amenity kodu eklenirse istemciler bilinmeyen değeri `other`/gizli olarak ele almalıdır (forward compatibility).
- Gelecek modüller (availability, payments) yeni endpoint kökleri olarak eklenecek (`/availability`, `/payments`); mevcut `/v1` sözleşmesi kırılmaz (foundation Bölüm 9).
