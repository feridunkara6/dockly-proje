import 'geo.dart';
import 'occupancy.dart';

/// Harita iğnesi — minimum bayt seti (docs/23 §11.1).
class LocationPin {
  const LocationPin({
    required this.id,
    required this.name,
    required this.type,
    required this.position,
    required this.ratingAvg,
    required this.priceTier,
    this.maxBoatLengthM,
    this.maxDraftM,
    this.occupancy,
  });

  final String id;
  final String name;

  /// location_type kodu (istemci ikon/renk eşler).
  final String type;
  final GeoPoint position;
  final double? ratingAvg;
  final String priceTier;

  /// Kabul limitleri (null = bilinmiyor) — haritada tekne-uyum rozeti için.
  /// Geriye uyumlu: eski sunucu göndermezse null kalır.
  final double? maxBoatLengthM;
  final double? maxDraftM;

  /// Son 6 saatte doluluk bildirimi varsa özet; yoksa null (geriye uyumlu).
  final OccupancySummary? occupancy;

  factory LocationPin.fromJson(Map<String, dynamic> json) => LocationPin(
        id: json['id'] as String,
        name: json['name'] as String,
        type: json['type'] as String,
        position: GeoPoint.fromJson(json['position'] as Map<String, dynamic>),
        ratingAvg: (json['ratingAvg'] as num?)?.toDouble(),
        priceTier: json['priceTier'] as String,
        maxBoatLengthM: (json['maxBoatLengthM'] as num?)?.toDouble(),
        maxDraftM: (json['maxDraftM'] as num?)?.toDouble(),
        occupancy: OccupancySummary.fromJsonNullable(json['occupancy']),
      );
}

/// Harita balonu (docs/23 §9.5). `bbox` = balonun hücre kapsamı; istemci dokununca
/// bu kutuyla yeniden sorgular (kamera uçuşu). Balonlar ülkeye göre ayrılır;
/// `countryCode` (TR/GR…) istemcide balon rengini belirler. Geriye uyumlu:
/// eski sunucu göndermezse boş kalır → varsayılan renk.
class Cluster {
  const Cluster({
    required this.position,
    required this.count,
    required this.bbox,
    this.countryCode = '',
  });

  final GeoPoint position;
  final int count;
  final Bbox bbox;

  /// ISO-3166 alpha-2 ülke kodu ('' = bilinmiyor).
  final String countryCode;

  factory Cluster.fromJson(Map<String, dynamic> json) => Cluster(
        position: GeoPoint.fromJson(json['position'] as Map<String, dynamic>),
        count: (json['count'] as num).toInt(),
        bbox: Bbox.fromList(json['bbox'] as List<dynamic>),
        countryCode: json['countryCode'] as String? ?? '',
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
