# ADR-001 — Oturum (user_sessions) ve Idempotency Depoları

**Durum:** Kabul edildi (Faz 1, 6 Temmuz 2026) · **Bağlam:** 23 §3.2 ve 25-R10 bu kararı DDL fazına havale etmişti.

## Karar
Frozen içerik modeline (22) dokunmadan iki **işletim tablosu** eklendi:
- `user_sessions`: rotating refresh token deposu — token yalnız SHA-256 hash'iyle saklanır; `family_id` + `rotated_from_id` reuse tespiti ve aile iptali için; `revoked_at` / `reuse_detected_at` güvenlik olayları.
- `idempotency_keys`: **otorite DB'dir** (25-R10 kararı) — PK `(user_id, idem_key)`; `request_hash` aynı anahtarla farklı gövdeyi 422'ye düşürmek için; `response_status/body` tekrarında aynı yanıtı döndürmek için; Redis yalnız hızlı-yol önbelleğidir.

## Gerekçe
İkisi de içerik verisi değil oturum/istek altyapısıdır; 22 §1.9'daki "işletim tablosu" istisnası kapsamındadır. API sözleşmesi (23) değişmez.
