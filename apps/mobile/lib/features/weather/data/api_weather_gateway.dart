import 'package:dockly_api/dockly_api.dart';

import '../domain/weather_gateway.dart';

/// `WeatherGateway`'in gerçek uygulaması — `WeatherApi.forecast`'a devreder.
class ApiWeatherGateway implements WeatherGateway {
  const ApiWeatherGateway(this._api);

  final WeatherApi _api;

  @override
  Future<WeatherForecast> forecast({required double lat, required double lon}) {
    return _api.forecast(lat: lat, lon: lon);
  }
}
