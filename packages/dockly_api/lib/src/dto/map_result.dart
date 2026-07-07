import 'geo.dart';

/// Harita iğnesi — minimum bayt seti (docs/23 §11.1).
class LocationPin {
  const LocationPin({
    required this.id,
    required this.name,
    required this.type,
    required this.position,
    required this.ratingAvg,
    required this.priceTier,
  });

  final String id;
  final String name;

  /// location_type kodu (istemci ikon/renk eşler).
  final String type;
  final GeoPoint position;
  final double? ratingAvg;
  final String priceTier;

  factory LocationPin.fromJson(Map<String, dynamic> json) => LocationPin(
        id: json['id'] as String,
        name: json['name'] as String,
        type: json['type'] as String,
        position: GeoPoint.fromJson(json['position'] as Map<String, dynamic>),
        ratingAvg: (json['ratingAvg'] as num?)?.toDouble(),
        priceTier: json['priceTier'] as String,
      );
}

/// Harita balonu (docs/23 §9.5). `bbox` = balonun hücre kapsamı; istemci dokununca
/// bu kutuyla yeniden sorgular (kamera uçuşu).
class Cluster {
  const Cluster({required this.position, required this.count, required this.bbox});

  final GeoPoint position;
  final int count;
  final Bbox bbox;

  factory Cluster.fromJson(Map<String, dynamic> json) => Cluster(
        position: GeoPoint.fromJson(json['position'] as Map<String, dynamic>),
        count: (json['count'] as num).toInt(),
        bbox: Bbox.fromList(json['bbox'] as List<dynamic>),
      );
}

/// Harita yanıtı (docs/23 §9.5): zoom ≥ 12 → `locations` dolu; zoom < 12 → `clusters` dolu.
class MapResult {
  const MapResult({
    required this.clusters,
    required this.locations,
    required this.truncated,
  });

  final List<Cluster> clusters;
  final List<LocationPin> locations;
  final bool truncated;

  factory MapResult.fromJson(Map<String, dynamic> json) => MapResult(
        clusters: (json['clusters'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(Cluster.fromJson)
            .toList(growable: false),
        locations: (json['locations'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(LocationPin.fromJson)
            .toList(growable: false),
        truncated: json['truncated'] as bool? ?? false,
      );
}
