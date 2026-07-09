import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/reviews/domain/reviews_gateway.dart';

/// Test için örnek yorum üretir.
Review sampleReview(
  String id, {
  String authorName = 'Kaptan Ali',
  int rating = 5,
  String? title = 'Harika',
  String? body = 'Çok iyi.',
  String createdAt = '2026-07-01T10:00:00Z',
}) {
  return Review(
    id: id,
    authorName: authorName,
    rating: rating,
    title: title,
    body: body,
    visitedOn: null,
    createdAt: createdAt,
    helpfulCount: 0,
  );
}

/// `ReviewsGateway` yerine geçen sahte; boş varsayılan → bölüm gizlenir.
class FakeReviewsGateway implements ReviewsGateway {
  FakeReviewsGateway({this.results = const <Review>[], this.error});

  List<Review> results;
  AppFailure? error;

  @override
  Future<List<Review>> fetch(String idOrSlug) {
    final AppFailure? err = error;
    if (err != null) return Future<List<Review>>.error(err);
    return Future<List<Review>>.value(results);
  }
}
