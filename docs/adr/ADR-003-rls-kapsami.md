# ADR-003 — RLS Kapsamı

**Durum:** Kabul edildi (Faz 1) · **Bağlam:** 25-R3 — RDS Proxy/pooling altında oturum değişkeni taşımak kırılgan; RLS'in kâğıtta kalma riski.

## Karar (25'teki (a) seçeneği — dar kapsam)
1. Birincil yetki katmanı **uygulamadır** (guard + OwnershipPolicy + persistence `whereOwner` disiplini).
2. RLS yalnız **kritik sahiplik tablolarında** (user_sessions, boats, reservation_requests, favorites, notifications, user_profiles/settings/devices) ve yalnız `SET LOCAL app.user_id` taşıyan interactive transaction yollarında **savunma derinliği** olarak uygulanır.
3. RLS politikaları auth implementasyonuyla birlikte **Faz 2 migration'ında** gelir (0001_init'te yalnız işaret yorumu var). MVP'de RDS Proxy zaten yok (28) — `SET LOCAL` güvenlidir; Proxy geldiğinde (Scale fazı) bu ADR yeniden açılır.
4. Telafi kontrolü: persistence sorgularında sahiplik filtresi zorunluluğu code-review kontrol listesine eklendi.
