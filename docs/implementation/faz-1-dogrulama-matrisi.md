# Faz 1 — Zorunlu Doğrulama Matrisi ve Engel Raporu

**Tarih:** 7 Temmuz 2026 · **Durum:** ⛔ Faz 1 **TAMAMLANMADI** — ortam engelleri sürüyor. Kural gereği duruldu; varsayım yapılmadı, hiçbir kontrol "geçti" sayılmadı.

## 1. Ortam Engeli — Ayrıntılı Teşhis (bu oturumda yeniden doğrulandı)

| Kaynak | Test | Sonuç |
|---|---|---|
| `registry.npmjs.org` | doğrudan + sandbox proxy'si üzerinden HTTPS | **403 — "Host not in allowlist"** (ortamın ağ çıkış politikası) |
| `pypi.org` | HTTPS | 403 (aynı politika) |
| `registry-1.docker.io` | HTTPS | erişilemiyor (000) |
| `apt` universe deposu (PostGIS paketi) | apt-get | 403 |
| `api.github.com` | HTTPS | ✅ 200 (GitHub API açık) |
| Docker daemon | `service docker start` + `docker info` | **daemon bu sandbox'ta çalıştırılamıyor** (ağdan bağımsız kısıt) |

**Sonuç:** `npm install` imkânsız → derleme/lint/test zinciri koşamaz. Docker daemon yokluğu → `docker build` / `compose up` ağ açılsa bile bu sandbox'ta koşamaz; bu iki adım **her koşulda CI'da** koşmalıdır (workflow hazır).

## 2. Zorunlu Adımlar Matrisi

| # | Adım | Durum | Not |
|---|---|---|---|
| 1 | npm install | ⛔ BLOKE | registry 403 |
| 2 | npm audit (+fix) | ⛔ BLOKE | registry 403; CI `security` job'ına da eklendi (audit-level=high) |
| 3 | eslint | ⛔ BLOKE | bağımlılık yok; config + mimari sınır kuralı hazır |
| 4 | prettier check | ⛔ BLOKE | CI adımı eklendi |
| 5 | tsc compile | ⛔ BLOKE | bağımlılık yok |
| 6 | prisma validate / generate | ⛔ BLOKE | prisma CLI kurulamıyor |
| 7 | prisma migrate verify | 🟡 KISMÎ | Stub'lı uygulama lokal PG16'da hatasız (61 tablo); **gerçek `migrate deploy` CI'da** |
| 8 | Unit / Integration / E2E testler | ⛔ BLOKE | 19 senaryo yazılı, koşulamadı |
| 9 | Docker build | ⛔ BLOKE (kalıcı, sandbox) | CI adımı hazır |
| 10 | docker compose up | ⛔ BLOKE (kalıcı, sandbox) | CI'da compose+`/readyz` smoke adımı **bu turda eklendi** |
| 11 | Health endpoint testleri | 🟡 KISMÎ | e2e spec'te 7 senaryo yazılı; koşum bloke; CI smoke'u canlı imaja karşı da vuruyor |
| 12 | OpenAPI validation | ➖ FAZ KAPSAMI DIŞI | Faz 1'de health dışında endpoint yok; OpenAPI dosyaları Faz 2'de auth uçlarıyla başlar (23 §20) — atlanmadı, kapsam kaydı |
| 13 | Env variable validation | ✅ TAMAM | Zod fail-fast şeması + 5 senaryolu unit test (koşumu bloke ama davranış şema gereği derleme-bağımsız değil → CI'da kanıtlanacak) |

## 3. PostgreSQL + PostGIS Zorunlu Doğrulamaları

Talimat gereği stub yeterli sayılmadı. **`prisma/tests/spatial_validation.sql` bu turda yazıldı** ve CI'a bağlandı — gerçek PostGIS'te şunları koşar ve herhangi bir başarısızlıkta pipeline'ı kırar:

| Doğrulama | Kapsandı |
|---|---|
| Migration testleri (gerçek `migrate deploy` + çift seed) | ✅ CI adımı |
| geography(Point,4326) tip doğrulaması | ✅ test 1 |
| GIST index varlığı + **planlayıcının gerçekten kullandığı** (EXPLAIN JSON) | ✅ test 2 |
| ST_MakeEnvelope viewport/bbox — brute-force ile birebir sonuç | ✅ test 3 |
| ST_DWithin + ST_Distance — 10 nm nearby, mesafe sıralı, yarıçap sınırı | ✅ test 4 |
| ST_Intersects | ✅ test 2-3-6-7 içinde |
| ST_Contains (poligon/water_bodies senaryosu) | ✅ test 5 |
| Cluster read-model temeli (ST_SnapToGrid aggregate, 10K nokta sayım bütünlüğü) | ✅ test 6 |
| Harita performans eşiği (10K nokta, bbox ort. < 50 ms, 20 tekrar + ısınma) | ✅ test 7 |

## 4. Güvenlik Taramaları (CI `security` job'ı — bu turda eklendi)
Dependency scan (`npm audit --audit-level=high`) · Secret scan (gitleaks) · SAST (semgrep, OWASP Top-10 + TypeScript kural setleri) · Docker imaj taraması (Trivy, HIGH/CRITICAL'da kırar, unfixed hariç) · Lisans uyumu (license-checker, izinli lisans beyaz listesi). **Henüz koşmadı** — sonuçlar rapor edilmeden faz kapanmayacak.

## 5. Kod Kalitesi / Performans Raporları
Coverage, lint, warning sayısı, duplicate analizi, build süresi, cold start, memory: tümü koşum gerektirir → **BLOKE**. Coverage eşiği yapılandırıldı (%80 global, jest kapısı); performans eşiği DB katmanı için spatial paket test 7'de otomatikleşti; API cold-start/memory ölçümü network açıldığında `time node dist/main.js` + `/readyz` ile ölçülecek.

## 6. Kararın İçin Seçenekler (varsayım yapılmıyor — birini seç)
**A. Ortam ağ izni (kısmî çözüm):** `registry.npmjs.org`'u ortamın ağ çıkış allowlist'ine ekle → sandbox'ta adım 1-8 + kalite/performans raporları koşulur. Docker adımları (9-10) ve Trivy yine CI gerektirir.
**B. GitHub reposu (tam çözüm — önerilen):** Boş bir repo oluşturup bu ortama bağla → push ederim; hazır iki CI job'ı HER ŞEYİ (gerçek PostGIS spatial paket dahil) koşar, sonuçları rapor ederim. GitHub API'si bu ortamdan erişilebilir durumda (200).
**C. A+B birlikte:** en hızlı iterasyon (lokalde geliştir-koş, CI'da tam doğrulama).

Faz 1, seçtiğin yol üzerinden **tüm matris yeşil olmadan** kapatılmayacak; Faz 2'ye onaysız geçilmeyecek.
