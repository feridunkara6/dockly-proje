/**
 * Ham tahmin sağlayıcı soyutlaması — servis somut HTTP'ye değil buna bağlanır
 * (docs/26 clean architecture; testte sahte ile değiştirilir, CI ASLA dış
 * servise çıkmaz).
 */
export const WEATHER_PROVIDER = Symbol('WEATHER_PROVIDER');

export interface WeatherProvider {
  /** Verilen koordinat için kaynaktan HAM tahmin yanıtını getirir. */
  fetchRaw(lat: number, lon: number): Promise<unknown>;
}
