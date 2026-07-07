import 'package:dockly_api/dockly_api.dart';

import '../domain/map_locations_gateway.dart';
import '../domain/map_viewport.dart';

/// `MapLocationsGateway`'in gerçek uygulaması — `LocationsApi`'ye devreder.
class ApiMapLocationsGateway implements MapLocationsGateway {
  const ApiMapLocationsGateway(this._api);

  final LocationsApi _api;

  @override
  Future<MapResult> loadViewport(MapViewport viewport, {List<String>? types}) {
    return _api.mapByBbox(bbox: viewport.bbox, zoom: viewport.zoom, types: types);
  }
}
