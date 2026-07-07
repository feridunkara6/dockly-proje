# Dockly — Sprint Planı

> Kanonik referans: `00-foundation.md` (enum, tablo, API, ekran ID'leri, teknoloji yığını). Tarih/faz çerçevesi: `18-roadmap.md`. Kapsam kilidi ve faz çıkış kriterleri: `20-mvp-gelistirme-plani.md`. Dağıtım mekaniği: `16-deployment-stratejisi.md`. Branch/commit kuralları: `17-git-branch-stratejisi.md`.
> Tarih bağlamı: bugün **6 Temmuz 2026**. Sprint 0 başlangıcı **13 Temmuz 2026** (Pazartesi). MVP dönemi 13 sprint'te (Sprint 0 → Sprint 12) tamamlanır ve **10 Ocak 2027**'de sona erer — bu, `18-roadmap.md` §3.2 ve §9 (gantt: "Sprint 0-12 geliştirme, 2026-07-13 → 2027-01-10") ile birebir tutarlıdır.

---

## 1. Genel Çerçeve

### 1.1 Sprint ritmi

- Sprint uzunluğu: **2 hafta**, her zaman **Pazartesi** başlar, ikinci haftanın **Cuma** günü biter (Cuma: Review + Retro).
- Toplam MVP dönemi: **13 sprint** — Sprint 0 (kurulum) + Sprint 1…12 (özellik + stabilizasyon).
- Sprint numaralandırması `18-roadmap.md` §9'daki gantt etiketiyle ("Sprint 0-12") birebir örtüşür.

### 1.2 Ekip

| Rol | Adet | Not |
|---|---|---|
| Flutter Developer | 2 | Mobil (`apps/mobile`), gerektiğinde `admin_web` |
| Backend Developer | 1 | Supabase (migration, Edge Functions, RLS), API tasarımı |
| Tasarımcı (Product Designer) | 1 | Design system (`dockly_ui`), Figma, kullanıcı akışları |
| PM (Delivery Lead) | 1 | Backlog, seremoniler, paydaş iletişimi, veri operasyonu koordinasyonu |
| QA | 0.5 (yarı zamanlı) | Sprint 4'ten itibaren düzenli, beta öncesi (Sprint 6-7) tam yoğunluk |
| Veri Girişi Operasyonu | 0.5 (yarı zamanlı) | Sprint 4'ten itibaren aktif; detay: `20-mvp-gelistirme-plani.md` §5 |

Toplam çekirdek kapasite: **~4.5 FTE mühendislik/tasarım + 1 PM**, artı yarı zamanlı QA ve veri operasyonu. Story point tahminleri bu kapasiteye göre kalibre edilmiştir (sprint başına hedef ortalama **40-50 puan**; Sprint 0 kurulum ağırlıklı olduğundan daha yüksek, Sprint 11-12 yıl sonu tatili nedeniyle daha düşüktür).

### 1.3 Story Point Ölçeği

Fibonacci: **1, 2, 3, 5, 8, 13**. Referans: 1 pt ≈ birkaç saatlik iş; 3 pt ≈ 1 gün; 5 pt ≈ 2-3 gün; 8 pt ≈ neredeyse tüm sprint süren tekil iş parçası (varsa dikey dilimlere bölünür, bkz. `17-git-branch-stratejisi.md` §1.2). 13 pt planlamada **kullanılmaz** — 13 pt'lik bir story Planning'de zorunlu olarak bölünür.

### 1.4 User Story ID Formatı

Format: **`DCK-xxx`**, proje genelinde artan tek sıra (3 haneli, gerekirse 4 haneye genişler). Branch adlandırma ve commit footer'larında bu ID kullanılır (`17-git-branch-stratejisi.md` §2, §3). Bu dokümandaki ID'ler **DCK-001**'den başlar ve Sprint 12'de **DCK-104**'te biter; Sprint 12 sonrası (v1.x) backlog'u `18-roadmap.md` §12'de tanımlanan aylık tema panosundan beslenir ve DCK-105'ten devam eder.

---

## 2. Sprint Seremonileri

| Seremoni | Zamanlama | Süre | Katılımcılar | Amaç |
|---|---|---|---|---|
| **Sprint Planning** | Sprint'in 1. günü (Pazartesi sabahı) | 2-3 saat | Tüm ekip + PM | Sprint hedefi netleştirme, backlog'dan story seçimi, kapasite kontrolü, DoR kontrolü |
| **Daily Standup** | Her iş günü, sabah | 15 dk | Tüm ekip (QA/veri operasyonu aktifse dahil) | Engelleri açığa çıkarma, ilerleme senkronu |
| **Backlog Grooming (Refinement)** | Sprint'in 6. iş günü (ilk haftanın son günü) | 1-1.5 saat | PM + tasarımcı + 1 dev temsilcisi | Sonraki sprint story'lerinin taslaklanması, DoR'a hazırlama |
| **Sprint Review / Demo** | Sprint'in son günü (Cuma), öğleden önce | 45-60 dk | Tüm ekip + kurucular (opsiyonel paydaşlar) | Çalışan yazılımın gösterimi, kabul/red kararı |
| **Sprint Retrospective** | Sprint Review sonrası, aynı gün | 45 dk | Tüm ekip (paydaşlar hariç) | Süreç iyileştirme, eylem maddeleri |
| **Veri Operasyonu Senkronu** | Haftalık, Çarşamba | 20 dk | PM + veri operasyonu + backend dev (Sprint 4'ten itibaren) | Lokasyon veri girişi ilerlemesi, admin panel ihtiyaçları |
| **Beta Geri Bildirim Turu** | Haftalık, Sprint 7'den itibaren | 30 dk | PM + tasarımcı + QA | Kapalı beta bulgularının triaj edilmesi |

Standup dışındaki tüm seremoniler asenkron notlarla desteklenir (paylaşılan doküman); uzaktan/hibrit çalışma durumunda video ile yapılır.

---

## 3. Definition of Ready (DoR)

Bir story Planning'e girebilmesi için:

1. Kabul kriterleri (acceptance criteria) yazılı ve netleştirilmiş.
2. Foundation'daki kanonik adlandırmalarla (enum, tablo, ekran ID, API endpoint) çelişki yok — PM/tech lead kontrolü yapılmış.
3. Tasarım bağımlılığı varsa Figma linki hazır (en azından wireframe seviyesinde).
4. Story point tahmini yapılmış (Planning Poker veya asenkron oylama).
5. Teknik bağımlılıklar (başka bir story/migration/API) tanımlı ve mevcut sprint veya önceki sprint'te karşılanabilir durumda.
6. ≤ 8 puan; daha büyükse Grooming'de bölünmüş.

## 4. Definition of Done (DoD)

Bir story "Done" sayılabilmesi için:

1. Kod, ilgili feature modülü katmanlarına uygun yazılmış (`data/domain/presentation`, foundation §3).
2. Unit test (domain/usecase) + gerekli yerlerde widget test eklenmiş; CI (`pr-checks.yml`) yeşil.
3. PR, `17-git-branch-stratejisi.md` konvansiyonlarına uygun (branch adı, commit formatı, ≤ 3 gün ömür hedefi) açılmış ve **en az 1 onay** ile merge edilmiş.
4. Kabul kriterleri manuel/QA doğrulaması ile test edilmiş (staging ortamında).
5. Yeni/güncellenen API endpoint'i varsa API dokümantasyon notu (foundation §6 formatına uygun) güncellenmiş.
6. Feature flag arkasında olması gerekiyorsa `app_settings` kaydı oluşturulmuş.
7. Sentry/Crashlytics'te yeni kritik hata sinyali yok (staging deploy sonrası 24 saat gözlem — büyük değişiklikler için).
8. Erişilebilirlik ve TR yerelleştirme kontrolü (metin, tarih/sayı formatı) yapılmış.
9. Story'nin bağlı olduğu ekran/akış demo edilebilir durumda (Review'a hazır).

---

## 5. Sprint Takvimi — Özet Tablo

| Sprint | Tarih Aralığı | Tema | Toplam Puan (tahmini) | Kilit Kilometre Taşı (varsa) |
|---|---|---|---|---|
| Sprint 0 | 13 Tem – 26 Tem 2026 | Kurulum / CI / Design System | 55 | — |
| Sprint 1 | 27 Tem – 9 Ağu 2026 | Auth + Profil | 55 | — |
| Sprint 2 | 10 Ağu – 23 Ağu 2026 | Tekne Profili | 45 | — |
| Sprint 3 | 24 Ağu – 6 Eyl 2026 | DB + API Çekirdek | 50 | — |
| Sprint 4 | 7 Eyl – 20 Eyl 2026 | Harita Çekirdeği | 47 | Veri operasyonu fiilen başlar |
| Sprint 5 | 21 Eyl – 4 Eki 2026 | Arama + Filtre | 34 | — |
| Sprint 6 | 5 Eki – 18 Eki 2026 | Lokasyon Detay | 37 | Beta öncesi regresyon |
| Sprint 7 | 19 Eki – 1 Kas 2026 | Rezervasyon Talebi | 42 | **Kapalı beta başlar (19 Eki)** |
| Sprint 8 | 2 Kas – 15 Kas 2026 | Topluluk (yorum/fotoğraf/öneri) | 44 | **İçerik eşiği: 500 lokasyon (10 Kas)** |
| Sprint 9 | 16 Kas – 29 Kas 2026 | Favoriler + Bildirimler | 44 | **Store submission (16-17 Kas), Soft Launch (26 Kas)** |
| Sprint 10 | 30 Kas – 13 Ara 2026 | Admin Panel | 49 | Soft launch sonrası stabilizasyon başlar |
| Sprint 11 | 14 Ara – 27 Ara 2026 | Polish + Beta | 34 | — |
| Sprint 12 | 28 Ara 2026 – 10 Oca 2027 | Launch Hazırlık | 27 | **Stabilizasyon dönemi biter (10 Oca) — bkz. `18-roadmap.md` §3.2** |

Not: Sprint 11 ve Sprint 12'de puan hedefleri düşüktür çünkü (a) yıl sonu/yılbaşı döneminde ekip kapasitesi düşer (1 Ocak 2027 resmi tatili Sprint 12 içindedir), (b) bu sprintler büyük ölçüde canlı sistem stabilizasyonuna ayrılmıştır ve önceden tam olarak öngörülemeyen "buffer" işi içerir.

---

## 6. Sprint Detayları

### Sprint 0 — Kurulum / CI / Design System
**Tarih:** 13 Tem – 26 Tem 2026
**Hedef:** Monorepo, 3 ortam (dev/staging/prod), CI/CD iskeleti ve design system v0.1 hazır; ekip ilk günden itibaren aynı temel üzerinde çalışabiliyor.

| ID | Story | Puan |
|---|---|---|
| DCK-001 | Monorepo iskeleti (`apps/`, `packages/`, `supabase/`, `docs/`, `.github/workflows/`) | 5 |
| DCK-002 | Flutter mobil proje kurulumu — 3 flavor (dev/staging/prod), bundle id'ler (foundation §1, §3) | 8 |
| DCK-003 | GitHub Actions `pr-checks.yml` (lint+test+build, path-bazlı tetik) | 5 |
| DCK-004 | Supabase 3 ortam kurulumu + PostGIS extension aktivasyonu | 8 |
| DCK-005 | Firebase 3 proje kurulumu (Auth, FCM, Crashlytics) | 5 |
| DCK-006 | `dockly_ui` paketi: renk/tipografi/spacing/radius token'ları (foundation §7) | 8 |
| DCK-007 | GoRouter iskeleti + 12 feature modülü klasör yapısı (foundation §3) | 5 |
| DCK-008 | Sentry entegrasyonu (mobil + Edge Functions) | 3 |
| DCK-009 | AWS S3 + CloudFront bucket kurulumu (3 ortam) | 5 |
| DCK-010 | Mapbox hesap + token yönetimi (3 ortam, bundle-id kısıtları) | 3 |

**Teslim edilebilirler:** Çalışan CI pipeline; her 3 ortamda boş ama canlı Supabase projesi; TestFlight Internal + Play Internal'a yüklenebilen "hello world" build; `dockly_ui` v0.1 (Storybook-benzeri örnek ekran).
**Bağımlılıklar:** Apple Developer Program hesabı, Google Play Console hesabı, AWS hesabı, Supabase org, Firebase billing — hepsi Sprint 0 öncesi (Temmuz ilk haftası) hazırlanmalı.
**Riskler:** Apple Developer Program kayıt/onayı günler sürebilir; Google Play yeni geliştirici hesapları için zorunlu kapalı test bekleme süresi ileride (Sprint 7) etkili olur, bu yüzden hesap **Sprint 0'da** açılmalı (bkz. `16-deployment-stratejisi.md` §2.2). Hesap açılışlarında gecikme tüm takvimi kaydırır — bu risk PM tarafından Sprint 0 öncesi (bu hafta) kapatılmalıdır.

---

### Sprint 1 — Auth + Profil
**Tarih:** 27 Tem – 9 Ağu 2026
**Hedef:** Kullanıcılar Apple/Google/E-posta/Telefon/Misafir ile giriş yapabiliyor ve temel profillerini yönetebiliyor.

| ID | Story | Puan |
|---|---|---|
| DCK-011 | Firebase Auth — Apple Sign-In entegrasyonu (S-03) | 8 |
| DCK-012 | Firebase Auth — Google Sign-In entegrasyonu (S-03) | 5 |
| DCK-013 | E-posta ile kayıt/giriş (S-04) | 5 |
| DCK-014 | Telefon + OTP doğrulama (S-05) | 8 |
| DCK-015 | Misafir/Anonim oturum akışı | 3 |
| DCK-016 | `POST /auth/session` Edge Function (Firebase ID Token → Supabase JWT köprüsü, foundation §6) | 8 |
| DCK-017 | `users` tablosu migration + RLS politikaları (foundation §5) | 5 |
| DCK-018 | Profil ekranı (S-19) — `GET/PATCH /users/me` | 5 |
| DCK-019 | Onboarding 3 sayfa (S-02) | 5 |
| DCK-020 | Splash ekranı (S-01) + oturuma göre yönlendirme | 3 |

**Teslim edilebilirler:** 5 giriş yöntemiyle uçtan uca çalışan auth akışı; profil görüntüleme/düzenleme.
**Bağımlılıklar:** Sprint 0 Firebase/Supabase kurulumu.
**Riskler:** Apple, "diğer sosyal girişler sunuluyorsa Apple Sign-In zorunludur" kuralını uygular — bu story'nin (DCK-011) App Store reddi riskini önlemesi kritik. SMS OTP maliyeti ve Türkiye operatörlerinde teslim gecikmesi (DCK-014) test edilmeli.

---

### Sprint 2 — Tekne Profili
**Tarih:** 10 Ağu – 23 Ağu 2026
**Hedef:** Kullanıcılar tekne(ler)ini ekleyip yönetebiliyor; ilk fotoğraf yükleme akışı (S3 presign) kuruluyor.

| ID | Story | Puan |
|---|---|---|
| DCK-021 | `boats` tablosu migration + RLS (foundation §5) | 5 |
| DCK-022 | `GET/POST /boats`, `GET/PATCH/DELETE /boats/{id}` | 8 |
| DCK-023 | Tekne listem ekranı (S-17) | 5 |
| DCK-024 | Tekne ekle/düzenle formu (S-18) — `boat_type`, `engine_type` enum seçimi | 8 |
| DCK-025 | Birincil tekne (`is_primary`) mantığı | 3 |
| DCK-026 | Tekne fotoğrafı yükleme — S3 presign akışının **ilk kurulumu** (`POST /photos/presign`, `POST /photos/complete`) | 8 |
| DCK-027 | `dockly_core` — tekne domain modelleri + usecase'ler | 5 |
| DCK-028 | Form validasyonu (`length_m`, `draft_m`, `beam_m` sınırları) | 3 |

**Teslim edilebilirler:** Tekne CRUD tam işlevsel; presign tabanlı fotoğraf yükleme paterni (ileride reviews/locations fotoğrafları bunu yeniden kullanacak).
**Bağımlılıklar:** Sprint 1 auth (`user_id` FK), Sprint 0 S3 bucket.
**Riskler:** Presign akışı burada ilk kez kuruluyor — tasarımı hatalıysa Sprint 3 (photos tablosu) ve Sprint 8 (topluluk fotoğrafları) doğrudan etkilenir; backend dev bu story'yi (DCK-026) dikkatle ele almalı.

---

### Sprint 3 — DB + API Çekirdek
**Tarih:** 24 Ağu – 6 Eyl 2026
**Hedef:** `locations` ve ilişkili çekirdek tablolar + API yüzeyi hazır; veri operasyonu ekibinin çalışabileceği **erken, temel** bir admin CRUD yayınlanır.

| ID | Story | Puan |
|---|---|---|
| DCK-029 | `locations` tablosu migration (`geography(Point,4326)`, foundation §5) | 8 |
| DCK-030 | `amenities` + `location_amenities` tabloları + seed (15 amenity kodu) | 5 |
| DCK-031 | `photos` tablosu (polymorphic owner: location/boat/review) | 5 |
| DCK-032 | `GET /locations` (bbox, filtre, arama) | 8 |
| DCK-033 | `GET /locations/{id}` | 3 |
| DCK-034 | GIST/GIN(`pg_trgm`)/B-tree index kurulumu (foundation §5) | 5 |
| DCK-035 | **Admin: temel Lokasyon CRUD ekranı (A-02, erken çıkış)** — veri operasyonu için | 8 |
| DCK-036 | Admin auth/yetki katmanı (`role >= moderator`) | 5 |
| DCK-037 | `app_settings` tablosu + feature flag okuma altyapısı | 3 |

**Teslim edilebilirler:** Lokasyon veri modeli ve API'si production-ready; veri operasyonu ekibinin ilk lokasyonları girebileceği asgari admin ekranı.
**Not:** DCK-035, tam admin paneli (moderasyon, istatistik, kullanıcı yönetimi) **değildir** — yalnızca lokasyon CRUD'udur. Tam admin paneli Sprint 10'da tamamlanır (bkz. §6 Sprint 10).
**Bağımlılıklar:** Sprint 0 Supabase, Sprint 2 photos pattern'inin genişletilmesi.
**Riskler:** Bu sprint backend için en yüklü sprintlerden biridir (PostGIS + RLS + cursor sayfalama). Buradaki gecikme, veri operasyonunun başlangıcını ve dolayısıyla **içerik eşiğini (10 Kasım)** doğrudan tehdit eder — kritik yol analizi için bkz. `20-mvp-gelistirme-plani.md` §4.

---

### Sprint 4 — Harita Çekirdeği
**Tarih:** 7 Eyl – 20 Eyl 2026
**Hedef:** Ana Sayfa haritası (S-06) çalışıyor; 9 `location_type` ikonlarla gösteriliyor. **Veri operasyonu bu sprintte fiilen başlar.**

| ID | Story | Puan |
|---|---|---|
| DCK-038 | `mapbox_maps_flutter` entegrasyonu + light/dark stil | 8 |
| DCK-039 | Harita ikon seti — 9 `location_type` renk kodu (foundation §7) | 5 |
| DCK-040 | bbox tabanlı canlı veri çekme + Riverpod provider | 8 |
| DCK-041 | Alt kart sistemi (bottom sheet, lokasyon önizleme) | 8 |
| DCK-042 | Kullanıcı konumu + izin akışı | 5 |
| DCK-043 | Drift offline cache (locations local şema) | 8 |
| DCK-044 | Harita performansı — temel clustering (v1) | 5 |

**Teslim edilebilirler:** Uçtan uca harita deneyimi (S-06); offline fallback.
**Bağımlılıklar:** Sprint 3 `/locations` API ve admin CRUD (DCK-035).
**Riskler:** Mapbox kota/maliyet takibi; orta segment Android cihazlarda clustering performansı — **bu sprint, MVP'nin teknik olarak en riskli sprintlerinden biridir** (bkz. `20-mvp-gelistirme-plani.md` kritik yol analizi). Bu sprint sonunda veri operasyonu ekibi (yarı zamanlı) admin CRUD üzerinden ilk pilot ~20-30 lokasyonu girmeye başlar; süreç Sprint 5'ten itibaren düzenli tempoya oturur.

---

### Sprint 5 — Arama + Filtre
**Tarih:** 21 Eyl – 4 Eki 2026
**Hedef:** Kullanıcılar arama ve filtrelerle lokasyon keşfedebiliyor.

| ID | Story | Puan |
|---|---|---|
| DCK-045 | Arama ekranı (S-07) — `pg_trgm` tabanlı isim/şehir/ilçe/koy araması | 8 |
| DCK-046 | Filtreler bottom sheet (S-08) — amenity, `location_type`, `price_tier` | 8 |
| DCK-047 | Cursor tabanlı sayfalama (arama sonuçları) | 5 |
| DCK-048 | Son görüntülenenler (`recently_viewed`) upsert akışı | 5 |
| DCK-049 | Arama geçmişi (local, Drift) | 3 |
| DCK-050 | Filtre state yönetimi (Riverpod) + deep-link senkronizasyonu | 5 |

**Teslim edilebilirler:** Arama + filtre uçtan uca çalışıyor; son görüntülenenler kaydediliyor.
**Bağımlılıklar:** Sprint 4 harita, Sprint 3 API.
**Riskler:** `pg_trgm` performansı veri hacmi arttıkça (300+ lokasyon) yeniden test edilmeli; Türkçe karakter/yazım toleransı (ı/i, ş/s, ğ, ü, ö) özel dikkat gerektirir — beta öncesi kritik bir kullanılabilirlik riski.

---

### Sprint 6 — Lokasyon Detay
**Tarih:** 5 Eki – 18 Eki 2026
**Hedef:** Lokasyon Detay ve Galeri tam işlevsel; kapalı betaya (19 Ekim) hazır çekirdek keşif deneyimi tamamlanıyor.

| ID | Story | Puan |
|---|---|---|
| DCK-051 | Lokasyon Detay ekranı (S-09) — tüm kritik kolonlar (foundation §5) | 8 |
| DCK-052 | Fotoğraf Galerisi tam ekran (S-10) | 5 |
| DCK-053 | Favorile butonu (UI + geçici state; tam backend Sprint 9'da) | 3 |
| DCK-054 | Paylaş / harici harita uygulamasına yol tarifi yönlendirme | 3 |
| DCK-055 | `rating_avg`/`rating_count` DB trigger'ları | 5 |
| DCK-056 | Detay ekranı offline fallback (Drift cache) | 5 |
| DCK-057 | **Beta öncesi regresyon: S-01…S-10 uçtan uca QA turu** | 8 |

**Teslim edilebilirler:** Detay + galeri production-ready; beta öncesi tam regresyon raporu.
**Bağımlılıklar:** Sprint 4/5.
**Riskler:** **Kapalı beta 19 Ekim 2026'da başlıyor** (bkz. `18-roadmap.md` §3.2) — bu sprintin son günüyle (18 Ekim) çakışıyor. QA turu (DCK-057) ve TestFlight External/Play Closed track kurulumunun bu sprintte tamamlanması zorunlu; gecikme beta başlangıcını doğrudan öteler.

---

### Sprint 7 — Rezervasyon Talebi *(Kapalı beta bu sprintte başlıyor — 19 Ekim)*
**Tarih:** 19 Eki – 1 Kas 2026
**Hedef:** Rezervasyon talebi akışı canlı; kapalı beta (50 tekne sahibi) başlıyor.

| ID | Story | Puan |
|---|---|---|
| DCK-058 | `booking_requests` tablosu migration (foundation §5) | 5 |
| DCK-059 | Rezervasyon Talebi formu (S-14) | 8 |
| DCK-060 | Taleplerim ekranı — liste + detay (S-15) | 5 |
| DCK-061 | `GET/POST /booking-requests`, `POST /booking-requests/{id}/cancel` | 8 |
| DCK-062 | `booking_request_status` akışı — admin tarafı temel (manuel işlem, foundation §4) | 5 |
| DCK-063 | Bildirim tetikleyici altyapısı: `booking_status` (backend event; tam FCM Sprint 9) | 3 |
| DCK-064 | **Kapalı beta lansmanı: TestFlight External + Play Closed track kurulumu, 50 davetiye gönderimi** | 8 |

**Teslim edilebilirler:** Rezervasyon talebi uçtan uca (S-14/S-15); 50 tekne sahibiyle kapalı beta canlı.
**Bağımlılıklar:** Sprint 6 lokasyon detay, Sprint 2 boats (`boat_length_m`/`boat_draft_m` formda kullanılır).
**Riskler:** Google Play'in yeni geliştirici hesapları için zorunlu tuttuğu kapalı test bekleme süresi (bkz. `16-deployment-stratejisi.md` §2.2) — hesabın Sprint 0'da açılmamış olması burada gecikmeye yol açabilir. Apple Beta Review süresi belirsizliği.

---

### Sprint 8 — Topluluk (yorum/fotoğraf/öneri) *(İçerik eşiği: 500 lokasyon, 10 Kasım)*
**Tarih:** 2 Kas – 15 Kas 2026
**Hedef:** Topluluk döngüsü (yorum, fotoğraf, öneri, hatalı bilgi bildirimi) canlı; **500 lokasyon içerik eşiği bu sprint içinde geçilir.**

| ID | Story | Puan |
|---|---|---|
| DCK-065 | `reviews` tablosu + `UNIQUE(location_id,user_id) WHERE deleted_at IS NULL` | 5 |
| DCK-066 | Yorumlar listesi (S-11) | 5 |
| DCK-067 | Yorum yaz + puan ver (S-12) | 5 |
| DCK-068 | Fotoğraf yükle akışı (S-13, Sprint 2'deki presign paterni yeniden kullanılır) | 5 |
| DCK-069 | Yeni nokta öner (S-22) — `suggestions` tablosu, `payload JSONB` | 8 |
| DCK-070 | Hatalı bilgi bildir (S-23) — `reports` tablosu | 5 |
| DCK-071 | `moderation_status` akışı — admin onay ekranı genişletmesi | 8 |
| DCK-072 | Veri operasyonu: içerik eşiği ilerleme sayacı (basit dashboard) | 3 |

**Teslim edilebilirler:** Topluluk özellikleri uçtan uca; içerik eşiği izleme aracı.
**Bağımlılıklar:** Sprint 3 admin temel CRUD, Sprint 6 detay ekranı.
**Riskler:** **İçerik eşiği (500 lokasyon, 10 Kasım) bu sprint içinde düşüyor — veri operasyonu MVP'nin kritik yoludur** (bkz. `20-mvp-gelistirme-plani.md` §4). Gecikme, store submission (16-17 Kasım) ve soft launch (26 Kasım) tarihini doğrudan tehdit eder. Beta kullanıcılarından gelen içerik moderasyon kuyruğunu şişirebilir.

---

### Sprint 9 — Favoriler + Bildirimler *(Store submission 16-17 Kasım, SOFT LAUNCH 26 Kasım bu sprintte)*
**Tarih:** 16 Kas – 29 Kas 2026
**Hedef:** Favoriler ve bildirim akışları tamamlanıyor; **v1.0.0 store'a gönderiliyor ve soft launch gerçekleşiyor.**

| ID | Story | Puan |
|---|---|---|
| DCK-073 | `favorites` tablosu (hard delete) + `GET/PUT/DELETE /favorites` | 5 |
| DCK-074 | Favoriler ekranı (S-16) | 5 |
| DCK-075 | `devices` tablosu + `PUT /devices` (FCM token kaydı) | 3 |
| DCK-076 | `notifications` tablosu + `GET /notifications`, `POST /notifications/read` | 5 |
| DCK-077 | Bildirimler ekranı (S-21) | 5 |
| DCK-078 | FCM push entegrasyonu (`booking_status`, `new_photo`, `new_review`, `favorite_update`, `system`) | 8 |
| DCK-079 | **v1.0.0 release candidate build + App Store/Play Review'a gönderim (16-17 Kasım)** | 8 |
| DCK-080 | **Soft launch: 26 Kasım 2026 — sessiz yayın, canlı izleme (crash-free, çekirdek akışlar)** | 5 |

**Teslim edilebilirler:** Favoriler + bildirimler tam işlevsel; v1.0.0 App Store/Play'de yayında (soft launch).
**Bağımlılıklar:** Sprint 7/8'in tüm çekirdek akışları; içerik eşiği (Sprint 8).
**Riskler:** Store review süresi belirsizliği (bkz. `16-deployment-stratejisi.md` §2.1 — bu yüzden 16 Kasım'da review'a gönderim tamponu bırakılmıştır). Soft launch günü (26 Kasım) tüm ekibin (PM+dev+QA) canlı izleme için hazır bulunması zorunludur.

---

### Sprint 10 — Admin Panel *(Soft launch sonrası stabilizasyon)*
**Tarih:** 30 Kas – 13 Ara 2026
**Hedef:** Tam admin paneli tamamlanıyor (moderasyon, istatistik, kullanıcı yönetimi); soft launch sonrası canlı veriye göre operasyon araçları güçlendiriliyor.

| ID | Story | Puan |
|---|---|---|
| DCK-081 | Admin Dashboard (A-01) — temel metrikler | 5 |
| DCK-082 | Kategori/Amenity yönetim ekranı (A-03) | 3 |
| DCK-083 | Fotoğraf moderasyon ekranı (A-04) | 5 |
| DCK-084 | Yorum moderasyon ekranı (A-05) | 5 |
| DCK-085 | Talepler yönetim ekranı (A-06) — `booking_request_status` güncelleme | 8 |
| DCK-086 | Kullanıcılar ekranı (A-07) | 5 |
| DCK-087 | İstatistik ekranı (A-08) | 5 |
| DCK-088 | `audit_logs` kaydının tüm admin aksiyonlarına entegrasyonu | 5 |
| DCK-089 | Soft launch canlı hata triage (P0/P1 hızlı düzeltmeler, buffer) | 8 |

**Teslim edilebilirler:** A-01…A-08 tam işlevsel admin paneli; canlı ortamda çıkan kritik hataların hızlı çözümü.
**Bağımlılıklar:** Sprint 9 soft launch (gerçek moderasyon/işlem yükü bu sprintin önceliklerini şekillendirir).
**Riskler:** Canlı ortamda çıkan P0 hatalar admin panel geliştirmesini yarıda kesebilir — kapasitenin bir kısmı bilinçli olarak buffer (DCK-089) olarak ayrılmıştır.

---

### Sprint 11 — Polish + Beta
**Tarih:** 14 Ara – 27 Ara 2026
**Hedef:** Soft launch geri bildirimlerine göre UX cilası; kapalı beta ekibinden (50 kullanıcı) toplanan bulgular kapatılıyor.

| ID | Story | Puan |
|---|---|---|
| DCK-090 | Soft launch retrospektifi + öncelik sıralı hata/istek listesi | 3 |
| DCK-091 | Onboarding/ilk kullanım cilası (drop-off noktaları düzeltme) | 5 |
| DCK-092 | Harita performans cilası (Sprint 4 clustering v1 üzerine iyileştirme) | 8 |
| DCK-093 | Arama/filtre küçük iyileştirmeler (beta geri bildirimi) | 5 |
| DCK-094 | Erişilebilirlik (a11y) taraması ve düzeltmeleri | 5 |
| DCK-095 | Yerelleştirme (TR metin) tutarlılık taraması | 3 |
| DCK-096 | Performans: açılış süresi, görsel yükleme optimizasyonu | 5 |

**Teslim edilebilirler:** Ölçülebilir UX/performans iyileştirmeleri; kapalı beta bulgu listesinin büyük kısmı kapatılmış.
**Bağımlılıklar:** Sprint 9/10 canlı veriler ve beta geri bildirimleri.
**Riskler:** Yıl sonu döneminde ekip izinleri kapasiteyi düşürebilir; bu yüzden hedef puan bilinçli olarak düşük tutulmuştur.

---

### Sprint 12 — Launch Hazırlık
**Tarih:** 28 Ara 2026 – 10 Oca 2027
**Hedef:** v1.0 stabilizasyon dönemi tamamlanıyor; v1.x'e (içerik büyütme, Nisan 2027 tam lansman hazırlığı) geçiş için sprint kapıları değerlendiriliyor.

| ID | Story | Puan |
|---|---|---|
| DCK-098 | G1 sonrası metrik izleme raporu (crash-free, WAU, retention — bkz. `18-roadmap.md` §3.3) | 5 |
| DCK-099 | Store yorumları/derecelendirme triage ve hızlı düzeltmeler | 5 |
| DCK-100 | Veri operasyonu Ocak-Mart planının onaylanması (2→4 kişi ölçekleme, `20-mvp-gelistirme-plani.md` §5) | 3 |
| DCK-101 | v1.1 backlog oluşturma (soft launch öğrenimleri) | 3 |
| DCK-102 | Teknik borç envanteri ve v1.x öncesi öncelik sıralaması | 5 |
| DCK-103 | G2 (tam lansman onayı, 15 Mart 2027) hazırlık checklist taslağı | 3 |
| DCK-104 | Sprint 0-12 retrospektifi (MVP dönemi genel değerlendirme) | 3 |

**Teslim edilebilirler:** MVP dönemi kapanış raporu; v1.x backlog'u hazır; G2 hazırlık checklist taslağı.
**Bağımlılıklar:** Sprint 9/10/11 canlı veriler.
**Riskler:** 1 Ocak 2027 resmi tatili bu sprint içinde düşer (kapasite ~%85). Bu sprintin sonu (10 Ocak 2027), `18-roadmap.md` §3.2'deki "Soft launch stabilizasyonu + launch hazırlık sprintleri sonu" milestone'u ile birebir örtüşür — sonraki çalışma `18-roadmap.md` §4 (v1.x) kapsamına geçer.

---

## 7. Kapasite ve Tatil Notları

| Tarih | Etki | İlgili Sprint |
|---|---|---|
| 30 Ağustos (Zafer Bayramı) | Resmi tatil, 1 gün kapasite düşüşü | Sprint 3 |
| 29 Ekim (Cumhuriyet Bayramı) | Resmi tatil, kapalı beta lansman haftasına denk gelir — dikkatli planlanmalı | Sprint 7 |
| 24 Aralık – 1 Ocak dönemi | Yıl sonu/yılbaşı, izin yoğunluğu (resmi tatil yalnızca 1 Ocak) | Sprint 11-12 |
| 1 Ocak (Yılbaşı) | Resmi tatil | Sprint 12 |

Bu tatiller sprint hedeflerinde (§5, §6) puan tahminlerine dahil edilmiştir; ek tatil/izin planlaması Sprint Planning'de PM tarafından güncellenir.

---

## 8. Sprint Sonrası (v1.x) Bağlantısı

Sprint 12'nin bitişiyle (10 Ocak 2027) MVP dönemi kapanır. Bundan sonraki çalışma **artık bu sprint numaralandırmasının dışındadır** ve `18-roadmap.md` §4 (v1.x — İyileştirme ve Büyütme) kapsamında, aynı 2 haftalık ritimle ama yeni bir backlog ve tema panosuyla devam eder. Sprint kırılımının bir sonraki güncellemesi, G2 kapı kararı (15 Mart 2027) öncesinde, `18-roadmap.md` §12 gereği çeyrek başı gözden geçirmesiyle birlikte yapılır.

---

*Son güncelleme: 6 Temmuz 2026. Bu doküman Sprint Planning seremonilerinde canlı olarak güncellenir; DCK-ID'ler ve tarihler burada donuklaştırılmıştır, story detayları (kabul kriterleri) ayrı bir backlog aracında (ör. Linear/Jira) tutulur.*
