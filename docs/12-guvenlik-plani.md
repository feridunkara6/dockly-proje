# Dockly — Güvenlik Planı (12)

> Bu doküman [00-foundation.md](00-foundation.md) kanonik temel dokümanına bağlıdır. Tablo adları, enum'lar, endpoint'ler ve roller oradan birebir alınmıştır.
> Kapsam: mobil uygulama (`com.dockly.app`), admin web (`com.dockly.admin`), Supabase backend, AWS S3/CloudFront, Firebase Authentication.

---

## 1. Güvenlik İlkeleri ve Tehdit Modeli Özeti

### 1.1 İlkeler
- **Least privilege:** Her istemci, her rol ve her servis yalnızca ihtiyacı olan veriye erişir. RLS (Row Level Security) varsayılan olarak AÇIK; politika yoksa erişim YOK.
- **Defense in depth:** Edge Function doğrulaması + PostgREST RLS + veritabanı constraint'leri + client-side validation birlikte çalışır; hiçbiri tek başına yeterli sayılmaz.
- **Secure by default:** Yeni tablo = RLS enabled + deny-all. Yeni endpoint = auth zorunlu (istisna: `GET /locations` public read).
- **Auditability:** Tüm kritik değişiklikler `audit_logs` tablosuna yazılır (append-only).

### 1.2 Tehdit Modeli (STRIDE özet)
| Tehdit | Örnek senaryo | Ana savunma |
|---|---|---|
| Spoofing | Sahte Firebase ID token | Edge'de Firebase Admin SDK ile token doğrulama |
| Tampering | Başka kullanıcının `boats` kaydını değiştirme | RLS `user_id = auth.uid()` politikaları |
| Repudiation | Admin'in moderasyon kararını inkârı | `audit_logs` (actor, action, before/after) |
| Information disclosure | Presigned URL sızması, PII sızıntısı | Kısa TTL, private bucket, alan bazlı maskeleme |
| Denial of service | `POST /booking-requests` flood | Rate limiting + idempotency key |
| Elevation of privilege | `role` alanının client'tan set edilmesi | `users.role` yalnızca service-role ile yazılabilir |

---

## 2. Kimlik Doğrulama Güvenliği (Authentication)

### 2.1 Firebase ID Token Doğrulama
Kanonik akış (bkz. foundation §6): `Authorization: Bearer <Firebase ID Token>` → Edge Function → Supabase JWT köprüsü.

1. İstemci Firebase Authentication (Apple, Google, E-posta, Telefon, Anonim/Misafir) ile giriş yapar ve ID token alır.
2. `POST /auth/session` çağrısında Edge Function (Deno) token'ı doğrular:
   - İmza: Google `securetoken@system.gserviceaccount.com` public key'leri ile (JWKS cache: 6 saat, `kid` bazlı).
   - `aud` = Firebase proje ID'si, `iss` = `https://securetoken.google.com/<proje>`, `exp`/`iat` kontrolü (clock skew toleransı ±60s).
   - `sub` (Firebase UID) → `users.firebase_uid` eşleşmesi; kayıt yoksa `users` satırı oluşturulur (`role = 'user'`, `country_code = 'TR'`).
3. Edge Function, kısa ömürlü (**15 dk**) bir Supabase JWT üretir; claim'ler: `sub` (users.id), `role` (user_role), `firebase_uid`, `is_anonymous`.
4. Diğer tüm `/v1` istekleri bu Supabase JWT ile PostgREST/Edge'e gider; RLS bu claim'leri kullanır.

Kurallar:
- Edge Function'lar Firebase token'ı ASLA loglamaz (Sentry scrubbing listesinde `authorization` header'ı var).
- `email_verified = false` olan e-posta hesapları yorum/fotoğraf yazamaz (moderasyon yükünü azaltır) — Edge'de kontrol.
- Revoke kontrolü: hesap ele geçirme şüphesinde Firebase `revokeRefreshTokens(uid)` çağrılır; Edge, `auth_time` claim'ini `users.tokens_valid_after` (yeni kolon, migration ile) ile karşılaştırır.

### 2.2 Token Yenileme
- Firebase ID token ömrü 1 saat; Firebase SDK otomatik yeniler. Mobil taraf `idTokenChanges()` stream'ini dinler.
- Supabase köprü JWT'si 15 dk; `dockly_api` paketindeki interceptor 401 aldığında **tek uçuşta** (single-flight mutex) `POST /auth/session` ile yeniler, bekleyen istekleri tekrar oynatır (idempotent olmayan istekler tekrar oynatılmaz, hata döner).
- Refresh döngüsü koruması: 5 dk içinde 3'ten fazla köprü yenileme başarısızsa oturum düşürülür, kullanıcı S-03 (Giriş) ekranına yönlendirilir.
- Token'lar cihazda yalnızca secure storage'da tutulur (bkz. §7.2); Drift cache'ine ASLA yazılmaz.

### 2.3 Misafir (Anonim) Mod Sınırları
Firebase Anonymous auth ile misafir oturum desteklenir; `is_anonymous = true` claim'i taşır.

| Yetenek | Misafir | Kayıtlı kullanıcı |
|---|---|---|
| Harita, `GET /locations`, `GET /locations/{id}` | ✅ | ✅ |
| Arama, filtre, `GET /locations/{id}/reviews` okumak | ✅ | ✅ |
| `recently_viewed` (yalnızca lokal Drift) | ✅ (sunucuya yazılmaz) | ✅ (sunucu senkron) |
| Favori ekleme (`PUT /favorites/{locationId}`) | ❌ → kayıt daveti | ✅ |
| Yorum, puan, fotoğraf yükleme | ❌ | ✅ |
| `POST /booking-requests` | ❌ | ✅ (telefon doğrulanmış olmalı) |
| `POST /suggestions`, `POST /reports` | ❌ | ✅ |
| Tekne profili (`/boats`) | ❌ | ✅ |

- Misafir → kayıtlı geçişte Firebase `linkWithCredential` kullanılır; aynı `firebase_uid` korunur, `users` satırı güncellenir (veri kaybı yok).
- Misafir hesaplar 90 gün inaktifse Firebase tarafında temizlenir (scheduled Edge Function + Admin SDK); `users` satırı soft delete edilir.
- Misafir istekleri daha sıkı rate limit'e tabidir (bkz. §6.1).

### 2.4 Hesap Ele Geçirme (Account Takeover) Önlemleri
- **Sağlayıcı güvenliği:** Apple/Google OAuth birincil; e-posta+şifre için Firebase şifre politikası (min 8, en az 1 harf + 1 rakam) ve e-posta doğrulama zorunlu.
- **OTP (S-05 Telefon doğrulama):** Firebase Phone Auth; deneme limiti 5/saat/numara, SMS flood'a karşı reCAPTCHA/App Check devrede.
- **Firebase App Check:** Play Integrity (Android) + App Attest (iOS) zorunlu; App Check token'ı olmayan istekler Firebase Auth'ta reddedilir. Edge Function'lar da `X-Firebase-AppCheck` header'ını doğrular (kademeli: önce monitor, sonra enforce).
- **Oturum olayları bildirimi:** Yeni cihaz girişi → `notifications` tablosuna `type = 'system'` kayıt + FCM push ("Hesabınıza yeni bir cihazdan giriş yapıldı").
- **Hassas işlem re-auth:** Hesap silme ve telefon değişikliği için son 5 dk içinde alınmış "fresh" Firebase token gerekir (`auth_time` kontrolü).
- **Kilit:** 10 başarısız girişte Firebase otomatik geciktirme; Edge tarafında IP başına giriş köprüsü limiti (bkz. §6.1).

---

## 3. Yetkilendirme (Authorization)

### 3.1 Rol Hiyerarşisi
Kanonik `user_role`: `user < moderator < admin < super_admin`.

| Yetki | user | moderator | admin | super_admin |
|---|---|---|---|---|
| Kendi verisi (boats, favorites, booking_requests…) | ✅ | ✅ | ✅ | ✅ |
| Fotoğraf/yorum moderasyonu (A-04, A-05) | ❌ | ✅ | ✅ | ✅ |
| `suggestions` / `reports` işleme | ❌ | ✅ | ✅ | ✅ |
| Lokasyon CRUD (A-02), talep işleme (A-06) | ❌ | ❌ | ✅ | ✅ |
| Kullanıcı yönetimi (A-07), rol atama (≤ admin) | ❌ | ❌ | ✅ | ✅ |
| `app_settings`, rol atama (admin/super_admin), `audit_logs` tam erişim | ❌ | ❌ | ❌ | ✅ |

Kurallar:
- Rol yükseltme yalnızca `POST /admin/users/{id}/role` üzerinden; bir aktör kendi rolünü değiştiremez, kendi seviyesine eşit/üstü rol atayamaz (super_admin hariç). Her rol değişikliği `audit_logs`'a yazılır.
- Rol claim'i köprü JWT'sine gömülür; rol değişikliği sonrası eski JWT en fazla 15 dk yaşar (kabul edilen pencere), kritik durumlarda `tokens_valid_after` ile anında düşürülür.

### 3.2 RLS Politikaları — Tablo Bazında
Tüm tablolarda `ALTER TABLE ... ENABLE ROW LEVEL SECURITY;` + `FORCE ROW LEVEL SECURITY`. `auth.uid()` = köprü JWT `sub` (users.id). Yardımcı fonksiyon: `app.role_rank(text) → int` (user=1, moderator=2, admin=3, super_admin=4), `app.current_role()` JWT claim'den okur.

| Tablo | SELECT | INSERT | UPDATE | DELETE |
|---|---|---|---|---|
| `users` | Kendi satırı; moderator+ tüm satırlar (PII maskeli view üzerinden), admin+ tam | Yalnız service-role (auth köprüsü) | Kendi satırı (yalnız profil alanları; `role`, `firebase_uid` hariç — kolon listesi ile); admin+ diğerleri | Yok (soft delete UPDATE ile, yalnız kendi satırı veya admin+) |
| `boats` | `user_id = auth.uid() AND deleted_at IS NULL`; admin+ tümü | `user_id = auth.uid()` | Kendi kaydı | Soft delete: kendi kaydı |
| `locations` | `status = 'published' AND deleted_at IS NULL` herkes (anon dahil); admin+ tüm status'ler | admin+ | admin+ | admin+ (soft delete) |
| `amenities` | Herkes | admin+ | admin+ | admin+ |
| `location_amenities` | Herkes (published lokasyonlar) | admin+ | admin+ | admin+ |
| `photos` | `status = 'approved'` herkes; sahibi kendi `pending/rejected` kayıtlarını görür; moderator+ tümü | `user_id = auth.uid()` (owner_type kurallı) | Sahibi (yalnız caption); moderator+ `status` | Soft delete: sahibi veya moderator+ |
| `reviews` | `status = 'approved' AND deleted_at IS NULL` herkes; sahibi kendi tüm kayıtları; moderator+ tümü | `user_id = auth.uid()`, rating 1-5 CHECK | Sahibi (body/rating, status→pending'e döner); moderator+ status | Soft delete: sahibi veya moderator+ |
| `favorites` | `user_id = auth.uid()` | `user_id = auth.uid()` | — | Hard delete: `user_id = auth.uid()` |
| `recently_viewed` | `user_id = auth.uid()` | `user_id = auth.uid()` (upsert) | Kendi kaydı | Kendi kaydı |
| `booking_requests` | `user_id = auth.uid()`; admin+ tümü | `user_id = auth.uid()`, `status = 'pending'` zorunlu | Kullanıcı yalnız cancel (Edge Function üzerinden); admin+ status geçişleri | Yok (soft delete admin+) |
| `suggestions` | Sahibi; moderator+ tümü | `user_id = auth.uid()` | moderator+ (status) | Soft delete moderator+ |
| `reports` | Sahibi; moderator+ tümü | `user_id = auth.uid()` | moderator+ | Soft delete moderator+ |
| `notifications` | `user_id = auth.uid()` | Yalnız service-role | Kendi kaydı (yalnız `read_at`) | Kendi kaydı |
| `devices` | `user_id = auth.uid()` | `user_id = auth.uid()` | Kendi kaydı | Kendi kaydı |
| `audit_logs` | admin+ (super_admin tam; admin kendi domain'i) | Yalnız service-role / trigger | Yok (append-only) | Yok |
| `app_settings` | Public flag'ler herkes (`is_public = true`); super_admin tümü | super_admin | super_admin | super_admin |

Notlar:
- `booking_requests` status geçişleri (`pending → contacted → confirmed | cancelled | expired`) veritabanı trigger'ı ile doğrulanır; geçersiz geçiş exception fırlatır.
- RLS politikaları pgTAP ile test edilir (bkz. 15-test-stratejisi.md).
- PostgREST'e açılmayan kolonlar (ör. `users.firebase_uid`) column-level `GRANT` ile kısıtlanır.

### 3.3 Admin Panel Erişim Güvenliği (+2FA)
- Admin web (`com.dockly.admin`, A-01…A-08) yalnızca `role >= moderator` hesaplarla açılır; `POST /auth/session` yanıtındaki rol claim'i yetersizse uygulama login'de durur.
- **2FA zorunlu:** moderator ve üzeri tüm hesaplarda Firebase TOTP MFA (multi-factor) etkinleştirilmeden `/admin/*` endpoint'leri 403 döner. Edge, ID token'daki `firebase.sign_in_second_factor` claim'ini kontrol eder.
- Admin oturumu: idle timeout 30 dk, mutlak timeout 12 saat; her admin girişi `audit_logs`'a yazılır (IP, user agent).
- Ağ kısıtı: `/admin/*` API Gateway'de ayrı route; opsiyonel IP allowlist (`app_settings.admin_ip_allowlist`), v1'de ofis + VPN CIDR'ları.
- Admin panelde misafir/anonim token kesinlikle reddedilir (`is_anonymous = true` → 403).

---

## 4. Veri Güvenliği

### 4.1 Şifreleme
- **In-transit:** Tüm trafik TLS 1.2+ (hedef 1.3). `api.dockly.app` HSTS (`max-age=31536000; includeSubDomains`), zayıf cipher'lar kapalı. Mobil ↔ Firebase/Supabase/S3 tamamı HTTPS.
- **At-rest:** Supabase PostgreSQL disk şifreleme (AES-256, sağlayıcı yönetimli). S3 bucket'larda SSE-S3 (AES-256) varsayılan; hassas ekler olursa SSE-KMS'e geçiş planı hazır.
- **Uygulama seviyesi:** `users.phone` ve `booking_requests.phone` alanları için pgcrypto ile kolon şifreleme değerlendirildi; v1'de RLS + maskeli view yeterli görüldü, KVKK denetiminde tekrar değerlendirilecek (karar kaydı: ADR-SEC-01).
- Sırlar (service-role key, Firebase Admin key, S3 credentials): Supabase Vault + GitHub Actions encrypted secrets; koda/`.env` commit'ine izin yok (gitleaks CI'da).

### 4.2 S3 Bucket Politikaları
Bucket'lar (eu-central-1):
| Bucket | İçerik | Erişim |
|---|---|---|
| `dockly-photos-prod` | `photos` tablosundaki tüm görseller (location/boat/review) | Private; okuma YALNIZ CloudFront OAC üzerinden |
| `dockly-photos-staging` | Staging | Private |

Kurallar:
- `BlockPublicAcls`, `BlockPublicPolicy`, `IgnorePublicAcls`, `RestrictPublicBuckets` = true (Block Public Access tam açık).
- Bucket policy: yalnız CloudFront Origin Access Control principal'ına `s3:GetObject`; upload yalnız presigned `PUT` ile.
- Key şeması: `photos/{owner_type}/{owner_id}/{photo_id}/{variant}.webp` — tahmin edilemez UUID'ler; listeleme (`s3:ListBucket`) hiçbir istemci rolüne verilmez.
- Versioning açık (yanlışlıkla silmeye karşı), lifecycle: rejected fotoğraflar 30 gün sonra kalıcı silinir; soft-delete edilen fotoğraflar 90 gün sonra purge.
- CloudFront: HTTPS zorunlu, signed URL gerekmez (approved fotoğraflar public-read semantiği taşır) ama `pending/rejected` varyantlar CDN'e hiç yayınlanmaz (yalnız moderasyon paneli kısa süreli presigned GET ile görür).

### 4.3 Presigned URL Süreleri
| İşlem | Endpoint | TTL | Not |
|---|---|---|---|
| Fotoğraf upload | `POST /photos/presign` → S3 `PUT` | **10 dakika** | Content-Type + max 15 MB `content-length-range` condition |
| Upload tamamlama | `POST /photos/complete` | — | Sunucu S3 `HEAD` ile doğrular, `photos` satırı `pending` olur |
| Moderasyon önizleme (pending) | Admin panel presigned GET | **5 dakika** | Yalnız moderator+ |
| Public görüntüleme | CloudFront URL | TTL yok | Yalnız `approved` |

- Presign isteğinde kullanıcı başına limit: 20/saat (misafir: 0). MIME allowlist: `image/jpeg`, `image/png`, `image/webp`, `image/heic`.
- `POST /photos/complete` sunucuda: gerçek boyut, magic-bytes ile içerik tipi doğrulaması, EXIF GPS/PII strip (Lambda/Edge işleme sırasında).

---

## 5. KVKK Uyumu ve GDPR Hazırlığı

### 5.1 Veri Envanteri (kişisel veri haritası)
| Veri | Tablo/Kolon | Amaç | Hukuki dayanak | Saklama |
|---|---|---|---|---|
| Ad soyad | `users.full_name` | Profil, talep iletişimi | Sözleşmenin ifası | Hesap ömrü + 30 gün |
| E-posta | `users.email` | Giriş, bildirim | Sözleşmenin ifası | Hesap ömrü + 30 gün |
| Telefon | `users.phone`, `booking_requests.phone` | OTP, rezervasyon talebi iletişimi | Sözleşmenin ifası / açık rıza | Hesap ömrü + 30 gün; taleplerde 2 yıl (uyuşmazlık) |
| Avatar | `users.avatar_url` + S3 | Profil | Açık rıza | Hesap ömrü |
| Tekne bilgisi | `boats.*` | Uygunluk filtreleri, talep formu | Sözleşmenin ifası | Hesap ömrü |
| Konum (anlık) | Yalnız cihazda (harita merkezleme) | Keşif | Açık rıza (OS izni) | Sunucuda TUTULMAZ |
| Kullanım kayıtları | `audit_logs`, `recently_viewed` | Güvenlik, ürün | Meşru menfaat | audit 2 yıl; recently_viewed 90 gün |
| FCM token | `devices` | Push | Açık rıza | Token geçersizleşince / hesap silinince |
| Yorum/fotoğraf | `reviews`, `photos` | Topluluk içeriği | Açık rıza | Anonimleştirilerek kalabilir (bkz. 5.3) |

### 5.2 Açık Rıza ve Aydınlatma
- Onboarding (S-02) sonunda ve kayıtta (S-04/S-05): Aydınlatma Metni + açık rıza checkbox'ları (zorunlu işleme için rıza istenmez, ayrı gösterilir):
  1. Pazarlama bildirimleri (opsiyonel, varsayılan KAPALI),
  2. Fotoğraf/yorumun herkese açık yayımlanması (içerik üretiminde),
  3. Konum izni (OS düzeyinde, gerekçeli pre-prompt).
- Rıza kayıtları: `users` üzerinde `consents JSONB` (versiyon, timestamp, kanal) — rıza metni versiyonlanır (`app_settings.consent_version`).
- Ayarlar (S-20) → "Gizlilik": rızaları geri çekme, veri indirme talebi, hesap silme.

### 5.3 Silme Hakkı → Soft Delete + Anonimleştirme Akışı
Kullanıcı "Hesabımı sil" dediğinde (S-20 → re-auth → onay):
1. `DELETE /users/me` Edge Function tetiklenir; `users.deleted_at = now()`, PII alanları hemen NULL'lanır/karartılır: `email → deleted+{id}@dockly.app`, `phone → NULL`, `full_name → 'Silinmiş Kullanıcı'`, `avatar_url → NULL` (S3 objesi silme kuyruğuna).
2. Firebase hesabı Admin SDK ile silinir; `devices` satırları hard delete (push kesilir).
3. Bağlı veriler:
   - `boats`, `favorites`, `recently_viewed`, `notifications` → hard delete/soft delete (favorites hard, diğerleri soft).
   - `reviews`, `photos` (approved) → içerik kalır, `user_id` anonimleştirilmiş kullanıcıya bağlı kalır; ekranda "Dockly Kullanıcısı" görünür. Kullanıcı isterse silme talebinde "içeriklerim de silinsin" seçer → soft delete.
   - `booking_requests` → 2 yıl saklanır (uyuşmazlık/meşru menfaat), PII'si maskelenmiş halde.
4. 30 gün pişmanlık penceresi YOK (anında anonimleştirme); yalnızca yedeklerden doğal düşme süresi bildirilir (max 35 gün, PITR + yedek rotasyonu).
5. Tüm akış `audit_logs`'a `action = 'user.delete'` olarak yazılır (PII içermeden).

### 5.4 Diğer KVKK Yükümlülükleri
- VERBİS kaydı ve Veri Sorumlusu iletişimi lansmandan önce tamamlanır; başvuru kanalı: `kvkk@dockly.app` + uygulama içi form; yanıt SLA'sı 30 gün.
- Veri işleyen sözleşmeleri (DPA): Supabase, AWS, Google (Firebase), Mapbox, Sentry — hepsiyle DPA/SCC dosyalanır.
- Yurt dışı aktarım: Firebase/AWS AB bölgeleri seçilir; KVKK md.9 kapsamında açık rıza + standart sözleşme yaklaşımı hukuk danışmanıyla netleştirilir.

### 5.5 GDPR Hazırlığı (Avrupa açılımı)
Foundation §9 uyarınca tüm içerik tablolarında `country_code` mevcut; GDPR için ek hazırlık:
- **Veri yerleşimi:** AB kullanıcı verisi için Supabase EU (Frankfurt) zaten kullanılıyor; S3 `eu-central-1`. AB açılımında ek bölge gerekmez.
- **Haklar:** Erişim (export: `GET /users/me/export` — JSON dump, v1.1), taşınabilirlik, itiraz, kısıtlama akışları KVKK akışlarının üzerine eklenir.
- **DPO / Art.27 temsilcisi:** AB lansmanından önce atanır.
- **Cookie/SDK consent:** Admin web için consent banner; mobilde ATT (iOS App Tracking Transparency) — v1'de üçüncü taraf reklam/tracking SDK'sı YOK, yalnız Crashlytics/Sentry (meşru menfaat, aydınlatmada belirtilir).
- Records of Processing (RoPA) dokümanı §5.1 envanterinden türetilir ve çeyreklik güncellenir.

---

## 6. API Güvenliği

### 6.1 Rate Limiting
API Gateway + Edge Function katmanında, anahtar = `users.id` (auth'lu) veya IP (anon):

| Kapsam | Limit | Pencere |
|---|---|---|
| Genel okumalar (`GET /locations` vb.) | 120 istek | 1 dk / kullanıcı |
| Anon/misafir okumalar | 60 istek | 1 dk / IP |
| `POST /auth/session` | 10 | 1 dk / IP |
| `POST /booking-requests` | 5 | 1 saat / kullanıcı |
| `POST /locations/{id}/reviews` | 3 | 1 saat / kullanıcı |
| `POST /photos/presign` | 20 | 1 saat / kullanıcı |
| `POST /suggestions` + `POST /reports` | 10 | 1 gün / kullanıcı |
| `/admin/*` | 300 | 1 dk / admin |

- Aşımda `429` + `Retry-After`; mobil taraf exponential backoff uygular. Limitler `app_settings` üzerinden ayarlanabilir.
- Şüpheli desenler (tek IP'den çok UID, user-agent anomalisi) Supabase Logs → alarm.

### 6.2 Input Validation
- Edge Function'larda şema doğrulama (Zod): tip, uzunluk, format, enum üyeliği (`location_type`, `boat_type`, `report_reason`… foundation §4 listelerinden).
- Örnek kurallar: `rating` 1..5; `check_in < check_out`, `check_in >= today`; `boat_length_m` 0–200 `NUMERIC(5,2)`; `note`/`body` max 2000 karakter; `bbox` parametresi 4 float + max alan sınırı (aşırı geniş bbox reddedilir).
- Bilinmeyen alanlar reddedilir (strict parsing). Hata formatı kanonik: `{ "error": { "code", "message", "details" } }` — `details.fields` alan bazlı.
- Veritabanı ikinci hat: CHECK constraint'ler, enum tipleri, FK'ler, trigger'lar.

### 6.3 SQL Injection / XSS Önlemleri
- SQL: PostgREST parametrik erişim + Edge Function'larda yalnızca supabase-js/parametreli sorgular; string birleştirme ile SQL YASAK (code review checklist maddesi). `pg_trgm` arama girdisi escape edilir, `websearch_to_tsquery` benzeri güvenli fonksiyonlar tercih edilir.
- XSS: API yalnızca JSON döner, HTML üretmez. Kullanıcı içeriği (yorum body, tekne adı) mobilde Text widget'ı ile (HTML render yok), admin webde Flutter Web (DOM injection yüzeyi yok; yine de `dart:html` ile raw HTML basılmaz).
- Depolanan içerikte kontrol karakterleri ve aşırı unicode temizlenir (sanitize-then-store: trim + control char strip; görünüm katmanında ek escape).
- CSP (admin web hosting): `default-src 'self'`, Mapbox/Firebase/Sentry origin'leri açık allowlist.

### 6.4 Idempotency
- Yazma uçları (`POST /booking-requests`, `POST /photos/complete`, `POST /suggestions`, `POST /reports`) `Idempotency-Key` header'ı destekler (UUID, zorunlu: booking-requests).
- Edge Function anahtarı `idempotency_keys` yardımcı tablosunda (key, user_id, endpoint, response_hash, expires_at 24h) saklar; tekrar istekte ilk yanıt aynen döner.
- Doğal idempotent uçlar: `PUT /favorites/{locationId}`, `PUT /devices`, `POST /notifications/read` (idempotent tasarım, key gerekmez).
- Ayrıca `booking_requests` üzerinde kısmi unique index: aynı kullanıcı + lokasyon + check_in için aktif `pending` talep tekliği.

### 6.5 Diğer API Sertleştirmeleri
- CORS: mobil için gerekmez; admin web origin'i (`admin.dockly.app`) dışındakiler reddedilir.
- HTTP metod/route allowlist; PostgREST şeması yalnız `api` schema'yı expose eder, tablolara doğrudan erişim view/RPC ile sınırlandırılır.
- Sürümleme: `/v1` kırıcı değişiklik yapmaz; güvenlik düzeltmeleri geriye uyumlu yayınlanır.

---

## 7. Mobil Uygulama Güvenliği

### 7.1 Certificate Pinning
- Hedef: `api.dockly.app` için SPKI pinning (Dio `badCertificateCallback` yerine `http` sertifika doğrulaması + pin listesi; `dockly_api` paketinde).
- 2 pin: aktif leaf/intermediate + yedek (rotasyon için). Pin seti `app_settings` üzerinden acil güncellenebilir (pin-break durumunda uzaktan kapatma anahtarı: `security.cert_pinning_enabled`).
- Firebase/Mapbox/S3 domain'leri pin'lenmez (sağlayıcı rotasyonu kırılganlığı); yalnız kendi API'miz pinlenir. Karar: ADR-SEC-02.

### 7.2 Secure Storage
- `flutter_secure_storage`: iOS Keychain (`kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`), Android EncryptedSharedPreferences/Keystore.
- Saklananlar: Supabase köprü JWT, Firebase yenileme materyali (SDK kendi yönetir), cihaz kayıt kimliği.
- Drift (SQLite) cache'inde token/PII yok; yalnız `locations`, `amenities`, favori ID listesi gibi genel veriler. Gerekirse SQLCipher'a geçiş noktası ayrıldı.
- Ekran güvenliği: S-05 (OTP) ve ödeme benzeri gelecek ekranlarda Android `FLAG_SECURE` (screenshot engeli) — v1'de yalnız OTP.

### 7.3 Jailbreak / Root Tespiti Kararı
- **Karar (ADR-SEC-03): v1'de engelleme YOK, tespit + telemetri VAR.** Dockly finansal işlem yapmıyor (online ödeme hard exclusion); agresif root engelleme meşru kullanıcıları kaybettirir.
- `flutter_jailbreak_detection` ile tespit → Crashlytics custom key + analytics; root'lu cihazda hassas uyarı gösterilmez, davranış değişmez.
- Online ödeme geldiğinde (gelecek modül) karar yeniden değerlendirilir: ödeme akışında root'lu cihaza ek doğrulama.

### 7.4 Kod Obfuscation ve Build Sertleştirme
- Release build: `flutter build --obfuscate --split-debug-info=build/symbols` (semboller CI artefaktı olarak saklanır, Sentry/Crashlytics'e yüklenir).
- Android: R8 shrinking, `debuggable=false`, imzalama anahtarı yalnız CI secret'ta (Play App Signing). iOS: bitcode dışı standart, provisioning CI'da.
- API anahtarları: Mapbox public token domain/bundle kısıtlı; Firebase config dosyaları zaten public sayılır (güvenlik App Check + Rules ile). Gerçek sırlar mobil binary'ye GİRMEZ.
- Reverse engineering testi: her major release'te bir kez `apktool`/`class-dump` hızlı incelemesi (sızan string, endpoint, anahtar taraması).

---

## 8. İçerik Güvenliği (Trust & Safety)

### 8.1 Fotoğraf / Yorum Moderasyon Süreci
Kanonik `moderation_status`: `pending → approved | rejected`.
1. Kullanıcı içeriği (S-12 yorum, S-13 fotoğraf) `pending` olarak girer; yalnız sahibi görür.
2. Otomatik ön filtre: fotoğrafta AWS Rekognition moderation labels (nudity/violence eşiği) — eşik üstü otomatik `rejected` + moderasyon kuyruğuna işaret; yorumda TR küfür/spam sözlüğü + link sayısı kuralı.
3. İnsan moderasyonu: Admin panel A-04 (fotoğraf) / A-05 (yorum) kuyruğu; moderator+ onaylar/reddeder, ret nedeni seçilir. SLA: 24 saat içinde karar.
4. Karar `audit_logs`'a yazılır; reddedilen kullanıcıya `notifications` (`type = 'system'`) ile kibar gerekçe gider.
5. `reviews.status = 'approved'` olunca trigger `locations.rating_avg / rating_count` cache'ini günceller.

### 8.2 Kötüye Kullanım Raporlama
- `POST /reports` — kanonik `report_reason`: `wrong_info`, `closed_permanently`, `wrong_photo`, `wrong_position`, `other`. Lokasyon detayından (S-23) erişilir.
- İçerik şikâyeti (yorum/fotoğraf) da aynı uç ile `other` + hedef referansı taşır; v1.1'de ayrı `abuse` reason eklenmesi backlog'da.
- Eskalasyon: aynı hedefe 3+ rapor → içerik otomatik `pending`'e çekilir (yayından geçici kaldırma) + kuyruk önceliği yükselir.
- Tekrarlayan ihlalci politikası: 3 onaylı ihlal → içerik üretimi 30 gün kısıtlanır (Edge kontrolü, `users` üzerinde kısıt alanı); ağır ihlalde hesap askıya alınır (Firebase disable + `audit_logs`).

---

## 9. audit_logs Kullanımı

Şema (foundation §5 ile uyumlu, append-only, aylık partition'a hazır):
`id, actor_user_id, actor_role, action, entity_type, entity_id, before JSONB, after JSONB, ip, user_agent, created_at`.

- **Yazan olaylar:** rol değişikliği, `locations` CRUD, moderasyon kararları, `booking_requests` status geçişleri, kullanıcı silme/anonimleştirme, `app_settings` değişikliği, admin girişleri, RLS ihlal denemeleri (PostgREST 403 örnekleme).
- **Yazım yolu:** Kritik tablolar için `AFTER INSERT/UPDATE/DELETE` trigger'ları + Edge Function'lardan doğrudan service-role insert.
- **PII kuralı:** `before/after` alanlarında telefon/e-posta maskelenir (`+90*****1234`).
- **Erişim:** RLS gereği admin+ okur; super_admin tam. Kayıt değiştirilemez/silinemez (UPDATE/DELETE policy yok + `REVOKE`).
- **Saklama:** 24 ay; aylık partition'lar 24 ay sonra arşive (S3 export) taşınır, 5. yılda imha (bkz. 13-olceklenebilirlik-plani.md partitioning).
- **Kullanım senaryoları:** incident forensics, KVKK denetim izi, moderasyon kalite kontrolü, şüpheli admin davranışı alarmı (ör. gece saati toplu lokasyon silme → Sentry alert).

---

## 10. Sızma Testi ve Güvenlik Gözden Geçirme Takvimi

| Aktivite | Sıklık | Sorumlu |
|---|---|---|
| Bağımlılık taraması (Dependabot + `dart pub audit` + `npm audit` Edge) | Haftalık (CI) | Platform |
| Secret taraması (gitleaks) | Her PR | CI |
| SAST (semgrep kural seti: Dart + TypeScript/Deno) | Her PR | CI |
| RLS politika testleri (pgTAP) | Her migration PR'ı | Backend |
| İç güvenlik gözden geçirmesi (bu doküman + tehdit modeli güncelleme) | Çeyreklik | CTO/Güvenlik lideri |
| Harici sızma testi (mobil + API + admin web) | Lansman öncesi 1 kez, sonra yılda 1 | Dış firma |
| Firebase/Supabase/S3 konfigürasyon denetimi (Rules, RLS, bucket policy) | Aylık script + çeyreklik manuel | Platform |
| Erişim gözden geçirmesi (admin rolleri, cloud IAM) | Çeyreklik | CTO |
| Yedek geri dönüş tatbikatı (restore drill) | 6 ayda 1 | Backend |

Sızma testi kapsam notu: auth köprüsü, RLS bypass denemeleri, presigned URL kötüye kullanımı, rate limit atlatma, admin panel 2FA, IDOR (özellikle `/boats/{id}`, `/booking-requests`).

---

## 11. Incident Response Planı

### 11.1 Şiddet Seviyeleri
| Seviye | Tanım | Örnek | İlk yanıt |
|---|---|---|---|
| SEV-1 | Veri ihlali / tam kesinti / auth bypass | RLS açığı ile PII sızıntısı | 15 dk |
| SEV-2 | Kısmi kesinti, kritik fonksiyon bozulması | Booking talepleri yazılamıyor | 1 saat |
| SEV-3 | Sınırlı etki | Tek endpoint'te hata artışı | 4 saat |
| SEV-4 | Kozmetik/düşük | Yanlış hata mesajı | 2 iş günü |

### 11.2 Akış
1. **Tespit:** Sentry alert, Supabase Logs anomalisi, kullanıcı bildirimi (`security@dockly.app`), pentest bulgusu.
2. **Triage:** Nöbetçi (on-call) 15 dk içinde seviye atar; SEV-1/2'de incident kanalı açılır, Incident Commander (CTO veya vekili) atanır.
3. **Containment:** Gerekirse: ilgili endpoint feature flag ile kapatılır (`app_settings`), service-role key rotasyonu, `revokeRefreshTokens`, presigned URL üretimi durdurma, WAF kuralı.
4. **Eradication & Recovery:** Kök neden düzeltmesi, hotfix release (Fastlane fast-lane), veri düzeltme script'leri (audit'li).
5. **Bildirim:** KVKK veri ihlali → Kurul'a **72 saat** içinde bildirim + etkilenen kullanıcılara "gecikmeksizin" bilgilendirme (şablonlar hazır: `docs/ir-templates/`). GDPR kapsamındaysa ilgili otorite eklenir.
6. **Postmortem:** 5 iş günü içinde suçlamasız (blameless) rapor: zaman çizelgesi, kök neden, aksiyonlar (owner + tarih). Aksiyonlar backlog'a P0/P1 olarak girer.

### 11.3 Hazırlık
- On-call rotasyonu (2 kişi, haftalık) + eskalasyon zinciri.
- Runbook'lar: "service-role key rotasyonu", "Firebase key sızıntısı", "S3 public exposure", "DB restore (PITR)".
- Yılda 1 masa başı tatbikat (tabletop): senaryo = RLS açığı + PII sızıntısı.

---

## 12. OWASP MASVS / ASVS Kontrol Listesi Eşlemesi

### 12.1 MASVS v2 (mobil) — hedef profil: MAS-L1 + seçili L2
| MASVS alanı | Dockly karşılığı | Durum |
|---|---|---|
| MASVS-STORAGE-1/2 | Token'lar secure storage'da; Drift'te PII yok; log'larda PII scrubbing | v1 zorunlu |
| MASVS-CRYPTO-1 | Platform kripto (Keychain/Keystore); özel kripto yazılmaz | v1 zorunlu |
| MASVS-AUTH-1/2/3 | Firebase Auth + köprü JWT; re-auth hassas işlemde; MFA adminlerde | v1 zorunlu |
| MASVS-NETWORK-1/2 | TLS her yerde; cert pinning `api.dockly.app` | v1 zorunlu |
| MASVS-PLATFORM-1/2/3 | İzin minimizasyonu (yalnız konum+bildirim+kamera/galeri); WebView yok; FLAG_SECURE OTP | v1 zorunlu |
| MASVS-CODE-1/2/3/4 | Obfuscation, R8, güncel bağımlılıklar, güvenli release imzalama | v1 zorunlu |
| MASVS-RESILIENCE-1/2 | Root/jailbreak tespiti (telemetri modu), App Check | L2 — kısmi (ADR-SEC-03) |
| MASVS-PRIVACY-1/2 | Veri minimizasyonu, konum sunucuya gitmez, ATT gereksiz (tracker yok) | v1 zorunlu |

### 12.2 ASVS 4.0 (API/backend) — hedef Level 2 (seçili kontroller)
| ASVS bölümü | Kontrol örneği | Dockly karşılığı |
|---|---|---|
| V2 Authentication | 2.1.x şifre politikası, 2.8 tek kullanımlık doğrulayıcılar | Firebase policy + OTP limitleri (§2.4) |
| V3 Session | 3.3 timeout, 3.5 token iptali | 15 dk köprü JWT, `tokens_valid_after` (§2.1–2.2) |
| V4 Access Control | 4.1 deny-by-default, 4.2 IDOR | RLS + FORCE RLS (§3.2), pgTAP testleri |
| V5 Validation | 5.1 input validation, 5.3 output encoding | Zod strict + JSON-only (§6.2–6.3) |
| V7 Error/Logging | 7.1 log'da PII yok, 7.4 hata sızıntısı | Kanonik hata formatı, Sentry scrubbing |
| V8 Data Protection | 8.3 hassas veri, 8.1 sunucu tarafı | §4 şifreleme + S3 politikaları |
| V9 Communications | 9.1 TLS | §4.1 |
| V10 Malicious Code | 10.3 bağımlılık bütünlüğü | lockfile + audit CI |
| V11 Business Logic | 11.1 akış limitleri | Rate limit + status geçiş trigger'ı (§6.1, §3.2) |
| V12 Files | 12.1 upload doğrulama | Presign + magic-bytes + Rekognition (§4.3, §8.1) |
| V13 API | 13.1 REST güvenliği, 13.2 idempotency | §6 tamamı |
| V14 Config | 14.1 build pipeline, 14.3 header'lar | CI sertleştirme, HSTS/CSP |

Kontrol listesi durumu çeyreklik gözden geçirmede (bkz. §10) güncellenir; her satır için kanıt linki (test, config, ADR) `docs/security-evidence.md` dosyasında tutulur.

---

## 13. Açık Kararlar ve İzleme
- ADR-SEC-01: telefon kolonlarına pgcrypto — KVKK denetiminde yeniden değerlendirilecek.
- ADR-SEC-02: yalnız birinci parti domain pinning.
- ADR-SEC-03: root/jailbreak = tespit-et-engelleme; ödeme modülüyle revize.
- App Check enforce tarihi: beta bitişi + 2 hafta (monitör verisine göre).
- Bu doküman her çeyrek CTO tarafından gözden geçirilir; değişiklikler changelog ile işlenir.
