import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/nearby/application/nearby_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/nearby_fakes.dart';
import '../../support/search_fakes.dart';

void main() {
  test('merkezin kendisi (excludeId) hariç tutulur ve en fazla 5 döner', () async {
    final List<LocationSummary> items = <LocationSummary>[
      sampleSummary('self', 'Kendisi', distanceNm: 0),
      for (int i = 1; i <= 8; i++) sampleSummary('alt-$i', 'Alt $i', distanceNm: i.toDouble()),
    ];
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        nearbyGatewayProvider.overrideWithValue(FakeNearbyGateway(results: items)),
      ],
    );
    addTearDown(container.dispose);

    final List<LocationSummary> result = await container.read(
      nearbyAlternativesProvider((lat: 36.75, lon: 28.93, excludeId: 'self')).future,
    );

    expect(result.any((LocationSummary s) => s.id == 'self'), isFalse);
    expect(result.length, kNearbyAltLimit);
    expect(result.first.id, 'alt-1');
  });

  test('yalnız merkezin kendisi dönerse alternatif listesi boş', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        nearbyGatewayProvider.overrideWithValue(
          FakeNearbyGateway(results: <LocationSummary>[sampleSummary('self', 'Kendisi')]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final List<LocationSummary> result = await container.read(
      nearbyAlternativesProvider((lat: 36.75, lon: 28.93, excludeId: 'self')).future,
    );
    expect(result, isEmpty);
  });
}
