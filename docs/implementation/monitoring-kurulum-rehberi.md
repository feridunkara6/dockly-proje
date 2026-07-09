# Dockly — İzleme (Monitoring) Kurulum Rehberi

> **Bağlam:** Denetim bulgusu D1 ("prod kör uçuşta — monitoring/alerting yok"). Bu rehber Faz A.6 kapsamında hazırlandı.
> **Durum:** Gerçek SDK'lar (Sentry/Crashlytics) iki dış önkoşula bağlı (aşağıda). Bu rehber (a) BUGÜN koda dokunmadan açılabilecek ara çözümü, (b) önkoşullar hazır olunca SDK'ların birebir "tak-çalıştır" adımlarını verir.
> **Son güncelleme:** 8 Temmuz 2026

---

## 0. Şu an ne HAZIR (Faz A.6)

- ✅ **Yapısal loglama + PII maskeleme** (pino, `app.module.ts`): her hata satırı makine-okunur.
- ✅ **5xx sunucu hataları sabit etiketle loglanıyor:** `event: "server_error"` + `status` + `requestId` + `instance` (`problem.filter.ts`). Bu etiket log-tabanlı alarmın yakalama anahtarıdır.
- ✅ **Sağlık uçları:** `/healthz` (liveness), `/readyz` (readiness — DB/Redis).
- ✅ **Config seam:** `SENTRY_DSN` + `SENTRY_ENVIRONMENT` env değişkenleri (opsiyonel) şemada hazır; verilince Sentry SDK okur.

## 1. İki dış önkoşul (neden SDK'lar şimdi bağlanmadı)

1. **Backend Sentry** yeni bir npm paketi (`@sentry/node`) gerektirir → `package-lock.json` güncellenmelidir. Bu, bir kez `npm install` çalıştırmayı gerektirir (CI `npm ci` kilidi senkron olmadan kırmızı verir). → **Firebase fazında veya bir kerelik rehberli `npm install` ile** yapılır.
2. **Mobil Crashlytics** Firebase kurulumu (google-services.json / GoogleService-Info.plist, `firebase_core`) ister → bu, ayrı ertelenmiş faz **2.4c**'nin parçasıdır. Firebase gelmeden Crashlytics mobil build'i kırar.

---

## 2. ARA ÇÖZÜM — bugün, kodsuz: Render log alarmı + uptime

Bu, "kör uçuş"u hemen bitirir; hiçbir bağımlılık/Firebase gerekmez.

### 2.1 Sunucu hatası alarmı (Render)
1. Render Dashboard → `dockly-proje` servisi → **Logs** (veya **Alerts**, plana göre).
2. Log tabanlı bir uyarı kuralı ekle: metin **`"event":"server_error"`** içeren log satırı görülürse bildirim (e-posta).
3. Bu, her 5xx'i (beklenmeyen sunucu hatası) anında haber verir; `requestId` ile logda kök neden bulunur.

### 2.2 Ayakta-mı (uptime) izleme — ücretsiz
- Bir uptime servisi (ör. UptimeRobot, ücretsiz) → `https://dockly-proje.onrender.com/healthz` adresini 5 dk'da bir yoklasın; 2 ardışık başarısızlıkta e-posta.
- (Render ücretsiz plan 15 dk'da uyur; ilk istek uyandırır — bunu "uptime" alarmında tolere et.)

> Bu iki adım, gerçek Sentry gelene kadar geçerli bir "erken uyarı" katmanıdır.

---

## 3. Backend Sentry — tak-çalıştır (önkoşul 1 hazır olunca)

1. Paket ekle (lockfile'ı günceller):
   ```
   cd apps/api && npm install @sentry/node
   ```
2. `apps/api/src/main.ts` en başına (uygulama oluşturulmadan önce):
   ```ts
   import * as Sentry from '@sentry/node';
   if (process.env.SENTRY_DSN) {
     Sentry.init({
       dsn: process.env.SENTRY_DSN,
       environment: process.env.SENTRY_ENVIRONMENT ?? process.env.NODE_ENV,
       tracesSampleRate: 0.1,
       // PII maskeleme: header/authorization/telefon/e-posta gövdeden çıkarılır.
       beforeSend(event) {
         if (event.request?.headers) delete event.request.headers['authorization'];
         return event;
       },
     });
   }
   ```
3. `problem.filter.ts` içindeki 5xx dalına tek satır:
   ```ts
   if (process.env.SENTRY_DSN) Sentry.captureException(exception);
   ```
   (Log etiketi `event: 'server_error'` yerinde kalır — ikisi bir arada çalışır.)
4. Render/hosting env'ine `SENTRY_DSN` (ve `SENTRY_ENVIRONMENT=production`) ekle. DSN Sentry projesinden alınır; **repoya yazılmaz**.
5. Doğrulama: bilinçli bir test hatası tetikle → Sentry'de görün.

---

## 4. Mobil Crashlytics — tak-çalıştır (önkoşul 2 / Firebase 2.4c ile)

1. Firebase projesine mobil uygulamayı ekle; `google-services.json` (Android) + `GoogleService-Info.plist` (iOS) — repoya girmez, CI secret'tan yazılır (docs/16 §1).
2. `apps/mobile/pubspec.yaml`: `firebase_core`, `firebase_crashlytics`.
3. `bootstrap.dart`:
   ```dart
   await Firebase.initializeApp();
   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
   PlatformDispatcher.instance.onError = (error, stack) {
     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
     return true;
   };
   ```
4. Release build'de sembol yükleme (obfuscation ile okunur stack trace): `--obfuscate --split-debug-info` + Crashlytics symbol upload (docs/12 §7.4).
5. Doğrulama: `crash-free session ≥ %99.5` hedefi (docs/01-prd §8.2) buradan ölçülür.

---

## 5. Sırada (Faz D / lansman öncesi)
- APM/trace (p95 latency), Prometheus/OTel metrikleri, alarm eşikleri (docs/14-performans-plani).
- Backend Sentry + mobil Crashlytics gerçek bağlanışı (bu rehberdeki 3–4).
- Bu rehber, bağlanış tamamlanınca `security-evidence.md` ve `DOCKLY-PROJE-DENETIM-RAPORU.md` D1 satırıyla birlikte güncellenir.
