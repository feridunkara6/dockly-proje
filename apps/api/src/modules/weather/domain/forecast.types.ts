/**
 * Rüzgâr/hava tahmini tipleri (S-Rüzgâr fazı). Kaynak: MET Norway
 * Locationforecast 2.0 (CC BY 4.0 — atıf zorunlu, ticari kullanım serbest).
 * Rüzgâr HASSAS veridir: değerler kaynaktan aynen (yalnız birim çevrimi
 * m/s → knot) aktarılır; hamle (gust) ayrıca taşınır; her nokta tahmin
 * saatini taşır. Uygulama "tahmindir" ibaresini göstermekle yükümlüdür.
 */

/** Tek zaman dilimi tahmini. */
export interface ForecastPoint {
  /** Tahminin geçerli olduğu an (ISO-8601, UTC). */
  time: string;
  /** Rüzgâr hızı (knot, 1 ondalık). */
  windKn: number;
  /** Hamle/gust (knot, 1 ondalık) — kaynakta yoksa null. */
  gustKn: number | null;
  /** Rüzgârın GELDİĞİ yön (derece, 0=K). */
  windDirDeg: number;
  /** Hava sıcaklığı (°C, 1 ondalık). */
  tempC: number;
  /** MET sembol kodu (ör. 'clearsky_day') — ikon eşlemesi istemcide. */
  symbol: string | null;
}

/** Bir koordinat için tahmin paketi. */
export interface WeatherForecast {
  points: ForecastPoint[];
  /** Verinin sunucumuzca kaynaktan alındığı an (ISO-8601). */
  fetchedAt: string;
  /** Zorunlu atıf metni (CC BY 4.0). */
  attribution: string;
}

export const MET_ATTRIBUTION = 'MET Norway (CC BY 4.0)';

/** m/s → knot (uluslararası sabit), 1 ondalığa yuvarlanır. */
export function msToKn(ms: number): number {
  return Math.round(ms * 1.943844 * 10) / 10;
}
