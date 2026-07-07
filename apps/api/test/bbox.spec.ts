import { AppProblem } from '../src/common/problem/problem';
import { MAX_BBOX_DEGREES, parseBbox, quantizeBbox } from '../src/modules/locations/domain/bbox';

/** Fırlatılan AppProblem'in alan kodunu yakalar. */
function fieldCode(fn: () => unknown): string | undefined {
  try {
    fn();
  } catch (e) {
    if (e instanceof AppProblem) return e.errors?.[0]?.code;
    throw e;
  }
  throw new Error('beklenen istisna fırlatılmadı');
}

describe('parseBbox (docs/23 §9.5)', () => {
  it('geçerli bbox → sayısal kenarlar', () => {
    expect(parseBbox('27.10,36.55,28.35,37.05')).toEqual({
      minLon: 27.1,
      minLat: 36.55,
      maxLon: 28.35,
      maxLat: 37.05,
    });
  });

  it('eksik bbox → bbox-required', () => {
    expect(fieldCode(() => parseBbox(undefined))).toBe('bbox-required');
    expect(fieldCode(() => parseBbox(''))).toBe('bbox-required');
  });

  it('4 olmayan değer → bbox-invalid', () => {
    expect(fieldCode(() => parseBbox('1,2,3'))).toBe('bbox-invalid');
    expect(fieldCode(() => parseBbox('1,2,3,4,5'))).toBe('bbox-invalid');
  });

  it('sayısal olmayan → bbox-invalid', () => {
    expect(fieldCode(() => parseBbox('a,2,3,4'))).toBe('bbox-invalid');
  });

  it('aralık dışı lon/lat → bbox-invalid', () => {
    expect(fieldCode(() => parseBbox('-181,36,28,37'))).toBe('bbox-invalid');
    expect(fieldCode(() => parseBbox('27,-91,28,37'))).toBe('bbox-invalid');
  });

  it('min >= max → bbox-invalid', () => {
    expect(fieldCode(() => parseBbox('28,37,27,36'))).toBe('bbox-invalid');
    expect(fieldCode(() => parseBbox('27,37,28,37'))).toBe('bbox-invalid');
  });

  it(`tek kenar > ${MAX_BBOX_DEGREES}° → bbox-too-large`, () => {
    expect(fieldCode(() => parseBbox('20,36,26.1,37'))).toBe('bbox-too-large');
    expect(fieldCode(() => parseBbox('27,30,28,36.1'))).toBe('bbox-too-large');
  });

  it('tam sınır (5°) kabul edilir', () => {
    expect(parseBbox('20,30,25,35')).toEqual({ minLon: 20, minLat: 30, maxLon: 25, maxLat: 35 });
  });
});

describe('quantizeBbox (%1 grid, dışa genişletir)', () => {
  it('grid hizalı bbox değişmez', () => {
    // span=1.0 → cell=0.01; kenarlar zaten 0.01 katı
    expect(quantizeBbox({ minLon: 27.0, minLat: 36.5, maxLon: 28.0, maxLat: 37.5 })).toEqual({
      minLon: 27.0,
      minLat: 36.5,
      maxLon: 28.0,
      maxLat: 37.5,
    });
  });

  it('kuantalanmış kutu orijinali kapsar (pin düşmez)', () => {
    const b = { minLon: 27.003, minLat: 36.504, maxLon: 27.997, maxLat: 37.496 };
    const q = quantizeBbox(b);
    expect(q.minLon).toBeLessThanOrEqual(b.minLon);
    expect(q.minLat).toBeLessThanOrEqual(b.minLat);
    expect(q.maxLon).toBeGreaterThanOrEqual(b.maxLon);
    expect(q.maxLat).toBeGreaterThanOrEqual(b.maxLat);
  });

  it('genişleme bir hücreden küçük kalır', () => {
    const b = { minLon: 27.003, minLat: 36.504, maxLon: 27.997, maxLat: 37.496 };
    const cell = Math.max(b.maxLon - b.minLon, b.maxLat - b.minLat) * 0.01;
    const q = quantizeBbox(b);
    expect(b.minLon - q.minLon).toBeLessThan(cell);
    expect(q.maxLon - b.maxLon).toBeLessThan(cell);
  });
});
