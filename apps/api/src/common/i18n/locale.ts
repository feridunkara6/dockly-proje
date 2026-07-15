/** Desteklenen içerik dilleri (docs/00 §1: v1 TR, EN gün-1 hazır).
 *  2026-07 dil desteği: uygulama arayüzüyle birlikte ES ve RU içerik de
 *  sunulur; çeviriler location_i18n'e seed ile akar (i18n_*.json). */
export const SUPPORTED_LOCALES = ['tr', 'en', 'es', 'ru'] as const;
export type SupportedLocale = (typeof SUPPORTED_LOCALES)[number];
export const DEFAULT_LOCALE: SupportedLocale = 'tr';

/**
 * Accept-Language → desteklenen locale (docs/23 §7). Basit birincil-dil eşlemesi;
 * `q` ağırlıkları bu sürümde sırayı bozmaz (ilk desteklenen kazanır).
 */
export function resolveLocale(acceptLanguage: string | undefined): SupportedLocale {
  if (!acceptLanguage) return DEFAULT_LOCALE;
  const tags = acceptLanguage
    .split(',')
    .map((part) => part.split(';')[0].trim().toLowerCase())
    .filter((tag) => tag.length > 0);
  for (const tag of tags) {
    const primary = tag.split('-')[0];
    const match = SUPPORTED_LOCALES.find((locale) => locale === primary);
    if (match) return match;
  }
  return DEFAULT_LOCALE;
}

/**
 * Çeviri listesinden locale'e göre etiket seçer; fallback zinciri (docs/23 §7):
 * istenen → 'en' → ilk mevcut → kod.
 */
export function pickLabel(
  translations: ReadonlyArray<{ locale: string; name: string }>,
  locale: string,
  fallbackCode: string,
): string {
  return (
    translations.find((t) => t.locale === locale)?.name ??
    translations.find((t) => t.locale === 'en')?.name ??
    translations[0]?.name ??
    fallbackCode
  );
}
