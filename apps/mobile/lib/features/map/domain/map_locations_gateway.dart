import 'package:dockly_api/dockly_api.dart';

import 'map_viewport.dart';

/// Harita verisi ağ geçidi (docs/26 clean architecture). Kontrolcü somut API
/// yerine bu soyutlamaya bağlanır — böylece Mapbox/token olmadan test edilebilir.
abstract interface class MapLocationsGateway {
  Future<MapResult> loadViewport(MapViewport viewport, {List<String>? types});
}
