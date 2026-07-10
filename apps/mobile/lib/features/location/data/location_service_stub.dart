import 'package:dockly_api/dockly_api.dart' show GeoPoint;

import '../domain/location_service.dart';

/// Konum servisi — VARSAYILAN (mobil/native). Native konum (geolocator + iOS/
/// Android izinleri) bir sonraki adımda eklenecek; şimdilik konum yok (`null`).
/// Web derlemesi bu dosyayı KULLANMAZ (koşullu import ile web sürümü seçilir).
class PlatformLocationService implements LocationService {
  const PlatformLocationService();

  @override
  Future<GeoPoint?> current() async => null;
}
