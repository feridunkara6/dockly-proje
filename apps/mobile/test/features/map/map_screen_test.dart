import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/map/application/map_controller.dart';
import 'package:dockly_mobile/features/map/presentation/location_bottom_card.dart';
import 'package:dockly_mobile/features/map/presentation/map_screen.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_map_surface.dart';
import '../../support/map_fakes.dart';

Widget _app(FakeMapGateway gateway) {
  return ProviderScope(
    overrides: <Override>[
      mapLocationsGatewayProvider.overrideWithValue(gateway),
      mapSurfaceBuilderProvider.overrideWithValue(fakeMapSurfaceBuilder()),
      mapDebounceProvider.overrideWithValue(Duration.zero),
    ],
    child: const MaterialApp(home: MapScreen()),
  );
}

const ValueKey<String> _pinKey = ValueKey<String>('pin-loc-1');

void main() {
  testWidgets('açılışta görünüm bildirilir → marker çizilir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(result: pinResult)));
    await tester.pumpAndSettle();
    expect(find.byKey(_pinKey), findsOneWidget);
  });

  testWidgets('pin dokunma → seçim gösterilir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(result: pinResult)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_pinKey));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey<String>('selection')), findsOneWidget);
    expect(find.text('secili:loc-1'), findsOneWidget);
  });

  testWidgets('pin dokunma → alt detay kartı belirir; kapatınca kaybolur', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(result: pinResult)));
    await tester.pumpAndSettle();
    expect(find.byKey(LocationBottomCard.cardKey), findsNothing);

    await tester.tap(find.byKey(_pinKey));
    await tester.pumpAndSettle();
    expect(find.byKey(LocationBottomCard.cardKey), findsOneWidget);
    expect(find.text('Özel Marina'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.byKey(LocationBottomCard.cardKey), findsNothing);
  });

  testWidgets('liste görünümüne geçince liman listesi görünür', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(result: pinResult)));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNothing); // harita modu (sahte yüzey ListTile kullanmaz)

    await tester.tap(find.byIcon(Icons.view_list));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsOneWidget); // liste modu, tek pin
    expect(find.byIcon(Icons.map_outlined), findsOneWidget); // haritaya dön ikonu
  });

  testWidgets('boş bölge → boş görünüm', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(
      result: const MapResult(
        clusters: <Cluster>[],
        locations: <LocationPin>[],
        truncated: false,
      ),
    )));
    await tester.pumpAndSettle();
    expect(find.textContaining('henüz liman yok'), findsOneWidget);
  });

  testWidgets('truncated → yakınlaştırma ipucu', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(
      result: const MapResult(
        clusters: <Cluster>[],
        locations: <LocationPin>[testPin],
        truncated: true,
      ),
    )));
    await tester.pumpAndSettle();
    expect(find.textContaining('yakınlaştırın'), findsOneWidget);
  });

  testWidgets('hata → hata görünümü + retry başarıyla toparlar', (WidgetTester tester) async {
    final gateway = FakeMapGateway(error: const NetworkFailure());
    await tester.pumpWidget(_app(gateway));
    await tester.pumpAndSettle();
    expect(find.text('Tekrar dene'), findsOneWidget);
    expect(find.byKey(_pinKey), findsNothing);

    gateway.error = null;
    gateway.result = pinResult;
    await tester.tap(find.text('Tekrar dene'));
    await tester.pumpAndSettle();
    expect(find.byKey(_pinKey), findsOneWidget);
  });
}
