import 'package:dockly_api/dockly_api.dart';

/// Yakın-lokasyon ağ geçidi (docs/26 clean architecture). Kontrolcü somut API
/// yerine bu soyutlamaya bağlanır — böylece ağ olmadan test edilebilir.
abstract interface class NearbyGateway {
  Future<List<LocationSummary>> fetch({
    required double lat,
    required double lon,
    double? radiusNm,
    int? limit,
  });
}
