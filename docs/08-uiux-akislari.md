# Dockly — UI/UX Akışları (08)

> Bu doküman [00-foundation.md](00-foundation.md) dokümanına tabidir. Ekran ID'leri (S-01…S-23), renk token'ları, `location_type` kodları ve enum değerleri oradan **birebir** alınmıştır. Çelişki durumunda foundation geçerlidir.

> **Tasarım Kuzey Yıldızı:** Dockly bir rezervasyon uygulaması gibi DEĞİL, denizcinin her gün açtığı bir harita uygulaması gibi hissettirmelidir. Referans his: Google Maps'in akıcılığı + Apple Maps'in bottom sheet zarafeti + TripAdvisor'ın topluluk sıcaklığı. Her etkileşim kararı bu cümleyle test edilir: *"Bu, haritayı mı merkeze koyuyor, yoksa bir form akışını mı?"* Cevap her zaman harita olmalıdır.

---

## 1. Genel Etkileşim Mimarisi

### 1.1 Navigasyon iskeleti

- Alt navigasyon (5 sekme, foundation §8): **Keşfet (harita) · Arama · Favoriler · Taleplerim · Profil**
- Keşfet (S-06) uygulamanın evidir. Uygulama her açılışta buraya döner; diğer sekmeler "harita üzerine açılan katmanlar" gibi davranır.
- Tab bar glassmorphism yüzeydedir (`bg.glass`, blur 20). Harita tab bar'ın **altına** devam eder; tab bar haritanın üstünde yüzer.
- Bottom sheet full durumuna geçtiğinde tab bar 250ms'de aşağı kayarak gizlenir (harita uygulaması hissi: içerik tam ekranı alır).
- Push edilen tüm detay sayfaları (S-09 vb.) soldan değil, **alttan yukarı modal** ya da **hero transition** ile açılır — harita hiçbir zaman "geride kaybolmuş" hissi vermez, geri dönüşte harita durumu (zoom, merkez, seçili pin) aynen korunur.

### 1.2 Durum koruma (state restoration)

| Durum | Davranış |
|---|---|
| Sekme değişimi | Harita kamerası, açık bottom sheet durumu, seçili pin korunur |
| Detaydan geri dönüş | Harita kamerası + sheet snap noktası aynen geri gelir, seçili pin highlight'ı 400ms daha kalır sonra söner |
| Uygulama arka plandan dönüş | Son kamera konumu Drift cache'ten restore edilir; konum izni varsa kullanıcı konumu sessizce güncellenir (kamera OYNATILMAZ) |
| Cold start | Son bilinen kamera; yoksa TR geneli bbox (zoom ~5.8) |

---

## 2. S-06 Ana Sayfa — Harita + Apple Maps Benzeri Alt Kart Sistemi

### 2.1 Katman düzeni (z-order, alttan üste)

1. Mapbox harita (custom style: deniz vurgulu, sakin kara tonları; dark mode'da gece stili)
2. Pin katmanı (`DocklyMapPin` — renkler foundation §7'deki `location_type` renkleriyle birebir)
3. Kullanıcı konumu (mavi nokta + pulse halkası, `brand.primary`)
4. Üst yüzen arama kapsülü (`DocklySearchBar`, glass) + sağda avatar butonu
5. Sağ kenar dikey harita kontrolleri: konumuma git, katman/stil, pusula (döndürülünce belirir)
6. Bottom sheet (`DocklyBottomSheet`, glass yüzey)
7. Tab bar (glass)

### 2.2 Bottom sheet — 3 snap durumu

| Durum | Yükseklik | İçerik | Harita etkileşimi |
|---|---|---|---|
| **Peek** | 96pt + safe area | Grabber + "Bu bölgede 34 nokta" özeti + hızlı filtre chip satırı | Tam serbest |
| **Half** | ekranın %42'si | Kart rayları (yatay scroll listeleri) | Serbest; harita görünür kalır |
| **Full** | üst safe area'ya 8pt kala | Raylar dikey listeye açılır + arama alanı sheet başına sabitlenir | Harita karartılır (scrim %20), tap ile half'e döner |

**Snap fiziği:**
- Spring animasyonu: stiffness 380, damping 32 (iOS `interactiveSpring` hissi).
- Sürükleme hızı > 800pt/s ise ara durum atlanır (peek→full tek harekette mümkün).
- Sheet half→peek geçişinde harita kamerası **değişmez**; pin'e odaklıyken sheet büyürse kamera, pin görünür kalacak şekilde `padding.bottom = sheetHeight` ile yeniden çerçevelenir (ease-out, 350ms).
- Grabber: 36×5pt, radius full, `text.secondary` %30 opaklık.

### 2.3 Kart rayları (half durumunda, sırasıyla)

| Ray | Kaynak | Boş durum davranışı |
|---|---|---|
| **Yakındaki** | Konum izni + bbox sorgusu, mesafeye göre | Konum izni yoksa ray başlığı yerine izin isteme kartı |
| **Popüler** | `rating_count` ağırlıklı skor | Her zaman dolu (seed verisi) |
| **En Yüksek Puanlılar** | `rating_avg` ≥ 4.5, `rating_count` ≥ 5 | Eşik altındaysa ray gizlenir |
| **Yeni Eklenenler** | `created_at` son 30 gün | Yoksa ray gizlenir |
| **Son Görüntülenenler** | `recently_viewed` (lokal + API) | Hiç yoksa ray gizlenir (asla boş ray gösterilmez) |
| **Favoriler** | `favorites` | Boşsa "Favorilerin burada görünecek ⚓" mini kartı |

- Her ray: başlık (Headline 17/600) + "Tümü" text butonu + yatay `DocklyLocationCard` listesi (kart 280×148pt, snap scroll, `padding: 16`).
- Ray kartına tap → hero transition ile S-09.
- Raylar lazy render edilir; görünmeyen raylar build edilmez (performans).

### 2.4 Pin etkileşimi: tap → mini kart → detay (hero transition)

**Adım 1 — Pin tap:**
- Pin 150ms'de 1.0→1.3 ölçeklenir (easing: `easeOutBack`), gölge belirir, diğer pin'ler %60 opaklığa iner.
- Hafif haptic (`HapticFeedback.selectionClick`).
- Harita kamerası pin'i, mini kartın kapatmayacağı şekilde yatayda ortalar, dikeyde üst 1/3'e taşır (400ms, `easeInOutCubic`).

**Adım 2 — Mini kart:**
- Bottom sheet mevcut içeriğinin ÜZERİNE mini kart modu gelir: sheet peek yüksekliğine snap eder ve tek bir `DocklyLocationCard` (geniş varyant) gösterir: fotoğraf, ad, tip ikonu + TR tip adı, ⭐ `rating_avg` (`rating_count`), mesafe, `price_tier` rozeti, mini amenity ikon satırı (maks 4 + "+3").
- Kart alttan 250ms slide+fade ile girer (`easeOutCubic`).
- Boş haritaya tap ya da kartı aşağı sürükleme → mini kart kapanır, pin normale döner, raylar geri gelir.

**Adım 3 — Detaya hero transition:**
- Mini karta tap → kartın fotoğrafı, S-09'un hero görseline **shared element** olarak büyür (450ms, `Curves.fastOutSlowIn`).
- Eşzamanlı: kart başlığı hero başlığa doğru ölçeklenip konumlanır; sayfa zemini fotoğrafın arkasından fade-in.
- Geri dönüş aynı animasyonun tersi (400ms); harita ve sheet durumu aynen restore edilir.

### 2.5 Pin kümeleme (clustering)

- Zoom < 11: kümeler — dairesel glass rozet, içinde sayı, baskın `location_type` renginde halka.
- Küme tap: kamera kümenin bbox'una zoom (500ms, `easeInOutCubic`) — asla "liste açma", her zaman harita hareketi.
- Zoom ≥ 13: tekil pin + zoom ≥ 14.5'te pin altında ad etiketi (Micro 11/500, glass pill).

---

## 3. S-07 Arama Deneyimi

### 3.1 Giriş

- Haritadaki arama kapsülüne tap → kapsül, tam ekran arama yüzeyinin arama alanına **morph** olur (300ms): kapsül yukarı sabitlenip genişler, arka plan `bg.base` fade-in, klavye eşzamanlı açılır.
- İptal: "Vazgeç" ya da aşağı swipe → ters morph, haritaya sıfır kayıpla dönüş.

### 3.2 Boş arama durumu (query yokken)

Sıra kritik — kullanıcı yazmadan değer görmeli:
1. **Öneri chip'leri** (yatay `DocklyFilterChip` seti): "Yakınımdaki marinalar", "Restoran iskeleleri", "Yakıt iskeleleri", "Ücretsiz bağlama", "Şamandıralar" — her chip hazır bir filtre sorgusudur, tap ile doğrudan harita sonucuna döner.
2. **Son aramalar** (recent searches): son 8 sorgu, saat ikonu + metin + sağda "×" (tek tek silme). Başlık yanında "Temizle". Lokal (Drift) saklanır.
3. **Son görüntülenenler**: 3 kompakt satır.

### 3.3 Yazarken

- Debounce 300ms; minimum 2 karakter.
- Sonuç grupları: **Lokasyonlar** (tip ikonu renkli), **Şehir/İlçe/Koy** (bölge ikonu — tap ile harita o bbox'a uçar, arama kapanır), **Kategoriler** ("Yakıt İskelesi" gibi tip araması).
- Eşleşen metin bold vurgulanır. Türkçe karakter toleransı (ı/i, ğ/g) arama tarafında normalize edilir.
- Sonuç satırı tap → hero'suz hızlı geçiş: harita lokasyona uçar + mini kart açılır (arama tam ekranı kapanır). Detaya gitmek ikinci tap'tir — önce harita, sonra detay ilkesi.
- Sonuç yoksa: `DocklyEmptyState` — "Bu sularda bir şey bulamadık" + "Yeni nokta öner" butonu (S-22'ye köprü).

---

## 4. S-08 Filtre Bottom Sheet UX'i

- Arama kapsülünün sağındaki filtre ikonundan ya da peek'teki hızlı chip'lerden açılır. Half yükseklikte açılır, içerik uzunsa full'e sürüklenebilir.
- Bölümler (yukarıdan aşağı): **Lokasyon tipi** (9 `location_type`, renkli ikon + TR adıyla çoklu seçim grid'i), **Hizmetler** (amenity chip grid'i — foundation §4 amenity kodları), **Fiyat** (`free/paid/unknown` segmented), **Puan** (4.0+ / 4.5+ chip), **Tekne uyumu** ("Teknem sığar" toggle'ı — birincil teknenin `length_m`/`draft_m` değerini `max_boat_length_m`/`max_draft_m` ile karşılaştırır).
- **Canlı sonuç sayısı:** Alt sabit CTA her seçimde güncellenir: "27 nokta göster". Sayı değişirken counter animasyonu (150ms).
- Sonuç 0 ise CTA disabled olmaz; "Sonuç yok — filtreleri gevşet" metnine döner ve en kısıtlayıcı filtre chip'i sarı vurgulanır.
- "Sıfırla" başlıkta text buton; her chip toggle'ında `selectionClick` haptic.
- Kapanınca aktif filtre sayısı arama kapsülündeki filtre ikonunda `DocklyBadge` olarak görünür; peek satırında aktif filtreler kaldırılabilir chip olarak listelenir.

---

## 5. S-09 Lokasyon Detay — Scroll Koreografisi

### 5.1 Sayfa anatomisi (yukarıdan aşağı)

Hero galeri → başlık bloğu (ad, tip, ⭐ puan, mesafe) → aksiyon satırı (Ara · Yol tarifi · Web · VHF kanalı · Paylaş · Favori) → bilgi kartları (kapasite, `max_boat_length_m`, `max_draft_m`, `price_tier`, `is_24h`) → amenity grid'i → mini harita → yorum özeti + ilk 3 yorum → fotoğraf ızgarası → "Hatalı bilgi bildir" (S-23) → alt boşluk (sticky CTA payı).

### 5.2 Scroll koreografisi

| Scroll aşaması | Davranış |
|---|---|
| 0 → hero yüksekliği | **Parallax:** hero görsel 0.5x hızda kayar, üzerine alttan `#0A2540` %40 gradient; aşırı çekmede (overscroll) görsel stretch-zoom yapar (Apple Music tarzı) |
| Hero'nun %60'ı geçilince | Glass nav bar fade-in (200ms): geri butonu + lokasyon adı (Headline) + favori kalbi belirir |
| Aksiyon satırı görünürken | Sticky CTA henüz gizli — ekranda zaten aksiyonlar var |
| Aksiyon satırı ekrandan çıkınca | **Sticky CTA** alttan slide-up (250ms, `easeOutCubic`): "Rezervasyon Talebi Gönder" (`DocklyButton.primary`, glass panel içinde) + solda küçük favori butonu |
| Yukarı hızlı scroll | CTA görünür kalır; yalnızca aksiyon satırı tekrar görünürse gizlenir |

- Geri butonu her zaman erişilebilir: hero üzerinde daire glass buton, scroll sonrası nav bar içinde.
- Hero galeri yatay swipe destekler (sayfa göstergesi: alt ortada nokta), tap → S-10 tam ekran galeri (fade + ölçek 1.0→1.02 geçişi, pinch-to-zoom, aşağı sürükleyip bırakma ile kapanır — sürükleme mesafesine bağlı arka plan opaklığı).

### 5.3 Mikro etkileşimler

- Favori kalbi: tap'te 1.0→1.35→1.0 spring + dolgu rengi `semantic.error`; `mediumImpact` haptic. Optimistic update — API hatasında geri alınır + `DocklyToast` "Favorilere eklenemedi".
- VHF kanalı satırı tap → kopyalanır, toast: "VHF 72 panoya kopyalandı".
- Telefon/web satırları OS intent'ine gider; dönüşte durum kaybolmaz.

---

## 6. S-14 Rezervasyon Talebi Formu UX'i

> Kural (foundation §1): v1'de gerçek rezervasyon YOK; bu bir **talep** formudur ve dil buna göre kurulur — "Talebini iletelim, marinayla biz görüşelim" tonu.

### 6.1 Akış

1. Sticky CTA → S-14 alttan modal (full-height sheet, üstte grabber).
2. **Tekne seçimi (ilk alan):** Kullanıcının tekneleri yatay kart seçici (`DocklyBoatCard.compact`). Birincil tekne (`is_primary`) önseçili gelir.
   - **Otomatik doldurma:** Tekne seçilince `boat_length_m` ve `boat_draft_m` alanları teknenin `length_m`/`draft_m` değerleriyle otomatik dolar; alanlar 200ms highlight (turkuaz %15 arka plan flash) ile "dolduğunu" gösterir. Alanlar düzenlenebilir kalır (o seferlik farklı değer girilebilir; tekne kaydı DEĞİŞMEZ).
   - Hiç tekne yoksa: inline boş durum kartı "Önce teknenizi ekleyin" → S-18'e sheet-üstü-sheet; dönüşte form durumu korunur, yeni tekne otomatik seçilir.
3. **Tarih:** `DocklyDatePicker` ile check-in/check-out aralığı; geçmiş tarihler disabled; check-out otomatik check-in+1 önerilir. Gece sayısı özeti canlı: "3 gece".
4. **Uyum kontrolü (canlı):** Girilen boy/draft, lokasyonun `max_boat_length_m`/`max_draft_m` değerini aşarsa alan altında sarı uyarı: "Bu nokta en fazla 20 m tekne kabul ediyor" — engellemez, bilgilendirir (veri `unknown` olabilir).
5. **Telefon:** profildeki `phone` önden dolu; yoksa zorunlu alan.
6. **Not:** opsiyonel, 500 karakter, placeholder: "Örn. elektrik bağlantısı gerekiyor, geç varış ~21:00".
7. **Gönder:** CTA `DocklyButton.primary` loading state'ine döner (spinner + "Gönderiliyor…"), çift tap koruması, `success` haptic + tam ekran başarı anı: turkuaz halka animasyonu içinde ⚓ ikonu, "Talebin alındı! Ekibimiz en kısa sürede seninle iletişime geçecek." + "Taleplerimi Gör" (S-15) ve "Haritaya Dön" butonları.

### 6.2 Hata ve doğrulama

- Doğrulama alan bazlı ve **blur sonrası** çalışır (yazarken kızmaz); gönderimde topluca kontrol edilir, ilk hatalı alana yumuşak scroll (300ms) + shake animasyonu (3×4pt, 250ms) + `error` haptic.
- Ağ hatası: form verisi KAYBOLMAZ, toast + CTA "Tekrar Dene" olur. Taslak lokalde tutulur; sheet kapatılırsa "Talebin taslak olarak kalsın mı?" onayı.

### 6.3 S-15 Taleplerim

- Durum rozetleri (`booking_request_status`): `pending` sarı "Beklemede", `contacted` mavi "İletişime geçildi", `confirmed` yeşil "Onaylandı", `cancelled` gri "İptal", `expired` gri "Süresi doldu".
- Durum değişimi push (FCM `booking_status`) + S-21 bildirimiyle gelir; listede ilgili kart 400ms renk pulse'ı ile güncellenir.
- İptal: kart detayında ikincil buton, onay diyaloğu ile (`POST /booking-requests/{id}/cancel`).

---

## 7. Yorum ve Fotoğraf Yükleme Akışları

### 7.1 S-12 Yorum yaz + puan ver

1. Giriş noktaları: S-09 yorum bölümü CTA'sı, S-11 listedeki yüzen buton. Misafir kullanıcıysa önce nazik auth kapısı: "Yorum yazmak için giriş yap" sheet'i (S-03'e köprü, dönüşte akış kaldığı yerden sürer).
2. Yıldızlar önce: 5 büyük `DocklyRatingStars` (44pt tap alanı); yıldıza tap'te sıralı dolum animasyonu (her yıldız 60ms arayla, `lightImpact` haptic) + altında anlam etiketi ("1 — Uzak dur" … "5 — Mükemmel").
3. Metin opsiyonel (min 0, maks 1000); akıllı placeholder: "Bağlama nasıldı? Elektrik, su, personel…".
4. Fotoğraf ekleme aynı sheet içinde (maks 5) — §7.2 bileşeniyle.
5. Gönderim → moderasyon bilgisi ŞEFFAF verilir: başarı ekranında "Yorumun incelendikten sonra yayınlanacak" (`moderation_status = pending`). Kullanıcının kendi yorumu kendisine hemen "İnceleniyor" rozetiyle görünür (optimistic).
6. Kullanıcının bu lokasyonda aktif yorumu varsa (UNIQUE kuralı) akış "Yorumunu düzenle" moduna döner.

### 7.2 S-13 Fotoğraf yükleme

1. Kaynak seçimi: sistem picker (kamera / galeri, çoklu seçim maks 5).
2. Seçim sonrası ızgara önizleme; her karo: kaldır butonu + yükleme durumu.
3. Yükleme boru hattı (kullanıcıya görünen): karo üzerinde dairesel progress → `POST /photos/presign` → S3 upload → `POST /photos/complete` → ✓ işareti (turkuaz, 200ms scale-in).
4. Paralel yükleme (maks 3 eşzamanlı); biri düşerse yalnız o karo hata durumuna geçer, "Tekrar dene" karo üstünde.
5. Client-side sıkıştırma: uzun kenar 2048px, JPEG q80 — kullanıcıya sessiz.
6. Tamamlanınca: "Fotoğrafların moderasyon onayından sonra görünecek" bilgisi + `success` haptic.

---

## 8. Boş Durumlar ve Skeleton Loading

### 8.1 Boş durum ilkeleri

Her boş durum (`DocklyEmptyState`) üç parçadır: **denizci illüstrasyonu/ikonu + tek cümle samimi metin + tek aksiyon**. Asla suçlayıcı değil, yol gösterici.

| Ekran | Metin | Aksiyon |
|---|---|---|
| S-16 Favoriler | "Henüz favori limanın yok. Haritada kalbe dokun, buraya demirlesin." | "Haritayı Keşfet" |
| S-15 Taleplerim | "Henüz bir talebin yok. Beğendiğin noktadan talep gönderebilirsin." | "Haritayı Keşfet" |
| S-17 Tekne listem | "İlk teknenle başlayalım — talep formların otomatik dolsun." | "Tekne Ekle" |
| S-11 Yorumlar | "İlk yorumu sen yaz, diğer denizcilere yol göster." | "Yorum Yaz" |
| S-21 Bildirimler | "Şimdilik sakin sular — yeni bir şey olunca haber veririz." | — |
| S-07 sonuç yok | "Bu sularda bir şey bulamadık." | "Yeni Nokta Öner" |
| Ağ hatası (genel) | "Bağlantı koptu. Sinyal gelince tekrar deneriz." | "Tekrar Dene" |

### 8.2 Skeleton kuralları

- `DocklySkeleton`: gerçek layout'un birebir gölgesi (kart boyutları aynı) — layout shift SIFIR olmalı.
- Shimmer: soldan sağa gradient süpürme, 1200ms döngü, `easeInOut`; dark mode'da parlaklık farkı düşürülür (%6 → %4) — göz yormaz.
- Kural: ilk 300ms hiçbir skeleton gösterilmez (flash önleme); 300ms–3s skeleton; 3s+ skeleton + "Hâlâ yükleniyor…" mikro metni; 10s+ hata durumuna düşer.
- Harita pin'leri skeleton kullanmaz; bbox verisi gelene dek yalnız üst arama kapsülünde ince progress çizgisi (2pt, `brand.primary`).

---

## 9. Haptic Feedback Haritası

| Olay | Haptic (iOS karşılığı) |
|---|---|
| Pin seçimi, chip toggle, segment değişimi | `selectionClick` |
| Bottom sheet snap noktasına oturma | `lightImpact` |
| Favori ekleme, yıldız dokunuşu | `mediumImpact` (favori) / `lightImpact` (yıldız) |
| Talep gönderildi, yorum gönderildi, fotoğraf tamam | `notificationSuccess` |
| Form hatası, işlem başarısız | `notificationError` |
| Pull-to-refresh tetiklendi | `mediumImpact` |
| Uzun basış (pin/kart context menüsü) | `heavyImpact` |

Kurallar: Haptic asla art arda 100ms içinde iki kez tetiklenmez (debounce). Android'de `HapticFeedback` eşdeğerleri kullanılır; ayarlardan (S-20) kapatılabilir.

---

## 10. Tek Elle Kullanım (Thumb Zone)

- **Altın bölge:** ekranın alt %60'ı. Tüm birincil aksiyonlar (CTA, tab bar, bottom sheet, filtre chip'leri, harita kontrolleri) bu bölgededir.
- Arama kapsülü üstte ama tap sonrası tüm etkileşim (klavye, sonuçlar, chip'ler) alta iner.
- Sağ kenar harita kontrolleri baş parmak yayı içinde (alt-sağ çeyrekte kümelenir; sağ elle kullanım varsayılır, RTL/solak için ayar v1.x notu).
- Minimum dokunma hedefi **44×44pt** (Apple HIG); chip'ler görsel olarak küçükse bile tap alanı 44pt'ye tamamlanır.
- Destructive aksiyonlar (silme, iptal) asla thumb zone'un refleks noktalarına konmaz; onay ister.
- Geri hareketi: tüm push sayfalarda kenardan swipe-back + modallarda aşağı sürükleyip kapatma — üst-sol geri butonuna mahkûmiyet yok.

---

## 11. Erişilebilirlik

### 11.1 Dynamic Type

- Tüm metinler `MediaQuery.textScaler`'a uyar; XL ölçekte kart yükseklikleri büyür (sabit yükseklik yasak, `IntrinsicHeight`/min-height kullanılır).
- Erişilebilirlik ölçeklerinde (AX1+) kart rayları yataydan **dikey listeye** düşer; tab bar etiketleri korunur.
- Micro (11pt) stil yalnız dekoratif rozetlerde; bilgi taşıyan hiçbir metin 13pt (Caption) altına inmez.

### 11.2 Kontrast

- Tüm metin/zemin çiftleri WCAG AA (4.5:1; büyük metin 3:1). `text.secondary` (#5B6B84) `bg.surface` üzerinde 4.6:1 — doğrulandı.
- Glass yüzeylerde metin kontrastı, arkadaki en kötü harita karesine göre test edilir; gerekirse glass opaklığı 0.72→0.85 yükseltilir (erişilebilirlik "şeffaflığı azalt" ayarına da bağlanır).
- Harita pin renkleri tek başına anlam taşımaz: pin içinde her `location_type` için **ikon** vardır (renk körü güvenliği).

### 11.3 VoiceOver / TalkBack

- Pin semantiği: "Kaş Setur Marina, Özel Marina, 4,7 yıldız, 128 değerlendirme, 2,3 kilometre uzaklıkta. Detay için çift dokun."
- Bottom sheet snap durumları semantik aksiyon olarak duyurulur ("Genişlet", "Daralt"); grabber `semantics: button`.
- Yıldız verme: ayarlanabilir semantik (`Semantics(adjustable)`) — yukarı/aşağı swipe ile 1–5.
- Hero transition'lar screen reader açıkken atlanır (anında geçiş); odak, açılan sayfanın başlığına taşınır.
- Fotoğraflara yükleme sırasında girilmese bile otomatik semantik etiket: "Kullanıcı fotoğrafı, {lokasyon adı}".
- Tüm toast'lar `liveRegion` olarak duyurulur.

### 11.4 Hareket azaltma

- `disableAnimations`/Reduce Motion açıkken: parallax kapanır, hero transition çapraz fade'e (200ms) döner, harita uçuşları anında `jumpTo` olur, shimmer statik %6 opaklık bloğuna döner.

---

## 12. Dark Mode Geçiş Davranışı

- Üç mod (S-20): Sistem (varsayılan) / Açık / Koyu.
- Tema değişimi **300ms cross-fade** ile uygulanır (ThemeData lerp); ani "flash" yasak.
- Harita stili eşzamanlı değişir: Mapbox light/dark style URL swap; geçişte harita üzerine 300ms `bg.base` renkli scrim fade edilir (stil yüklenme sıçramasını gizler).
- Pin renkleri (foundation §7) her iki modda AYNIDIR (marka tutarlılığı); dark'ta pin'lere %20 daha güçlü dış glow verilir (koyu deniz zemininde seçilirlik).
- Fotoğraflar dark'ta hafif karartılmaz (denizcilik fotoğrafları doğal kalmalı); yalnız hero gradient'i koyulaşır.
- Sistem modundayken gün içi otomatik değişim, uygulama ön plandayken bile yumuşak cross-fade ile gerçekleşir.

---

## 13. Animasyon Spesifikasyonları

### 13.1 Süre ve easing token'ları (09-design-system.md ile ortak)

| Token | Değer | Kullanım |
|---|---|---|
| `motion.fast` | 150ms | Chip toggle, buton press, pin scale, highlight flash |
| `motion.normal` | 250ms | Sheet içi içerik geçişi, toast giriş, sticky CTA, mini kart |
| `motion.slow` | 400ms | Sayfa geçişleri, kamera çerçeveleme, durum pulse |
| `motion.hero` | 450ms | Hero shared-element transition |
| `motion.map` | 500ms | Küme zoom, bölgeye uçuş (kısa mesafe) |

| Easing token | Curve | Kullanım |
|---|---|---|
| `ease.standard` | `Curves.easeInOutCubic` (0.65, 0, 0.35, 1) | Genel geçişler, kamera |
| `ease.enter` | `Curves.easeOutCubic` (0.33, 1, 0.68, 1) | Ekrana giren her şey |
| `ease.exit` | `Curves.easeInCubic` (0.32, 0, 0.67, 0) | Ekrandan çıkan her şey |
| `ease.spring` | spring(stiffness 380, damping 32) | Bottom sheet snap, favori kalbi, pin pop |
| `ease.emphasized` | `Curves.fastOutSlowIn` | Hero transition |

### 13.2 Harita zoom / kamera animasyonu

- Kısa mesafe (< 2× viewport): `easeTo`, 500ms, `ease.standard`.
- Uzun mesafe (şehir değişimi, arama sonucu): `flyTo` — parabolik uçuş, süre mesafeye orantılı `clamp(600ms, 1400ms)`, zirvede zoom-out ile bağlam gösterir (Google Maps hissi).
- Pin odaklama: `easeTo` + `padding.bottom = aktif sheet yüksekliği` — pin her zaman görünür alanın merkezinde kalır.
- Kullanıcı, animasyon sırasında haritaya dokunursa animasyon ANINDA iptal edilir ve kontrol kullanıcıya geçer (harita uygulaması altın kuralı).

### 13.3 Bileşen animasyon tarifleri

| Bileşen/An | Tarif |
|---|---|
| Buton press | scale 1.0→0.97, 150ms `ease.standard`, bırakınca spring geri |
| Toast | alttan 16pt slide + fade-in 250ms `ease.enter`; 3s sonra fade-out 200ms `ease.exit` |
| Pull-to-refresh | çapa (⚓) ikonu çekme mesafesiyle döner, eşikte `mediumImpact` + dalga ripple |
| Skeleton→içerik | 200ms cross-fade, kesinlikle layout shift yok |
| Tab değişimi | ikon 1.0→1.15→1.0 spring + aktif renk geçişi 150ms; sayfalar arası animasyon YOK (anında, harita uygulaması gibi) |
| Rozet/sayaç değişimi | eski sayı yukarı fade-out, yeni sayı alttan fade-in (150ms) |
| Onboarding (S-02) sayfa geçişi | parallax: illüstrasyon 1.2x, metin 1.0x hız; 3. sayfada CTA spring ile belirir |
| Splash→Ana geçiş (S-01→S-06) | logo dalga çizgisine morph olup arama kapsülünün yerine yerleşir hissi: logo fade+scale-out, harita fade-in altında (toplam 600ms) |

### 13.4 Performans bütçesi

- Tüm animasyonlar 60fps hedefli (120Hz cihazda ProMotion'a uyar); jank bütçesi: frame başına < 8ms build+layout.
- Blur (glass) katman sayısı ekran başına maks 3; scroll sırasında blur canlı hesaplanan yüzeylerde `RepaintBoundary` zorunlu.
- Hero transition sırasında harita render'ı dondurulur (snapshot) — çift GPU yükü önlenir.

---

## 14. Ekran Bazlı Akış Özetleri (hızlı referans)

| Akış | Ekran zinciri | Kritik an |
|---|---|---|
| Keşif | S-06 → pin tap → mini kart → S-09 | Hero transition, harita durumu korunur |
| Arama | S-06 → S-07 → sonuç tap → S-06 (mini kart) → S-09 | Önce harita, sonra detay |
| Filtreleme | S-06/S-07 → S-08 → S-06 | Canlı sonuç sayısı |
| Talep | S-09 → S-14 → başarı → S-15 | Tekne seçince boy/draft otomatik dolar |
| Yorum | S-09/S-11 → S-12 (+S-13) → moderasyon bilgisi | Şeffaf `pending` iletişimi |
| Topluluk | S-07 boş sonuç / S-09 → S-22 / S-23 | Boş durumdan değer üretme |
| Onboarding | S-01 → S-02 → S-03 (Misafir mümkün) → S-06 | Misafir 10 sn içinde haritada |

---

*Doküman sonu — 08-uiux-akislari.md. Bağlı dokümanlar: 00-foundation.md (kanonik), 09-design-system.md (token'lar), 10-component-library.md (bileşen API'leri).*
