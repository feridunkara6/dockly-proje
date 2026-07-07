# Dockly — Teknik Dokümantasyon

> Tekne sahipleri için Türkiye'nin tüm marina, iskele ve bağlama noktalarını tek uygulamada toplayan mobil platform.
> **v1 = Keşif + Topluluk + Rezervasyon Talebi.** Kod yazımı bu dokümantasyon seti onaylanmadan başlamaz.

## Okuma Sırası

**Önce bunu oku:** [`00-foundation.md`](00-foundation.md) — tek doğruluk kaynağı (enum'lar, tablolar, API yüzeyi, design token'ları, ekran ID'leri). Tüm dokümanlar buna bağlıdır.

### Ürün
| # | Doküman | İçerik |
|---|---|---|
| 01 | [PRD](01-prd.md) | Vizyon, personalar, kapsam, metrikler, rekabet |
| 06 | [Kullanıcı Akışları](06-kullanici-akislari.md) | 12 akış, Mermaid diyagramlı |
| 07 | [Ekran Listesi](07-ekran-listesi.md) | S-01…S-23 + A-01…A-08 envanteri |
| 21 | [Ekran Tasarımları](21-ekran-tasarimlari.md) | Wireframe'ler, animasyonlar, geçişler, bottom nav, arama UX |

### Tasarım
| # | Doküman | İçerik |
|---|---|---|
| 08 | [UI/UX Akışları](08-uiux-akislari.md) | Etkileşim tasarımı, bottom sheet, hero transition |
| 09 | [Design System](09-design-system.md) | Renk, tipografi, spacing, motion, glassmorphism |
| 10 | [Component Library](10-component-library.md) | 20+ Dockly component API'si |
| — | [`../design/dockly-design-system.html`](../design/dockly-design-system.html) | İnteraktif görsel referans (light/dark) |

### Mimari & Backend
| # | Doküman | İçerik |
|---|---|---|
| 02 | [Teknik Mimari](02-teknik-mimari.md) | C4 diyagramları, Clean Architecture, Riverpod, offline cache |
| 03 | [Klasör Yapısı](03-klasor-yapisi.md) | Monorepo, feature-first ağaç, import kuralları |
| 04 | [Veritabanı Tasarımı](04-veritabani-tasarimi.md) | ER diagram, CREATE TABLE'lar, index, trigger, migration |
| 22 | [Veritabanı Mimarisi v2](22-veritabani-mimarisi.md) | 🧊 **FROZEN v2.0** — Lead DBA: 5-10 yıllık model, i18n, geo hiyerarşisi, genişleme planı; 04'ü üstün kılar |
| 05 | [API Dokümantasyonu](05-api-dokumantasyonu.md) | /v1 tüm endpoint spesifikasyonları (MVP taslağı) |
| 23 | [API Mimarisi](23-api-mimarisi.md) | Lead API Architect: kanonik API sözleşmesi (Frozen DB v2 üzerine) — **05'i üstün kılar** |
| 11 | [Backend Mimarisi](11-backend-mimarisi.md) | Supabase, RLS, Edge Functions, S3/CDN |

### Kalite & Operasyon
| # | Doküman | İçerik |
|---|---|---|
| 12 | [Güvenlik Planı](12-guvenlik-plani.md) | Auth, RLS, KVKK/GDPR, OWASP, incident response |
| 13 | [Ölçeklenebilirlik](13-olceklenebilirlik-plani.md) | 10K→1M kullanıcı, maliyet projeksiyonu |
| 14 | [Performans Planı](14-performans-plani.md) | Bütçeler, harita/görsel/ağ optimizasyonu |
| 15 | [Test Stratejisi](15-test-stratejisi.md) | Piramit, golden testler, pgTAP, beta programı |
| 16 | [Deployment](16-deployment-stratejisi.md) | Ortamlar, CI/CD, staged rollout, rollback |
| 17 | [Git Branch Stratejisi](17-git-branch-stratejisi.md) | GitHub Flow, Conventional Commits, PR kuralları |

### Plan
| # | Doküman | İçerik |
|---|---|---|
| 18 | [Roadmap](18-roadmap.md) | v1 (Kasım 2026 soft launch) → v4 (Avrupa) |
| 19 | [Sprint Planı](19-sprint-plani.md) | 12 sprint, DCK-xxx story'ler, 13 Tem 2026 başlangıç |
| 20 | [MVP Geliştirme Planı](20-mvp-gelistirme-plani.md) | Fazlar, veri operasyonu, launch kriterleri, risk kaydı |

## Kurallar
1. Adlandırma çelişkisinde `00-foundation.md` kazanır.
2. v1 Hard Exclusions (AI, rota, hava durumu, AIS, Garmin, marina paneli, online ödeme, canlı müsaitlik, gerçek rezervasyon) hiçbir dokümanda kapsam içine alınamaz.
3. Doküman güncellemeleri PR ile yapılır (`docs/` path'i, bkz. 17-git-branch-stratejisi.md).
