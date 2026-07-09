import {
  DEFAULT_SEARCH_LIMIT,
  MIN_SEARCH_LEN,
  normalizeSearch,
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
