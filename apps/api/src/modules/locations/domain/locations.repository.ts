import { Bbox, Cluster, LocationPin, LocationSummary, NearbyParams } from './location.types';

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

  /**
   * bbox içindeki yayınlanmış lokasyonları `cellDeg` grid'ine göre gruplar
   * (docs/23 §9.5 cluster modu). En kalabalık balonlar önce; `limit` ile tavanlanır.
   */
  findClusters(
    bbox: Bbox,
    types: string[] | undefined,
    cellDeg: number,
    limit: number,
  ): Promise<Cluster[]>;
}

export const LOCATIONS_REPOSITORY = Symbol('LOCATIONS_REPOSITORY');
