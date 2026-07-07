# Dockly — Design System (09)

> Bu doküman [00-foundation.md](00-foundation.md) §7'deki kanonik token'ları **genişletir**; hiçbir token'ı değiştirmez. Çelişki durumunda foundation geçerlidir. Tüm token'lar `packages/dockly_ui` içinde yaşar; `apps/mobile` ve `apps/admin_web` yalnızca bu paketten tüketir — uygulama kodunda hex renk YASAKTIR.

---

## 1. Renk Sistemi

### 1.1 Marka ve zemin paleti (foundation §7 — kanonik)

| Token | Light | Dark | Kullanım |
|---|---|---|---|
| `brand.primary` | `#0C7BDC` | `#3B9DF2` | Ana marka, CTA, aktif tab, link |
| `brand.deep` | `#0A2540` | `#0A2540` | Logo, hero gradient, koyu zeminler |
| `accent.turquoise` | `#2EC4B6` | `#35D4C5` | Vurgu, başarı hisleri, seçili durum aksanı |
| `bg.base` | `#F7F9FC` | `#0B1220` | Sayfa zemini |
| `bg.surface` | `#FFFFFF` | `#141C2B` | Kart zemini |
| `bg.glass` | `rgba(255,255,255,0.72)` | `rgba(20,28,43,0.72)` | Glassmorphism (blur 20) |
| `text.primary` | `#0F1728` | `#F2F5F9` | Başlık, gövde |
| `text.secondary` | `#5B6B84` | `#93A1B8` | Yardımcı metin, ikon |

### 1.2 Genişletilmiş nötr / yüzey tonları (bu dokümanda tanımlanır)

| Token | Light | Dark | Kullanım |
|---|---|---|---|
| `bg.surfaceRaised` | `#FFFFFF` + elevation.2 | `#1B2536` | Sheet üstü sheet, popover |
| `bg.sunken` | `#EEF2F7` | `#080D18` | Input zemini, ayrık bölge |
| `border.subtle` | `#E4E9F0` | `#243044` | Kart kenarı, ayraç |
| `border.strong` | `#C7D0DC` | `#33415A` | Input odak dışı kenar |
| `text.tertiary` | `#8593A8` | `#6B7A93` | Placeholder, devre dışı metin |
| `text.inverse` | `#F2F5F9` | `#0F1728` | Dolgu butonu üstü metin |
| `overlay.scrim` | `rgba(10,37,64,0.40)` | `rgba(0,0,0,0.55)` | Modal arkası karartma |

### 1.3 Semantic renkler (light kanonik; dark türevleri burada tanımlanır)

| Token | Light | Dark | Yumuşak zemin (light/dark) | Kullanım |
|---|---|---|---|---|
| `semantic.success` | `#30A46C` | `#3DBD7D` | `#E9F6EF` / `#12291D` | Onaylandı rozeti, başarı toast |
| `semantic.warning` | `#FFB224` | `#FFC85C` | `#FFF4DE` / `#2E2410` | Beklemede rozeti, uyum uyarısı |
| `semantic.error` | `#E5484D` | `#F2555A` | `#FDECEC` / `#301619` | Hata, favori kalbi, yıkıcı aksiyon |
| `semantic.info` | `#0C7BDC` | `#3B9DF2` | `#E8F2FC` / `#102338` | Bilgi bandı, "İletişime geçildi" |

Kural: semantic renk asla tek başına anlam taşımaz; her zaman ikon + metinle birlikte kullanılır (renk körü güvenliği).

### 1.4 Harita ikon renkleri — `location_type` başına (foundation §7, kanonik)

| `location_type` | TR adı | Renk | Pin ikonu (bkz. §6) |
|---|---|---|---|
| `private_marina` | Özel Marina | `#0C7BDC` | marina çapası |
| `municipal_marina` | Belediye Marinası | `#3B82F6` | marina çapası + bina |
| `municipal_pier` | Belediye İskelesi | `#6366F1` | iskele kazıkları |
| `guest_mooring` | Misafir Bağlama Noktası | `#2EC4B6` | halat + baba |
| `restaurant_pier` | Restoran İskelesi | `#F97316` | çatal-bıçak + dalga |
| `fuel_pier` | Yakıt İskelesi | `#EAB308` | yakıt pompası |
| `boat_club` | Tekne Kulübü | `#8B5CF6` | flama/bayrak |
| `mooring_point` | Bağlama Noktası | `#64748B` | tekli baba |
| `buoy` | Şamandıra | `#EF4444` | şamandıra silueti |

Kurallar:
- Bu 9 renk light ve dark modda **aynıdır** (marka ve harita okunabilirlik tutarlılığı). Dark modda pin'e %20 daha güçlü dış glow eklenir.
- Pin dolgusu tip rengi, ikon `#FFFFFF`; seçili pin 1.3× ölçek + beyaz 2pt halka.
- Küme (cluster) rozeti: baskın tipin renginde halka, glass dolgu, `text.primary` sayı.
- Bu renkler amenity, rozet vb. başka hiçbir yerde yeniden kullanılamaz (harita semantiği rezervedir).

---

## 2. Tipografi Ölçeği

Yazı ailesi: iOS **SF Pro** (system), Android **Inter** (foundation §7). Rakamlar veri satırlarında `tabular figures` ile dizilir (fiyat, mesafe, sayaç).

| Stil | Boyut/Ağırlık | Line-height | Letter-spacing | Kullanım yerleri |
|---|---|---|---|---|
| `display` | 32 / 700 | 38 (1.19) | -0.4 | Onboarding başlıkları (S-02), başarı ekranı |
| `title1` | 28 / 700 | 34 (1.21) | -0.3 | S-09 lokasyon adı (hero), sayfa başlıkları |
| `title2` | 22 / 600 | 28 (1.27) | -0.2 | Bölüm başlıkları, sheet başlıkları |
| `headline` | 17 / 600 | 22 (1.29) | -0.1 | Kart başlıkları, ray başlıkları, nav bar başlığı |
| `body` | 16 / 400 | 24 (1.50) | 0 | Yorum gövdesi, açıklama metinleri, input değeri |
| `callout` | 15 / 400 | 20 (1.33) | 0 | İkincil bilgi satırları, liste alt metni |
| `caption` | 13 / 400 | 18 (1.38) | +0.1 | Rozet metni, zaman damgası, yardım metni |
| `micro` | 11 / 500 | 14 (1.27) | +0.2 | Pin etiketi, tab bar etiketi, sayaç rozeti |

Ek ağırlık varyantları: `body.semibold` (16/600 — buton metni, vurgu), `caption.semibold` (13/600 — rozet).
Kurallar:
- Bilgi taşıyan metin 13pt altına inmez; `micro` yalnız dekoratif/tekrar eden bağlamda.
- Dynamic Type: tüm stiller `TextScaler`'a uyar; `display`/`title1` maks 1.4× ile sınırlanır (layout patlaması önleme), diğerleri serbest.
- Satır uzunluğu hedefi: gövde metinde 60–75 karakter.

---

## 3. Spacing Sistemi (4pt Grid)

| Token | Değer | Kullanım |
|---|---|---|
| `space.1` | 4 | İkon-metin arası mikro boşluk |
| `space.2` | 8 | Chip iç yatay, satır içi eleman arası |
| `space.3` | 12 | Kart iç dikey ritim, liste satır arası |
| `space.4` | 16 | **Varsayılan sayfa yatay padding**, kart iç padding |
| `space.6` | 24 | Bölümler arası, sheet üst padding |
| `space.8` | 32 | Büyük bölüm ayrımı, hero altı |

Kurallar:
- Tüm boşluklar bu altı değerden seçilir; ara değer (10, 14, 20…) YASAK. İstisna: optik hizalama gerektiren ikon nudge'ları (±1–2pt) — yorum satırıyla belgelenir.
- Dikey ritim: bölüm başlığı ile içeriği arası `space.3`; iki bölüm arası `space.6`.
- Kart raylarında: ilk/son kart kenar boşluğu `space.4`, kartlar arası `space.3`.

---

## 4. Radius ve Elevation

### 4.1 Radius (foundation §7 kanonik)

| Token | Değer | Kullanım |
|---|---|---|
| `radius.sm` | 12 | Chip, input, küçük rozet zemini, toast |
| `radius.md` | 16 | Kart, buton, list item container |
| `radius.lg` | 24 | Bottom sheet üst köşeleri, modal, hero kart |
| `radius.full` | 999 | Avatar, pin, FAB, pill chip, grabber |

Kural: iç içe köşelerde iç radius = dış radius − iç padding (konsantrik köşe; örn. `radius.lg` sheet içindeki kart `radius.md`).

### 4.2 Elevation

Kanonik kart gölgesi (foundation §7): y=8, blur=24, %8 opaklık. Ölçek buradan türetilir:

| Token | Gölge (light) | Dark eşdeğeri | Kullanım |
|---|---|---|---|
| `elevation.0` | yok | yok | Zemine oturan içerik, list item |
| `elevation.1` | y=2, blur=8, `#0A2540` %6 | gölge yok, `border.subtle` 1pt | Chip, arama kapsülü (dinlenme) |
| `elevation.2` | y=8, blur=24, `#0A2540` %8 | `#000` %40, y=8/blur=24 + border | **Kart standardı**, mini kart |
| `elevation.3` | y=16, blur=40, `#0A2540` %12 | `#000` %55, y=16/blur=40 + border | Bottom sheet, modal, toast |

Kural: Dark modda derinlik esas olarak **yüzey rengi kademesi + ince border** ile anlatılır (`bg.base → bg.surface → bg.surfaceRaised`); gölge ikincildir.

---

## 5. Glassmorphism Spesifikasyonu

| Parametre | Değer |
|---|---|
| Blur | 20px (`ImageFilter.blur(sigmaX: 20, sigmaY: 20)`) — kanonik |
| Dolgu | `bg.glass` (light `rgba(255,255,255,0.72)` / dark `rgba(20,28,43,0.72)`) |
| Border | 1pt, light `rgba(255,255,255,0.55)` / dark `rgba(255,255,255,0.08)` — üst kenar vurgusu |
| İç parlaklık | Üstten alta beyaz %6→%0 gradient (cam ışıması, yalnız light) |
| Saturasyon | +%20 (`ColorFilter` saturation boost — iOS materyal hissi) |

**Kullanılır:** arama kapsülü, tab bar, bottom sheet zemini, harita üstü kontroller, S-09 scroll sonrası nav bar, sticky CTA paneli, küme rozetleri, pin etiketi pill'i, toast.
**Kullanılmaz:** okuma yoğun içerik zeminleri (yorum listesi, form alanları), fotoğraf üstü metin blokları (gradient scrim kullanılır), tam sayfa zeminler, üst üste ikinci glass (glass-üstü-glass yasak).
**Performans/erişilebilirlik:** ekran başına maks 3 canlı blur yüzeyi; scroll eden içerik altındaki glass'a `RepaintBoundary`; "şeffaflığı azalt" açıkken dolgu opaklığı 0.72→0.95 ve blur 20→0 (düz yüzeye yaklaşır).

---

## 6. İkonografi

### 6.1 Temel set

- **SF Symbols** (iOS) + eşleşen **Material Symbols Rounded** (Android) — ağırlık: Regular, kritik aksiyonlarda Semibold. Boyutlar: 16 (satır içi), 20 (liste), 24 (standart), 28 (tab bar).
- Stil: yuvarlatılmış, 2pt stroke hissi; dolgulu varyant yalnız aktif/seçili durumda (tab bar, favori kalbi).

### 6.2 Özel denizcilik ikon seti — ihtiyaç listesi

Pin ikonları (9 `location_type` — §1.4 renkleriyle birebir eşleşir, 24×24 grid, beyaz glyph):
1. `ic_pin_private_marina` — marina çapası
2. `ic_pin_municipal_marina` — çapa + belediye bina silueti
3. `ic_pin_municipal_pier` — iskele kazıkları perspektifi
4. `ic_pin_guest_mooring` — halat düğümü + baba
5. `ic_pin_restaurant_pier` — çatal-bıçak + dalga
6. `ic_pin_fuel_pier` — yakıt pompası + damla
7. `ic_pin_boat_club` — kulüp flaması
8. `ic_pin_mooring_point` — tekli bağlama babası
9. `ic_pin_buoy` — şamandıra silueti

Amenity ikonları (foundation §4 kodlarıyla birebir): `electricity` fiş, `water` musluk/damla, `fuel` pompa, `restaurant` çatal-bıçak, `shower` duş başlığı, `market` sepet, `laundry` çamaşır makinesi, `wifi` wifi, `security` kalkan, `open_24h` 24 rozeti, `wc` wc, `pump_out` atık pompası, `crane` vinç, `travel_lift` travel lift portali, `technical_service` anahtar/dişli. (15 adet, 20×20 grid, stroke stil, `text.secondary` renk; seçili chip'te `brand.primary`.)

Destek ikonları: `ic_anchor` (boş durum/refresh çapası), `ic_wave`, `ic_vhf` (telsiz), `ic_depth` (draft/derinlik), `ic_boat_length`, `ic_berth` (bağlama yeri). Format: SVG kaynak → Flutter'a `flutter_svg` ya da icon font; her ikonun semantik etiketi zorunlu.

---

## 7. Grid ve Layout Kuralları

- **Safe area:** tüm yüzen elemanlar `SafeArea` içinde; harita kenardan kenara (edge-to-edge), sistem barları şeffaf.
- Sayfa yatay padding: `space.4` (16). İçerik maks genişliği (tablet/admin web): 600pt form, 1200pt dashboard.
- **Bottom sheet yükseklikleri (S-06):** peek `96pt + bottomSafeArea`; half `%42`; full `üst safeArea − 8pt`. Filtre sheet'i (S-08): açılış half, maks full. Modal form sheet'leri (S-14): full-height.
- Tab bar: 49pt + bottomSafeArea, glass. Nav bar: 44pt + topSafeArea.
- Dokunma hedefi minimumu: 44×44pt. Liste satırı minimumu: 56pt.
- Kart rayı kartı: 280×148pt (S-06); dikey liste kartı: tam genişlik − 32, min 96pt.
- Klavye davranışı: form sayfalarında `resizeToAvoidBottomInset` + aktif alana otomatik scroll (`ensureVisible`, 300ms).

---

## 8. Motion Sistemi

### 8.1 Duration token'ları

| Token | Değer | Kullanım |
|---|---|---|
| `motion.fast` | **150ms** | Press, toggle, highlight, mikro geri bildirim |
| `motion.normal` | **250ms** | Giriş/çıkışlar, toast, sticky CTA, sheet içi geçiş |
| `motion.slow` | **400ms** | Sayfa geçişi, tema cross-fade, pulse |
| `motion.hero` | 450ms | Shared-element hero transition |
| `motion.map` | 500–1400ms | Kamera hareketleri (mesafeye orantılı, clamp) |

### 8.2 Easing token'ları

| Token | Değer | Kullanım |
|---|---|---|
| `ease.standard` | cubic-bezier(0.65, 0, 0.35, 1) | Genel |
| `ease.enter` | cubic-bezier(0.33, 1, 0.68, 1) | Ekrana giren |
| `ease.exit` | cubic-bezier(0.32, 0, 0.67, 0) | Ekrandan çıkan |
| `ease.spring` | spring(stiffness: 380, damping: 32) | Sheet snap, kalp, pin |
| `ease.emphasized` | `Curves.fastOutSlowIn` | Hero |

Kurallar: Çıkış animasyonu girişten kısa olmalı (çıkış = giriş × 0.8). Reduce Motion açıkken tüm süreler 0–200ms fade'e düşer. Ayrıntılı koreografi: [08-uiux-akislari.md](08-uiux-akislari.md) §13.

---

## 9. Flutter Implementasyonu (`dockly_ui`)

### 9.1 Paket dosya yapısı

```
packages/dockly_ui/lib/
├── dockly_ui.dart                 # barrel export
├── src/tokens/
│   ├── dockly_colors.dart         # DocklyColors ThemeExtension
│   ├── dockly_typography.dart     # DocklyTypography ThemeExtension
│   ├── dockly_spacing.dart        # sabitler (4pt grid)
│   ├── dockly_radius.dart
│   ├── dockly_elevation.dart
│   ├── dockly_motion.dart         # duration + curve token'ları
│   ├── dockly_glass.dart          # glass spesifikasyonu
│   └── map_pin_colors.dart        # location_type → renk haritası
├── src/theme/
│   ├── dockly_theme.dart          # light()/dark() ThemeData fabrikası
│   └── dockly_map_styles.dart     # Mapbox style URL'leri
└── src/components/                # bkz. 10-component-library.md
```

### 9.2 ThemeExtension örneği — renkler

```dart
// packages/dockly_ui/lib/src/tokens/dockly_colors.dart
import 'package:flutter/material.dart';

@immutable
class DocklyColors extends ThemeExtension<DocklyColors> {
  const DocklyColors({
    required this.brandPrimary,
    required this.brandDeep,
    required this.accentTurquoise,
    required this.bgBase,
    required this.bgSurface,
    required this.bgGlass,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.warning,
    required this.error,
  });

  final Color brandPrimary;
  final Color brandDeep;
  final Color accentTurquoise;
  final Color bgBase;
  final Color bgSurface;
  final Color bgGlass;
  final Color textPrimary;
  final Color textSecondary;
  final Color success;
  final Color warning;
  final Color error;

  static const light = DocklyColors(
    brandPrimary: Color(0xFF0C7BDC),
    brandDeep: Color(0xFF0A2540),
    accentTurquoise: Color(0xFF2EC4B6),
    bgBase: Color(0xFFF7F9FC),
    bgSurface: Color(0xFFFFFFFF),
    bgGlass: Color(0xB8FFFFFF), // rgba(255,255,255,0.72)
    textPrimary: Color(0xFF0F1728),
    textSecondary: Color(0xFF5B6B84),
    success: Color(0xFF30A46C),
    warning: Color(0xFFFFB224),
    error: Color(0xFFE5484D),
  );

  static const dark = DocklyColors(
    brandPrimary: Color(0xFF3B9DF2),
    brandDeep: Color(0xFF0A2540),
    accentTurquoise: Color(0xFF35D4C5),
    bgBase: Color(0xFF0B1220),
    bgSurface: Color(0xFF141C2B),
    bgGlass: Color(0xB8141C2B), // rgba(20,28,43,0.72)
    textPrimary: Color(0xFFF2F5F9),
    textSecondary: Color(0xFF93A1B8),
    success: Color(0xFF3DBD7D),
    warning: Color(0xFFFFC85C),
    error: Color(0xFFF2555A),
  );

  @override
  DocklyColors copyWith({Color? brandPrimary, Color? bgBase /* ... */}) =>
      DocklyColors(
        brandPrimary: brandPrimary ?? this.brandPrimary,
        brandDeep: brandDeep,
        accentTurquoise: accentTurquoise,
        bgBase: bgBase ?? this.bgBase,
        bgSurface: bgSurface,
        bgGlass: bgGlass,
        textPrimary: textPrimary,
        textSecondary: textSecondary,
        success: success,
        warning: warning,
        error: error,
      );

  @override
  DocklyColors lerp(DocklyColors? other, double t) {
    if (other == null) return this;
    return DocklyColors(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandDeep: Color.lerp(brandDeep, other.brandDeep, t)!,
      accentTurquoise: Color.lerp(accentTurquoise, other.accentTurquoise, t)!,
      bgBase: Color.lerp(bgBase, other.bgBase, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgGlass: Color.lerp(bgGlass, other.bgGlass, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
```

> `lerp` sayesinde tema değişimi 300ms cross-fade ile otomatik yumuşar (bkz. 08 §12).

### 9.3 Motion, spacing ve pin renk token'ları

```dart
// dockly_motion.dart
abstract final class DocklyMotion {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);
  static const hero = Duration(milliseconds: 450);

  static const easeStandard = Cubic(0.65, 0, 0.35, 1);
  static const easeEnter = Cubic(0.33, 1, 0.68, 1);
  static const easeExit = Cubic(0.32, 0, 0.67, 0);
}

// dockly_spacing.dart
abstract final class DocklySpacing {
  static const s1 = 4.0, s2 = 8.0, s3 = 12.0, s4 = 16.0, s6 = 24.0, s8 = 32.0;
}

// map_pin_colors.dart — foundation §7 ile birebir; iki modda aynı
const Map<String, Color> docklyMapPinColors = {
  'private_marina': Color(0xFF0C7BDC),
  'municipal_marina': Color(0xFF3B82F6),
  'municipal_pier': Color(0xFF6366F1),
  'guest_mooring': Color(0xFF2EC4B6),
  'restaurant_pier': Color(0xFFF97316),
  'fuel_pier': Color(0xFFEAB308),
  'boat_club': Color(0xFF8B5CF6),
  'mooring_point': Color(0xFF64748B),
  'buoy': Color(0xFFEF4444),
};
```

### 9.4 Tema fabrikası ve tüketim

```dart
// dockly_theme.dart
ThemeData docklyLightTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: DocklyColors.light.bgBase,
      extensions: const [DocklyColors.light, DocklyTypography.standard],
    );

// Tüketim (yalnız bu yolla; hex yazmak yasak):
final colors = Theme.of(context).extension<DocklyColors>()!;
```

---

## 10. Yazım Tonu (UX Writing)

### 10.1 İlkeler

1. **Samimi denizci dili, amatör argo değil:** "Demirle", "rota", "sular" gibi denizci sözcükleri doğal aktığı yerde; zorlama metafor yok.
2. **Sen dili**, kısa cümleler, aktif çatı. Buton metni fiille başlar.
3. **Dürüstlük:** v1'de talep modeli olduğu asla gizlenmez — "rezervasyon yapıldı" DENMEZ, "talebin alındı" denir.
4. Teknik terimler foundation §10 kuralıyla İngilizce kalabilir (endpoint, cache); kullanıcı arayüzünde ise Türkçe karşılık esastır.
5. Ünlem cimriliği: ekran başına en fazla bir "!" (yalnızca kutlama anında).

### 10.2 TR mikrocopy örnekleri

| Bağlam | ❌ Yapma | ✅ Yap |
|---|---|---|
| CTA (S-09) | "Gönder" | "Rezervasyon Talebi Gönder" |
| Talep başarı | "İşleminiz gerçekleştirilmiştir." | "Talebin alındı! Ekibimiz en kısa sürede seninle iletişime geçecek." |
| Boş favoriler | "Kayıt bulunamadı." | "Henüz favori limanın yok. Haritada kalbe dokun, buraya demirlesin." |
| Konum izni | "Uygulama konumunuza erişmek istiyor." | "Yakınındaki koyları gösterelim mi? Konumun yalnızca haritada kullanılır." |
| Ağ hatası | "Hata: bağlantı başarısız." | "Bağlantı koptu. Sinyal gelince tekrar deneriz." |
| Moderasyon | "İçerik onay beklemektedir." | "Yorumun incelendikten sonra yayınlanacak." |
| Bildirim izni | "Bildirimlere izin verin." | "Talebinin durumu değişince ilk sen öğren." |
| Yorum placeholder | "Yorumunuzu giriniz" | "Bağlama nasıldı? Elektrik, su, personel…" |
| Boş bildirimler | "Bildirim yok." | "Şimdilik sakin sular — yeni bir şey olunca haber veririz." |
| Silme onayı | "Emin misiniz?" | "Bu tekneyi silmek üzeresin. Bu işlem geri alınamaz." |

### 10.3 Terminoloji sözlüğü (UI'da tutarlı kullanım)

| Kavram | UI'daki tek karşılığı |
|---|---|
| booking request | Rezervasyon Talebi (kısaltma: Talep) |
| location | Nokta (genel), tip adları foundation §4 TR adlarıyla |
| amenity | Hizmet |
| favorite | Favori |
| review | Yorum, rating → Puan |
| guest (auth) | Misafir |
| draft (tekne) | Su çekimi (yanında "draft" parantezle, teknik alanlarda) |

---

## 11. Uygulama Disiplini

- **Token değişikliği süreci:** Yeni token/değer önce bu dokümana ve foundation'a (kanonikse) PR ile eklenir, sonra `dockly_ui`'a yazılır — ters sıra yasak.
- **Lint koruması:** `avoid_hardcoded_colors` custom lint kuralı `apps/` altında hex kullanımını CI'da engeller.
- **Görsel regresyon:** Widgetbook + golden test'ler (bkz. 10-component-library.md §5) her token PR'ında light/dark çift golden üretir.
- **Erişilebilirlik kapısı:** Yeni renk çifti eklenirken kontrast testi (AA) zorunlu; PR şablonunda kontrast oranı alanı vardır.

---

*Doküman sonu — 09-design-system.md. Bağlı dokümanlar: 00-foundation.md (kanonik token kaynağı), 08-uiux-akislari.md (motion koreografisi), 10-component-library.md (bileşenler).*
