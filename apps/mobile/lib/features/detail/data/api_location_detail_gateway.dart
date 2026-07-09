import 'package:dockly_api/dockly_api.dart';

import '../domain/location_detail_gateway.dart';

/// `LocationDetailGateway`'in gerçek uygulaması — `LocationsApi.detail`'e devreder.
class ApiLocationDetailGateway implements LocationDetailGateway {
  const ApiLocationDetailGateway(this._api);

  final LocationsApi _api;

  @override
  Future<LocationDetail> fetch(String idOrSlug) => _api.detail(idOrSlug);
}
