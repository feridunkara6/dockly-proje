import 'package:dio/dio.dart';

import 'dto/forecast.dart';
import 'problem_mapper.dart';

/// `/v1/weather` istemcisi — anonim uç; hatalar `AppFailure`'a eşlenir.
class WeatherApi {
  const WeatherApi(this._dio);

  final Dio _dio;

  Future<WeatherForecast> forecast({required double lat, required double lon}) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/v1/weather',
        queryParameters: <String, dynamic>{'lat': lat, 'lon': lon},
      );
      return WeatherForecast.fromJson(res.data!);
    } on DioException catch (error) {
      throw mapDioError(error);
    }
  }
}
