import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:geolocator/geolocator.dart';

import '../domain/location_service.dart';

/// Konum servisi — MOBİL (iOS/Android, geolocator; mağaza fazı).
///
/// Sözleşme web sürümüyle AYNIDIR: en iyi çaba, asla fırlatmaz. İzin reddi,
/// kapalı konum servisi, eklenti yokluğu (VM testleri) → `null`. iOS izin
/// metni Info.plist'te (NSLocationWhenInUseUsageDescription — iskele workflow'u
/// ekler); izin yalnız kullanıcı "Konumum"a basınca istenir, açılışta değil.
class PlatformLocationService implements LocationService {
  const PlatformLocationService();

  @override
  Future<GeoPoint?> current() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return null;
      }
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        return null;
      }
      final Position pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      return GeoPoint(lat: pos.latitude, lon: pos.longitude);
    } catch (_) {
      // eklenti yok / zaman aşımı / platform hatası → konum yok (çökme yok)
      return null;
    }
  }
}
