import 'package:dockly_mobile/features/boat/application/my_boat_controller.dart';
import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:dockly_mobile/features/map/application/map_controller.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:dockly_mobile/features/shell/presentation/dockly_shell.dart';
import 'package:dockly_mobile/features/welcome/presentation/welcome_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_map_surface.dart';
import '../../support/map_fakes.dart';
import '../../support/welcome_fakes.dart';

Widget _app({required FakeWelcomeStore store, FakeBoatStorage? boatStorage}) {
  return ProviderScope(
    overrides: <Override>[
      mapLocationsGatewayProvider.overrideWithValue(FakeMapGateway(result: pinResult)),
      mapSurfaceBuilderProvider.overrideWithValue(fakeMapSurfaceBuilder()),
      mapDebounceProvider.overrideWithValue(Duration.zero),
      mapCacheProvider.overrideWithValue(FakeMapCache()),
      welcomeStoreProvider.overrideWithValue(store),
      boatStorageProvider.overrideWithValue(boatStorage ?? FakeBoatStorage()),
    ],
    child: const MaterialApp(home: DocklyShell()),
  );
}

void main() {
  testWidgets('ilk açılış: karşılama sorusu görünür; hızlı boy seçimi tekneyi tanımlar',
      (WidgetTester tester) async {
    final FakeWelcomeStore store = FakeWelcomeStore();
    await tester.pumpWidget(_app(store: store));
    await tester.pumpAndSettle();

    expect(find.textContaining('Teknenin markası'), findsOneWidget);

    // Denizci dili: marka yaz + FEET çipi seç → metreye çevrilip saklanır.
    await tester.enterText(find.byType(TextField), 'Beneteau');
    await tester.tap(find.widgetWithText(ActionChip, '39 ft'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Teknenin markası'), findsNothing); // kapandı
    final ProviderContainer container =
        ProviderScope.containerOf(tester.element(find.byType(DocklyShell)));
    expect(container.read(myBoatProvider)?.lengthM, 11.9); // 39 ft → 11.9 m
    expect(container.read(myBoatProvider)?.brand, 'Beneteau');
    expect(store.shown, isTrue); // bir daha sorulmaz
  });

  test('feetToMeters: 1 ft = 0.3048 m, 1 ondalık', () {
    expect(feetToMeters(39), 11.9);
    expect(feetToMeters(26), 7.9);
    expect(feetToMeters(79), 24.1);
  });

  testWidgets('daha önce soruldu → karşılama çıkmaz', (WidgetTester tester) async {
    await tester.pumpWidget(_app(store: FakeWelcomeStore(shown: true)));
    await tester.pumpAndSettle();
    expect(find.textContaining('Teknenin markası'), findsNothing);
  });

  testWidgets('cihazda tekne zaten kayıtlı → soru çıkmaz, soruldu işaretlenir',
      (WidgetTester tester) async {
    final FakeWelcomeStore store = FakeWelcomeStore();
    await tester.pumpWidget(_app(
      store: store,
      boatStorage: FakeBoatStorage(boat: const MyBoat(lengthM: 15)),
    ));
    await tester.pumpAndSettle();
    expect(find.textContaining('Teknenin markası'), findsNothing);
    expect(store.shown, isTrue);
  });

  testWidgets('"Şimdilik geç" → kapanır, tekne tanımlanmaz, tekrar sorulmaz',
      (WidgetTester tester) async {
    final FakeWelcomeStore store = FakeWelcomeStore();
    await tester.pumpWidget(_app(store: store));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Şimdilik geç'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Teknenin markası'), findsNothing);
    final ProviderContainer container =
        ProviderScope.containerOf(tester.element(find.byType(DocklyShell)));
    expect(container.read(myBoatProvider), isNull);
    expect(store.shown, isTrue);
  });
}
