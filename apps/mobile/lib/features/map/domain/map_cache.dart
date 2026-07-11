import 'package:dockly_api/dockly_api.dart';

/// Cihazda saklanan son başarılı harita verisi (çevrimdışı görünüm için).
class CachedMap {
  const CachedMap({required this.pins, required this.clusters, required this.savedAt});

  final List<LocationPin> pins;
  final List<Cluster> clusters;
  final DateTime savedAt;

  bool get isEmpty => pins.isEmpty && clusters.isEmpty;
}

/// Harita çevrimdışı önbelleği sözleşmesi. Denizde bağlantı gidince uygulama
/// kör kalmasın: son görülen limanlar gösterilir (docs/26 çevrimdışı ilkesi).
abstract interface class MapCache {
  Future<CachedMap?> load();
  Future<void> save(List<LocationPin> pins, List<Cluster> clusters);
}
