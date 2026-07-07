# Dockly — Performans Planı (14)

> Bu doküman [00-foundation.md](00-foundation.md) kanonik temel dokümanına bağlıdır. Teknoloji yığını: Flutter 3.x/Dart 3.x, Riverpod, GoRouter, Mapbox (`mapbox_maps_flutter`), Supabase (PostgreSQL 15 + PostGIS, PostgREST, Edge Functions/Deno), Drift (SQLite) + `cached_network_image`, AWS S3 + CloudFront, Firebase (Auth, FCM, Performance, Crashlytics), Sentry.
> İlgili dokümanlar: [12-guvenlik-plani.md](12-guvenlik-plani.md) (rate limiting, presigned URL, input validation ile bu doküman çelişmez), [13-olceklenebilirlik-plani.md](13-olceklenebilirlik-plani.md) (CDN/cache katmanları, cluster endpoint, DB ölçekleme — bu doküman onun istemci ve sorgu-seviyesi tamamlayıcısıdır).
> İlke: **"Ölçülmeyen performans yönetilemez."** Her bütçe, CI'da veya üretimde otomatik ölçülen bir metrikle eşleşir; sübjektif "hızlı hissettiriyor" kabul edilmez.

---

## 1. Performans Bütçeleri (Kanonik Hedefler)

Aşağıdaki bütçeler tüm feature ekiplerini bağlar; bir PR bütçeyi kalıcı olarak bozuyorsa merge edilmez (bkz. §8.4 CI regresyon testleri).

| Metrik | Bütçe | Ölçüm noktası | Cihaz referansı |
|---|---|---|---|
| Soğuk açılış (cold start) — splash → S-06 ilk etkileşilebilir kare | **< 2.0 s** | `app_start` custom trace (Firebase Performance) | Düşük seviye Android (bkz. §9) |
| Harita ilk render (S-06) — ekran açık → ilk pin kümesi görünür | **< 1.5 s** | `map_first_render` trace | Orta/düşük Android + iPhone SE |
| Ekran geçişi (GoRouter push/pop, ör. S-06→S-09) | **< 300 ms** | `screen_transition_*` trace + `flutter_driver` timeline | Tüm matris |
| Animasyon/scroll akıcılığı | **60 fps** (16.6 ms/frame), düşük uçta minimum **45 fps**, jank oranı < %1 | Flutter `FramesTimingCallback` / DevTools timeline | Tüm matris |
| API p95 (backend) | **< 400 ms** (foundation/13 ile uyumlu SLO) | API Gateway + Sentry transaction | — |
| API p99 | < 1 s | Sentry | — |
| Görsel ilk görünür içerik (LQIP/blur-hash → net görsel) | **< 100 ms** blur-hash render, tam görsel medium varyant **< 800 ms** (iyi ağ), thumb **< 300 ms** | `image_load_*` trace | 4G referans profili |
| Sıcak yeniden başlatma (app resume, arka plandan) | < 700 ms | `app_resume` trace | Tüm matris |
| Bellek (RSS) — S-06 harita ekranında sürekli kullanım | < 250 MB düşük uçta, < 400 MB orta/üst uçta | DevTools memory / Android Studio Profiler | §9 |
| Uygulama boyutu (indirme) | Android AAB < 40 MB, iOS IPA < 60 MB | Play Console / App Store Connect boyut raporu | — |
| Bağlama noktası arama (S-07) yanıt gecikmesi (debounce dahil) | < 500 ms (debounce 300 ms + API p95) | `search_latency` trace | — |

### 1.1 Bütçe İhlali Süreci
- CI'da bütçe aşımı **uyarı**; 2 ardışık PR'da kalıcıysa **blocking**; istisna yalnızca CTO onayıyla (`docs/perf-exceptions.md` kaydı).
- Her bütçenin bir sahibi vardır: mobil bütçeleri mobil lead, API/DB bütçeleri backend lead; ihlal Sentry/Firebase Performance alert'i ile ilgili kişiye gider.

---

## 2. Flutter Performans Pratikleri

### 2.1 Widget Ağacı Disiplini
- **`const` widget'lar zorunlu** her yerde mümkün olduğunda; lint kuralı `prefer_const_constructors` + `prefer_const_literals_to_create_immutables` CI'da `error` seviyesinde (analysis_options.yaml, tüm `apps/mobile` ve `packages/dockly_ui`).
- **`RepaintBoundary`** kullanım noktaları: harita üzerindeki alt kart (bottom sheet) sistemi (S-06), liste kartlarında (S-07, S-16) her kart kendi `RepaintBoundary`'sine sarılır — kaydırma sırasında komşu kartların yeniden çizimi engellenir. Kural: bağımsız olarak sık güncellenen widget (rating badge, favori kalp ikonu animasyonu) ayrı `RepaintBoundary` alır.
- `ListView.builder` / `SliverList` her zaman; sabit sayıda öğe olsa bile (S-11 yorumlar, S-17 tekne listem) `Column` + `map()` YASAK (lint: `dockly_lints` özel kural `no_column_map_for_lists`).
- `Consumer`/`ref.watch` granülerliği: Riverpod provider'ları mümkün olduğunca dar tutulur (ör. `mapCameraProvider` yalnız kamera state, `mapPinsProvider` ayrı) — geniş bir provider'ın tek alanı değiştiğinde tüm ekranın rebuild olması engellenir. `select()` kullanımı zorunlu kılınır (ör. `ref.watch(bookingRequestFormProvider.select((s) => s.isValid))`).
- `AutomaticKeepAliveClientMixin` yalnız gerçekten pahalı sekme içeriklerinde (harita sekmesi); gereksiz kullanım bellek şişirir, code review checklist maddesi.

### 2.2 Image Cache Yönetimi
- `cached_network_image` + Flutter `ImageCache`: `PaintingBinding.instance.imageCache.maximumSizeBytes` düşük uçta **50 MB**, orta/üst uçta **100 MB** (cihaz sınıfına göre `RuntimeConfig` içinde ayarlanır, bkz. §9).
- Her `CachedNetworkImage` çağrısında **`memCacheWidth`/`memCacheHeight`** görüntülenen boyuta göre zorunlu set edilir (ör. liste kartı 96dp → `memCacheWidth: 96 * devicePixelRatio.round()`), çözünürlük eşleşmesi olmadan orijinal boyutta decode YASAK (lint kuralı: `require_mem_cache_dimensions`).
- Disk cache (bkz. §5.3) 200 MB LRU (13-olceklenebilirlik-plani.md §6 ile birebir); `CacheManager` özelleştirmesi `dockly_ui` paketinde tek noktadan (`DocklyImageCacheManager`).

### 2.3 Isolate Kullanımı
Ana thread'i (UI isolate) bloklayabilecek işler ayrı isolate'e taşınır (`compute()` veya `Isolate.run`, Flutter 3.x):
- Büyük JSON parse/deserialize (ör. `GET /locations` bbox yanıtı 200 satır + iç içe amenity listesi) — `compute(parseLocationsResponse, body)`.
- Client-side clustering fallback (offline modda veya sunucu cluster endpoint'i başarısız olduğunda basit grid clustering) — isolate'te hesaplanır, ana thread yalnız sonucu çizer.
- Görsel ön-işleme (upload öncesi EXIF strip önizlemesi, boyut küçültme — sunucu tarafı asıl işleme foundation/13 §4.2'de olsa da istemci önizlemesi de isolate'te).
- Drift sorguları zaten arka planda çalışır (`NativeDatabase.createInBackground` / `drift_flutter` background isolate) — büyük senkron sorgular ana isolate'i bloklamaz.
- Kural: 8 ms'den uzun sürmesi beklenen herhangi bir CPU-bound işlem isolate adayıdır (code review checklist).

### 2.4 Shader Warmup (Jank Önleme — İlk Kare Takılmaları)
- Impeller (iOS varsayılan, Android Vulkan destekli cihazlarda hedef backend) altında bile ilk kullanımda shader derleme gecikmesi (jank) görülebilir; önlem:
  - `flutter build ... --bundle-sksl-path=flutter_01.sksl.json` ile **SkSL warmup** — release build pipeline'ına (CI) entegre; `sksl` dosyası her major release'te `flutter screenshot --type=skp` / `dumpShaders` akışıyla temsili kullanıcı senaryosundan (S-01→S-06→S-09→S-14) yeniden üretilir.
  - Uygulama açılışında `DevicePixelRatio`'ya göre kritik widget'ların (harita pin ikon seti, alt kart, buton stilleri) bir kerelik "warmup frame"i offscreen render edilir (splash sırasında, kullanıcı görmeden).
  - Android'de Impeller/Vulkan desteklemeyen düşük uçlarda Skia (OpenGL) fallback; her iki backend için ayrı sksl warmup verisi tutulur.
- Ölçüm: DevTools "Rendering" sekmesi + `flutter_driver` ile "jank frame count" ilk 10 saniyede regresyon testi (bkz. §8.4).

---

## 3. Harita Performansı

### 3.1 Marker Clustering
- Sunucu tarafı ön-hesaplanmış cluster (13-olceklenebilirlik-plani.md §5.2, `GET /locations/clusters`) **birincil strateji**; istemci yalnız gelen `{cell_id, lon, lat, count, top_types[]}` verisini çizer, kendi clustering algoritmasını ÇALIŞTIRMAZ (ağ ve CPU tasarrufu).
- İstemci tarafı clustering yalnız **offline fallback** (ağ yok, Drift cache'inden gelen ham pinler) için basit grid-based algoritma (isolate'te, §2.3) — kullanıcı deneyimi bozulmadan devam eder.
- Cluster → tekil pin geçişi (zoom-in): kademeli animasyon (250 ms, `Curves.easeOutCubic`), yeni zoom seviyesinin verisi CDN'den zaten SWR ile hazır olduğundan (13 §5.2) ek gecikme hissedilmez.

### 3.2 Viewport-Based Veri Çekme + Debounce
- Harita kamerası hareket ettikçe (`onCameraIdle`, `onCameraChanged` DEĞİL) yeni bbox için istek atılır; **debounce 300 ms** (kullanıcı hızlı pan/zoom yaparken ara isteklerin iptali — `CancelToken` ile önceki istek iptal edilir, yarış koşulu (race condition) engellenir: yalnız en son isteğin yanıtı state'e yazılır, `requestId` karşılaştırmasıyla).
- Bbox küçük değişimlerde (ör. < %10 alan farkı, kaydırma < 1 ekran genişliği) yeniden istek atılMAZ — mevcut veri + Drift cache yeterli kabul edilir (eşik: `app_settings.map.rebounce_threshold_pct`, uzaktan ayarlanabilir).
- İlk açılışta (S-06 cold start): son bilinen konum/bbox Drift'ten anında çizilir (§5), gerçek konum/ağ yanıtı geldiğinde sorunsuz geçiş (cross-fade 150 ms) — böylece "harita ilk render < 1.5 s" bütçesi ağ beklemeden karşılanır.

### 3.3 Tile Cache
- Mapbox SDK yerleşik disk tile cache: hedef **50 MB** (13-olceklenebilirlik-plani.md §5.1 ile tutarlı), düşük uçta 30 MB'a düşürülür (§9 cihaz profili).
- Sık ziyaret edilen bölgeler (Bodrum–Göcek–Fethiye, Çeşme, Ayvalık — 13 §1.2) için opsiyonel **offline tile pack** ön-indirme değerlendirildi; v1'de KAPSAM DIŞI (bundle boyutu ve karmaşıklık), backlog'a not düşüldü.
- Stil (style) tek seferlik indirilir ve versiyonlanır (`style_version` uygulama config'inde); stil değişikliği yalnız uygulama güncellemesiyle veya uzaktan sprite/glyph invalidation ile yayılır.

### 3.4 Symbol Layer vs Widget Marker Kararı
**Karar (ADR-PERF-01): Harita pin'lerinin büyük çoğunluğu Mapbox `SymbolLayer` (native GL katmanı) ile çizilir; Flutter widget marker'lar yalnız istisnai/etkileşimli durumlarda kullanılır.**

| Durum | Yaklaşım | Gerekçe |
|---|---|---|
| Normal lokasyon pin'leri (location_type ikonları, foundation §7 renk paleti) | `SymbolLayer` + sprite atlas (9 `location_type` ikonu + seçili/vurgulu varyantları) | GPU'da render edilir; 100'lerce pin'de dahi 60fps korunur, widget marker'da bu sayıda `Positioned` widget ciddi jank yaratır |
| Cluster balonları (sayı rozetli) | `SymbolLayer` (dinamik metin: `count`) | Aynı gerekçe; metin de sprite/label olarak GL'de |
| Seçili/aktif pin (kullanıcı dokunduğunda büyüyen, gölgeli pin) | Flutter widget marker (`PointAnnotation` yerine overlay widget) | Karmaşık animasyon (scale + shadow + gölge blur) GL sprite ile pratik değil; tek bir aktif pin olduğundan performans maliyeti ihmal edilebilir |
| Kullanıcı konum puck'ı (mavi nokta + yön konisi) | Native SDK location component (built-in) | SDK'nın kendi optimize bileşeni; yeniden yazmaya gerek yok |
| Rota/koy sınırı gibi gelecek katmanlar (foundation §9 MapLayer arayüzü) | `LineLayer`/`FillLayer` (GL) | Aynı prensip — vektör katmanlar her zaman GL'de |

- Sprite atlas: 9 `location_type` ikonu × (normal, seçili) × (light/dark harita stili) = derlenmiş tek PNG/SDF atlas, uygulama ile birlikte paketlenir (ağ isteği yok).
- Dokunma (tap) hedefi: `SymbolLayer` `queryRenderedFeatures` ile hit-test yapılır; minimum dokunma alanı 44x44dp garanti edilecek şekilde sprite padding'i ayarlanır.

---

## 4. Ağ Performansı

### 4.1 Cursor Pagination
- Foundation §6 kanonik: tüm liste uçları `?cursor=&limit=`. Varsayılan `limit`: mobil liste ekranları (S-07 arama sonuçları, S-11 yorumlar, S-15 taleplerim, S-16 favoriler) **20**; harita bbox sorgusu ayrı sınırla çalışır (13 §2.3, max 200 satır dar view).
- İstemci: `infinite_scroll` deseni, son öğeye 5 öğe kala prefetch tetiklenir (kullanıcı beklemeden bir sonraki sayfa hazır olur).
- Cursor opak taşınır (`base64(created_at,id)` gibi); istemci içeriğini yorumlamaz, yalnız sunucudan geldiği gibi geri gönderir.

### 4.2 Sıkıştırma (gzip/brotli) ve HTTP/2
- API Gateway tüm JSON yanıtlarında `Content-Encoding: br` (brotli, istemci `Accept-Encoding: br, gzip` gönderirse) veya `gzip` fallback; eşik: 1 KB üstü yanıtlar sıkıştırılır (küçük yanıtlarda overhead kazandırmaz).
- Tüm bağlantılar **HTTP/2** (API Gateway + CloudFront varsayılan); tek TCP/TLS bağlantısı üzerinden çoklu istek (multiplexing) — harita ekranında eşzamanlı bbox + amenity + kullanıcı favorileri istekleri için bağlantı kurulum maliyeti tekrarlanmaz.
- `dockly_api` HTTP client (Dio) **connection keep-alive** + HTTP/2 destekli engine (`cupertino_http` iOS'ta, `cronet`/`okhttp` Android'de native performans için değerlendirildi — v1'de standart `dart:io HttpClient` + Dio, ölçüme göre native adaptöre geçiş backlog'da).

### 4.3 İstek Birleştirme (Request Coalescing/Batching)
- S-09 (Lokasyon Detay) açılışında: detay + ilk sayfa yorumlar + amenity listesi **tek Edge Function** ucu ile birleştirilir (`GET /locations/{id}` yanıtı zaten iç içe `amenities[]` + `reviews_preview[]` (ilk 3) döner; ayrı yorum sayfası yalnız "tümünü gör" (S-11) tetiklendiğinde çağrılır) — foundation §6 endpoint yüzeyiyle uyumlu, ekstra round-trip önlenir.
- Aynı frame'de tetiklenen birden fazla favori/recently-viewed yazma isteği **debounce + batch** edilir (ör. hızlı favori aç/kapa): 500 ms pencere içinde son durum tek istek olarak gönderilir.
- `dockly_api` içinde aynı anda aynı endpoint+parametre için birden fazla in-flight istek varsa **request de-duplication** (aynı Future paylaşılır) — ör. hızlı ardışık widget rebuild'lerinde aynı `locations/{id}` iki kez çağrılmaz.
- Arama kutusu (S-07): girişte **debounce 300 ms** + minimum 2 karakter eşiği; önceki istek `CancelToken` ile iptal edilir (§3.2 ile aynı desen).

---

## 5. Görsel Pipeline

### 5.1 Format ve Varyantlar
Kanonik varyant tablosu 13-olceklenebilirlik-plani.md §4.2 ile birebir aynıdır (tek doğruluk kaynağı orada):

| Varyant | Boyut | Format | Kullanım (ekran) |
|---|---|---|---|
| `thumb` | 200px kısa kenar, q60 | WebP | Liste kartları (S-07, S-16), galeri grid (S-09, S-10) |
| `medium` | 800px, q75 | WebP | Detay hero (S-09), kart carousel |
| `full` | 1600px, q80 | WebP | Tam ekran galeri (S-10) |
| `blurhash` | string (~20-30 karakter) | — | Placeholder (yükleme sırasında + hata durumunda) |

- İstemci **her zaman ekrana uygun en küçük varyantı** ister; S-10 tam ekran galeride dahi önce `medium` gösterilip kullanıcı zoom/pinch yaptığında `full` talep edilir (kademeli yükleme — "progressive reveal").
- T3'te AVIF varyantı eklendiğinde (13 §4.2) istemci `Accept` header'ı ile müzakere eder; v1'de yalnız WebP.

### 5.2 Blur-hash / LQIP Politikası
- Her `photos` satırı sunucu tarafında üretilmiş `blurhash` kolonu taşır (13 §4.2). İstemci akışı:
  1. Görsel widget mount olur olmaz **blurhash anında decode edilip çizilir** (< 100 ms bütçe, §1) — ağdan bağımsız, ilk boya (paint) hemen olur.
  2. `thumb`/`medium` varyantı paralelde indirilir; geldiğinde 200 ms cross-fade ile blurhash üzerine biner.
  3. Ağ hatası/timeout durumunda blurhash + "yeniden dene" ikonu kalıcı gösterilir (asla boş gri kutu yok — algılanan performans ilkesi).
- `dockly_ui` paketinde tek bileşen: `DocklyNetworkImage` (blurhash + cached_network_image + memCacheWidth mantığını sarmalar) — tüm feature'lar bunu kullanır, doğrudan `CachedNetworkImage` çağrısı code review'da reddedilir.

### 5.3 cached_network_image Politikası
- Disk cache: `DocklyImageCacheManager`, 200 MB LRU, TTL 30 gün (fotoğraf key'leri içerik-adresli/immutable olduğundan — 13 §4.1 — stale veri riski yok, yalnız disk alanı yönetimi için LRU).
- Bellek cache: §2.2'de belirtilen `ImageCache` limitleri.
- Prefetch: S-07 arama sonuçları ve S-06 harita alt kartı görünüme girmeden önce (ör. `ListView` `cacheExtent` ile) bir sonraki 3-5 kartın `thumb` görseli önceden indirilir.
- Hata/placeholder: blurhash yoksa (nadir, migration öncesi eski kayıt) statik marka renkli placeholder (foundation §7 `bg.surface` tonunda) — asla varsayılan Flutter kırık-görsel ikonu gösterilmez.

---

## 6. Veritabanı Sorgu Performansı — EXPLAIN Hedefleri

Bu bölüm 13-olceklenebilirlik-plani.md §2.3 ve §9.2'de atıfta bulunulan somut hedefleri tanımlar (13 §2.3: *"hedefler 14-performans-plani.md §6'da"*).

### 6.1 Kritik Sorgu 1 — Harita Bbox Sorgusu
```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, slug, name, type, ST_X(geo::geometry) AS lon, ST_Y(geo::geometry) AS lat,
       price_tier, rating_avg
FROM api.map_pins  -- dar view, foundation/13 §2.3
WHERE geo && ST_MakeEnvelope($1,$2,$3,$4,4326)::geography
  AND status = 'published' AND deleted_at IS NULL
  AND type = ANY($5)
ORDER BY rating_count DESC
LIMIT 200;
```
| Hedef | Değer |
|---|---|
| Plan tipi | `Index Scan`/`Bitmap Index Scan` **using GIST** (`locations_geo_gist_idx`) — asla `Seq Scan` |
| Execution time (p95, T1 veri hacmi ~2.500 satır) | **< 15 ms** |
| Execution time (p95, T2 hacmi ~6.000 satır) | **< 40 ms** |
| Execution time (p95, T3 hacmi ~40.000 satır) | **< 80 ms** (13 §9.2 SLO ile birebir) |
| Buffers | Shared hit oranı > %95 (sıcak veri, çalışma seti RAM'de) |

### 6.2 Kritik Sorgu 2 — `pg_trgm` Arama (S-07)
```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, slug, name, type, city, district
FROM locations
WHERE deleted_at IS NULL AND status = 'published'
  AND (name % $1 OR city % $1 OR district % $1 OR bay_name % $1)
ORDER BY similarity(name, $1) DESC
LIMIT 20;
```
| Hedef | Değer |
|---|---|
| Plan tipi | `Bitmap Index Scan` **using GIN** (`pg_trgm`, foundation §5 kanonik index) |
| `similarity` eşiği | `pg_trgm.similarity_threshold = 0.25` (query-time `SET` veya fonksiyon parametresi) — düşük eşik gereksiz geniş tarama yaratmasın diye izlenir |
| Execution time (p95, T2) | **< 60 ms** |
| Sonuç kalitesi | Yazım hatalarına toleranslı (ör. "bodrm" → "Bodrum"); minimum skor altı sonuç dönmez |
| T3 notu | Sözlük büyüdükçe (13 §9.1 madde 6) tsvector hibrit veya ayrı arama servisi (Meilisearch/Typesense) değerlendirilir — repository arayüzü zaten soyut (`LocationSearchRepository`), geçiş yeniden yazım gerektirmez |

### 6.3 Kritik Sorgu 3 — Lokasyon Detay Sorgusu (S-09)
```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT l.*,
       (SELECT jsonb_agg(a.*) FROM location_amenities la JOIN amenities a ON a.id = la.amenity_id WHERE la.location_id = l.id) AS amenities,
       (SELECT jsonb_agg(p.*) FROM photos p WHERE p.owner_type='location' AND p.owner_id=l.id AND p.status='approved' ORDER BY p.created_at DESC LIMIT 12) AS photos,
       (SELECT jsonb_agg(r.*) FROM reviews r WHERE r.location_id=l.id AND r.status='approved' AND r.deleted_at IS NULL ORDER BY r.created_at DESC LIMIT 3) AS reviews_preview
FROM locations l
WHERE l.id = $1 AND l.deleted_at IS NULL;
```
| Hedef | Değer |
|---|---|
| Plan tipi | Ana satır: `Index Scan using locations_pkey`; alt sorgular: FK index kullanımı (`location_amenities(location_id)`, `photos(owner_type, owner_id)`, `reviews(location_id, status)`) |
| Execution time (p95) | **< 25 ms** (tek satır + sınırlı alt sorgular, CDN cache ile zaten origin yükü düşük — 13 §3.2) |
| N+1 kontrolü | Tüm ilişkili veri **tek sorguda** (lateral/subquery agregasyon) döner; API katmanında ayrı ayrı sorgu YASAK (code review checklist) |
| Cache | CloudFront 300s + SWR 600s (13 §3.2) — bu EXPLAIN hedefi yalnız cache-miss/origin durumunu kapsar |

### 6.4 Genel DB Performans Disiplini
- Her yeni migration PR'ında, `locations`/`reviews`/`booking_requests`/`photos` tablolarını etkileyen sorgular için `EXPLAIN (ANALYZE, BUFFERS)` çıktısı PR açıklamasına eklenir (CI kontrol listesi maddesi).
- Çeyreklik regresyon: `pg_stat_statements` top-10 yavaş sorgu raporu (13 §2.3 ile aynı ritim) — bu dokümandaki hedeflerle karşılaştırılır, sapma > %20 ise P1 backlog.
- `EXPLAIN` planlarında `Seq Scan` görülen herhangi bir kritik yol sorgusu **release blocker** kabul edilir (index eksikliği veya istatistik bayatlığı; `ANALYZE` tetiklenir).

---

## 7. Offline Cache Stratejisi (Drift)

### 7.1 Cache Edilen Veri ve Politika
Foundation §2 (Drift/SQLite) ve 13-olceklenebilirlik-plani.md §6 ("Client — Drift" satırı) ile uyumlu:

| Veri | Drift tablosu (istemci) | Tazelik stratejisi | Boyut/TTL |
|---|---|---|---|
| Lokasyon detayları (görüntülenenler) | `cached_locations` | Stale-while-revalidate: önce cache göster, arkada tazele | 7 gün TTL, LRU 500 kayıt |
| Harita pin'leri (son görüntülenen bbox'lar) | `cached_map_pins` | Bbox+zoom anahtarlı; §3.2 debounce ile eşleşir | 24 saat TTL, en fazla son 10 bbox |
| `amenities` sözlüğü | `cached_amenities` | Neredeyse hiç değişmez | 7 gün TTL, versiyon numarasıyla invalidation |
| Favoriler | `cached_favorites` | Optimistic update + arka plan senkron | Kalıcı (kullanıcı oturumuyla) |
| Son aramalar / son görüntülenenler | `cached_recently_viewed` | Yalnız lokal (misafirde sunucuya gitmez — 12-guvenlik-plani.md §2.3) | 90 gün, en fazla 50 kayıt |
| Taslak rezervasyon talebi (S-14, offline doldurulmuş form) | `draft_booking_requests` | Ağ gelince otomatik gönderim (Idempotency-Key ile, 12 §6.4) | Gönderilene kadar kalıcı |
| Bildirimler (son görüntülenen) | `cached_notifications` | Pull-to-refresh + FCM push tetikli senkron | 30 gün |

### 7.2 Senkronizasyon ve Çakışma Kuralları
- Okuma verisi (locations, amenities): sunucu her zaman "doğru" kaynak — çakışma yok, yalnız üzerine yazma (overwrite).
- Kullanıcı verisi (favorites, draft booking requests): "son yazan kazanır" (last-write-wins) `updated_at` karşılaştırmasıyla; çakışma nadir olduğundan (tek kullanıcı, tek cihaz senaryosu ağırlıklı) karmaşık CRDT gerekmez — v1 kararı, çoklu cihaz senaryosu artarsa gözden geçirilir.
- Ağ döndüğünde senkron sırası: önce yazma kuyruğu (draft requests, favori değişiklikleri) boşaltılır, sonra okuma cache'i arka planda tazelenir.
- Depolama bütçesi: toplam Drift veritabanı boyutu düşük uçta **< 30 MB**, orta/üstte **< 80 MB** hedeflenir; aşımda en eski `cached_locations`/`cached_map_pins` kayıtları budanır (scheduled cleanup, uygulama açılışında arka planda).

### 7.3 Offline Kullanıcı Deneyimi
- Ağ yokken: son cache'lenen bbox pinleri + "Çevrimdışısınız, gösterilen veriler güncel olmayabilir" banner'ı (S-06).
- S-14 (Rezervasyon Talebi formu) offline doldurulabilir, gönderim ağ gelince otomatik dener (arka planda, kullanıcıya bildirim ile — `notifications` `type='system'`).
- Yazma gerektiren aksiyonlar (yorum, fotoğraf, favori — misafir olmayan) offline'da devre dışı buton + açıklayıcı tooltip; sessiz başarısızlık YOK.

---

## 8. Ölçüm ve İzleme

### 8.1 Firebase Performance — Custom Trace'ler
Kanonik trace isimleri (kod tabanında sabit, değiştirilemez — dashboard sürekliliği için):

| Trace adı | Kapsam |
|---|---|
| `app_start` | Process start → S-06 ilk etkileşilebilir kare |
| `app_resume` | Arka plandan dönüş → etkileşilebilir |
| `map_first_render` | S-06 mount → ilk pin kümesi çizildi |
| `screen_transition_{from}_{to}` | GoRouter navigasyon süresi (ör. `screen_transition_s06_s09`) |
| `search_latency` | S-07 girdi → sonuç listesi render |
| `image_load_thumb` / `image_load_medium` / `image_load_full` | Görsel varyant istek → decode tamamlanma |
| `booking_request_submit` | S-14 gönder tıklama → sunucu yanıtı |

- Otomatik toplananlar (Firebase Performance varsayılan): app start (cold/warm), HTTP request süreleri (`dockly_api` otomatik enstrümante), ekran render süreleri.
- Segmentasyon: cihaz sınıfı (§9), OS versiyonu, ağ tipi (wifi/4g/3g), ülke — dashboard'da kademeli filtre.

### 8.2 Sentry Transactions
- `dockly_api` Dio interceptor her isteği Sentry transaction/span olarak işaretler (`http.client` span, endpoint adı normalize edilmiş — ID'ler `{id}` placeholder'a indirgenir, kardinalite patlaması önlenir).
- Kritik kullanıcı yolculukları (booking request akışı, auth akışı) uçtan uca transaction: `flow.booking_request` (S-06→S-09→S-14→submit), alt span'lar her adımı gösterir; yavaş adım tek bakışta görülür.
- Backend: her Edge Function çağrısı kendi Sentry transaction'ını açar (`edge.{function_name}`), DB sorgu span'ları (Supabase client instrumentation) alt span olarak eklenir — API p95 ihlali durumunda hangi katmanda (network/DB/işleme) zaman harcandığı ayrıştırılır.
- Sampling: production'da transaction sample rate %10 (maliyet/gürültü dengesi), hata (error) durumunda her zaman %100; yük testi/staging'de %100.

### 8.3 Custom Trace'ler ve Dashboard
- Haftalık "Performans Panosu" (Grafana + Firebase Performance konsolu + Sentry Performance sekmesi tek sayfada özetlenir): §1 bütçe tablosundaki her metrik için p50/p95/p99 trend.
- Alarm eşiği: bütçenin %90'ında uyarı, aşımda incident (12-guvenlik-plani.md §11 şiddet seviyeleri ile aynı çerçeve, SEV-3 varsayılan — kullanıcı etkisi kanıtlanırsa SEV-2'ye yükseltilir).
- Yaz sezonu (13 §1.2) öncesi Nisan ayında ek "performans sağlık kontrolü": tüm bütçeler düşük uçta yeniden doğrulanır.

### 8.4 CI'da Performans Regresyon Testleri
- **Widget/render regresyonu:** `flutter test --update-goldens` dışında, `integration_test` + `flutter drive --profile` ile kritik ekranlarda (S-06, S-07, S-09) frame timeline toplanır; jank frame sayısı ve ortalama frame süresi önceki `main` baseline'ıyla karşılaştırılır (`%15` üstü regresyon → CI fail).
- **Uygulama boyutu regresyonu:** her PR'da AAB/IPA boyut farkı raporlanır (`> +500 KB` tek PR'da → uyarı yorum; `> +2 MB` → onay gerektirir).
- **Cold start regresyonu:** Android üzerinde `am start -W` ile ölçülen `TotalTime`, nightly CI'da düşük-uç emülatör profilinde (§9) baseline ile karşılaştırılır.
- **Backend regresyon:** `EXPLAIN ANALYZE` çıktısı kritik sorgular için migration CI job'ında otomatik çalıştırılır (küçük sentetik veri seti + T2-ölçekli fixture); plan tipi `Seq Scan`'e döndüyse **build fail**.
- **k6 performans profili** (13 §10 ile aynı araç) nightly'de küçük profilde API p95 bütçesini doğrular; sezon öncesi tam profil.
- Sonuçlar `docs/perf-reports/` altında tarihli saklanır (13 §10 `load-reports/` ile kardeş dizin); regresyonlar backlog'a P1.

---

## 9. Düşük Seviye Cihaz Hedefi ve Cihaz Matrisi

### 9.1 Hedef Tanımı
- **Minimum desteklenen Android:** API 24 (Android 7.0) — Flutter'ın pratik alt sınırı ve TR pazarında hâlâ anlamlı pay taşıyan eski cihazlar.
- **Düşük seviye referans profil:** 2 GB RAM, 4 çekirdek orta-alt SoC (ör. Mediatek Helio/Snapdragon 4-serisi sınıfı), 720p-1080p ekran, eMMC depolama (yavaş I/O). Bu profil §1 bütçelerinin "minimum kabul edilebilir" hattıdır; üst/orta cihazlarda bütçeler daha rahat karşılanır.
- **iOS minimum:** foundation'da belirtilen platform hedefiyle uyumlu en az iPhone SE (2. nesil) sınıfı donanım; iOS tarafında parçalanma (fragmentation) Android kadar geniş olmadığından ayrı "düşük uç profili" tanımlanmaz, ancak SE serisi CI/manuel test matrisinde daima yer alır.

### 9.2 Cihaz Matrisi (Manuel + Otomatik Test Kapsamı)
| Sınıf | Örnek cihaz | RAM | OS | Kapsam |
|---|---|---|---|---|
| Android — Düşük | Samsung Galaxy A0x / Xiaomi Redmi 9 serisi sınıfı | 2 GB | Android 8–9 | Cold start, harita render, bellek profili — her release |
| Android — Orta | Samsung Galaxy A5x, Xiaomi Redmi Note 1x | 4 GB | Android 11–13 | Tam regresyon paketi — her release |
| Android — Üst | Google Pixel 7/8, Samsung Galaxy S2x | 8 GB+ | Android 14+ | Golden path smoke — her release |
| Android — Tablet | Samsung Galaxy Tab A | 3–4 GB | Android 12+ | Layout/responsive kontrol — çeyreklik |
| iOS — Düşük | iPhone SE (2. nesil) | 3 GB | iOS 16+ | Cold start, harita render — her release |
| iOS — Orta/Üst | iPhone 13/14/15 | 4–6 GB | iOS 17+ | Tam regresyon paketi — her release |
| iOS — Tablet | iPad (9./10. nesil) | 3–4 GB | iPadOS 16+ | Layout/responsive — çeyreklik |

- Otomasyon: Firebase Test Lab (Android fiziksel/emülatör matrisi) + Xcode Cloud/local device farm (iOS) CI'ya entegre; her release adayı (RC) bu matrisin tamamından geçer (bkz. 15-test-stratejisi.md §11 manuel QA süreciyle birlikte yürütülür).
- Ağ profili simülasyonu: testler yalnızca WiFi'de değil, "Regular 3G" ve "Slow 4G" throttle profillerinde de (Chrome DevTools benzeri network conditioning, Android'de `tc`/emülatör ayarı) koşulur — Türkiye kıyı bölgelerinde (koylar, açık deniz yakını) zayıf hücresel sinyal gerçek kullanım senaryosudur.
- Düşük uç cihazlarda özel ayarlar (§2.2 image cache limitleri, §3.3 tile cache 30 MB) `RuntimeConfig.deviceTier` (`low/mid/high`) ile çalışma zamanında belirlenir: toplam RAM + çekirdek sayısına göre basit sınıflandırma, açılışta bir kez hesaplanır.

### 9.3 Kabul Kriteri (Release Gate)
- Düşük seviye Android referans profilinde: cold start < 2.4 s (bütçenin %20 toleranslısı, düşük uç için resmi istisna), harita ilk render < 2.0 s, jank oranı < %3.
- Bu eşiklerin üstünde bir RC (release candidate) düşük uç kapsamında **release edilmez**; performans lead onayı olmadan istisna geçilmez.

---

## 10. Sorumluluklar ve Gözden Geçirme

- Mobil performans bütçeleri: Mobil Lead sahiplenir, her sprint sonunda §8.1 dashboard'u gözden geçirir.
- Backend/DB performansı: Backend Lead sahiplenir, §6 EXPLAIN hedeflerini migration review checklist'ine dahil eder.
- Bu doküman her çeyrek CTO tarafından, 13-olceklenebilirlik-plani.md ile birlikte gözden geçirilir (kademe geçişleri performans bütçelerini de tetikleyebilir — ör. T3'te API p95 hedefi coğrafi genişleme nedeniyle bölge bazlı ayrıştırılabilir).
- Değişiklikler `docs/perf-reports/` ve bu dosyanın changelog'unda izlenir.
