# ADR-004 — Veritabanı Barındırma: AWS RDS

**Durum:** Kabul edildi (Faz 1) · **Bağlam:** 24 §0 öneriyi vermişti; 25-R4/ADR-004 nihai kararı bekletiyordu.

## Karar
PostgreSQL **AWS RDS** (eu-central-1, PG15+PostGIS, MVP'de Single-AZ db.t4g.small — 28 §1) üzerinde barındırılır; Supabase managed seçeneği kapatıldı.

## Gerekçe
Tek bulut/tek fatura/tek IAM (28'in konsolidasyon ilkesi); NestJS+Prisma sonrası Supabase'in kalan katma değeri (PostgREST/Edge) kullanılmıyor; VPC-içi gecikme ve SG bütünlüğü. Maliyet farkı MVP boyutunda ihmal edilebilir (28 §10).
