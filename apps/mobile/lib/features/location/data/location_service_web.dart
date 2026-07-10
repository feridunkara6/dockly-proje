// Web'de tarayıcının Geolocation API'si kullanılır. Bu dosya YALNIZCA web
// derlemesinde derlenir (koşullu import); mobilde stub sürümü seçilir.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:dockly_api/dockly_api.dart' show GeoPoint;

import '../domain/location_service.dart';

/// Konum servisi — WEB. Tarayıcı izin ister; kullanıcı reddederse ya da konum
/// alınamazsa `null` döner (en iyi çaba, fırlatmaz). HTTPS gerektirir — GitHub
/// Pages HTTPS olduğundan çalışır.
class PlatformLocationService implements LocationService {
  const PlatformLocationService();

  @override
  Future<GeoPoint?> current() async {
    try {
      final html.Geoposition pos =
          await html.window.navigator.geolocation.getCurrentPosition();
      final html.Coordinates? coords = pos.coords;
      final num? lat = coords?.latitude;
      final num? lon = coords?.longitude;
      if (lat == null || lon == null) return null;
      return GeoPoint(lat: lat.toDouble(), lon: lon.toDouble());
    } catch (_) {
      // izin reddi / zaman aşımı / desteklenmiyor → konum yok
      return null;
    }
  }
}
