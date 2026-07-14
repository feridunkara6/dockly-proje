import { AppProblem } from '../src/common/problem/problem';
import { MAX_ZOOM, clusterCellSizeDeg, parseZoom } from '../src/modules/locations/domain/cluster';

function fieldCode(fn: () => unknown): string | undefined {
  try {
    fn();
  } catch (e) {
    if (e instanceof AppProblem) return e.errors?.[0]?.code;
    throw e;
  }
  throw new Error('beklenen istisna fırlatılmadı');
}

describe('parseZoom (docs/23 §9.5)', () => {
  it('yok/boş → undefined (pin modu varsayılanı)', () => {
    expect(parseZoom(undefined)).toBeUndefined();
    expect(parseZoom('')).toBeUndefined();
  });

  it('geçerli tam sayı zoom', () => {
    expect(parseZoom('0')).toBe(0);
    expect(parseZoom('13')).toBe(13);
    expect(parseZoom(String(MAX_ZOOM))).toBe(MAX_ZOOM);
  });

  it('geçersiz zoom → zoom-invalid', () => {
    expect(fieldCode(() => parseZoom('abc'))).toBe('zoom-invalid');
    expect(fieldCode(() => parseZoom('2.5'))).toBe('zoom-invalid');
    expect(fieldCode(() => parseZoom('-1'))).toBe('zoom-invalid');
    expect(fieldCode(() => parseZoom(String(MAX_ZOOM + 1)))).toBe('zoom-invalid');
  });
});

describe('clusterCellSizeDeg', () => {
  it('pozitif ve zoom arttıkça küçülür', () => {
    expect(clusterCellSizeDeg(5)).toBeGreaterThan(0);
    expect(clusterCellSizeDeg(5)).toBeGreaterThan(clusterCellSizeDeg(11));
    expect(clusterCellSizeDeg(0)).toBeGreaterThan(clusterCellSizeDeg(5));
  });

  it('zoom 0 → 90° (çeyrek karo — balonlar daha uzaktan dağılır)', () => {
    expect(clusterCellSizeDeg(0)).toBe(90);
  });
});
