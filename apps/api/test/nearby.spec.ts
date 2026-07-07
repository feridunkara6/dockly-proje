import { AppProblem } from '../src/common/problem/problem';
import {
  DEFAULT_NEARBY_LIMIT,
  DEFAULT_RADIUS_NM,
  parseNearbyQuery,
} from '../src/modules/locations/domain/nearby';

function fieldCode(fn: () => unknown): string | undefined {
  try {
    fn();
  } catch (e) {
    if (e instanceof AppProblem) return e.errors?.[0]?.code;
    throw e;
  }
  throw new Error('beklenen istisna fırlatılmadı');
}

describe('parseNearbyQuery (docs/23 §9.6)', () => {
  it('geçerli lat/lon → varsayılan radius/limit', () => {
    expect(parseNearbyQuery({ lat: '36.75', lon: '28.93' })).toEqual({
      lat: 36.75,
      lon: 28.93,
      radiusNm: DEFAULT_RADIUS_NM,
      limit: DEFAULT_NEARBY_LIMIT,
    });
  });

  it('verilen radius/limit korunur', () => {
    expect(parseNearbyQuery({ lat: '36', lon: '28', radiusNm: '25', limit: '5' })).toEqual({
      lat: 36,
      lon: 28,
      radiusNm: 25,
      limit: 5,
    });
  });

  it('lat/lon zorunlu', () => {
    expect(fieldCode(() => parseNearbyQuery({ lon: '28' }))).toBe('lat-required');
    expect(fieldCode(() => parseNearbyQuery({ lat: '36' }))).toBe('lon-required');
    expect(fieldCode(() => parseNearbyQuery({ lat: '', lon: '28' }))).toBe('lat-required');
  });

  it('lat/lon aralık dışı', () => {
    expect(fieldCode(() => parseNearbyQuery({ lat: '91', lon: '28' }))).toBe('lat-range');
    expect(fieldCode(() => parseNearbyQuery({ lat: '36', lon: '181' }))).toBe('lon-range');
    expect(fieldCode(() => parseNearbyQuery({ lat: 'abc', lon: '28' }))).toBe('lat-range');
  });

  it('radiusNm (0,50] dışında → radius-range', () => {
    expect(fieldCode(() => parseNearbyQuery({ lat: '36', lon: '28', radiusNm: '0' }))).toBe('radius-range');
    expect(fieldCode(() => parseNearbyQuery({ lat: '36', lon: '28', radiusNm: '51' }))).toBe('radius-range');
  });

  it('limit tam sayı [1,50] değilse → limit-range', () => {
    expect(fieldCode(() => parseNearbyQuery({ lat: '36', lon: '28', limit: '0' }))).toBe('limit-range');
    expect(fieldCode(() => parseNearbyQuery({ lat: '36', lon: '28', limit: '51' }))).toBe('limit-range');
    expect(fieldCode(() => parseNearbyQuery({ lat: '36', lon: '28', limit: '2.5' }))).toBe('limit-range');
  });
});
