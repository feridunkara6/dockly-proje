import 'package:dockly_api/dockly_api.dart';

/// Rüzgâr/hava ağ geçidi (docs/26 clean architecture) — kart somut API yerine
/// buna bağlanır; testte sahte ile değiştirilir, test ASLA ağa çıkmaz.
abstract interface class WeatherGateway {
  Future<WeatherForecast> forecast({required double lat, required double lon});
}
