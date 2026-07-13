import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/weather/domain/weather_gateway.dart';

/// `WeatherGateway` yerine geçen sahte. Varsayılan: hata → kart gizlenir
/// (mevcut detay testleri etkilenmez); `forecast` verilirse onu döndürür.
class FakeWeatherGateway implements WeatherGateway {
  FakeWeatherGateway({this.result});

  WeatherForecast? result;

  @override
  Future<WeatherForecast> forecast({required double lat, required double lon}) {
    final WeatherForecast? r = result;
    if (r == null) {
      return Future<WeatherForecast>.error(const NetworkFailure());
    }
    return Future<WeatherForecast>.value(r);
  }
}

/// Deterministik örnek tahmin (saat başı; ilk nokta verilen değerlerle).
WeatherForecast sampleForecast({
  double windKn = 14.2,
  double? gustKn = 22.4,
  int windDirDeg = 310,
  double tempC = 24.4,
  int hours = 12,
}) {
  final DateTime t0 = DateTime.utc(2026, 7, 13, 9);
  return WeatherForecast(
    fetchedAt: t0,
    attribution: 'MET Norway (CC BY 4.0)',
    points: List<ForecastPoint>.generate(hours, (int i) {
      return ForecastPoint(
        time: t0.add(Duration(hours: i)),
        windKn: i == 0 ? windKn : 10 + i.toDouble(),
        gustKn: i == 0 ? gustKn : null,
        windDirDeg: windDirDeg,
        tempC: tempC,
        symbol: 'clearsky_day',
      );
    }),
  );
}
