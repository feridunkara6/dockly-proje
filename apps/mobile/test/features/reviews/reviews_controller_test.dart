import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/reviews/application/reviews_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/reviews_fakes.dart';

void main() {
  test('gateway sonuçları provider üzerinden döner', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        reviewsGatewayProvider.overrideWithValue(
          FakeReviewsGateway(results: <Review>[sampleReview('rev-1', authorName: 'Ali')]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final List<Review> result = await container.read(reviewsProvider('loc-1').future);
    expect(result.single.authorName, 'Ali');
  });

  test('boş liste döner', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        reviewsGatewayProvider.overrideWithValue(FakeReviewsGateway()),
      ],
    );
    addTearDown(container.dispose);

    final List<Review> result = await container.read(reviewsProvider('loc-1').future);
    expect(result, isEmpty);
  });
}
