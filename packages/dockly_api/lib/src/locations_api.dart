import 'package:dio/dio.dart';

import 'dto/geo.dart';
import 'dto/location_summary.dart';
import 'dto/map_result.dart';
import 'problem_mapper.dart';

/// `/v1/locations*` istemcisi (docs/23 §9). Anonim uçlar; tüm hatalar `AppFailure`'a
/// eşlenir. `type` tekrarlı param = OR (docs/23 §9.2).
class LocationsApi {
  const LocationsApi(this._dio);

  final Dio _dio;

  /// Harita bbox sorgusu (docs/23 §9.5). zoom < 12 → cluster, ≥ 12 → pin.
  Future<MapResult> mapByBbox({
    required Bbox bbox,
    int? zoom,
    List<String>? types,
  }) async {
    return _call(() async {
      final res = await _dio.get<Map<String, dynamic>>(
        '/v1/locations',
        queryParameters: <String, dynamic>{
          'bbox': bbox.toParam(),
          if (zoom != null) 'zoom': zoom,
          if (types != null && types.isNotEmpty) 'type': types,
        },
        options: Options(listFormat: ListFormat.multi),
      );
      return MapResult.fromJson(res.data!);
    });
  }

  /// Yakınımdaki limanlar (docs/23 §9.6) — mesafeye göre sıralı.
  Future<List<LocationSummary>> nearby({
    required double lat,
    required double lon,
    double? radiusNm,
    List<String>? types,
    int? limit,
  }) async {
    return _call(() async {
      final res = await _dio.get<Map<String, dynamic>>(
        '/v1/locations/nearby',
        queryParameters: <String, dynamic>{
          'lat': lat,
          'lon': lon,
          if (radiusNm != null) 'radiusNm': radiusNm,
          if (limit != null) 'limit': limit,
          if (types != null && types.isNotEmpty) 'type': types,
        },
        options: Options(listFormat: ListFormat.multi),
      );
      final data = res.data!['data'] as List<dynamic>? ?? const <dynamic>[];
      return data
          .whereType<Map<String, dynamic>>()
          .map(LocationSummary.fromJson)
          .toList(growable: false);
    });
  }

  Future<T> _call<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw mapDioError(error);
    }
  }
}
