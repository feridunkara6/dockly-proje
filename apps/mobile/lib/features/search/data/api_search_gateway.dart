import 'package:dockly_api/dockly_api.dart';

import '../domain/search_gateway.dart';

/// `SearchGateway`'in gerçek uygulaması — `LocationsApi.search`'e devreder.
class ApiSearchGateway implements SearchGateway {
  const ApiSearchGateway(this._api);

  final LocationsApi _api;

  @override
  Future<List<LocationSummary>> search(String q, {List<String>? types}) {
    return _api.search(q: q, types: types);
  }
}
