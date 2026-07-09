import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/nearby/application/nearby_controller.dart';
import 'package:dockly_mobile/features/nearby/presentation/nearby_alternatives.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/nearby_fakes.dart';
import '../../support/search_fakes.dart';

Widget _app(FakeNearbyGateway gateway) {
  return ProviderScope(
    overrides: <Override>[nearbyGatewayProvider.overrideWithValue(gateway)],
    child: const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: NearbyAlternatives(
            locationId: 'self',
            position: GeoPoint(lat: 36.75, lon: 28.93),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('alternatifler listelenir; merkezin kendisi hariç', (WidgetTester tester) async {
    final FakeNearbyGateway gateway = FakeNearbyGateway(
      results: <LocationSummary>[
        sampleSummary('self', 'Kendisi', distanceNm: 0),
        sampleSummary('alt-1', 'Yakın Marina', distanceNm: 2.3, type: 'municipal_marina'),
      ],
    );
    await tester.pumpWidget(_app(gateway));
    await tester.pumpAndSettle();

    expect(find.text('Yakındaki alternatifler'), findsOneWidget);
    expect(find.text('Yakın Marina'), findsOneWidget);
    expect(find.text('Kendisi'), findsNothing);
  });

  testWidgets('yalnız kendisi dönerse bölüm gizlenir', (WidgetTester tester) async {
    final FakeNearbyGateway gateway =
        FakeNearbyGateway(results: <LocationSummary>[sampleSummary('self', 'Kendisi')]);
    await tester.pumpWidget(_app(gateway));
    await tester.pumpAndSettle();

    expect(find.text('Yakındaki alternatifler'), findsNothing);
  });
}
