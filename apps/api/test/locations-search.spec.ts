import {
  DEFAULT_SEARCH_LIMIT,
  MAX_AMENITY_FILTERS,
  MIN_SEARCH_LEN,
  normalizeSearch,
  sanitizeAmenities,
} from '../src/modules/locations/domain/search';

describe('normalizeSearch (S-07 arama query normalizasyonu)', () => {
  it('q kırpar ve iç boşlukları tekilleştirir', () => {
    expect(normalizeSearch({ q: '  D-Marin   Göcek ' }).q).toBe('D-Marin Göcek');
  });

  it('boş/yok q → boş metin, searchable false', () => {
    expect(normalizeSearch({}).q).toBe('');
    expect(normalizeSearch({}).searchable).toBe(false);
    expect(normalizeSearch({ q: '   ' }).searchable).toBe(false);
  });

  it(`kısa q (< ${MIN_SEARCH_LEN}) → searchable false`, () => {
    expect(normalizeSearch({ q: 'a' }).searchable).toBe(false);
  });

  it('yeterli q → searchable true', () => {
    expect(normalizeSearch({ q: 'göcek' }).searchable).toBe(true);
  });

  it('limit yok/geçersiz/aralık-dışı → varsayılana kelepçelenir', () => {
    expect(normalizeSearch({ q: 'göcek' }).limit).toBe(DEFAULT_SEARCH_LIMIT);
    expect(normalizeSearch({ q: 'göcek', limit: '0' }).limit).toBe(DEFAULT_SEARCH_LIMIT);
    expect(normalizeSearch({ q: 'göcek', limit: '999' }).limit).toBe(DEFAULT_SEARCH_LIMIT);
    expect(normalizeSearch({ q: 'göcek', limit: 'abc' }).limit).toBe(DEFAULT_SEARCH_LIMIT);
    expect(normalizeSearch({ q: 'göcek', limit: '2.5' }).limit).toBe(DEFAULT_SEARCH_LIMIT);
  });

  it('geçerli limit korunur', () => {
    expect(normalizeSearch({ q: 'göcek', limit: '5' }).limit).toBe(5);
    expect(normalizeSearch({ q: 'göcek', limit: '50' }).limit).toBe(50);
  });
});

describe('sanitizeAmenities (S-07 gelişmiş arama — olanak filtreleri)', () => {
  it('kırpar, küçültür, tekilleştirir', () => {
    expect(sanitizeAmenities([' Fuel ', 'WATER', 'fuel'])).toEqual(['fuel', 'water']);
  });

  it('biçim dışı kodlar atılır (SQL savunma katmanı)', () => {
    expect(sanitizeAmenities(["fuel'; DROP TABLE x;--", 'a', '', 'wc'])).toEqual(['wc']);
  });

  it('boş/yok → boş liste', () => {
    expect(sanitizeAmenities(undefined)).toEqual([]);
    expect(sanitizeAmenities([])).toEqual([]);
  });

  it(`en çok ${MAX_AMENITY_FILTERS} filtre tutulur`, () => {
    const many = Array.from({ length: 20 }, (_, i) => `code_${i}`);
    expect(sanitizeAmenities(many)).toHaveLength(MAX_AMENITY_FILTERS);
  });
});
