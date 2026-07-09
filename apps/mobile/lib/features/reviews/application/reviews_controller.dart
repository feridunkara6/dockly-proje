import 'package:dockly_api/dockly_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/api_reviews_gateway.dart';
import '../domain/reviews_gateway.dart';

/// Yorum ağ geçidi sağlayıcısı — testte sahte ile override edilir.
final Provider<ReviewsGateway> reviewsGatewayProvider = Provider<ReviewsGateway>(
  (ref) => ApiReviewsGateway(ref.watch(locationsApiProvider)),
);

/// Bir lokasyonun onaylı yorumları (S-09, docs/23 §11.3). id/slug başına;
/// AsyncValue ile yükleme/hata/veri taşır.
final reviewsProvider = FutureProvider.family<List<Review>, String>(
  (ref, String idOrSlug) => ref.watch(reviewsGatewayProvider).fetch(idOrSlug),
);
