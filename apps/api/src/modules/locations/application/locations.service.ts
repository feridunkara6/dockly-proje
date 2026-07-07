import { Inject, Injectable } from '@nestjs/common';
import { LOCATIONS_REPOSITORY, LocationsRepository } from '../domain/locations.repository';
import { PIN_CAP, parseBbox, quantizeBbox } from '../domain/bbox';
import { NM_TO_M, parseNearbyQuery } from '../domain/nearby';
import { LocationSummary, PinResult } from '../domain/location.types';

/** Harita/lokasyon sorguları — doğrulama + tavan/truncation orkestrasyonu. */
@Injectable()
export class LocationsService {
  constructor(
    @Inject(LOCATIONS_REPOSITORY) private readonly repo: LocationsRepository,
  ) {}

  /**
   * bbox pin sorgusu (docs/23 §9.5, zoom ≥ 12). Ham bbox doğrulanır, %1 grid'e
   * kuantalanır; tavanı (500) tespit için +1 satır çekilir. Cluster modu
   * (zoom < 12) sonraki alt-fazda.
   */
  async pinsInBbox(rawBbox: string | undefined, types: string[] | undefined): Promise<PinResult> {
    const bbox = parseBbox(rawBbox);
    const quantized = quantizeBbox(bbox);
    const rows = await this.repo.findPinsInBbox(quantized, types, PIN_CAP + 1);
    const truncated = rows.length > PIN_CAP;
    return { locations: truncated ? rows.slice(0, PIN_CAP) : rows, truncated };
  }

  /**
   * Yakınımdaki lokasyonlar (docs/23 §9.6). Query doğrulanır; radiusNm metreye
   * çevrilir; sonuç mesafeye göre artan sıralı döner.
   */
  async nearby(
    raw: { lat?: string; lon?: string; radiusNm?: string; limit?: string },
    types: string[] | undefined,
  ): Promise<{ data: LocationSummary[] }> {
    const q = parseNearbyQuery(raw);
    const data = await this.repo.findNearby({
      lat: q.lat,
      lon: q.lon,
      radiusMeters: q.radiusNm * NM_TO_M,
      types,
      limit: q.limit,
    });
    return { data };
  }
}
