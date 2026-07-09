# Dockly — Güvenlik Kanıt Haritası (security-evidence)

> **Amaç:** Güvenlik planındaki (`12-guvenlik-plani.md`) her kontrolün gerçek koddaki/testteki karşılığını tek yerde tutmak. Harici sızma testi ve çeyreklik güvenlik gözden geçirmesi bu tabloyu referans alır.
> **Mimari gerçeği:** NestJS (Node 22) + Prisma + kendi RS256 köprü JWT'si + AWS RDS (ADR-004). Supabase/Edge/PostgREST **kullanılmıyor** — ayrıntı: `12-guvenlik-plani.md` §0.
> **Son güncelleme:** 8 Temmuz 2026 (Faz A TAMAMLANDI · A.1–A.6) · **Durum kodları:** ✅ uygulandı · 🟠 kısmi · ❌ açık/planlı

---

## 1. Kimlik doğrulama & oturum

| Kontrol | Durum | Kanıt (dosya) |
|---|---|---|
| Firebase ID token doğrulama (JWKS, RS256 sabit alg, `aud`/`iss` pin, clock skew ±60s) | ✅ | `apps/api/src/infrastructure/firebase/firebase-token.verifier.ts` |
| Kendi köprü JWT'si RS256, alg sabit (alg-confusion/`none` kapalı), ayrı public/private key | ✅ | `apps/api/src/infrastructure/jwt/token.signer.ts` |
| Refresh token yalnız SHA-256 hash saklanır; rotasyonlu; reuse → aile iptali + uyarı | ✅ | `apps/api/src/modules/auth/application/session.service.ts` |
| Askıya alınmış hesapta refresh reddi | ✅ | `apps/api/src/modules/auth/persistence/prisma-user-account.repository.ts` |
| Refresh rotasyonu tek transaction (atomik revoke-and-claim) | ❌ | Denetim bulgusu S7 — Faz A/C |
| `jti` acil iptal (blacklist) — okuma FAIL-CLOSED (Redis kesintisi → 503) | ✅ (A.3) | `apps/api/src/infrastructure/redis/jti-blacklist.service.ts`, `test/jti-blacklist.spec.ts` |
| Misafir (anonim) yazma kısıtları (`@RequireAccount` guard → 403 guest-not-allowed) | ✅ (A.2) | `apps/api/src/common/guards/account.guard.ts`, `test/account.guard.spec.ts`, `test/guest-restrictions.e2e.spec.ts` |

## 2. Yetkilendirme & veri erişimi

| Kontrol | Durum | Kanıt |
|---|---|---|
| Mass-assignment koruması (`.strict()` beyaz liste; `role`/`status` client'tan asla) | ✅ | `apps/api/src/modules/users/presentation/users.controller.ts`, `boats` şeması |
| IDOR/BOLA: başkasının/yok kaydına **404** (enumerasyon engelli) | ✅ | `apps/api/src/modules/boats/application/boats.service.ts`, `boats.controller.ts` |
| RolesGuard / MinRole (rol hiyerarşisi) | 🟠 | `apps/api/src/common/guards/roles.guard.ts` — tanımlı ama hiçbir controller'da kullanılmıyor (admin modülü yok) |
| RLS savunma derinliği (DB katmanı) — kod aktif + FORCE + CI'da doğrulanıyor | 🟠 (A.4) | `withUserContext` (`prisma.service.ts`) app.user_id'yi set ediyor; `0003_rls_force/migration.sql` FORCE ekliyor; boats+users depoları bağlı; `rls_validation.sql` CI'da koşuyor. **CANLI için tek ops adımı bekliyor:** DATABASE_URL süperkullanıcı-OLMAYAN rol olmalı (bkz. bu dosya §7). |
| RLS eksik 3 tablo (reservation_requests, favorites, notifications) | ❌ | O özellikler henüz kodda yok; tabloları geldiğinde RLS eklenecek (denetim DB1, bakım listesi) |

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
| Auth ucunda rate limit (`POST /auth/sessions`) — Redis kesintisinde bellek-içi yedek (fail-closed) | ✅ (A.3) | `apps/api/src/infrastructure/redis/rate-limiter.service.ts`, `test/rate-limiter.spec.ts` |
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
| RLS doğrulama testi (`rls_validation.sql`) CI'da | ✅ (A.4) | `.github/workflows/ci.yml` — gerçek PostGIS'te, sahibi-olmayan rolle koşuyor |

---

## 7. RLS canlı aktivasyonu — kalan tek OPS adımı (koddan yapılamaz)

RLS'in kod ve CI tarafı hazır (§2). Staging/canlıda gerçekten devreye girmesi için **API veritabanına süperkullanıcı OLMAYAN bir rolle bağlanmalıdır** — süperkullanıcı ve BYPASSRLS rolleri FORCE'a rağmen RLS'i atlar. Adımlar (Faz A kapanışında rehberli yapılacak):
1. Veritabanında `dockly_app` rolü (LOGIN, süperkullanıcı değil) + gerekli tablo GRANT'leri.
2. `DATABASE_URL`'i bu rolle güncelle (Render/hosting env).
3. `rls_validation.sql` zaten bu rolü CI'da simüle ediyor → davranış doğrulanmış olur.

## Faz A tamamlanma özeti (8 Temmuz 2026)
A.1 doküman hizalama ✅ · A.2 misafir kısıtları ✅ · A.3 auth fail-closed (rate-limit yedek + jti 503) ✅ · A.4 RLS aktivasyonu (kod+FORCE+CI) 🟠 (ops rol adımı bekliyor) · A.5 .dockerignore + migration_lock ✅ · A.6 monitoring iskeleti (server_error log etiketi + Sentry seam + rehber) ✅

*Bu dosya her güvenlik-etkili PR'da güncellenir; çeyreklik güvenlik gözden geçirmesinin (bkz. `12-guvenlik-plani.md` §10) birincil girdisidir.*
