import { Controller, Get, Header, Headers } from '@nestjs/common';
import { CatalogService } from '../application/catalog.service';
import { resolveLocale } from '../../../common/i18n/locale';
import {
  AmenityItem,
  BoatTypeItem,
  EngineTypeItem,
  LocationTypeItem,
  ServiceItem,
} from '../domain/lookup.types';

/**
 * Sözlük uçları (docs/23 §10 #8) — anonim, uzun cache'lenebilir (docs/23 §17).
 * `Vary: Accept-Language` ile CDN doğru locale'i ayrı cache'ler.
 */
@Controller()
export class CatalogController {
  constructor(private readonly catalog: CatalogService) {}

  @Get('location-types')
  @Header('Cache-Control', 'public, max-age=3600, s-maxage=86400, stale-while-revalidate=86400')
  @Header('Vary', 'Accept-Language')
  async locationTypes(
    @Headers('accept-language') acceptLanguage?: string,
  ): Promise<{ data: LocationTypeItem[] }> {
    return { data: await this.catalog.locationTypes(resolveLocale(acceptLanguage)) };
  }

  @Get('amenities')
  @Header('Cache-Control', 'public, max-age=3600, s-maxage=86400, stale-while-revalidate=86400')
  @Header('Vary', 'Accept-Language')
  async amenities(
    @Headers('accept-language') acceptLanguage?: string,
  ): Promise<{ data: AmenityItem[] }> {
    return { data: await this.catalog.amenities(resolveLocale(acceptLanguage)) };
  }

  @Get('services')
  @Header('Cache-Control', 'public, max-age=3600, s-maxage=86400, stale-while-revalidate=86400')
  @Header('Vary', 'Accept-Language')
  async services(
    @Headers('accept-language') acceptLanguage?: string,
  ): Promise<{ data: ServiceItem[] }> {
    return { data: await this.catalog.services(resolveLocale(acceptLanguage)) };
  }

  @Get('boat-types')
  @Header('Cache-Control', 'public, max-age=3600, s-maxage=86400, stale-while-revalidate=86400')
  @Header('Vary', 'Accept-Language')
  async boatTypes(
    @Headers('accept-language') acceptLanguage?: string,
  ): Promise<{ data: BoatTypeItem[] }> {
    return { data: await this.catalog.boatTypes(resolveLocale(acceptLanguage)) };
  }

  @Get('engine-types')
  @Header('Cache-Control', 'public, max-age=3600, s-maxage=86400, stale-while-revalidate=86400')
  async engineTypes(): Promise<{ data: EngineTypeItem[] }> {
    return { data: await this.catalog.engineTypes() };
  }
}
