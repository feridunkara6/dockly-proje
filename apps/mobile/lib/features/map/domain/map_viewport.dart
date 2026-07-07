import 'package:dockly_api/dockly_api.dart';

/// Haritanın o anki görünümü — sunucuya gidecek bbox + zoom (docs/23 §9.5).
/// Değer nesnesi: aynı görünüm için tekrar yükleme yapılmasın diye eşitlik taşır.
class MapViewport {
  const MapViewport({required this.bbox, required this.zoom});

  final Bbox bbox;
  final int zoom;

  @override
  bool operator ==(Object other) =>
      other is MapViewport &&
      other.zoom == zoom &&
      other.bbox.minLon == bbox.minLon &&
      other.bbox.minLat == bbox.minLat &&
      other.bbox.maxLon == bbox.maxLon &&
      other.bbox.maxLat == bbox.maxLat;

  @override
  int get hashCode =>
      Object.hash(zoom, bbox.minLon, bbox.minLat, bbox.maxLon, bbox.maxLat);
}
