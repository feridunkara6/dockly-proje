import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_mobile/features/location/domain/location_service.dart';

/// Sahte konum servisi — testte gerçek tarayıcı/native konum yerine.
class FakeLocationService implements LocationService {
  FakeLocationService(this.result);

  final GeoPoint? result;
  int calls = 0;

  @override
  Future<GeoPoint?> current() async {
    calls++;
    return result;
  }
}
