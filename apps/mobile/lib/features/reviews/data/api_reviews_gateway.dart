import 'package:dockly_api/dockly_api.dart';

import '../domain/reviews_gateway.dart';

/// `ReviewsGateway`'in gerçek uygulaması — `LocationsApi.reviews`'e devreder.
class ApiReviewsGateway implements ReviewsGateway {
  const ApiReviewsGateway(this._api);

  final LocationsApi _api;

  @override
  Future<List<Review>> fetch(String idOrSlug) {
    return _api.reviews(idOrSlug);
  }
}
