import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/search/application/search_controller.dart';
import 'package:dockly_mobile/features/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/search_fakes.dart';

Widget _app(FakeSearchGateway gateway) {
  return ProviderScope(
    overrides: <Override>[
      searchGatewayProvider.overrideWithValue(gateway),
      searchDebounceProvider.overrideWithValue(Duration.zero),
    ],
    child: const MaterialApp(home: SearchScreen()),
  );
}

void main() {
  testWidgets('boş sorguda "en az 2 harf" ipucu gösterilir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeSearchGateway()));
    await tester.pumpAndSettle();
    expect(find.textContaining('en az 2 harf'), findsOneWidget);
  });

  testWidgets('kısa sorgu (1 harf) → ipucu kalır, sonuç aranmaz', (WidgetTester tester) async {
    final FakeSearchGateway gateway =
        FakeSearchGateway(results: <LocationSummary>[sampleSummary('loc-1', 'Alfa Marina')]);
    await tester.pumpWidget(_app(gateway));
    await tester.enterText(find.byType(TextField), 'a');
    await tester.pumpAndSettle();
    expect(find.textContaining('en az 2 harf'), findsOneWidget);
    expect(gateway.queries, isEmpty);
  });

  testWidgets('yeterli sorgu → sonuç listelenir', (WidgetTester tester) async {
    final FakeSearchGateway gateway = FakeSearchGateway(
      results: <LocationSummary>[sampleSummary('loc-1', 'D-Marin Göcek', ratingAvg: 4.8)],
    );
    await tester.pumpWidget(_app(gateway));
    await tester.enterText(find.byType(TextField), 'göcek');
    await tester.pumpAndSettle();
    expect(find.text('D-Marin Göcek'), findsOneWidget);
    expect(gateway.queries, <String>['göcek']);
  });
}
