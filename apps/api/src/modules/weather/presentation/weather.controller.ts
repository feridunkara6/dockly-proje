import { Controller, Get, Header, Query } from '@nestjs/common';
import { WeatherService } from '../application/weather.service';
import { WeatherForecast } from '../domain/forecast.types';
import { parseLatLon } from '../domain/met-transform';

/**
 * Rüzgâr/hava tahmini ucu — istemci lokasyon detayında "Rüzgâr & Hava" kartını
 * bununla besler. Anonim erişilir; CDN 10 dk önbellekler (sunucu içi önbellek
 * zaten 1 saat — kaynak yükü ~sıfır). Kaynak: MET Norway (CC BY 4.0, atıf
 * yanıt gövdesinde).
 */
@Controller('weather')
export class WeatherController {
  constructor(private readonly weather: WeatherService) {}

  @Get()
  @Header('Cache-Control', 'public, max-age=600, s-maxage=600, stale-while-revalidate=1800')
  async forecast(@Query('lat') lat?: string, @Query('lon') lon?: string): Promise<WeatherForecast> {
    const q = parseLatLon(lat, lon);
    return this.weather.forecast(q.lat, q.lon);
  }
}
