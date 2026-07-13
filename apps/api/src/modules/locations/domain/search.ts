/** Metinle liman arama normalizasyonu (docs/23 §9 — S-07 arama rayı). */

export const MIN_SEARCH_LEN = 2;
export const MAX_SEARCH_LIMIT = 50;
export const DEFAULT_SEARCH_LIMIT = 20;

/** Doğrulanmış/normalize edilmiş arama query'si. */
export interface SearchQuery {
  /** Kırpılmış, iç boşlukları tekilleştirilmiş arama metni. */
  q: string;
  limit: number;
  /** q, arama için anlamlı uzunlukta mı (>= MIN_SEARCH_LEN). */
  searchable: boolean;
}

/** Ham query değeri → sayı (boş/yok = undefined; sayı değilse NaN). */
function num(raw: string | undefined): number | undefined {
  if (raw === undefined || raw.trim() === '') return undefined;
  const n = Number(raw);
  return Number.isFinite(n) ? n : NaN;
}

/**
 * `/locations/search` query'sini normalize eder: `q` kırpılır ve iç boşluklar
 * tekilleştirilir; `limit` [1, 50], varsayılan 20 — aralık dışı/geçersiz limit
 * hata atmaz, varsayılana kelepçelenir (arama UX'i akıcı kalsın). `searchable`,
 * q'nun anlamlı uzunlukta olup olmadığını belirtir (kısa q → boş sonuç, 422 değil).
 */
export function normalizeSearch(raw: { q?: string; limit?: string }): SearchQuery {
  const q = (raw.q ?? '').trim().replace(/\s+/g, ' ');
  const rawLimit = num(raw.limit);
  const limit =
    rawLimit !== undefined &&
    Number.isInteger(rawLimit) &&
    rawLimit >= 1 &&
    rawLimit <= MAX_SEARCH_LIMIT
      ? rawLimit
      : DEFAULT_SEARCH_LIMIT;
  return { q, limit, searchable: q.length >= MIN_SEARCH_LEN };
}

/** Olanak filtresi üst sınırı (S-07 gelişmiş arama — "yakıtı olan" gibi). */
export const MAX_AMENITY_FILTERS = 8;

const AMENITY_CODE_RE = /^[a-z][a-z0-9_]{1,31}$/;

/**
 * Olanak kodu filtrelerini süzer: kırpılır+küçültülür, biçim dışı atılır
 * (yalnız [a-z0-9_] — SQL'e dizi parametresi gitse de savunma katmanı),
 * tekilleştirilir ve en çok MAX_AMENITY_FILTERS tutulur. Tanımsız kod hata
 * değildir — hiçbir kayıtla eşleşmez, boş sonuç döner (arama UX'i akıcı kalır).
 */
export function sanitizeAmenities(raw: string[] | undefined): string[] {
  if (!raw || raw.length === 0) return [];
  const seen = new Set<string>();
  for (const c of raw) {
    const v = c.trim().toLowerCase();
    if (AMENITY_CODE_RE.test(v)) seen.add(v);
    if (seen.size >= MAX_AMENITY_FILTERS) break;
  }
  return [...seen];
}
