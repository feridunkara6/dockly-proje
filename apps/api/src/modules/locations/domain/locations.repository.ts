import {
  Bbox,
  Cluster,
  ContactDto,
  Dimensions,
  HourDto,
  LocationPin,
  LocationSummary,
  NearbyParams,
  RatingDimensionAvg,
  SearchParams,
  SeasonDto,
  TypeDetails,
} from './location.types';

export interface TranslationRow {
  locale: string;
  name: string;
}

/** Detay için ham veri; i18n etiketleme uygulama katmanında yapılır. */
export interface DetailData {
  id: string;
  slug: string;
  type: string;
  status: string;
  baseName: string;
  baseDescription: string | null;
  i18n: { locale: string; name: string | null; description: string | null }[];
  lat: number;
  lon: number;
  countryCode: string;
  adminArea: { id: string; name: string; province: string | null } | null;
  waterBody: { id: string; name: string; type: string } | null;
  dimensions: Dimensions;
  priceTier: string;
  is24h: boolean;
  verifiedAt: string | null;
  ratingAvg: number | null;
  ratingCount: number;
  reviewCount: number;
  photoCount: number;
  amenities: { code: string; category: string | null; translations: TranslationRow[] }[];
  services: { code: string; translations: TranslationRow[] }[];
  contacts: ContactDto[];
  hours: HourDto[];
  seasons: SeasonDto[];
  typeDetails: TypeDetails | null;
  ratingDimensions: RatingDimensionAvg[];
}

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

  /**
   * Metinle arama (docs/23 §9, S-07): `q` lokasyon adı, şehir (admin_area) veya
   * su alanı adında geçen yayınlanmış (silinmemiş) lokasyonları döndürür. `types`
   * verilirse location_type koduna göre OR filtresi. Sıralama: ada baştan uyanlar
   * önce, sonra önem (rating_count DESC). Konum bağımsız olduğundan `distanceNm` = 0.
   */
  findSearch(params: SearchParams): Promise<LocationSummary[]>;

  /**
   * Yayınlanmış (silinmemiş) bir lokasyonun detay verisi (docs/23 §11.3); id veya
   * slug ile. Bulunamazsa `null`. i18n etiketleri ham döner (locale servis'te seçilir).
   */
  findDetail(idOrSlug: string): Promise<DetailData | null>;
}

export const LOCATIONS_REPOSITORY = Symbol('LOCATIONS_REPOSITORY');
