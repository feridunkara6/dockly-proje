import 'package:dockly_api/dockly_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/api_weather_gateway.dart';
import '../domain/weather_gateway.dart';

/// Ağ geçidi sağlayıcısı — testte sahte ile override edilir.
final Provider<WeatherGateway> weatherGatewayProvider = Provider<WeatherGateway>(
  (ref) => ApiWeatherGateway(ref.watch(weatherApiProvider)),
);

/// Tahmin sorgu anahtarı: koordinat ~1 km'ye yuvarlanır (sunucu önbelleğiyle
/// aynı hücre mantığı — aynı koya bakan herkes aynı önbelleğe düşer).
typedef WeatherKey = ({double lat, double lon});

WeatherKey weatherKeyFor(double lat, double lon) =>
    (lat: (lat * 100).roundToDouble() / 100, lon: (lon * 100).roundToDouble() / 100);

/// Bir koordinatın rüzgâr/hava tahmini (detay sayfası kartı).
final weatherForecastProvider =
    FutureProvider.family<WeatherForecast, WeatherKey>((ref, WeatherKey key) {
  return ref.watch(weatherGatewayProvider).forecast(lat: key.lat, lon: key.lon);
});
