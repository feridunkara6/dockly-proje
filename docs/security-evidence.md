# Dockly — Güvenlik Kanıt Haritası (security-evidence)

> **Amaç:** Güvenlik planındaki (`12-guvenlik-plani.md`) her kontrolün gerçek koddaki/testteki karşılığını tek yerde tutmak. Harici sızma testi ve çeyreklik güvenlik gözden geçirmesi bu tabloyu referans alır.
> **Mimari gerçeği:** NestJS (Node 22) + Prisma + kendi RS256 köprü JWT'si + AWS RDS (ADR-004). Supabase/Edge/PostgREST **kullanılmıyor** — ayrıntı: `12-guvenlik-plani.md` §0.
> **Son güncelleme:** 8 Temmuz 2026 (Faz A · A.1) · **Durum kodları:** ✅ uygulandı · 🟠 kısmi · ❌ açık/planlı

---

## 1. Kimlik doğrulama & oturum

| Kontrol | Durum | Kanıt (dosya) |
|---|---|---|
| Firebase ID token doğrulama (JWKS, RS256 sabit alg, `aud`/`iss` pin, clock skew ±60s) | ✅ | `apps/api/src/infrastructure/firebase/firebase-token.verifier.ts` |
| Kendi köprü JWT'si RS256, alg sabit (alg-confusion/`none` kapalı), ayrı public/private key | ✅ | `apps/api/src/infrastructure/jwt/token.signer.ts` |
| Refresh token yalnız SHA-256 hash saklanır; rotasyonlu; reuse → aile iptali + uyarı | ✅ | `apps/api/src/modules/auth/application/session.service.ts` |
| Askıya alınmış hesapta refresh reddi | ✅ | `apps/api/src/modules/auth/persistence/prisma-user-account.repository.ts` |
| Refresh rotasyonu tek transaction (atomik revoke-and-claim) | ❌ | Denetim bulgusu S7 — Faz A/C |
| `jti` acil iptal (blacklist) | 🟠 | `apps/api/src/infrastructure/redis/jti-blacklist.service.ts` — Redis kesintisinde fail-open (S2) |
| Misafir (anonim) yazma kısıtları | ❌ | `guest-not-allowed` tipi tanımlı (`src/common/problem/problem.ts`) ama guard yok — **Faz A / A.2** |

## 2. Yetkilendirme & veri erişimi

| Kontrol | Durum | Kanıt |
|---|---|---|
| Mass-assignment koruması (`.strict()` beyaz liste; `role`/`status` client'tan asla) | ✅ | `apps/api/src/modules/users/presentation/users.controller.ts`, `boats` şeması |
| IDOR/BOLA: başkasının/yok kaydına **404** (enumerasyon engelli) | ✅ | `apps/api/src/modules/boats/application/boats.service.ts`, `boats.controller.ts` |
| RolesGuard / MinRole (rol hiyerarşisi) | 🟠 | `apps/api/src/common/guards/roles.guard.ts` — tanımlı ama hiçbir controller'da kullanılmıyor (admin modülü yok) |
| RLS savunma derinliği (DB katmanı) | ❌ | `apps/api/prisma/migrations/0002_rls/migration.sql` — İNERT: `app.user_id` set edilmiyor + fail-open + FORCE yok — **Faz A / A.4** |
| RLS eksik 3 tablo (reservation_requests, favorites, notifications) | ❌ | ADR-003 gereği — **Faz A / A.4** (denetim DB1) |

## 3. Girdi & çıktı güvenliği

| Kontrol | Durum | Kanıt |
|---|---|---|
| SQL injection kapalı (tümü parametrik `Prisma.sql`; `queryRawUnsafe` yok) | ✅ | `apps/api/src/modules/locations/persistence/prisma-locations.repository.ts` |
| Zod strict girdi doğrulama (bilinmeyen alan reddi) | ✅ | ilgili controller şemaları (`users`, `boats`) |
| RFC 9457 Problem Details; 500 maskeleme; detay yalnız log | ✅ | `apps/api/src/common/problem/problem.filter.ts`, `problem.ts` |
| Güvenlik başlıkları (helmet), CORS allowlist, HSTS/CSP | ❌ | `main.ts`'te yok; ALB/CDN varsayımı doğrulanmadı — **Faz D** (S4) |

## 4. Hız sınırlama & kötüye kullanım

| Kontrol | Durum | Kanıt |
|---|---|---|
| Auth ucunda rate limit (`POST /auth/sessions`) | 🟠 | `apps/api/src/infrastructure/redis/rate-limiter.service.ts` — fail-open (S2) → **Faz A / A.3** fail-closed |
| Genel/okuma/yazma/admin rate limitleri | ❌ | Yalnız auth uygulanıyor — **Faz D** (S5) |
| Boat başına üst sınır (MAX_BOATS_PER_OWNER) | ✅ | `apps/api/src/modules/boats/application/boats.service.ts` |

## 5. Log, gizlilik & KVKK

| Kontrol | Durum | Kanıt |
|---|---|---|
| PII log maskeleme (authorization/cookie/phone/email) | ✅ | `apps/api/src/app.module.ts` |
| Log-injection guard (request-id `SAFE_ID` regex) | ✅ | `apps/api/src/common/context/request-context.middleware.ts` |
| Env fail-fast (Zod; eksik/yanlış env'de uygulama açılmaz) | ✅ | `apps/api/src/config/env.schema.ts` |
| Repoda secret yok (gitleaks CI) | ✅ | `.gitleaks.toml`, `.github/workflows/ci.yml` |
| KVKK silme — DB anonimleştirme (tek transaction, cihaz hard-delete, audit, tombstone) | ✅ | `apps/api/src/modules/users/persistence/prisma-user.repository.ts` |
| KVKK silme — Firebase hesabı silme | ❌ | firebase-admin yok — **Faz D** (S6) |

## 6. CI/CD güvenlik taraması

| Kontrol | Durum | Kanıt |
|---|---|---|
| Secret taraması (gitleaks) her PR | ✅ | `.github/workflows/ci.yml` |
| İmaj güvenlik taraması (Trivy) | ✅ | `.github/workflows/ci.yml` |
| SAST (Semgrep OWASP) | ✅ | `.github/workflows/ci.yml` |
| Lisans uyum taraması | ✅ | `.github/workflows/ci.yml` |
| Gerçek PostGIS+Redis ile e2e + seed idempotency (2x) | ✅ | `.github/workflows/ci.yml`, `apps/api/test/` |
| RLS doğrulama testi (`rls_validation.sql`) CI'da | ❌ | Dosya var, CI koşmuyor — **Faz A / A.5** (D5) |

---

## Faz A kapsamında bu dosyada güncellenecek satırlar
A.2 → misafir kısıtları ✅ · A.3 → auth fail-closed ✅ · A.4 → RLS aktif + eksik tablolar ✅ · A.5 → RLS testi CI'da ✅

*Bu dosya her güvenlik-etkili PR'da güncellenir; çeyreklik güvenlik gözden geçirmesinin (bkz. `12-guvenlik-plani.md` §10) birincil girdisidir.*
