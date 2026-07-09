/** Yorum-listesi query normalizasyonu (docs/23 §11.3 — misafir yorum okuma). */

export const MAX_REVIEWS_LIMIT = 50;
export const DEFAULT_REVIEWS_LIMIT = 10;

/**
 * `/locations/:idOrSlug/reviews` limitini normalize eder: [1, 50], varsayılan 10.
 * Aralık dışı/geçersiz → varsayılana kelepçelenir (hata atmaz).
 */
export function parseReviewsLimit(raw: string | undefined): number {
  if (raw === undefined || raw.trim() === '') return DEFAULT_REVIEWS_LIMIT;
  const n = Number(raw);
  if (!Number.isInteger(n) || n < 1 || n > MAX_REVIEWS_LIMIT) return DEFAULT_REVIEWS_LIMIT;
  return n;
}
