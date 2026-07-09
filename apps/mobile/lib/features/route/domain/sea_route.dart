import 'dart:math' as math;

import 'package:dockly_api/dockly_api.dart' show GeoPoint;

/// Deniz-rota (v1) — kuşuçuşu deniz mesafesi + yön (kerteriz). Karayolu/Google
/// Maps mantığı YOK: ürün vizyonu gereği tüm rota deneyimi denizcilik-odaklıdır.
/// Mimari ileride hava, rüzgâr, dalga, akıntı, derinlik, yasak bölge gibi
/// faktörlerle genişleyebilir; v1 yalnız geometri (mesafe + kerteriz + süre)
/// sağlar. Mesafe daima deniz mili, yön daima kerteriz+pusuladır.

/// Dünya ortalama yarıçapı — deniz mili (1' yay ≈ 1 deniz mili).
const double kEarthRadiusNm = 3440.065;

/// Varsayılan seyir hızı (knot) — kaba ETA tahmini için (v1).
const double kDefaultCruiseKn = 8;

double _rad(double deg) => deg * math.pi / 180.0;
double _deg(double rad) => rad * 180.0 / math.pi;

/// İki nokta arası büyük-daire (kuşuçuşu) mesafe — deniz mili.
double haversineNm(GeoPoint a, GeoPoint b) {
  final double dLat = _rad(b.lat - a.lat);
  final double dLon = _rad(b.lon - a.lon);
  final double lat1 = _rad(a.lat);
  final double lat2 = _rad(b.lat);
  final double h = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
  final double c = 2 * math.asin(math.min(1.0, math.sqrt(h)));
  return kEarthRadiusNm * c;
}

/// Başlangıç kerterizi (ileri azimut) — 0..360 derece, kuzeyden saat yönünde.
double initialBearingDeg(GeoPoint a, GeoPoint b) {
  final double lat1 = _rad(a.lat);
  final double lat2 = _rad(b.lat);
  final double dLon = _rad(b.lon - a.lon);
  final double y = math.sin(dLon) * math.cos(lat2);
  final double x = math.cos(lat1) * math.sin(lat2) -
      math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
  final double brng = _deg(math.atan2(y, x));
  return (brng + 360.0) % 360.0;
}

/// 16-yönlü pusula etiketi (Türkçe) — kerterizden. idx 0 = Kuzey.
const List<String> _compass16 = <String>[
  'Kuzey', 'KKD', 'Kuzeydoğu', 'DKD',
  'Doğu', 'DGD', 'Güneydoğu', 'GGD',
  'Güney', 'GGB', 'Güneybatı', 'BGB',
  'Batı', 'BKB', 'Kuzeybatı', 'KKB',
];

/// Kerterizi 16-yönlü Türkçe pusula etiketine çevirir.
String compass16Tr(double bearingDeg) {
  final int idx = ((bearingDeg % 360.0) / 22.5).round() % 16;
  return _compass16[idx];
}

/// Mesafe ve hıza göre kaba süre (saat). Hız ≤ 0 ise sonsuz.
double etaHours(double distanceNm, {double speedKn = kDefaultCruiseKn}) {
  if (speedKn <= 0) return double.infinity;
  return distanceNm / speedKn;
}

/// Deniz-rota önizlemesi (v1 geometri). İleride ek güvenlik/çevre faktörleri
/// için genişletilebilir; şimdilik mesafe + kerteriz + pusula taşır.
class SeaRoutePreview {
  const SeaRoutePreview({
    required this.distanceNm,
    required this.bearingDeg,
    required this.compass,
  });

  final double distanceNm;
  final double bearingDeg;
  final String compass;

  /// Varsayılan seyir hızında kaba süre (saat).
  double get etaHoursAtCruise => etaHours(distanceNm);
}

/// `from` → `to` için deniz-rota önizlemesi üretir (kuşuçuşu, v1).
SeaRoutePreview computeSeaRoute(GeoPoint from, GeoPoint to) {
  final double distance = haversineNm(from, to);
  final double bearing = initialBearingDeg(from, to);
  return SeaRoutePreview(
    distanceNm: distance,
    bearingDeg: bearing,
    compass: compass16Tr(bearing),
  );
}
