import { Controller, Get, Header, Query } from '@nestjs/common';
import { LocationsService } from '../application/locations.service';
import { LocationSummary, MapResult } from '../domain/location.types';

/**
 * Lokasyon süper-tipi — harita/arama/nearby/detay (docs/23 §8, §10 #10).
 * Bu alt-faz: bbox pin modu (§9.5, zoom ≥ 12). Anonim, kuantalanmış bbox 120s
 * + SWR ile CDN'de cache'lenir (docs/23 §17, docs/13 §4).
 */
@Controller('locations')
export class LocationsController {
  constructor(private readonly locations: LocationsService) {}

  @Get()
  @Header('Cache-Control', 'public, max-age=120, s-maxage=120, stale-while-revalidate=600')
  async list(
    @Query('bbox') bbox?: string,
    @Query('zoom') zoom?: string,
    @Query('type') type?: string | string[],
  ): Promise<MapResult> {
    return this.locations.map(bbox, zoom, normalizeTypes(type));
  }

  /** Yakınımdaki limanlar (docs/23 §9.6) — mesafeye göre sıralı, S-06 rayı. */
  @Get('nearby')
  @Header('Cache-Control', 'public, max-age=60, stale-while-revalidate=300')
  async nearby(
    @Query('lat') lat?: string,
    @Query('lon') lon?: string,
    @Query('radiusNm') radiusNm?: string,
    @Query('limit') limit?: string,
    @Query('type') type?: string | string[],
  ): Promise<{ data: LocationSummary[] }> {
    return this.locations.nearby({ lat, lon, radiusNm, limit }, normalizeTypes(type));
  }
}

/** Tekrarlı `type` param = OR listesi (docs/23 §9.2); tekil değeri diziye sarar. */
function normalizeTypes(type: string | string[] | undefined): string[] | undefined {
  if (type === undefined) return undefined;
  const list = (Array.isArray(type) ? type : [type])
    .map((t) => t.trim())
    .filter((t) => t.length > 0);
  return list.length > 0 ? list : undefined;
}
