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
