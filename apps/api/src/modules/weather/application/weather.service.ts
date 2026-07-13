import { Inject, Injectable } from '@nestjs/common';
import { AppProblem } from '../../../common/problem/problem';
import { MET_ATTRIBUTION, WeatherForecast } from '../domain/forecast.types';
import { transformMetForecast } from '../domain/met-transform';
import { WEATHER_PROVIDER, WeatherProvider } from '../domain/weather.provider';

/** Önbellek tazelik süresi — MET kullanım şartları önbellek İSTER; tahmin
 * modeli saatte birden sık güncellenmez, 1 saat hem nazik hem günceldir. */
const CACHE_TTL_MS = 60 * 60 * 1000;

/** Bellek koruması: en fazla bu kadar koordinat hücresi tutulur (LRU benzeri). */
const CACHE_MAX_ENTRIES = 500;

interface CacheEntry {
  forecast: WeatherForecast;
  expiresAt: number;
}

/**
 * Rüzgâr/hava tahmini servisi. Koordinat ~1 km hücresine yuvarlanır (0.01°) —
 * aynı koya bakan bin kullanıcı kaynağa TEK istek üretir. Kaynak çökerse ve
 * elde süresi geçmiş de olsa önbellek varsa o sunulur (denizde eski tahmin,
 * hiç tahminden iyidir; `fetchedAt` damgası istemcide dürüstçe gösterilir).
 */
@Injectable()
export class WeatherService {
  private readonly cache = new Map<string, CacheEntry>();

  constructor(@Inject(WEATHER_PROVIDER) private readonly provider: WeatherProvider) {}

  async forecast(lat: number, lon: number): Promise<WeatherForecast> {
    const rLat = Math.round(lat * 100) / 100;
    const rLon = Math.round(lon * 100) / 100;
    const key = `${rLat},${rLon}`;
    const now = Date.now();

    const hit = this.cache.get(key);
    if (hit && hit.expiresAt > now) return hit.forecast;

    try {
      const raw = await this.provider.fetchRaw(rLat, rLon);
      const points = transformMetForecast(raw);
      const forecast: WeatherForecast = {
        points,
        fetchedAt: new Date(now).toISOString(),
        attribution: MET_ATTRIBUTION,
      };
      this.store(key, { forecast, expiresAt: now + CACHE_TTL_MS });
      return forecast;
    } catch (err) {
      // Kaynak sorunu + elde (bayat da olsa) veri varsa: bayatı sun.
      if (hit) return hit.forecast;
      if (err instanceof AppProblem) throw err;
      throw new AppProblem('service-unavailable', 'Tahmin şu anda alınamıyor.');
    }
  }

  private store(key: string, entry: CacheEntry): void {
    // Basit sınır: kapasite dolunca en eski eklenen düşer (Map ekleme sıralı).
    if (this.cache.size >= CACHE_MAX_ENTRIES && !this.cache.has(key)) {
      const oldest = this.cache.keys().next().value;
      if (oldest !== undefined) this.cache.delete(oldest);
    }
    this.cache.delete(key); // yeniden ekleme → sıranın sonuna geçer
    this.cache.set(key, entry);
  }
}
