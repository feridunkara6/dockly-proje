import { AppProblem } from '../../../common/problem/problem';
import { Bbox } from './location.types';

/** bbox tek kenar tavanı — alan > 5°×5° reddedilir (docs/23 §9.5). */
export const MAX_BBOX_DEGREES = 5;

/** Pin modu sonuç tavanı; aşılırsa `truncated=true` (docs/23 §9.5). */
export const PIN_CAP = 500;

/** Koordinat kuantalama grid oranı — span'in %1'i (docs/23 §9.5 → CDN cache hit). */
export const QUANTIZE_GRID_FRACTION = 0.01;

/** Kayan nokta tozunu temizler (≈0.1 m çözünürlük cache/sorgu için yeterli). */
function roundTo(value: number, decimals = 6): number {
  const factor = 10 ** decimals;
  return Math.round(value * factor) / factor;
}

function fail(field: string, code: string, message: string): never {
  throw new AppProblem('validation-error', 'Geçersiz bbox parametresi.', [{ field, code, message }]);
}

/**
 * `bbox` ham query string'ini ayrıştırır ve doğrular (docs/23 §9.5):
 * 4 sonlu sayı, geçerli lon/lat aralığı, min < max, tek kenar ≤ 5°.
 * Hatada `validation-error` (422) fırlatır; `bbox-too-large` alan koduyla ayırt edilir.
 */
export function parseBbox(raw: string | undefined): Bbox {
  if (!raw) fail('bbox', 'bbox-required', 'bbox parametresi zorunlu (minLon,minLat,maxLon,maxLat)');

  const parts = raw.split(',').map((p) => p.trim());
  if (parts.length !== 4) {
    fail('bbox', 'bbox-invalid', 'bbox tam olarak 4 değer içermeli: minLon,minLat,maxLon,maxLat');
  }

  const nums = parts.map(Number);
  if (nums.some((n) => !Number.isFinite(n))) {
    fail('bbox', 'bbox-invalid', 'bbox değerleri sayısal olmalı');
  }

  const [minLon, minLat, maxLon, maxLat] = nums;
  if (minLon < -180 || maxLon > 180 || minLon > 180 || maxLon < -180) {
    fail('bbox', 'bbox-invalid', 'boylam (lon) -180..180 aralığında olmalı');
  }
  if (minLat < -90 || maxLat > 90 || minLat > 90 || maxLat < -90) {
    fail('bbox', 'bbox-invalid', 'enlem (lat) -90..90 aralığında olmalı');
  }
  if (minLon >= maxLon || minLat >= maxLat) {
    fail('bbox', 'bbox-invalid', 'minLon<maxLon ve minLat<maxLat olmalı');
  }
  if (maxLon - minLon > MAX_BBOX_DEGREES || maxLat - minLat > MAX_BBOX_DEGREES) {
    fail('bbox', 'bbox-too-large', `bbox tek kenarı ${MAX_BBOX_DEGREES}° dereceyi aşamaz`);
  }

  return { minLon, minLat, maxLon, maxLat };
}

/**
 * bbox'ı mutlak %1 grid'e hizalar (docs/23 §9.5). Dışa doğru genişletir
 * (min aşağı, max yukarı) — böylece görünürdeki hiçbir pin düşmez ve küçük
 * kaydırmalarda cache anahtarı sabit kalır.
 */
export function quantizeBbox(b: Bbox): Bbox {
  const span = Math.max(b.maxLon - b.minLon, b.maxLat - b.minLat);
  const cell = span * QUANTIZE_GRID_FRACTION;
  if (cell <= 0) return b;
  const snapDown = (v: number): number => roundTo(Math.floor(v / cell) * cell);
  const snapUp = (v: number): number => roundTo(Math.ceil(v / cell) * cell);
  return {
    minLon: snapDown(b.minLon),
    minLat: snapDown(b.minLat),
    maxLon: snapUp(b.maxLon),
    maxLat: snapUp(b.maxLat),
  };
}
