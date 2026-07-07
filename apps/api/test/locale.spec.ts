import { pickLabel, resolveLocale } from '../src/common/i18n/locale';

describe('resolveLocale (docs/23 §7)', () => {
  it('desteklenen birincil dili seçer', () => {
    expect(resolveLocale('tr')).toBe('tr');
    expect(resolveLocale('en-US,en;q=0.9')).toBe('en');
    expect(resolveLocale('tr-TR,tr;q=0.9,en;q=0.8')).toBe('tr');
  });

  it('desteklenmeyen dil → varsayılan tr', () => {
    expect(resolveLocale('de-DE,de;q=0.9')).toBe('tr');
    expect(resolveLocale('fr')).toBe('tr');
  });

  it('boş/eksik header → varsayılan tr', () => {
    expect(resolveLocale(undefined)).toBe('tr');
    expect(resolveLocale('')).toBe('tr');
  });

  it('ilk desteklenen kazanır (de sonra en)', () => {
    expect(resolveLocale('de,en;q=0.5')).toBe('en');
  });
});

describe('pickLabel (fallback zinciri)', () => {
  const translations = [
    { locale: 'tr', name: 'Elektrik' },
    { locale: 'en', name: 'Electricity' },
  ];

  it('istenen locale bulunursa onu döner', () => {
    expect(pickLabel(translations, 'tr', 'electricity')).toBe('Elektrik');
    expect(pickLabel(translations, 'en', 'electricity')).toBe('Electricity');
  });

  it('istenen yoksa en fallback', () => {
    expect(pickLabel(translations, 'de', 'electricity')).toBe('Electricity');
  });

  it('en de yoksa ilk çeviri', () => {
    expect(pickLabel([{ locale: 'tr', name: 'Yakıt' }], 'de', 'fuel')).toBe('Yakıt');
  });

  it('hiç çeviri yoksa kod', () => {
    expect(pickLabel([], 'tr', 'electric')).toBe('electric');
  });
});
