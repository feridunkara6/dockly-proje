import { AppProblem } from '../../../common/problem/problem';

/** Deniz mili → metre (PostGIS ST_DWithin metre ister). */
export const NM_TO_M = 1852;

export const MAX_RADIUS_NM = 50; // docs/23 §9.6 tavanı
export const DEFAULT_RADIUS_NM = 10; // docs/23 §9.6 örneği
export const MAX_NEARBY_LIMIT = 50;
export const DEFAULT_NEARBY_LIMIT = 20;

/** Doğrulanmış nearby query (deniz mili cinsinden yarıçap). */
export interface NearbyQuery {
  lat: number;
  lon: number;
  radiusNm: number;
  limit: number;
}

/** Ham query değeri → sayı (boş/yok = undefined). */
function num(raw: string | undefined): number | undefined {
  if (raw === undefined || raw.trim() === '') return undefined;
  const n = Number(raw);
  return Number.isFinite(n) ? n : NaN;
}

function fail(field: string, code: string, message: string): never {
  throw new AppProblem('validation-error', 'Geçersiz nearby parametresi.', [{ field, code, message }]);
}

/**
 * `/locations/nearby` query'sini ayrıştırır ve doğrular (docs/23 §9.6):
 * lat/lon zorunlu ve aralıkta; radiusNm ∈ (0, 50] varsayılan 10; limit ∈ [1,50]
 * varsayılan 20. Hatada `validation-error` (422).
 */
export function parseNearbyQuery(raw: {
  lat?: string;
  lon?: string;
  radiusNm?: string;
  limit?: string;
}): NearbyQuery {
  const lat = num(raw.lat);
  if (lat === undefined) fail('lat', 'lat-required', 'lat parametresi zorunlu');
  if (Number.isNaN(lat) || (lat as number) < -90 || (lat as number) > 90) {
    fail('lat', 'lat-range', 'lat -90..90 aralığında olmalı');
  }

  const lon = num(raw.lon);
  if (lon === undefined) fail('lon', 'lon-required', 'lon parametresi zorunlu');
  if (Number.isNaN(lon) || (lon as number) < -180 || (lon as number) > 180) {
    fail('lon', 'lon-range', 'lon -180..180 aralığında olmalı');
  }

  let radiusNm = num(raw.radiusNm);
  if (radiusNm === undefined) {
    radiusNm = DEFAULT_RADIUS_NM;
  } else if (Number.isNaN(radiusNm) || radiusNm <= 0 || radiusNm > MAX_RADIUS_NM) {
    fail('radiusNm', 'radius-range', `radiusNm (0, ${MAX_RADIUS_NM}] aralığında olmalı`);
  }

  let limit = num(raw.limit);
  if (limit === undefined) {
    limit = DEFAULT_NEARBY_LIMIT;
  } else if (!Number.isInteger(limit) || limit <= 0 || limit > MAX_NEARBY_LIMIT) {
    fail('limit', 'limit-range', `limit tam sayı ve [1, ${MAX_NEARBY_LIMIT}] aralığında olmalı`);
  }

  return { lat: lat as number, lon: lon as number, radiusNm, limit };
}
