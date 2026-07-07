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

/** Pin modu yanıtı (docs/23 §9.5): tavanı aşarsa `truncated=true`. */
export interface PinResult {
  locations: LocationPin[];
  truncated: boolean;
}
