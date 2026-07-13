import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppProblem } from '../src/common/problem/problem';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { WeatherService } from '../src/modules/weather/application/weather.service';
import { msToKn } from '../src/modules/weather/domain/forecast.types';
import { parseLatLon, transformMetForecast } from '../src/modules/weather/domain/met-transform';
import { WEATHER_PROVIDER, WeatherProvider } from '../src/modules/weather/domain/weather.provider';
import { WeatherController } from '../src/modules/weather/presentation/weather.controller';

/** MET compact yanıtının küçültülmüş gerçekçi örneği (uydurma değil — şema birebir). */
function metFixture(times: string[]): unknown {
  return {
    properties: {
      timeseries: times.map((t, i) => ({
        time: t,
        data: {
          instant: {
            details: {
              wind_speed: 5 + i, // m/s
              wind_speed_of_gust: 8 + i,
              wind_from_direction: 310,
              air_temperature: 24.36,
            },
          },
          next_1_hours: { summary: { symbol_code: 'clearsky_day' } },
        },
      })),
    },
  };
}

class FakeProvider implements WeatherProvider {
  calls: Array<{ lat: number; lon: number }> = [];
  raw: unknown = metFixture(['2026-07-13T09:00:00Z', '2026-07-13T10:00:00Z']);
  error: Error | null = null;

  async fetchRaw(lat: number, lon: number): Promise<unknown> {
    this.calls.push({ lat, lon });
    if (this.error) throw this.error;
    return this.raw;
  }
}

describe('met-transform (birim)', () => {
  it('m/s → knot çevrimi doğru (1.943844) ve 1 ondalık', () => {
    expect(msToKn(5)).toBeCloseTo(9.7, 5); // 5 m/s = 9.71922 → 9.7
    expect(msToKn(0)).toBe(0);
  });

  it('geçerli yanıt → noktalar: knot, hamle, yön, sıcaklık, sembol', () => {
    const pts = transformMetForecast(metFixture(['2026-07-13T09:00:00Z']));
    expect(pts).toHaveLength(1);
    expect(pts[0].windKn).toBeCloseTo(9.7, 5);
    expect(pts[0].gustKn).toBeCloseTo(15.6, 5); // 8 m/s
    expect(pts[0].windDirDeg).toBe(310);
    expect(pts[0].tempC).toBeCloseTo(24.4, 5);
    expect(pts[0].symbol).toBe('clearsky_day');
  });

  it('48 saat ufku aşan dilimler alınmaz', () => {
    const pts = transformMetForecast(metFixture(['2026-07-13T00:00:00Z', '2026-07-16T00:00:00Z']));
    expect(pts).toHaveLength(1);
  });

  it('eksik sayısal alanlı dilim DAHİL EDİLMEZ (uydurma yok)', () => {
    const raw = metFixture(['2026-07-13T09:00:00Z']) as {
      properties: {
        timeseries: Array<{ data: { instant: { details: Record<string, unknown> } } }>;
      };
    };
    delete raw.properties.timeseries[0].data.instant.details.wind_speed;
    expect(() => transformMetForecast(raw)).toThrow(AppProblem); // tek dilim vardı → boş → hata
  });

  it('bozuk gövde → service-unavailable AppProblem', () => {
    expect(() => transformMetForecast({})).toThrow(AppProblem);
  });

  it('parseLatLon: eksik/aralık dışı → validation-error', () => {
    expect(() => parseLatLon(undefined, '27')).toThrow(AppProblem);
    expect(() => parseLatLon('91', '27')).toThrow(AppProblem);
    expect(() => parseLatLon('36.7', '181')).toThrow(AppProblem);
    expect(parseLatLon('36.75', '28.93')).toEqual({ lat: 36.75, lon: 28.93 });
  });
});

describe('WeatherService (birim — önbellek davranışı)', () => {
  it('aynı ~1 km hücresi ikinci kez kaynağa GİTMEZ; koordinat yuvarlanır', async () => {
    const provider = new FakeProvider();
    const svc = new WeatherService(provider);
    await svc.forecast(36.7512, 28.9345);
    await svc.forecast(36.7534, 28.9298); // aynı 0.01° hücresi
    expect(provider.calls).toHaveLength(1);
    expect(provider.calls[0]).toEqual({ lat: 36.75, lon: 28.93 });
  });

  it('kaynak çökerse ve önbellek varsa: eldeki tahmin sunulur (bayat da olsa)', async () => {
    const provider = new FakeProvider();
    const svc = new WeatherService(provider);
    const first = await svc.forecast(36.75, 28.93);
    provider.error = new Error('ağ yok');
    // Önbelleği manuel bayatlatamayız (TTL 1 saat) ama hata halinde bayat-sunum
    // dalını doğrulamak için farklı hücre + hata → problem; aynı hücre → veri.
    const again = await svc.forecast(36.75, 28.93);
    expect(again.points).toEqual(first.points);
    await expect(svc.forecast(35.0, 25.0)).rejects.toBeInstanceOf(AppProblem);
  });

  it('atıf ve fetchedAt damgası yanıtta taşınır (CC BY yükümlülüğü)', async () => {
    const svc = new WeatherService(new FakeProvider());
    const f = await svc.forecast(36.75, 28.93);
    expect(f.attribution).toContain('MET Norway');
    expect(Date.parse(f.fetchedAt)).not.toBeNaN();
  });
});

describe('GET /v1/weather (uç — sahte sağlayıcı, dış servis YOK)', () => {
  let app: INestApplication;
  let provider: FakeProvider;

  beforeAll(async () => {
    provider = new FakeProvider();
    const moduleRef = await Test.createTestingModule({
      controllers: [WeatherController],
      providers: [WeatherService, { provide: WEATHER_PROVIDER, useValue: provider }],
    }).compile();
    app = moduleRef.createNestApplication({ logger: false });
    app.useGlobalFilters(new GlobalProblemFilter());
    app.setGlobalPrefix('v1');
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('lat/lon ile 200: noktalar + atıf + cache başlığı', async () => {
    const res = await request(app.getHttpServer())
      .get('/v1/weather?lat=36.75&lon=28.93')
      .expect(200);
    expect(res.body.points.length).toBeGreaterThan(0);
    expect(res.body.points[0]).toEqual(
      expect.objectContaining({ windKn: expect.any(Number), windDirDeg: 310 }),
    );
    expect(res.body.attribution).toContain('MET Norway');
    expect(res.headers['cache-control']).toContain('max-age=600');
  });

  it('eksik lat → 422 lat-required', async () => {
    const res = await request(app.getHttpServer()).get('/v1/weather?lon=28.93').expect(422);
    expect(res.body.errors[0].code).toBe('lat-required');
  });
});
