/// Coğrafi nokta (WGS84) — sunucu `position` sözleşmesi (docs/23 §11.1).
class GeoPoint {
  const GeoPoint({required this.lat, required this.lon});

  final double lat;
  final double lon;

  factory GeoPoint.fromJson(Map<String, dynamic> json) => GeoPoint(
        lat: (json['lat'] as num).toDouble(),
        lon: (json['lon'] as num).toDouble(),
      );
}

/// Sınırlayıcı kutu (`minLon,minLat,maxLon,maxLat`, docs/23 §9.5).
class Bbox {
  const Bbox({
    required this.minLon,
    required this.minLat,
    required this.maxLon,
    required this.maxLat,
  });

  final double minLon;
  final double minLat;
  final double maxLon;
  final double maxLat;

  /// Sunucunun beklediği query biçimi: `minLon,minLat,maxLon,maxLat`.
  String toParam() => '$minLon,$minLat,$maxLon,$maxLat';

  /// Cluster yanıtındaki `[minLon, minLat, maxLon, maxLat]` dizisinden.
  factory Bbox.fromList(List<dynamic> list) => Bbox(
        minLon: (list[0] as num).toDouble(),
        minLat: (list[1] as num).toDouble(),
        maxLon: (list[2] as num).toDouble(),
        maxLat: (list[3] as num).toDouble(),
      );
}
