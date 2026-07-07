import { Bbox, LocationPin, LocationSummary, NearbyParams } from './location.types';

/** Lokasyon coğrafi sorguları (PostGIS; ham SQL — ADR-005). */
export interface LocationsRepository {
  /**
   * bbox içindeki yayınlanmış (silinmemiş) lokasyonları pin olarak döndürür.
   * `types` verilirse location_type koduna göre OR filtresi. Önem sırası
   * (rating_count DESC) — tavan aşılırsa en önemli pin'ler korunur.
   */
  findPinsInBbox(bbox: Bbox, types: string[] | undefined, limit: number): Promise<LocationPin[]>;

  /**
   * Bir merkeze `radiusMeters` içindeki yayınlanmış lokasyonları mesafeye göre
   * artan sıralı döndürür (docs/23 §9.6). Her öğede `distanceNm`.
   */
  findNearby(params: NearbyParams): Promise<LocationSummary[]>;
}

export const LOCATIONS_REPOSITORY = Symbol('LOCATIONS_REPOSITORY');
