import { AppProblem } from '../../../common/problem/problem';

/** Pin/cluster eşiği: zoom < 9 ⇒ cluster, zoom ≥ 9 ⇒ pin. (docs/23 §9.5
 * temeli 12 idi; pinler daha uzaktan görünsün diye önce 10'a, kullanıcı geri
 * bildirimiyle ("fazla yakınlaştırma gerekiyor") 9'a çekildi — UX kararı.
 * Güvenlik: PIN_CAP=500 > toplam yayınlı kayıt, kesilme riski yok.) */
export const MIN_PIN_ZOOM = 9;

/** Cluster yanıtı üst sınırı (koruma; en kalabalık balonlar korunur). */
export const CLUSTER_CAP = 1000;

/** Mapbox zoom üst sınırı (doğrulama). */
export const MAX_ZOOM = 22;

function fail(field: string, code: string, message: string): never {
  throw new AppProblem('validation-error', 'Geçersiz zoom parametresi.', [{ field, code, message }]);
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
 * cluster hücresi ≈ ÇEYREK karo (yarım karodan küçültüldü — balonlar daha uzak
 * zoom'da dağılsın, kullanıcı isteği; docs/13 §5.2 zoom-tabanlı ST_SnapToGrid).
 * Düşük zoom = büyük hücre = az balon; yüksek zoom = küçük hücre = çok balon.
 */
export function clusterCellSizeDeg(zoom: number): number {
  const z = Math.max(0, Math.min(zoom, MAX_ZOOM));
  return 360 / 2 ** (z + 2);
}
