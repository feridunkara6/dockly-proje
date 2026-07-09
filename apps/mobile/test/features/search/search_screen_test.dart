import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/boat/application/my_boat_controller.dart';
import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:dockly_mobile/features/search/application/search_controller.dart';
import 'package:dockly_mobile/features/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/search_fakes.dart';

/// Sabit tekne döndüren kontrolcü (depolamaya gitmez).
class _FixedBoat extends MyBoatController {
  _FixedBoat(this._boat);
  final MyBoat _boat;
  @override
  MyBoat? build() => _boat;
}

Widget _app(FakeSearchGateway gateway, {MyBoat? boat}) {
  return ProviderScope(
    overrides: <Override>[
      searchGatewayProvider.overrideWithValue(gateway),
      searchDebounceProvider.overrideWithValue(Duration.zero),
      if (boat != null) myBoatProvider.overrideWith(() => _FixedBoat(boat)),
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

  testWidgets('tür çipine dokununca filtre uygulanır', (WidgetTester tester) async {
    final FakeSearchGateway gateway = FakeSearchGateway(
      results: <LocationSummary>[sampleSummary('loc-1', 'D-Marin Göcek')],
    );
    await tester.pumpWidget(_app(gateway));
    await tester.enterText(find.byType(TextField), 'göcek');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilterChip, 'Özel Marina'));
    await tester.pumpAndSettle();
    expect(gateway.typeArgs.last, contains('private_marina'));
  });

  testWidgets('tekne yokken "Teknem sığar" çipi tekne tanımlama sayfasını açar',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeSearchGateway()));
    await tester.tap(find.widgetWithText(FilterChip, 'Teknem sığar'));
    await tester.pumpAndSettle();
    expect(find.text('Tekneni tanımla'), findsOneWidget); // alt sayfa başlığı
  });

  testWidgets('"Teknem sığar" açıkken tekneye sığmayanlar gizlenir',
      (WidgetTester tester) async {
    final FakeSearchGateway gateway = FakeSearchGateway(
      results: <LocationSummary>[
        sampleSummary('fits', 'Sığan Marina', maxBoatLengthM: 40, maxDraftM: 5),
        sampleSummary('big', 'Küçük İskele', maxBoatLengthM: 8, maxDraftM: 1),
      ],
    );
    await tester.pumpWidget(_app(gateway, boat: const MyBoat(lengthM: 15, draftM: 2)));
    await tester.enterText(find.byType(TextField), 'liman');
    await tester.pumpAndSettle();
    expect(find.text('Sığan Marina'), findsOneWidget);
    expect(find.text('Küçük İskele'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilterChip, 'Teknem sığar'));
    await tester.pumpAndSettle();
    expect(find.text('Sığan Marina'), findsOneWidget);
    expect(find.text('Küçük İskele'), findsNothing); // 15 m tekne 8 m limite sığmaz
  });
}
