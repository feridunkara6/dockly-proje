import { AppProblem } from '../../../common/problem/problem';
import { ForecastPoint, msToKn } from './forecast.types';

/**
 * MET Norway Locationforecast 2.0 "compact" yanıtını sadeleştirir.
 * Doğruluk ilkesi: değer UYDURULMAZ — kaynakta olmayan alan null kalır;
 * bozuk/eksik zaman dilimleri sessizce atlanmaz, sayısal alanları eksikse
 * o dilim dahil edilmez (yanlış değer göstermekten iyidir).
 */

/** Varsayılan ufuk: 48 saat (detay kartı bugünden yarına gösterir). */
export const FORECAST_HORIZON_HOURS = 48;

interface MetTimeseriesEntry {
  time?: string;
  data?: {
    instant?: {
      details?: {
        wind_speed?: number;
        wind_speed_of_gust?: number;
        wind_from_direction?: number;
        air_temperature?: number;
      };
    };
    next_1_hours?: { summary?: { symbol_code?: string } };
    next_6_hours?: { summary?: { symbol_code?: string } };
  };
}

export function transformMetForecast(
  raw: unknown,
  horizonHours: number = FORECAST_HORIZON_HOURS,
): ForecastPoint[] {
  const series: MetTimeseriesEntry[] | undefined = (
    raw as {
      properties?: { timeseries?: MetTimeseriesEntry[] };
    }
  )?.properties?.timeseries;
  if (!Array.isArray(series) || series.length === 0) {
    throw new AppProblem('service-unavailable', 'Tahmin kaynağı beklenmeyen yanıt döndürdü.');
  }

  const points: ForecastPoint[] = [];
  const first = series[0]?.time ? Date.parse(series[0].time) : NaN;
  const horizonMs = horizonHours * 3600 * 1000;

  for (const entry of series) {
    const t = entry.time;
    const d = entry.data?.instant?.details;
    if (!t || !d) continue;
    if (
      typeof d.wind_speed !== 'number' ||
      typeof d.wind_from_direction !== 'number' ||
      typeof d.air_temperature !== 'number'
    ) {
      continue; // eksik sayısal alan → dilimi dahil ETME (uydurma yok)
    }
    if (!Number.isNaN(first) && Date.parse(t) - first > horizonMs) break;
    points.push({
      time: t,
      windKn: msToKn(d.wind_speed),
      gustKn: typeof d.wind_speed_of_gust === 'number' ? msToKn(d.wind_speed_of_gust) : null,
      windDirDeg: Math.round(d.wind_from_direction),
      tempC: Math.round(d.air_temperature * 10) / 10,
      symbol:
        entry.data?.next_1_hours?.summary?.symbol_code ??
        entry.data?.next_6_hours?.summary?.symbol_code ??
        null,
    });
  }

  if (points.length === 0) {
    throw new AppProblem('service-unavailable', 'Tahmin kaynağı kullanılabilir veri içermiyor.');
  }
  return points;
}

/** lat/lon query doğrulaması — hatalıysa 422 alan hatalarıyla. */
export function parseLatLon(
  rawLat: string | undefined,
  rawLon: string | undefined,
): {
  lat: number;
  lon: number;
} {
  const fail = (field: string, code: string, message: string): never => {
    throw new AppProblem('validation-error', 'Geçersiz koordinat.', [{ field, code, message }]);
  };
  if (rawLat === undefined || rawLat.trim() === '') fail('lat', 'lat-required', 'lat zorunlu');
  if (rawLon === undefined || rawLon.trim() === '') fail('lon', 'lon-required', 'lon zorunlu');
  const lat = Number(rawLat);
  const lon = Number(rawLon);
  if (!Number.isFinite(lat) || lat < -90 || lat > 90) {
    fail('lat', 'lat-range', 'lat -90..90 olmalı');
  }
  if (!Number.isFinite(lon) || lon < -180 || lon > 180) {
    fail('lon', 'lon-range', 'lon -180..180 olmalı');
  }
  return { lat, lon };
}
