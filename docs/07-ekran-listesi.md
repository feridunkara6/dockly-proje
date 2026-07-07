# Dockly — Tüm Ekran Listesi

> **Doküman No:** 07 · **Sürüm:** 1.0
> **Bağlı olduğu kanonik doküman:** [`00-foundation.md`](./00-foundation.md) — ekran ID'leri (S-01…S-23, A-01…A-08), enum'lar ve endpoint'ler oradan birebir alınmıştır.
> **Format:** Her ekran için: amaç · ana bileşenler · giriş noktaları · çıkış/aksiyonlar · boş durum · hata durumu · misafir mod davranışı · analytics event'leri.

---

## 0. Navigasyon Mimarisi

### 0.1 Alt navigasyon (5 sekme)

Foundation §8'deki kanonik yapı:

| Sekme | Ekran | Feature | Not |
|---|---|---|---|
| 1. **Keşfet (harita)** | S-06 | `map` | Varsayılan açılış sekmesi |
| 2. **Arama** | S-07 | `search` | S-08 filtre sheet'i buradan ve S-06'dan açılır |
| 3. **Favoriler** | S-16 | `favorites` | Misafirde kilit rozetli |
| 4. **Taleplerim** | S-15 | `booking` | Misafirde kilit rozetli |
| 5. **Profil** | S-19 | `profile` | Bildirim zili (S-21) ve Ayarlar (S-20) girişi burada |

- Sekmeler arası geçişte her sekme kendi navigation stack'ini korur (GoRouter `StatefulShellRoute`).
- Sekme ikonuna ikinci dokunuş: stack'i köke sarar (S-06'da ayrıca haritayı kullanıcı konumuna döndürür).
- Misafir kullanıcı Favoriler/Taleplerim sekmesine dokunduğunda sekme açılır ama içerik yerine kayıt CTA'lı boş durum gösterilir (sekme engellenmez — değer önce gösterilir).

### 0.2 Modal / bottom sheet hiyerarşisi

| Katman | Yüzey | Örnekler |
|---|---|---|
| L0 | Tam ekran route | S-06, S-07, S-09, S-15, S-16, S-17, S-19 vd. |
| L1 | Tam ekran modal (aşağı kaydırarak kapanır) | S-10 Fotoğraf Galerisi, S-14 Talep formu, S-18 Tekne ekle/düzenle, S-12 Yorum yaz, S-22 Yeni nokta öner |
| L2 | Bottom sheet (yarım/uzayabilir) | S-06 alt detay kartı, S-08 Filtreler, S-23 Hata bildir, "Yol tarifi" uygulama seçici, kayıt duvarı |
| L3 | Dialog / snackbar | Onay diyalogları (iptal, silme), geri-al snackbar'ları, izin ön açıklamaları |

Kurallar:
- Aynı anda tek L2 sheet açık olabilir; yeni sheet öncekini kapatır.
- **Kayıt duvarı** (L2) her yazma eyleminin önüne aynı bileşenle çıkar; kapatılınca altındaki bağlam korunur.
- L1 modallarda kaydedilmemiş veri varsa kapatma anında "Vazgeçilsin mi?" (L3) onayı istenir.
- Tüm sheet'ler `bg.glass` (blur 20) zemin token'ını kullanır.

### 0.3 Analytics adlandırma sözleşmesi
`snake_case`, `alan_eylem` düzeni; her event'e otomatik eklenen ortak parametreler: `screen_id`, `is_guest`, `session_id`, `app_version`. Aşağıdaki listelerde yalnızca ekrana özgü event'ler yazılmıştır (`screen_view` her ekranda otomatiktir).

---

## 1. Mobil Ekranlar (S-01 … S-23)

### S-01 — Splash (`core`)
- **Amaç:** Marka anı + oturum/flag ön yüklemesi; kullanıcıyı doğru başlangıç ekranına yönlendirmek.
- **Ana bileşenler:** Logo (`brand.deep` zemin), yükleme göstergesi, sürüm etiketi.
- **Giriş noktaları:** Soğuk açılış, bildirimden soğuk açılış (derin bağlantı splash'ten geçer).
- **Çıkış/aksiyonlar:** Oturum varsa → S-06; ilk açılışsa → S-02; oturumsuz tekrar açılışsa → S-03; derin bağlantı varsa hedef ekrana.
- **Boş durum:** Yok (geçiş ekranı).
- **Hata durumu:** Flag/oturum yenileme başarısızsa varsayılanlarla devam; zorunlu sürüm altındaysa "Güncelleme gerekli" tam sayfa engeli.
- **Misafir modu:** Anonim oturum da geçerli oturumdur → S-06.
- **Analytics:** `app_open`, `force_update_shown`.

### S-02 — Onboarding (3 sayfa) (`onboarding`)
- **Amaç:** Değer önerisini 3 kartta anlatmak (keşif · topluluk · talep).
- **Ana bileşenler:** PageView (3 illüstrasyonlu sayfa), sayfa göstergesi, "Atla", son sayfada "Başla".
- **Giriş noktaları:** S-01 (yalnızca ilk açılış).
- **Çıkış/aksiyonlar:** "Atla"/"Başla" → S-03.
- **Boş durum:** Yok.
- **Hata durumu:** Görsel yüklenemezse yerel placeholder; akış asla bloklanmaz.
- **Misafir modu:** N/A (oturum öncesi).
- **Analytics:** `onboarding_page_view (page_index)`, `onboarding_skip`, `onboarding_complete`.

### S-03 — Giriş (`auth`)
- **Amaç:** 5 seçenekle (Apple/Google/E-posta/Telefon/Misafir) en düşük sürtünmeli giriş.
- **Ana bileşenler:** Logo + slogan, Apple/Google native düğmeleri, "E-posta ile devam" (→ S-04), "Telefon ile devam" (→ S-05), **"Misafir olarak devam et"** metin düğmesi, yasal metin bağlantıları.
- **Giriş noktaları:** S-01/S-02; oturum düşmesi; **kayıt duvarı modal varyantı** — misafir bir yazma eylemi denediğinde L2 sheet olarak açılır.
- **Çıkış/aksiyonlar:** Başarılı giriş → S-06 (ya da duvar bağlamında kaldığı eyleme dönüş); Misafir → anonim oturum → S-06.
- **Boş durum:** Yok.
- **Hata durumu:** OAuth iptali sessiz; sağlayıcı hatası snackbar + tekrar dene; `POST /auth/session` hatasında "Giriş tamamlanamadı".
- **Misafir modu:** Ekranın kendisi misafir kapısıdır; duvar varyantında "Misafir olarak devam et" gizlenir (zaten misafir).
- **Analytics:** `login_start (method)`, `login_success (method)`, `login_error (method, code)`, `guest_continue`, `auth_wall_shown (source_action)`, `auth_wall_converted (method)`.

### S-04 — E-posta ile kayıt/giriş (`auth`)
- **Amaç:** E-posta+şifre ile kayıt ve giriş; şifre sıfırlama.
- **Ana bileşenler:** E-posta alanı, şifre alanı (göster/gizle), "Devam", "Şifremi unuttum", kayıt/giriş modu otomatik algısı.
- **Giriş noktaları:** S-03.
- **Çıkış/aksiyonlar:** Başarı → oturum köprüsü → S-06/duvar bağlamı; "Şifremi unuttum" → sıfırlama e-postası onay durumu.
- **Boş durum:** Yok (form).
- **Hata durumu:** Alan bazlı doğrulama (format, min. şifre), `wrong-password`/`user-not-found` yerelleştirilmiş, 5 hatalı denemede kısa soğuma.
- **Misafir modu:** Duvardan gelindiyse linkWithCredential ile anonim hesaba bağlanır (Akış 2).
- **Analytics:** `email_auth_submit (mode)`, `email_auth_error (code)`, `password_reset_request`.

### S-05 — Telefon doğrulama (OTP) (`auth`)
- **Amaç:** Telefonla kayıt/giriş; SMS OTP doğrulaması.
- **Ana bileşenler:** Ülke kodlu telefon alanı (varsayılan +90), 6 haneli OTP kutuları, 60 sn "yeniden gönder" sayacı, otomatik SMS okuma (Android).
- **Giriş noktaları:** S-03.
- **Çıkış/aksiyonlar:** Doğrulama → oturum köprüsü → S-06/duvar bağlamı.
- **Boş durum:** Yok.
- **Hata durumu:** Yanlış kod (3 hak, sonra yeni kod zorunlu), kota/`too-many-requests` mesajı, SMS gecikmesi için "E-posta ile dene" önerisi.
- **Misafir modu:** Duvardan gelindiyse hesap bağlama modu.
- **Analytics:** `phone_auth_start`, `otp_sent`, `otp_verify_success`, `otp_verify_error (attempt)`, `otp_resend`.

### S-06 — Ana Sayfa: Harita + alt kart sistemi (`map`)
- **Amaç:** Ürünün kalbi — Türkiye'deki tüm noktaların Mapbox haritasında keşfi.
- **Ana bileşenler:** Tam ekran Mapbox haritası; `location_type` bazlı renkli pinler (foundation §7 renkleri) ve cluster balonları; üst arama çubuğu (S-07 kapısı) + filtre rozeti (S-08 kapısı); "konumuma git" FAB'ı; **alt detay kartı** (L2): kapak foto, ad, tip, `rating_avg`/`rating_count`, `price_tier`, mesafe, "Detay"/"Yol tarifi", yatay swipe ile komşu kartlar; offline bandı.
- **Giriş noktaları:** Splash sonrası varsayılan; sekme 1; S-07 sonucundan "haritada gör"; S-22 konum seçiminden dönüş.
- **Çıkış/aksiyonlar:** Pin tap → alt kart; kart "Detay" → S-09; "Yol tarifi" → harici navigasyon seçici (L2); arama çubuğu → S-07; filtre → S-08; kalp (kartta) → favori (Akış 11).
- **Boş durum:** Görünür bbox'ta hiç nokta yoksa mikro-kart: "Bu bölgede kayıtlı nokta yok" + "Yeni nokta öner" (S-22).
- **Hata durumu:** `GET /locations` hatası → cache verisiyle devam + "Güncellenemedi" bandı; harita tile hatası → yeniden dene katmanı; offline → son cache + kalıcı bilgi bandı.
- **Misafir modu:** Tamamen açık (okuma); karttaki kalp → kayıt duvarı.
- **Analytics:** `map_view (zoom, bbox_center)`, `map_pin_tap (location_id, location_type)`, `map_cluster_tap (count)`, `map_card_swipe (direction)`, `map_card_detail_tap (location_id)`, `map_directions_tap (location_id, provider)`, `map_empty_area_shown`, `map_locate_me_tap`, `map_session_duration (seconds)` — *harita oturum süresi KPI'sının kaynağı.*

### S-07 — Arama (`search`)
- **Amaç:** Marina, iskele, şehir, ilçe, koy, restoran, yakıt araması (typo toleranslı).
- **Ana bileşenler:** Arama alanı (otomatik odak), son aramalar, son görüntülenenler (`GET /recently-viewed`), popüler şehir çipleri, sonuç listesi (tip ikonu, ad, şehir/ilçe, puan), filtre düğmesi (→ S-08), liste/harita görünüm anahtarı.
- **Giriş noktaları:** Sekme 2; S-06 arama çubuğu.
- **Çıkış/aksiyonlar:** Sonuç tap → S-09 (+ `POST /recently-viewed`); "haritada gör" → S-06 odaklı; filtre → S-08.
- **Boş durum:** Sorgu boş → son aramalar/son görüntülenenler; onlar da boşsa "Bir marina, koy ya da şehir ara" illüstrasyonu. Sonuç yok → "Sonuç bulunamadı" + filtre temizle + "Yeni nokta öner" (S-22).
- **Hata durumu:** API hatası → "Arama şu an yapılamıyor" + tekrar dene; offline → yalnızca cache içinde yerel arama + bilgi bandı.
- **Misafir modu:** Tamamen açık.
- **Analytics:** `search_query (query_length, results_count)`, `search_result_tap (location_id, rank)`, `search_no_results (query)`, `search_recent_tap`, `search_suggest_location_tap`.

### S-08 — Filtreler (bottom sheet) (`search`)
- **Amaç:** Sonuçları `location_type`, amenity, fiyat, puan, çalışma saati ve tekne uyumuna göre daraltmak.
- **Ana bileşenler:** L2 uzayabilir sheet; `location_type` çoklu seçim (9 tip, ikonlu); 15 amenity çipi (`electricity`…`technical_service`); `price_tier` segmenti (`free`/`paid`/`unknown`); min. puan kaydırıcısı; `is_24h` anahtarı; **tekne uyumu** anahtarı (primary teknenin `length_m`/`draft_m` ↔ `max_boat_length_m`/`max_draft_m`); alt bar: "Temizle" + "Sonuçları göster (N)".
- **Giriş noktaları:** S-06 filtre rozeti; S-07 filtre düğmesi.
- **Çıkış/aksiyonlar:** "Sonuçları göster" → çağıran yüzeye filtreli dönüş; "Temizle" → sıfırlama.
- **Boş durum:** N/A; ancak canlı sonuç sayacı 0 ise düğme "Sonuç yok — filtreleri gevşet" durumuna geçer.
- **Hata durumu:** Sayaç sorgusu hata verirse sayaçsız "Sonuçları göster"; amenity sözlüğü yüklenemezse cache'ten.
- **Misafir modu:** Açık; tekne uyumu anahtarı "Önce tekne ekle" der → tap → kayıt duvarı → S-18.
- **Analytics:** `filter_open (source)`, `filter_apply (types[], amenities[], price_tier, min_rating, is_24h, boat_fit, results_count)`, `filter_clear`, `filter_boat_fit_blocked_guest`.

### S-09 — Lokasyon Detay (`locations`)
- **Amaç:** Karar ekranı: bir noktanın tüm bilgisi + tüm eylemler.
- **Ana bileşenler:** Foto şeridi (→ S-10); başlık bloğu (ad, tip etiketi, şehir/ilçe/`bay_name`, `rating_avg` + `rating_count`, `price_tier`); tekne uyum rozeti; amenity ızgarası; teknik blok (`capacity`, `max_boat_length_m`, `max_draft_m`, `vhf_channel`, `is_24h`); iletişim (`phone`, `website`); mini konum haritası; yorum önizlemesi (3 adet → S-11); aksiyon çubuğu: **Talep bırak** (S-14), **Yol tarifi**, **Ara**, **Favorile**; üç-nokta: Fotoğraf ekle (S-13), Yorum yaz (S-12), Hata bildir (S-23), Paylaş.
- **Giriş noktaları:** S-06 kartı, S-07 sonucu, S-16, S-15 talep detayı, S-21 derin bağlantı, paylaşım linki.
- **Çıkış/aksiyonlar:** Yukarıdaki tüm hedefler; geri → çağıran yüzey.
- **Boş durum:** Foto yoksa tip bazlı placeholder + "İlk fotoğrafı sen ekle"; yorum yoksa "İlk yorumu sen yaz"; opsiyonel alanlar boşsa satır tamamen gizlenir.
- **Hata durumu:** `GET /locations/{id}` hatası → cache varsa "güncel olmayabilir" bandıyla göster, yoksa tam sayfa hata + tekrar dene; arşivlenmiş kayıt → "Bu nokta artık listelenmiyor".
- **Misafir modu:** Okuma + Ara + Yol tarifi + Paylaş serbest; Talep/Favori/Yorum/Foto/Hata bildir → kayıt duvarı.
- **Analytics:** `location_view (location_id, location_type, source)` — *North Star (WAE) kaynağı*; `location_call_tap`, `location_website_tap`, `location_directions_tap (provider)`, `location_share`, `location_booking_cta_tap`, `location_favorite_toggle (state)`, `location_fit_badge_shown (fit)`.

### S-10 — Fotoğraf Galerisi (tam ekran) (`locations`)
- **Amaç:** Fotoğrafları tam ekran, kaydırmalı incelemek.
- **Ana bileşenler:** L1 modal; yatay PageView, pinch-zoom, sayaç (3/17), yükleyen kullanıcı adı + tarih, kapat, üç-nokta: "Fotoğrafı bildir" (`report_reason = wrong_photo`).
- **Giriş noktaları:** S-09 foto şeridi; S-11 yorum fotoğrafı.
- **Çıkış/aksiyonlar:** Aşağı kaydır/kapat → geri; bildir → S-23 önseçili neden.
- **Boş durum:** Fotoğrafsız açılamaz (giriş noktası zaten yoktur).
- **Hata durumu:** Görsel yüklenemezse bulanık placeholder + yeniden dene ikonu; offline'da yalnızca cache'li görseller.
- **Misafir modu:** Görüntüleme serbest; "Fotoğrafı bildir" → kayıt duvarı.
- **Analytics:** `gallery_open (location_id, photo_count)`, `gallery_swipe (index)`, `gallery_photo_report_tap`.

### S-11 — Yorumlar listesi (`reviews`)
- **Amaç:** Bir lokasyonun tüm onaylı yorumlarını okumak.
- **Ana bileşenler:** Puan özeti başlığı (`rating_avg` büyük, yıldız dağılım çubukları, `rating_count`); sıralama (yeni/puan); yorum kartları (avatar, ad, yıldız, tarih, `body`, foto küçükleri → S-10, üç-nokta: bildir); "Yorum yaz" CTA; cursor-based sonsuz kaydırma.
- **Giriş noktaları:** S-09 "Tüm yorumlar"; S-21 `new_review` derin bağlantısı.
- **Çıkış/aksiyonlar:** "Yorum yaz" → S-12; foto → S-10; bildir → rapor akışı; kendi yorumunda: düzenle/sil.
- **Boş durum:** "Henüz yorum yok — ilk yorumu sen yaz" + CTA.
- **Hata durumu:** Sayfa yükleme hatası → satır içi tekrar dene; offline → cache'li ilk sayfa + bant.
- **Misafir modu:** Okuma serbest; "Yorum yaz"/bildir → kayıt duvarı.
- **Analytics:** `reviews_list_view (location_id, review_count)`, `reviews_sort_change (sort)`, `review_report_tap`, `review_write_cta_tap`.

### S-12 — Yorum yaz + puan ver (`reviews`)
- **Amaç:** 1-5 puan + metin + opsiyonel fotoğraf ile katkı.
- **Ana bileşenler:** L1 modal; lokasyon özeti; yıldız seçici (zorunlu); çok satırlı metin (maks. 2000, sayaç); foto ekleme şeridi (S-13 bileşeni gömülü, maks. 5); moderasyon bilgilendirme satırı; "Gönder".
- **Giriş noktaları:** S-09 üç-nokta, S-11 CTA.
- **Çıkış/aksiyonlar:** Gönder → `POST /locations/{id}/reviews` (`status = pending`) → başarı mesajı → geri; kapatma → taslak onayı (L3).
- **Boş durum:** N/A (form); yıldız seçilmeden "Gönder" pasif.
- **Hata durumu:** 409 (aktif yorum var) → "Yorumunu güncelle" akışına yönlendirme; ağ hatası → form korunur + tekrar dene.
- **Misafir modu:** Ekrana misafir ulaşamaz (girişte duvar).
- **Analytics:** `review_submit_start`, `review_submit_success (rating, has_body, photo_count)`, `review_submit_error (code)`, `review_draft_discarded`.

### S-13 — Fotoğraf yükle (`reviews`)
- **Amaç:** Lokasyona (ya da yorum içine) fotoğraf katkısı; presign → S3 → complete akışı.
- **Ana bileşenler:** Kaynak seçimi (kamera/galeri), çoklu seçim (maks. 5), önizleme ızgarası + tekil silme, yükleme ilerlemesi (parça parça), moderasyon bilgilendirmesi, "Yükle".
- **Giriş noktaları:** S-09 üç-nokta "Fotoğraf ekle"; S-12 içinde gömülü; S-18 tekne fotoğrafı; S-22 öneri fotoğrafı.
- **Çıkış/aksiyonlar:** Yükle → `POST /photos/presign` → S3 PUT → `POST /photos/complete` (`status = pending`) → başarı → geri.
- **Boş durum:** Seçim yapılmadan "Yükle" pasif.
- **Hata durumu:** Presign/S3 hatasında tekil foto "yeniden dene" durumuna düşer, başarılı olanlar korunur; izin reddi → ayarlara yönlendirme; dosya çok büyükse istemci tarafı sıkıştırma.
- **Misafir modu:** Girişte kayıt duvarı.
- **Analytics:** `photo_upload_start (source, count, owner_type)`, `photo_upload_success (count)`, `photo_upload_error (stage, code)`.

### S-14 — Rezervasyon Talebi formu (`booking`)
- **Amaç:** Request-only talep oluşturma; rezervasyon sözü VERMEDEN.
- **Ana bileşenler:** L1 modal; lokasyon özet kartı; tekne seçici (kayıtlı tekneler, primary önseçili; "tekne eklemeden devam" → manuel `boat_length_m`/`boat_draft_m` alanları); `check_in`/`check_out` takvimi; `phone` (profilden önerilir); `note` alanı; kısıt uyarısı (engellemeyen); **bilgi kutusu:** "Bu bir rezervasyon değildir — talebin Dockly ekibi tarafından iletilir"; "Talebi gönder".
- **Giriş noktaları:** S-09 "Talep bırak" (misafirse önce kayıt duvarı); S-15 boş durum CTA'sı (lokasyon seçimine yönlendirir → S-06).
- **Çıkış/aksiyonlar:** Gönder → `POST /booking-requests` (`status = pending`) → başarı ekranı (durum çizelgesi) → "Taleplerim'e git" (S-15); kapat → taslak onayı.
- **Boş durum:** Tekne yoksa seçici yerine "Tekne ekle" (→ S-18) + manuel giriş yolu.
- **Hata durumu:** Tarih doğrulama alan hataları; çakışan aktif talep uyarısı (+ S-15 bağlantısı); ağ hatası → form korunur.
- **Misafir modu:** Ekrana misafir ulaşamaz (S-09'daki CTA duvara yönlendirir; dönüşüm sonrası form dolu hâliyle açılır).
- **Analytics:** `booking_request_start (location_id)`, `booking_request_submit (location_id, has_boat_id, nights)`, `booking_request_success (request_id)` — *talep sayısı KPI kaynağı*; `booking_request_error (code)`, `booking_fit_warning_shown`.

### S-15 — Taleplerim (liste + detay) (`booking`)
- **Amaç:** Taleplerin durumunu şeffaf izlemek ve yönetmek.
- **Ana bileşenler:** Sekmeli liste (Aktif: `pending`/`contacted` · Geçmiş: `confirmed`/`cancelled`/`expired`); talep kartı (lokasyon adı+foto, tarih aralığı, durum rozeti — durum renkleri: `pending` `semantic.warning`, `confirmed` `semantic.success`, `cancelled`/`expired` `semantic.error`/nötr); detay görünümü: durum zaman çizgisi (`pending → contacted → confirmed | cancelled | expired`), tekne/tarih/telefon/not özeti, lokasyon kartı (→ S-09), "Talebi iptal et" (yalnızca `pending`/`contacted`).
- **Giriş noktaları:** Sekme 4; S-14 başarı ekranı; S-21 `booking_status` derin bağlantısı.
- **Çıkış/aksiyonlar:** Kart → detay; lokasyon → S-09; iptal → onay diyaloğu → `POST /booking-requests/{id}/cancel`.
- **Boş durum:** "Henüz talebin yok" + "Haritada keşfet" CTA (→ S-06).
- **Hata durumu:** Liste hatası → tekrar dene; iptal hatası → durum geri alınır + snackbar; offline → cache'li liste, iptal kapalı.
- **Misafir modu:** Sekme açılır, içerik yerine kilit illüstrasyonu + "Talep bırakmak için hesap oluştur" CTA (kayıt duvarı).
- **Analytics:** `bookings_list_view (active_count, past_count)`, `booking_detail_view (request_id, status)`, `booking_cancel_tap`, `booking_cancel_success`, `bookings_guest_wall_shown`.

### S-16 — Favoriler (`favorites`)
- **Amaç:** Kaydedilen noktalara hızlı dönüş.
- **Ana bileşenler:** Liste/mini-harita görünüm anahtarı; favori kartı (kapak, ad, tip, puan, şehir); satır swipe ile kaldırma + geri-al snackbar'ı; arşivlenen kayıtlarda soluk stil + etiket.
- **Giriş noktaları:** Sekme 3.
- **Çıkış/aksiyonlar:** Kart → S-09; kaldır → `DELETE /favorites/{locationId}` (hard delete).
- **Boş durum:** "Henüz favorin yok — keşfetmeye başla" + S-06 CTA.
- **Hata durumu:** Liste hatası → tekrar dene; kaldırma hatası → satır geri gelir; offline → cache'li liste (salt okunur).
- **Misafir modu:** Kilit illüstrasyonu + "Favorilerini kaydetmek için hesap oluştur" CTA.
- **Analytics:** `favorites_view (count, view_mode)`, `favorite_remove (location_id)`, `favorite_undo`, `favorites_guest_wall_shown`.

### S-17 — Tekne listem (`boats`)
- **Amaç:** Kullanıcının teknelerini (1→N) yönetmek.
- **Ana bileşenler:** Tekne kartları (foto/placeholder, `name`, `boat_type` etiketi, `length_m` × `beam_m`, `draft_m`, "Ana tekne" rozeti `accent.turquoise`); "+ Tekne ekle"; kart menüsü: düzenle / ana tekne yap / sil.
- **Giriş noktaları:** S-19 Profil → "Teknelerim"; S-14'ten "Tekne ekle" yönlendirmesi.
- **Çıkış/aksiyonlar:** Kart/düzenle → S-18; "ana tekne yap" → `PATCH /boats/{id}`; sil → onay diyaloğu → soft delete.
- **Boş durum:** "Henüz tekne eklemedin — talep formunu hızlandırmak için tekneni ekle" + CTA (→ S-18).
- **Hata durumu:** Liste hatası → tekrar dene; silme hatası → kart geri gelir.
- **Misafir modu:** Girişte kayıt duvarı (Profil üzerinden erişim zaten kayıt ister).
- **Analytics:** `boats_list_view (count)`, `boat_set_primary (boat_id)`, `boat_delete (boat_id)`.

### S-18 — Tekne ekle/düzenle (`boats`)
- **Amaç:** `boats` kaydı oluşturmak/güncellemek.
- **Ana bileşenler:** L1 modal form: `name`*, `boat_type`* (9 kanonik seçenek), `brand`, `model`, `year`, `length_m`*, `beam_m`, `draft_m`, `engine_type` (6 kanonik seçenek), `is_primary` anahtarı, foto ekleme (S-13 bileşeni); "Kaydet".
- **Giriş noktaları:** S-17; S-14 "Tekne ekle"; S-08 tekne uyumu yönlendirmesi.
- **Çıkış/aksiyonlar:** Kaydet → `POST /boats` / `PATCH /boats/{id}` → S-17 (ya da çağıran S-14'e seçili tekneyle dönüş).
- **Boş durum:** N/A (form); zorunlu alanlar dolmadan "Kaydet" pasif.
- **Hata durumu:** Alan doğrulamaları (boy aralığı, yıl); ağ hatası → form korunur; foto hatası tekneyi bloklamaz.
- **Misafir modu:** Girişte kayıt duvarı.
- **Analytics:** `boat_form_open (mode)`, `boat_save_success (mode, boat_type, has_photo)`, `boat_save_error (code)`.

### S-19 — Profil (`profile`)
- **Amaç:** Kimlik, katkılar ve modül kapıları.
- **Ana bileşenler:** Avatar + `full_name` + iletişim; katkı sayaçları (yorum/fotoğraf/öneri); menü: Teknelerim (S-17), Bildirimler (S-21, okunmamış rozeti), Ayarlar (S-20), Yardım/İletişim, yasal metinler; "onay bekleyen katkılarım" bölümü.
- **Giriş noktaları:** Sekme 5.
- **Çıkış/aksiyonlar:** Menü hedefleri; avatar/ad düzenleme → `PATCH /users/me`.
- **Boş durum:** Katkı sayaçları 0 ise "İlk katkını yap" teşvik kartı (→ S-22 / S-12).
- **Hata durumu:** Profil yüklenemezse cache + bant; güncelleme hatası → eski değere dönüş.
- **Misafir modu:** Misafir varyantı: "Misafir olarak geziyorsun" kartı + "Hesap oluştur" ana CTA + yalnızca Ayarlar erişilebilir (tema/dil).
- **Analytics:** `profile_view`, `profile_edit_success (field)`, `profile_guest_cta_tap`.

### S-20 — Ayarlar (tema, dil, bildirim) (`settings`)
- **Amaç:** Kişiselleştirme + hesap yönetimi + yasal gereklilikler.
- **Ana bileşenler:** Tema (light/dark/sistem); dil (TR/EN); bildirim tercihleri (5 `notification_type` için ayrı anahtar); hücresel veri tasarrufu (görsel kalitesi); önbelleği temizle; hesap: çıkış yap, **hesabı sil** (soft delete, çift onay); hakkında/sürüm.
- **Giriş noktaları:** S-19.
- **Çıkış/aksiyonlar:** Anahtarlar anında uygulanır; hesap sil → onay akışı → oturum kapatılır → S-03; çıkış → S-03.
- **Boş durum:** N/A.
- **Hata durumu:** Tercih sunucuya yazılamazsa yerelde tutulur + arkaplanda tekrar dener; hesap silme hatası açık şekilde bildirilir.
- **Misafir modu:** Tema/dil açık; bildirim tercihleri ve hesap bölümü yerine "Hesap oluştur" CTA'sı.
- **Analytics:** `settings_theme_change (value)`, `settings_language_change (value)`, `settings_notification_toggle (type, enabled)`, `account_logout`, `account_delete_start`, `account_delete_success`.

### S-21 — Bildirimler (`notifications`)
- **Amaç:** Uygulama içi bildirim merkezi.
- **Ana bileşenler:** Ters kronolojik liste; tip ikonlu satırlar (`booking_status`, `new_photo`, `new_review`, `favorite_update`, `system`); okunmamış vurgusu; "tümünü okundu işaretle"; cursor-based sayfalama.
- **Giriş noktaları:** S-19 zil; push bildirimi tap'i (derin bağlantı önce hedefe, sistem tipinde buraya).
- **Çıkış/aksiyonlar:** Satır tap → derin bağlantı (`booking_status` → S-15 detay; `new_photo`/`new_review`/`favorite_update` → S-09) + `POST /notifications/read`.
- **Boş durum:** "Henüz bildirimin yok" illüstrasyonu; push izni kapalıysa "Bildirimleri aç" banner'ı (→ sistem ayarları).
- **Hata durumu:** Liste hatası → tekrar dene; hedef içerik silinmişse "İçerik artık mevcut değil"; offline → cache'li liste, okundu işaretleri bağlantıda gönderilir.
- **Misafir modu:** Boş durum + "Bildirim almak için hesap oluştur" CTA.
- **Analytics:** `notifications_view (unread_count)`, `notification_tap (type, target_id)`, `notifications_mark_all_read`, `push_permission_prompt (result)`.

### S-22 — Yeni nokta öner (`reviews` — community)
- **Amaç:** Topluluğun haritaya yeni nokta kazandırması (`suggestion_type = new_location`).
- **Ana bileşenler:** 3 adımlı sihirbaz: (1) haritada pin bırakma + "konumumu kullan"; (2) ad*, `location_type`* (9 tip), şehir/ilçe (reverse geocode, düzenlenebilir), not, bilinen amenity'ler; (3) opsiyonel 1–5 foto; ilerleme göstergesi; moderasyon bilgilendirmesi; "Gönder".
- **Giriş noktaları:** S-06 boş bölge mikro-kartı; S-07 "sonuç yok"; S-19 "Katkıda bulun".
- **Çıkış/aksiyonlar:** Gönder → `POST /suggestions` (`pending`) → teşekkür ekranı → geri; yakın mevcut nokta algılanırsa → S-09'a yönlendirme ya da `edit_location` önerisine dönüştürme.
- **Boş durum:** N/A (sihirbaz); zorunlu alanlar dolmadan ileri pasif.
- **Hata durumu:** Reverse geocode hatası → elle giriş; gönderim hatası → taslak korunur; offline → gönderim kilidi + taslak.
- **Misafir modu:** Girişte kayıt duvarı.
- **Analytics:** `suggestion_start (source)`, `suggestion_step_complete (step)`, `suggestion_submit (location_type, has_photos)` — *içerik üretimi KPI kaynağı*; `suggestion_duplicate_detected`, `suggestion_error (code)`.

### S-23 — Hatalı bilgi bildir (`reviews` — community)
- **Amaç:** Veri kalitesi geri bildirimi (`reports`).
- **Ana bileşenler:** L2 bottom sheet; `report_reason` seçenekleri: `wrong_info`, `closed_permanently`, `wrong_photo`, `wrong_position`, `other`; `wrong_position` seçiminde mini harita ile doğru konum işaretleme (opsiyonel); açıklama alanı; "Gönder".
- **Giriş noktaları:** S-09 üç-nokta; S-10 "fotoğrafı bildir" (`wrong_photo` önseçili); S-11 yorum bildirimi (`other`).
- **Çıkış/aksiyonlar:** Gönder → `POST /reports` → teşekkür → sheet kapanır.
- **Boş durum:** N/A; neden seçilmeden "Gönder" pasif.
- **Hata durumu:** 24 saat içinde mükerrer bildirim → "Bildirimin zaten incelemede"; ağ hatası → metin korunur.
- **Misafir modu:** Girişte kayıt duvarı.
- **Analytics:** `report_open (source, preselected_reason)`, `report_submit (reason, has_position)`, `report_duplicate_blocked`.

---

## 2. Admin Web Ekranları (A-01 … A-08)

Genel kurallar: erişim `role >= moderator` (foundation §6); `admin`/`super_admin` ek yetkileri ekran bazında belirtilir; tüm yazma işlemleri `audit_logs`'a düşer; misafir modu admin'de yoktur (oturum zorunlu); tüm listeler cursor-based sayfalanır ve filtrelenebilir.

### A-01 — Dashboard
- **Amaç:** Operasyonun sağlık paneli: bekleyen işler + temel metrikler.
- **Ana bileşenler:** Bekleyen sayaç kartları (moderasyon kuyruğu: foto/yorum/öneri `pending`; talepler: `pending`); SLA göstergeleri; son `audit_logs` akışı; hızlı bağlantılar.
- **Giriş noktaları:** Admin girişi sonrası varsayılan.
- **Çıkış/aksiyonlar:** Sayaç kartları ilgili kuyruk ekranına (A-04/A-05/A-06) götürür.
- **Boş durum:** "Bekleyen iş yok" kutlama durumu.
- **Hata durumu:** Metrik servisi hatasında kartlar tekil "yüklenemedi" durumuna düşer.
- **Analytics (admin):** `admin_dashboard_view`, `admin_queue_shortcut_tap (target)`.

### A-02 — Lokasyon CRUD
- **Amaç:** `locations` kayıtlarını oluşturmak/düzenlemek; `draft/published/archived` yaşam döngüsünü yönetmek; öneri ve raporları veriye işlemek.
- **Ana bileşenler:** Filtreli tablo (tip, durum, şehir, arama); kayıt formu (tüm kanonik kolonlar: `slug`, `name`, `type`, `status`, `geo` harita seçici, `city`/`district`/`bay_name`, `phone`, `website`, `vhf_channel`, `max_boat_length_m`, `max_draft_m`, `capacity`, `price_tier`, `is_24h`); amenity atama (A-03 sözlüğünden); bağlı öneri/rapor paneli; foto yönetimi.
- **Giriş noktaları:** Menü; A-01; öneri/rapor kuyruklarından derin bağlantı.
- **Çıkış/aksiyonlar:** Kaydet/yayınla/arşivle; öneri kabulü → yeni `published` kayıt + öneri sahibine `system` bildirimi.
- **Boş durum:** Filtre sonucu boşsa "Kayıt yok" + filtre temizle.
- **Hata durumu:** `slug` çakışması alan hatası; geo doğrulaması (Türkiye sınır uyarısı); eşzamanlı düzenleme çakışmasında "kayıt güncellendi, yenile".
- **Yetki notu:** Silme/arşivleme `admin`+; moderatör taslak ve düzenleme yapabilir.
- **Analytics (admin):** `admin_location_create`, `admin_location_publish`, `admin_location_archive`, `admin_suggestion_accept/reject`.

### A-03 — Kategori / Amenity yönetimi
- **Amaç:** `amenities` referans sözlüğünü ve `location_type` görsel eşlemelerini yönetmek.
- **Ana bileşenler:** 15 kanonik amenity listesi (kod, TR/EN ad, ikon); `location_type` renk/ikon eşleme tablosu (salt görüntüleme — kodlar kanoniktir, foundation'dan değiştirilemez); yeni amenity ekleme (yalnızca `super_admin`).
- **Giriş noktaları:** Menü.
- **Çıkış/aksiyonlar:** Ad/ikon düzenleme; ekleme (migration eşliğinde, uyarılı).
- **Boş durum:** N/A (seed'li referans tablo).
- **Hata durumu:** Kullanımda olan amenity silinemez → engel mesajı (yalnızca pasife alma).
- **Analytics (admin):** `admin_amenity_edit`, `admin_amenity_add`.

### A-04 — Fotoğraf moderasyon
- **Amaç:** `photos` kuyruğunu (`moderation_status = pending`) işlemek.
- **Ana bileşenler:** Izgara kuyruk (büyük önizleme, sahip tip: location/boat/review, yükleyen, lokasyon bağlantısı); onayla/reddet (red nedeni seçimi); toplu seçim; klavye kısayolları; `wrong_photo` raporlarıyla ilişkili "bildirilen" sekmesi.
- **Giriş noktaları:** Menü; A-01 sayacı.
- **Çıkış/aksiyonlar:** Onay → `approved` (uygulamada görünür, ilgili kullanıcılara `new_photo` bildirimi tetiklenebilir); red → `rejected` + yükleyene bilgilendirme.
- **Boş durum:** "Kuyruk temiz".
- **Hata durumu:** Görsel CDN hatası → yeniden dene; işlem çakışması (başka moderatör işledi) → satır kuyruğa yenilenir.
- **Analytics (admin):** `admin_photo_approve`, `admin_photo_reject (reason)`, `admin_photo_bulk_action (count)`.

### A-05 — Yorum moderasyon
- **Amaç:** `reviews` kuyruğunu işlemek; yayın kalitesini korumak.
- **Ana bileşenler:** Kuyruk listesi (yıldız, `body`, foto ekleri, yazar geçmişi özeti, lokasyon bağlantısı); onayla/reddet (+neden); bildirilen yayın içi yorumlar sekmesi; kullanıcı bazlı geçmiş görünümü.
- **Giriş noktaları:** Menü; A-01.
- **Çıkış/aksiyonlar:** Onay → `approved` → `rating_avg`/`rating_count` trigger ile güncellenir + lokasyonu favorileyenlere `new_review` bildirimi; red → `rejected` + yazara bilgilendirme; yayından kaldırma (soft delete) `admin`+.
- **Boş durum:** "Kuyruk temiz".
- **Hata durumu:** Çakışma → satır yenilenir; toplu işlemde kısmi başarı raporu.
- **Analytics (admin):** `admin_review_approve`, `admin_review_reject (reason)`, `admin_review_unpublish`.

### A-06 — Talepler
- **Amaç:** v1'in operasyon kalbi: `booking_requests` kayıtlarını manuel işlemek (onay marina tarafından DEĞİL, Dockly operasyon ekibince).
- **Ana bileşenler:** Durum sekmeleri (`pending`/`contacted`/`confirmed`/`cancelled`/`expired`); talep detayı (kullanıcı iletişimi, tekne boy/su çekimi, tarih aralığı, `note`, lokasyon telefonu/`vhf_channel`); durum geçiş düğmeleri (yalnızca geçerli geçişler: `pending → contacted → confirmed`; her aşamadan `cancelled`); iç operasyon notu alanı; SLA yaş göstergesi (24 saat hedefi); `check_in` geçmiş `pending` kayıtlar için `expired` işaretleme.
- **Giriş noktaları:** Menü; A-01 "bekleyen talep" sayacı.
- **Çıkış/aksiyonlar:** Her durum değişimi → `booking_status` FCM bildirimi + `notifications` kaydı + `audit_logs`.
- **Boş durum:** "Bekleyen talep yok".
- **Hata durumu:** Bildirim gönderimi başarısızsa durum değişir ama uyarı rozeti düşer (yeniden gönder); geçersiz geçiş denemeleri arayüzde zaten kapalıdır.
- **Analytics (admin):** `admin_booking_status_change (from, to)`, `admin_booking_sla_breach_view`, `admin_booking_note_add`.

### A-07 — Kullanıcılar
- **Amaç:** `users` kayıtlarını görüntülemek ve yönetmek.
- **Ana bileşenler:** Arama/filtre (e-posta, telefon, `role`); kullanıcı detayı (profil, tekneler, katkılar, talepler, cihazlar); rol atama (`user`/`moderator`/`admin`/`super_admin` — yalnızca `super_admin` rol yükseltebilir); askıya alma / soft delete.
- **Giriş noktaları:** Menü; diğer ekranlardaki yazar bağlantıları.
- **Çıkış/aksiyonlar:** Rol değişimi, askıya alma → `audit_logs`; kullanıcının içeriklerine hızlı geçiş.
- **Boş durum:** Arama sonucu boş → "Kullanıcı bulunamadı".
- **Hata durumu:** Kendi rolünü düşürme / son `super_admin`'i silme engellenir.
- **Analytics (admin):** `admin_user_role_change (to_role)`, `admin_user_suspend`, `admin_user_view`.

### A-08 — İstatistik
- **Amaç:** PRD §8 KPI'larını operasyonel panoda izlemek.
- **Ana bileşenler:** North Star (WAE) grafiği; DAU/MAU; harita oturum süresi dağılımı; talep hunisi (`pending→contacted→confirmed` dönüşümleri, SLA); içerik üretimi (yorum/foto/öneri aylık, onay oranları); kapsam (published lokasyon sayısı, tip dağılımı, bölge boşluk haritası); misafir→kayıtlı dönüşüm; tarih aralığı seçici; CSV dışa aktarma.
- **Giriş noktaları:** Menü; A-01 özet kartlarından derin bağlantı.
- **Çıkış/aksiyonlar:** Grafiklerden segment detayına iniş; dışa aktarma.
- **Boş durum:** Veri birikmeden önce "Yeterli veri yok" durumu (lansman ilk haftaları).
- **Hata durumu:** Sorgu zaman aşımı → aralığı daralt önerisi; tekil grafik hatası diğerlerini bloklamaz.
- **Analytics (admin):** `admin_stats_view (range)`, `admin_stats_export (report)`.

---

## 3. Çapraz Referans Tabloları

### 3.1 Ekran ↔ birincil endpoint eşlemesi

| Ekran | Birincil endpoint(ler) |
|---|---|
| S-03/S-04/S-05 | `POST /auth/session`, `PUT /devices` |
| S-06 | `GET /locations` (bbox, filtre) |
| S-07 | `GET /locations` (search), `GET/POST /recently-viewed` |
| S-08 | `GET /locations` (filtre parametreleri) |
| S-09 | `GET /locations/{id}` |
| S-11/S-12 | `GET/POST /locations/{id}/reviews`, `DELETE /reviews/{id}` |
| S-13 | `POST /photos/presign`, `POST /photos/complete` |
| S-14/S-15 | `GET/POST /booking-requests`, `POST /booking-requests/{id}/cancel` |
| S-16 | `GET /favorites`, `PUT/DELETE /favorites/{locationId}` |
| S-17/S-18 | `GET/POST /boats`, `GET/PATCH/DELETE /boats/{id}` |
| S-19 | `GET/PATCH /users/me` |
| S-21 | `GET /notifications`, `POST /notifications/read` |
| S-22 | `POST /suggestions` |
| S-23 | `POST /reports` |
| A-01…A-08 | `/admin/*` (role >= moderator) |

### 3.2 Misafir modu özet matrisi

| Yetenek | Misafir | Kayıtlı |
|---|---|---|
| Harita, arama, filtre, lokasyon detay, galeri, yorum okuma | ✅ | ✅ |
| Yol tarifi, telefonla arama, paylaşma | ✅ | ✅ |
| Favori, rezervasyon talebi, yorum/puan, fotoğraf, yeni nokta önerisi, hata bildirimi | 🔒 kayıt duvarı | ✅ |
| Tekne profili, bildirim alma, talep takibi | 🔒 kayıt duvarı | ✅ |
| Tema/dil ayarı | ✅ | ✅ |

### 3.3 Boş durum tasarım ilkesi
Her boş durum üç öğe taşır: (1) tip/bağlama uygun illüstrasyon, (2) tek cümlelik açıklama, (3) **ileri götüren tek CTA** (keşfe, katkıya ya da kayda). Boş durumlar asla çıkmaz sokak değildir — özellikle S-06 boş bölge ve S-07 "sonuç yok" durumları S-22 içerik üretimine bağlanır.

---

*Bu doküman `01-prd.md` (kapsam) ve `06-kullanici-akislari.md` (akışlar) ile birlikte okunmalıdır. Çelişki hâlinde `00-foundation.md` geçerlidir.*
