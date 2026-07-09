import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/nearby/domain/nearby_gateway.dart';

/// `NearbyGateway` yerine geçen sahte; boş varsayılan → bölüm gizlenir.
class FakeNearbyGateway implements NearbyGateway {
  FakeNearbyGateway({this.results = const <LocationSummary>[], this.error});

  List<LocationSummary> results;
  AppFailure? error;

  @override
  Future<List<LocationSummary>> fetch({
    required double lat,
    required double lon,
    double? radiusNm,
    int? limit,
  }) {
    final AppFailure? err = error;
    if (err != null) return Future<List<LocationSummary>>.error(err);
    return Future<List<LocationSummary>>.value(results);
  }
}
