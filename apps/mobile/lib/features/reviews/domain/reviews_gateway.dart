import 'package:dockly_api/dockly_api.dart';

/// Yorum verisi ağ geçidi (docs/26 clean architecture). Kontrolcü somut API
/// yerine bu soyutlamaya bağlanır — böylece ağ olmadan test edilebilir.
abstract interface class ReviewsGateway {
  Future<List<Review>> fetch(String idOrSlug);
}
