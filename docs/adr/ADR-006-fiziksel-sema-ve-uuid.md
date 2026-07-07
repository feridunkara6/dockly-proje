# ADR-006 — Fiziksel Tek Şema ve UUID Üretimi

**Durum:** Kabul edildi (Faz 1).

## Karar 1 — Fiziksel tek şema (`public`)
22 §1.9'un açıkça izin verdiği sadeleştirme: mantıksal şema ayrımı (identity/geo/catalog/…) dokümantasyonda ve modül sınırlarında yaşar; fiziksel olarak tüm tablolar `public`'te. Gerekçe: Prisma multiSchema karmaşası ve migration basitliği (MVP önceliği #2). Fiziksel ayrıştırma gerektiğinde (Enterprise fazı, GRANT izolasyonu) tablo taşıma expand-contract ile yapılabilir.

## Karar 2 — UUID üretimi
22 §1.2 UUIDv7 ister; PostgreSQL 15'te yerleşik uuidv7 yok. Uygulama: **API üzerinden yaratılan satırlarda UUIDv7 uygulama tarafında üretilir** (Faz 2'de ilk INSERT'lerle birlikte `uuidv7` paketi eklenir); DB varsayılanı `gen_random_uuid()` (v4) yalnız doğrudan SQL/ops ekleri için emniyet ağıdır. PG18'e yükseltmede DB varsayılanı uuidv7'ye çevrilir. Index locality faydası ana yazma yolunda (API) korunur.
