# Dockly — Component Library (10)

> Bu doküman [00-foundation.md](00-foundation.md) ve [09-design-system.md](09-design-system.md) dokümanlarına tabidir. Tüm bileşenler `packages/dockly_ui/lib/src/components/` altında yaşar, yalnızca 09'daki token'ları tüketir (hex/hardcoded değer yasak) ve `dockly_ui.dart` barrel'ından export edilir. Ekran ID'leri foundation §8'den birebirdir.

## İçindekiler ve hiyerarşi (Atomic Design)

| Katman | Bileşenler |
|---|---|
| **Atoms** | DocklyButton, DocklyTextField, DocklyAvatar, DocklyBadge, DocklyRatingStars, DocklyAmenityChip, DocklyFilterChip, DocklySkeleton, DocklyDivider, DocklyIcon |
| **Molecules** | DocklySearchBar, DocklySegmentedControl, DocklyToast, DocklyDatePicker, DocklyGlassPanel, DocklyMapPin, DocklyEmptyState, DocklyListTile |
| **Organisms** | DocklyBottomSheet, DocklyLocationCard, DocklyBoatCard, DocklyCard, DocklyPhotoGallery, DocklyReviewCard |

Kural: Atoms hiçbir Dockly bileşenine bağımlı olamaz; Molecules yalnız Atoms'a; Organisms her ikisine bağımlı olabilir. Hiçbir bileşen feature koduna (Riverpod provider, repository) bağımlı OLAMAZ — tamamı saf, prop-driven widget'lardır.

Ortak kurallar (tümü için geçerli):
- Dark/light: renkler `Theme.of(context).extension<DocklyColors>()!` üzerinden; hiçbir bileşende mod kontrolü `if (isDark)` ile yazılmaz, token zaten çift değerlidir. İstisnalar bileşen kartında belirtilir.
- Dokunma hedefi min 44×44pt; tüm interaktif bileşenler `Semantics` etiketi alır; state animasyon süreleri `DocklyMotion` token'larından.
- `onPressed: null` = disabled görünümü (ekstra flag yok, Flutter konvansiyonu).

---

## 1. Atoms

### 1.1 DocklyButton
- **Amaç:** Tüm aksiyon butonları; tek buton bileşeni, varyantla çeşitlenir.
- **Varyantlar:** `primary` (dolgu `brand.primary`, metin `text.inverse`), `secondary` (yumuşak dolgu `brand.primary` %10, metin `brand.primary`), `ghost` (yalnız metin), `destructive` (`semantic.error`), `glass` (glass panel üstü, harita kontrolleri).
- **Boyutlar:** `large` (52pt, tam genişlik — CTA), `medium` (44pt), `small` (36pt — inline; tap alanı 44'e tamamlanır).
- **State'ler:** default / pressed (scale 0.97, 150ms) / disabled (%40 opaklık) / loading (metin yerine 20pt spinner, genişlik sabit kalır, çift tap kilidi).
- **API:**
```dart
DocklyButton({
  required String label,
  required VoidCallback? onPressed,
  DocklyButtonVariant variant = DocklyButtonVariant.primary,
  DocklyButtonSize size = DocklyButtonSize.large,
  IconData? leadingIcon,
  bool isLoading = false,
  bool expand = true,
})
```
- **Ekranlar:** S-03, S-09 (sticky CTA), S-12, S-13, S-14, S-18, S-22, S-23 — pratikte tümü.
- **Dark/light:** token otomatik; `glass` varyantı dark'ta border vurgusunu `rgba(255,255,255,0.08)`e düşürür.

### 1.2 DocklyTextField
- **Amaç:** Tüm metin girişleri.
- **Varyantlar:** `text`, `multiline` (not/yorum, karakter sayacı), `phone` (TR maskesi +90 5__ ___ __ __), `number` (boy/draft; suffix birim "m"), `otp` (6 kutu, S-05).
- **State'ler:** default / focused (border `brand.primary` 2pt, 150ms) / filled / error (border `semantic.error` + altta hata metni caption + shake) / disabled / autofilled (turkuaz %15 flash 200ms — tekne otomatik dolumu, bkz. 08 §6).
- **API:**
```dart
DocklyTextField({
  required TextEditingController controller,
  String? label, String? hint, String? errorText, String? suffixText,
  DocklyFieldType type = DocklyFieldType.text,
  int? maxLength, bool enabled = true,
  ValueChanged<String>? onChanged, VoidCallback? onEditingComplete,
})
```
- **Ekranlar:** S-04, S-05, S-12, S-14, S-18, S-22, S-23.
- **Dark/light:** zemin `bg.sunken`; dark'ta border kontrastı `border.strong` ile artırılır.

### 1.3 DocklyAvatar
- **Amaç:** Kullanıcı görseli; yoksa ad-soyad baş harfleri (`brand.deep` zemin üzerinde).
- **Boyutlar:** `xs 24` (yorum satırı), `sm 32` (harita üstü buton), `md 44` (liste), `lg 64` (profil başlığı), `xl 96` (S-19).
- **State'ler:** default / loading (skeleton daire) / error→baş harf fallback; opsiyonel rozet noktası (bildirim).
- **API:** `DocklyAvatar({String? imageUrl, required String fullName, DocklyAvatarSize size = .md, bool showDot = false, VoidCallback? onTap})`
- **Ekranlar:** S-06 (harita üstü), S-11, S-19, A-07.
- **Dark/light:** baş harf zemini iki modda `brand.deep` (sabit), metin `#F2F5F9`.

### 1.4 DocklyBadge
- **Amaç:** Durum rozetleri ve sayaçlar.
- **Varyantlar:** `status` (metinli pill — `booking_request_status` ve `moderation_status` renk eşlemesi 09 §1.3 yumuşak zeminleriyle), `count` (dairesel sayı, tab/filtre ikonu üstü), `dot` (8pt nokta), `priceTier` (`free`→"Ücretsiz" yeşil, `paid`→"Ücretli" mavi, `unknown`→"Bilinmiyor" gri).
- **API:** `DocklyBadge.status({required String label, required DocklySemanticTone tone})`, `DocklyBadge.count({required int value})`, `DocklyBadge.priceTier({required String tier})`
- **Ekranlar:** S-06 (mini kart), S-08, S-09, S-15, S-21, A-06.
- **Dark/light:** yumuşak zemin çiftleri 09 §1.3 tablosundan.

### 1.5 DocklyRatingStars
- **Amaç:** Puan gösterimi ve girişi.
- **Varyantlar:** `display` (salt okunur, yarım yıldız destekli, yanında "4,7 (128)" metni opsiyonel), `input` (44pt yıldızlar, sıralı dolum animasyonu + haptic, altında anlam etiketi).
- **State'ler:** empty / partial / filled; input'ta pressed scale.
- **API:** `DocklyRatingStars.display({required double rating, int? count, double size = 14})`, `DocklyRatingStars.input({required int value, required ValueChanged<int> onChanged})`
- **Ekranlar:** S-06, S-09, S-11, S-12.
- **Dark/light:** dolu yıldız `semantic.warning`, boş yıldız `border.strong`.
- **Erişilebilirlik:** input varyantı `Semantics(adjustable)` — swipe ile 1–5.

### 1.6 DocklyAmenityChip
- **Amaç:** Hizmet gösterimi (salt okunur) — foundation §4 amenity kodlarıyla ikon eşlemesi (09 §6.2).
- **Varyantlar:** `iconOnly` (mini kartta, 24pt), `labeled` (ikon + TR ad, S-09 grid'i), `overflow` ("+3" sayacı).
- **API:** `DocklyAmenityChip({required String amenityCode, DocklyAmenityChipVariant variant = .labeled})`
- **Ekranlar:** S-06 (mini kart), S-09.
- **Dark/light:** zemin `bg.sunken`, ikon `text.secondary`.

### 1.7 DocklyFilterChip
- **Amaç:** Seçilebilir filtre/öneri chip'i (amenity seçiminden farklı: interaktif).
- **State'ler:** unselected / selected (dolgu `brand.primary` %12, border `brand.primary`, ikon renklenir) / disabled; toggle'da `selectionClick` haptic + 150ms geçiş.
- **Varyantlar:** `toggle` (S-08), `suggestion` (S-07 öneri chip'leri, tap'te aksiyon), `removable` (aktif filtre özeti, sağda ×).
- **API:** `DocklyFilterChip({required String label, IconData? icon, required bool selected, required VoidCallback onTap, VoidCallback? onRemove})`
- **Ekranlar:** S-06 (peek hızlı filtreler), S-07, S-08.
- **Dark/light:** seçili dolgu dark'ta `brand.primary` %18 (koyu zeminde görünürlük).

### 1.8 DocklySkeleton
- **Amaç:** Yükleme iskeleti; gerçek layout'un birebir gölgesi (shift sıfır — 08 §8.2 zamanlama kuralları).
- **Varyantlar:** `box(width, height, radius)`, `circle(size)`, `text(lines)`, hazır kompozitler: `DocklySkeleton.locationCard()`, `.listTile()`, `.reviewCard()`.
- **API:** `DocklySkeleton.box({required double width, required double height, double radius = 12})`
- **Ekranlar:** S-06, S-09, S-11, S-15, S-16, S-21.
- **Dark/light:** shimmer kontrastı light %6 / dark %4.

### 1.9 DocklyDivider
- **Amaç:** Bölüm ayracı. Varyantlar: `full`, `inset` (soldan 16), `section` (üst-alt `space.6` boşluklu).
- **API:** `DocklyDivider({DocklyDividerVariant variant = .inset})` — renk `border.subtle`.
- **Ekranlar:** liste içeren tüm ekranlar.

### 1.10 DocklyIcon
- **Amaç:** SF Symbols / Material Symbols ve özel denizcilik seti (09 §6) için tek giriş noktası; platforma göre doğru glyph'i seçer, semantik etiketi zorlar.
- **API:** `DocklyIcon(DocklyIcons.anchor, {double size = 24, Color? color, String? semanticLabel})`
- **Ekranlar:** tümü.

---

## 2. Molecules

### 2.1 DocklySearchBar
- **Amaç:** Harita üstü yüzen arama kapsülü ve S-07 aktif arama alanı — tek bileşen, iki mod (morph animasyonu 08 §3.1).
- **Varyantlar:** `idle` (glass kapsül, placeholder "Marina, koy, iskele ara…", sağda filtre ikonu + `DocklyBadge.count`), `active` (gerçek input, "Vazgeç" butonu, temizle ×).
- **State'ler:** idle / focused / typing / loading (kapsül altında 2pt progress çizgisi).
- **API:**
```dart
DocklySearchBar({
  required DocklySearchBarMode mode,
  String? query, ValueChanged<String>? onChanged,
  VoidCallback? onTapIdle, VoidCallback? onCancel,
  VoidCallback? onFilterTap, int activeFilterCount = 0,
})
```
- **Ekranlar:** S-06, S-07.
- **Dark/light:** glass token otomatik; dark'ta placeholder `text.tertiary`.

### 2.2 DocklySegmentedControl
- **Amaç:** 2–4 seçenekli sekmeli seçim (iOS tarzı, kayan seçili pill).
- **State'ler:** seçim değişiminde pill 250ms spring ile kayar + `selectionClick`.
- **API:** `DocklySegmentedControl<T>({required List<DocklySegment<T>> segments, required T value, required ValueChanged<T> onChanged})`
- **Ekranlar:** S-08 (`price_tier`), S-15 (Aktif/Geçmiş), S-20 (tema: Sistem/Açık/Koyu), S-11 (sıralama).
- **Dark/light:** ray `bg.sunken`, pill `bg.surface` + elevation.1.

### 2.3 DocklyToast
- **Amaç:** Geçici bildirim; overlay üzerinde, tab bar'ın üstünde.
- **Varyantlar:** `info`, `success`, `error` (ikon + semantic renk şeridi), opsiyonel aksiyon ("Geri Al", "Tekrar Dene").
- **Davranış:** 08 §13.3 animasyonu; 3s otomatik kapanır (aksiyonluysa 5s); üst üste binmez, kuyruklanır; `liveRegion` duyurusu.
- **API:** `DocklyToast.show(context, {required String message, DocklyToastTone tone = .info, String? actionLabel, VoidCallback? onAction})`
- **Ekranlar:** global (S-09 kopyalama, S-12 hata, S-16 geri al…).
- **Dark/light:** glass zemin + elevation.3.

### 2.4 DocklyDatePicker
- **Amaç:** Check-in/check-out aralık seçimi (S-14) ve tekil tarih.
- **Varyantlar:** `range` (tek takvimde başlangıç-bitiş, aradaki günler `brand.primary` %10 bant), `single`.
- **State'ler:** geçmiş günler disabled; seçimde `lightImpact`; gece sayısı canlı özet ("3 gece").
- **API:** `DocklyDatePicker.range({DateTimeRange? initial, required ValueChanged<DateTimeRange> onChanged, DateTime? minDate})`
- **Ekranlar:** S-14.
- **Dark/light:** seçili gün dolgusu `brand.primary`, metin `text.inverse` (iki modda).

### 2.5 DocklyGlassPanel
- **Amaç:** Glassmorphism yüzeyi için TEK kaynak (blur 20 + `bg.glass` + border + saturasyon, 09 §5); tüm glass bileşenler bunu sarar.
- **Varyantlar:** `panel` (radius.md), `pill` (radius.full), `bar` (radius 0 — tab/nav bar).
- **API:** `DocklyGlassPanel({required Widget child, DocklyGlassShape shape = .panel, EdgeInsets padding = const EdgeInsets.all(16)})`
- **Ekranlar:** S-06 (arama, tab bar, kontroller), S-09 (nav bar, sticky CTA).
- **Dark/light + erişilebilirlik:** "şeffaflığı azalt" açıkken otomatik opak moda düşer (09 §5) — bu davranış bileşenin İÇİNDE, tüketici bilmez.

### 2.6 DocklyMapPin
- **Amaç:** Harita pin'i; `location_type` → renk/ikon eşlemesi (09 §1.4, `docklyMapPinColors`) tek yerden.
- **Varyantlar:** `pin` (damla form, beyaz glyph), `selected` (1.3× + beyaz halka + gölge), `cluster` (glass daire + sayı + baskın tip halkası), `label` (zoom ≥ 14.5'te ad pill'i).
- **State'ler:** default / selected / dimmed (%60 — başka pin seçiliyken).
- **API:** `DocklyMapPin({required String locationType, DocklyPinState state = .normal})`, `DocklyMapPin.cluster({required int count, required String dominantType})` — Mapbox annotation'a bitmap üretimi için `toImage()` yardımcı metodu içerir.
- **Ekranlar:** S-06, S-09 (mini harita), S-22 (konum seçici).
- **Dark/light:** pin renkleri iki modda AYNI; dark'ta dış glow %20 güçlenir (bileşen içinde otomatik — token istisnası, belgeli).

### 2.7 DocklyEmptyState
- **Amaç:** Boş/hata durumları (metinler ve kullanım tablosu: 08 §8.1).
- **Varyantlar:** `empty` (denizci ikonu + mesaj + CTA), `error` (Tekrar Dene), `offline`, `permission` (konum/bildirim izni kartı).
- **API:** `DocklyEmptyState({required IconData icon, required String message, String? actionLabel, VoidCallback? onAction, DocklyEmptyStateVariant variant = .empty})`
- **Ekranlar:** S-07, S-11, S-15, S-16, S-17, S-21.
- **Dark/light:** ikon `text.tertiary`, illüstrasyon tonları tema token'larından.

### 2.8 DocklyListTile
- **Amaç:** Standart liste satırı (56pt min): ayarlar, arama sonuçları, bildirimler.
- **Varyantlar:** `navigation` (sağda chevron), `toggle` (sağda switch), `value` (sağda değer metni), `destructive`.
- **API:** `DocklyListTile({required String title, String? subtitle, Widget? leading, DocklyListTileTrailing? trailing, VoidCallback? onTap})`
- **Ekranlar:** S-07, S-20, S-21, S-19.

---

## 3. Organisms

### 3.1 DocklyBottomSheet
- **Amaç:** 3 snap noktalı (peek/half/full) kalıcı harita sheet'i VE modal sheet'ler — iki kip tek bileşende.
- **Varyantlar:** `persistent` (S-06; snap fiziği 08 §2.2: spring 380/32, hız eşiği 800pt/s, grabber 36×5), `modal` (S-08 half→full; S-14 full; scrim `overlay.scrim`).
- **State'ler:** peek / half / full / dragging; full'de tab bar gizlenir ve scrim devreye girer (persistent kipte %20).
- **API:**
```dart
DocklyBottomSheet.persistent({
  required Widget Function(BuildContext, DocklySheetPosition) builder,
  DocklySheetPosition initial = DocklySheetPosition.half,
  ValueChanged<DocklySheetPosition>? onPositionChanged,
  DocklySheetController? controller, // programatik snapTo()
})
```
- **Ekranlar:** S-06, S-08, S-14 (+ tüm modal sheet akışları).
- **Dark/light:** zemin glass (`DocklyGlassPanel.bar` + üst köşe `radius.lg`); dark'ta üst border vurgusu.
- **Erişilebilirlik:** snap durumları semantik "Genişlet/Daralt" aksiyonları olarak duyurulur.

### 3.2 DocklyLocationCard
- **Amaç:** Lokasyonun kart temsili — uygulamanın en kritik bileşeni.
- **Varyantlar:** `rail` (280×148, ray kartı: foto üst, ad + tip + ⭐ + mesafe alt), `wide` (mini kart, S-06 pin tap: yatay layout, amenity ikon satırı + `priceTier` rozeti), `list` (dikey listeler: S-16, S-07 sonuçları, full sheet), `compact` (S-15 talep kartı içinde referans).
- **State'ler:** default / pressed (scale 0.98) / loading (`DocklySkeleton.locationCard`) / favorili (kalp dolu).
- **API:**
```dart
DocklyLocationCard({
  required DocklyLocationCardData data, // id, ad, tip, foto, rating_avg,
  // rating_count, mesafe, price_tier, amenity kodları, isFavorite
  DocklyLocationCardVariant variant = DocklyLocationCardVariant.rail,
  required VoidCallback onTap,
  VoidCallback? onFavoriteTap,
  String? heroTag, // hero transition için (08 §2.4)
})
```
- **Ekranlar:** S-06, S-07, S-09 (benzer noktalar), S-15, S-16.
- **Dark/light:** `bg.surface` + elevation.2; foto placeholder `bg.sunken` üzerinde çapa ikonu.

### 3.3 DocklyBoatCard
- **Amaç:** Tekne kartı.
- **Varyantlar:** `full` (S-17: foto, ad, marka/model, boy/su çekimi, `is_primary` "Birincil" rozeti, düzenle), `compact` (S-14 yatay tekne seçici: 160×88, seçilince `brand.primary` 2pt border + turkuaz ✓), `addNew` (kesikli border "+ Tekne Ekle" kartı).
- **State'ler:** default / selected (compact) / pressed.
- **API:** `DocklyBoatCard({required DocklyBoatCardData data, DocklyBoatCardVariant variant = .full, bool selected = false, VoidCallback? onTap})`
- **Ekranlar:** S-14, S-17, S-18.
- **Dark/light:** standart kart davranışı; seçili border iki modda `brand.primary`.

### 3.4 DocklyCard
- **Amaç:** Genel amaçlı kart kabuğu (radius.md + elevation.2 + `bg.surface`); özel kartların (bilgi kartları, S-09 kapasite/derinlik karoları) temeli.
- **Varyantlar:** `elevated`, `outlined` (elevation.0 + `border.subtle`), `tappable` (ripple + press scale).
- **API:** `DocklyCard({required Widget child, DocklyCardVariant variant = .elevated, EdgeInsets padding = const EdgeInsets.all(16), VoidCallback? onTap})`
- **Ekranlar:** S-09, S-15, S-19, S-20 ve tüm kart içerenler.

### 3.5 DocklyPhotoGallery
- **Amaç:** Fotoğraf gösterimi.
- **Varyantlar:** `hero` (S-09 üst galeri: yatay pager + nokta göstergesi + parallax/stretch desteği), `grid` (S-09 alt ızgara: 3 kolon, son karoda "+12"), `fullscreen` (S-10: pinch-zoom, çift tap zoom, aşağı sürükle-kapat, sayfa sayacı "3/17"), `uploadGrid` (S-13: progress'li karolar, kaldır/tekrar dene).
- **State'ler:** loading (skeleton karo) / error (kırık görsel ikonu + yenile) / uploading (dairesel progress) / done (✓ 200ms scale-in).
- **API:** `DocklyPhotoGallery.hero({required List<DocklyPhoto> photos, String? heroTag, VoidCallback? onTapPhoto})`, `.fullscreen({required List<DocklyPhoto> photos, int initialIndex = 0})`, `.uploadGrid({required List<DocklyUploadItem> items, VoidCallback? onAdd, void Function(String id)? onRemove, void Function(String id)? onRetry})`
- **Ekranlar:** S-09, S-10, S-12, S-13, S-18.
- **Dark/light:** fotoğraflar filtrelenmez (08 §12); fullscreen zemini iki modda `#000`.

### 3.6 DocklyReviewCard
- **Amaç:** Tek yorum kartı: `DocklyAvatar.xs` + ad + tarih + `DocklyRatingStars.display` + gövde + foto şeridi + kullanıcının kendi `pending` yorumunda "İnceleniyor" `DocklyBadge`.
- **Varyantlar:** `full` (S-11), `preview` (S-09'da 3 satır kırpılmış + "devamı").
- **API:** `DocklyReviewCard({required DocklyReviewData data, DocklyReviewCardVariant variant = .full, VoidCallback? onPhotoTap, VoidCallback? onReport})`
- **Ekranlar:** S-09, S-11.

---

## 4. Ekran → Bileşen Matrisi (hızlı referans)

| Ekran | Ana bileşenler |
|---|---|
| S-06 | DocklyBottomSheet.persistent, DocklySearchBar, DocklyMapPin, DocklyLocationCard (rail/wide), DocklyFilterChip, DocklyGlassPanel |
| S-07 | DocklySearchBar.active, DocklyFilterChip.suggestion, DocklyListTile, DocklyLocationCard.list, DocklyEmptyState |
| S-08 | DocklyBottomSheet.modal, DocklyFilterChip.toggle, DocklyAmenityChip, DocklySegmentedControl, DocklyButton |
| S-09 | DocklyPhotoGallery.hero/grid, DocklyRatingStars.display, DocklyAmenityChip, DocklyCard, DocklyReviewCard.preview, DocklyButton (sticky CTA), DocklyGlassPanel |
| S-12/S-13 | DocklyRatingStars.input, DocklyTextField.multiline, DocklyPhotoGallery.uploadGrid, DocklyToast |
| S-14 | DocklyBottomSheet.modal, DocklyBoatCard.compact, DocklyDatePicker.range, DocklyTextField (autofilled state), DocklyButton (loading) |
| S-15 | DocklyBadge.status, DocklyLocationCard.compact, DocklySegmentedControl, DocklyEmptyState |
| S-16 | DocklyLocationCard.list, DocklyEmptyState, DocklySkeleton |
| S-17/S-18 | DocklyBoatCard.full/addNew, DocklyTextField.number, DocklySegmentedControl (boat_type) |
| S-20 | DocklyListTile.toggle/navigation, DocklySegmentedControl (tema) |
| S-21 | DocklyListTile, DocklyBadge.dot, DocklyEmptyState |

---

## 5. Widgetbook Katalog Stratejisi

- **Konum:** `packages/dockly_ui/widgetbook/` — ayrı çalıştırılabilir Flutter hedefi; `dockly_ui`'ı tüketir, feature koduna dokunmaz.
- **Yapı:** Widgetbook ağacı Atomic hiyerarşiyi aynalar: `Atoms / Molecules / Organisms` klasörleri; her bileşen bir `WidgetbookComponent`, her varyant+state bir `UseCase` (örn. `DocklyButton / primary / loading`).
- **Knob'lar:** her use case'te label, boyut, variant, disabled, isLoading vb. knob'larla canlı kurcalanır; `DocklyLocationCard` için sahte veri fabrikası (`dockly_ui/test_fixtures.dart`) — 9 `location_type`'ın her biri için örnek kayıt.
- **Global addon'lar:** tema anahtarı (light/dark — `docklyLightTheme`/`docklyDarkTheme`), text scale (1.0 / 1.3 / AX1), locale (TR/EN), cihaz çerçevesi (iPhone 15 Pro / Pixel 8), "şeffaflığı azalt" simülasyonu.
- **Golden testler:** her use case için light+dark çift golden (`widgetbook_snapshot` job'ı); token PR'larında CI fark üretirse görsel diff review zorunlu (09 §11 ile bağlantılı).
- **Süreç:** yeni bileşen PR'ı = bileşen kodu + bu dokümana kart + Widgetbook use case + golden — dördü birden yoksa merge edilmez.
- **Dağıtım:** Widgetbook web build'i her `main` merge'ünde GitHub Actions ile internal URL'e deploy edilir; tasarım ekibi canlı katalogdan review yapar.

---

## 6. Bileşen Yaşam Döngüsü Kuralları

1. **Önce doküman:** bileşen bu dosyaya kartıyla eklenmeden kodlanmaz.
2. **Prop-driven saflık:** bileşenler veri çekmez, provider okumaz; her şey constructor'dan gelir. Callback'ler dışarı ham event verir (`onTap`, `onChanged`).
3. **Data sınıfları:** `DocklyLocationCardData` gibi görüntü modelleri `dockly_ui` içinde tanımlanır; `dockly_core` domain entity'lerinden mapper'lar feature katmanında yazılır (UI paketi core'a bağımlı olmaz).
4. **Deprecation:** bileşen API'si kırılacaksa `@Deprecated` + bir minor sürüm geçiş süresi; Widgetbook'ta "Deprecated" klasörüne taşınır.
5. **Erişilebilirlik kapısı:** her use case golden'ına ek olarak semantik test (`meets_tap_target`, `has_semantics_label`) zorunlu.

---

*Doküman sonu — 10-component-library.md. Bağlı dokümanlar: 00-foundation.md (kanonik), 09-design-system.md (token'lar), 08-uiux-akislari.md (etkileşim davranışları).*
