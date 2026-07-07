import { AppProblem } from '../../../common/problem/problem';

/** Pin/cluster eşiği (docs/23 §9.5): zoom < 12 ⇒ cluster, zoom ≥ 12 ⇒ pin. */
export const MIN_PIN_ZOOM = 12;

/** Cluster yanıtı üst sınırı (koruma; en kalabalık balonlar korunur). */
export const CLUSTER_CAP = 1000;

/** Mapbox zoom üst sınırı (doğrulama). */
export const MAX_ZOOM = 22;

function fail(field: string, code: string, message: string): never {
  throw new AppProblem('validation-error', 'Geçersiz zoom parametresi.', [
    { field, code, message },
  ]);
}

/**
 * `zoom` query'sini ayrıştırır (opsiyonel). Yok/boş → undefined (pin modu
 * varsayılanı). Verilmişse 0..22 tam sayı olmalı; değilse `zoom-invalid` (422).
 */
export function parseZoom(raw: string | undefined): number | undefined {
  if (raw === undefined || raw.trim() === '') return undefined;
  const n = Number(raw);
  if (!Number.isInteger(n) || n < 0 || n > MAX_ZOOM) {
    fail('zoom', 'zoom-invalid', `zoom 0..${MAX_ZOOM} tam sayı olmalı`);
  }
  return n;
}

/**
 * Zoom → grid hücre boyutu (derece). Mercator: dünya 360°'yi 2^zoom karoya böler;
 * cluster hücresi ≈ yarım karo (docs/13 §5.2 zoom-tabanlı ST_SnapToGrid). Düşük
 * zoom = büyük hücre = az balon; yüksek zoom = küçük hücre = çok balon.
 */
export function clusterCellSizeDeg(zoom: number): number {
  const z = Math.max(0, Math.min(zoom, MAX_ZOOM));
  return 360 / 2 ** (z + 1);
}
