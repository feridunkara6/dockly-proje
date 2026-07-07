/** Coğrafi nokta (WGS84). */
export interface GeoPoint {
  lat: number;
  lon: number;
}

/** Harita pin'i — minimum bayt seti (docs/23 §11.1). */
export interface LocationPin {
  id: string;
  name: string;
  /** location_type kodu (istemci ikon/renk eşler). */
  type: string;
  position: GeoPoint;
  ratingAvg: number | null;
  priceTier: string;
}

/** Sınırlayıcı kutu (`minLon,minLat,maxLon,maxLat`, docs/23 §9.5). */
export interface Bbox {
  minLon: number;
  minLat: number;
  maxLon: number;
  maxLat: number;
}

/** Harita balonu (docs/23 §9.5, cluster modu). `bbox` = balonun hücre kapsamı;
 * istemci dokununca bu bbox ile yeniden sorgular (S-06 kamera uçuşu). */
export interface Cluster {
  position: GeoPoint;
  count: number;
  /** [minLon, minLat, maxLon, maxLat] */
  bbox: [number, number, number, number];
}

/**
 * Harita yanıtı (docs/23 §9.5). zoom ≥ 12 → `locations` dolu, `clusters` boş;
 * zoom < 12 → `clusters` dolu, `locations` boş. `truncated` yalnız pin modunda
 * anlamlı (tavan aşımı).
 */
export interface MapResult {
  clusters: Cluster[];
  locations: LocationPin[];
  truncated: boolean;
}

/** Kart kapak görseli (docs/23 §11.2). `url` her zaman varyant CDN URL'idir (§12). */
export interface CoverMedia {
  url: string;
  blurhash: string | null;
}

/**
 * Kart/liste öğesi (docs/23 §11.2) = Pin + zenginleştirme.
 * `coverMedia` medya alt sistemi (§12) gelene dek `null` (v1'de lokasyon medyası
 * henüz doldurulmadı). `isFavorite` yalnız kimlikli bağlamda eklenir — bu anonim
 * uçta yer almaz.
 */
export interface LocationSummary {
  id: string;
  name: string;
  type: string;
  position: GeoPoint;
  slug: string;
  coverMedia: CoverMedia | null;
  ratingAvg: number | null;
  ratingCount: number;
  priceTier: string;
  city: string | null;
  waterBodyName: string | null;
  distanceNm: number;
  amenityCodes: string[];
}

/** Doğrulanmış nearby sorgu parametreleri (metreye çevrilmiş yarıçapla). */
export interface NearbyParams {
  lat: number;
  lon: number;
  radiusMeters: number;
  types?: string[];
  limit: number;
}

// --- LocationDetail (S-09, docs/23 §11.3) ---

export interface AdminAreaRef {
  id: string;
  name: string;
  province: string | null;
}

export interface WaterBodyRef {
  id: string;
  name: string;
  type: string;
}

export interface GeoBlock {
  countryCode: string;
  adminArea: AdminAreaRef | null;
  waterBody: WaterBodyRef | null;
}

export interface Dimensions {
  maxBoatLengthM: number | null;
  maxDraftM: number | null;
  depthMinM: number | null;
  depthMaxM: number | null;
  capacity: number | null;
}

export interface RatingDimensionAvg {
  code: string;
  avg: number;
}

export interface RatingBlock {
  avg: number | null;
  count: number;
  dimensions: RatingDimensionAvg[];
}

export interface AmenityLabeled {
  code: string;
  label: string;
  category: string | null;
}

export interface ServiceLabeled {
  code: string;
  label: string;
}

export interface ContactDto {
  type: string;
  value: string;
  isPrimary: boolean;
}

/** Gün içi çalışma saati; kapalı günlerde opensAt/closesAt null. */
export interface HourDto {
  dayOfWeek: number;
  opensAt: string | null;
  closesAt: string | null;
}

/** Sezon aralığı "MM-DD" (docs/23 §11.3). */
export interface SeasonDto {
  opensOn: string | null;
  closesOn: string | null;
}

export interface MediaBlock {
  cover: CoverMedia | null;
  count: number;
}

/**
 * Liman detayı (docs/23 §11.3). `typeDetails` (alt-tip birleşimi) ve
 * `rating.dimensions` (yorum-türevli) 3.1b-iv-b'de; `media.cover` medya alt
 * sistemiyle; `userContext` kimlikli bağlamda gelecek — bu anonim uçta `null`.
 */
export interface LocationDetail {
  id: string;
  slug: string;
  type: string;
  status: string;
  name: string;
  description: string | null;
  position: GeoPoint;
  geo: GeoBlock;
  dimensions: Dimensions;
  priceTier: string;
  is24h: boolean;
  verifiedAt: string | null;
  rating: RatingBlock;
  amenities: AmenityLabeled[];
  services: ServiceLabeled[];
  contacts: ContactDto[];
  hours: HourDto[];
  seasons: SeasonDto[];
  typeDetails: Record<string, unknown> | null;
  media: MediaBlock;
  userContext: null;
  counts: { reviews: number; photos: number };
}
