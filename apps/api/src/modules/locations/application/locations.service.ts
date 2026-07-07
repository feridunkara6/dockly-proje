import { Inject, Injectable } from '@nestjs/common';
import { LOCATIONS_REPOSITORY, LocationsRepository } from '../domain/locations.repository';
import { PIN_CAP, parseBbox, quantizeBbox } from '../domain/bbox';
import { CLUSTER_CAP, MIN_PIN_ZOOM, clusterCellSizeDeg, parseZoom } from '../domain/cluster';
import { NM_TO_M, parseNearbyQuery } from '../domain/nearby';
import { LocationSummary, MapResult } from '../domain/location.types';

/** Harita/lokasyon sorguları — doğrulama + tavan/truncation orkestrasyonu. */
@Injectable()
export class LocationsService {
  constructor(
    @Inject(LOCATIONS_REPOSITORY) private readonly repo: LocationsRepository,
  ) {}

  /**
   * Harita bbox sorgusu (docs/23 §9.5). Ham bbox doğrulanır, %1 grid'e kuantalanır.
   * zoom < 12 → cluster modu (balonlar); aksi halde (zoom ≥ 12 veya yok) → pin modu.
   */
  async map(
    rawBbox: string | undefined,
    rawZoom: string | undefined,
    types: string[] | undefined,
  ): Promise<MapResult> {
    const bbox = parseBbox(rawBbox);
    const zoom = parseZoom(rawZoom);
    const quantized = quantizeBbox(bbox);

    if (zoom !== undefined && zoom < MIN_PIN_ZOOM) {
      const cellDeg = clusterCellSizeDeg(zoom);
      const found = await this.repo.findClusters(quantized, types, cellDeg, CLUSTER_CAP + 1);
      const clusters = found.length > CLUSTER_CAP ? found.slice(0, CLUSTER_CAP) : found;
      return { clusters, locations: [], truncated: false };
    }

    const rows = await this.repo.findPinsInBbox(quantized, types, PIN_CAP + 1);
    const truncated = rows.length > PIN_CAP;
    return { clusters: [], locations: truncated ? rows.slice(0, PIN_CAP) : rows, truncated };
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
