import { Injectable, Logger } from '@nestjs/common';
import { AppProblem } from '../../../common/problem/problem';
import { WeatherProvider } from '../domain/weather.provider';

/**
 * MET Norway Locationforecast 2.0 sağlayıcısı.
 * Kullanım şartları (api.met.no/doc/TermsOfService):
 *  - Tanıtıcı User-Agent ZORUNLU (uygulama adı + iletişim) — aşağıda.
 *  - Önbellekleme zorunlu — WeatherService 1 saat önbellekler.
 *  - Atıf zorunlu (CC BY 4.0) — yanıt gövdesinde `attribution` taşınır.
 */
@Injectable()
export class MetNorwayProvider implements WeatherProvider {
  private readonly logger = new Logger(MetNorwayProvider.name);

  private static readonly BASE = 'https://api.met.no/weatherapi/locationforecast/2.0/compact';

  /// DİKKAT: HTTP başlık değerleri YALNIZ ASCII olabilir — Türkçe karakter
  /// (ş, ğ...) Node fetch'in isteği fırlatmadan reddetmesine yol açar
  /// (canlıda yaşandı: 503 'Tahmin kaynağına ulaşılamıyor'). ASCII kalmalı;
  /// weather.spec bunu testle kilitler.
  static readonly USER_AGENT = 'Moorira/1.0 https://moorira.com (maritime discovery app)';

  async fetchRaw(lat: number, lon: number): Promise<unknown> {
    const url = `${MetNorwayProvider.BASE}?lat=${lat}&lon=${lon}`;
    let res: Response;
    try {
      res = await fetch(url, {
        headers: { 'user-agent': MetNorwayProvider.USER_AGENT },
        signal: AbortSignal.timeout(8000),
      });
    } catch (err) {
      this.logger.warn(`MET erişilemedi: ${(err as Error).message}`);
      throw new AppProblem('service-unavailable', 'Tahmin kaynağına ulaşılamıyor.');
    }
    if (!res.ok) {
      this.logger.warn(`MET yanıtı: HTTP ${res.status}`);
      throw new AppProblem('service-unavailable', 'Tahmin kaynağı geçici olarak yanıt vermiyor.');
    }
    return res.json();
  }
}
