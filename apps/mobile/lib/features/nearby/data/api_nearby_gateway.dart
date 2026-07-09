import 'package:dockly_api/dockly_api.dart';

import '../domain/nearby_gateway.dart';

/// `NearbyGateway`'in gerçek uygulaması — `LocationsApi.nearby`'ye devreder.
class ApiNearbyGateway implements NearbyGateway {
  const ApiNearbyGateway(this._api);

  final LocationsApi _api;

  @override
  Future<List<LocationSummary>> fetch({
    required double lat,
    required double lon,
    double? radiusNm,
    int? limit,
  }) {
    return _api.nearby(lat: lat, lon: lon, radiusNm: radiusNm, limit: limit);
  }
}
