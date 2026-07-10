import 'package:dockly_api/dockly_api.dart' show GeoPoint;

/// Cihazın güncel konumunu sağlayan soyutlama (docs/26 clean architecture).
/// Platforma göre farklı uygulanır (web: tarayıcı; mobil: native — sonra).
/// En iyi çaba: izin yoksa/başarısızsa `null` döner, asla fırlatmaz.
abstract interface class LocationService {
  Future<GeoPoint?> current();
}
