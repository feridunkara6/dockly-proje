import 'dart:async';

import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/map/application/map_controller.dart';
import 'package:dockly_mobile/features/map/presentation/location_bottom_card.dart';
import 'package:dockly_mobile/features/map/presentation/map_screen.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_map_surface.dart';
import '../../support/map_fakes.dart';

/// İkonlar artık SVG tabanlı [DocklyIcon]; ikon verisiyle bulunur.
Finder _docklyIcon(DocklyIconData d) =>
    find.byWidgetPredicate((Widget w) => w is DocklyIcon && w.data == d);

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
    // Tip etiketi üstteki filtre çipinde de geçer; kartın İÇİNDE aranır.
    expect(
      find.descendant(
        of: find.byKey(LocationBottomCard.cardKey),
        matching: find.text('Özel Marina'),
      ),
      findsOneWidget,
    );

    await tester.tap(_docklyIcon(DocklyIcons.close));
    await tester.pumpAndSettle();
    expect(find.byKey(LocationBottomCard.cardKey), findsNothing);
  });

  testWidgets('liste görünümüne geçince liman listesi görünür', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeMapGateway(result: pinResult)));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNothing); // harita modu (sahte yüzey ListTile kullanmaz)

    await tester.tap(_docklyIcon(DocklyIcons.viewList));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsOneWidget); // liste modu, tek pin
    expect(_docklyIcon(DocklyIcons.mapOutlined), findsOneWidget); // haritaya dön ikonu
  });

  testWidgets('tip çipine dokununca filtre sunucuya geçer', (WidgetTester tester) async {
    final FakeMapGateway gateway = FakeMapGateway(result: pinResult);
    await tester.pumpWidget(_app(gateway));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilterChip, 'Özel Marina'));
    await tester.pumpAndSettle();
    expect(gateway.typeArgs.last, <String>['private_marina']);
  });

  testWidgets('ilk yüklemede dost mesaj gösterilir (sunucu uyanıyor)', (WidgetTester tester) async {
    final FakeMapGateway gateway = FakeMapGateway()..pending = Completer<MapResult>();
    await tester.pumpWidget(_app(gateway));
    // Süreli pump: sahte-saat ilerlesin ki debounce zamanlayıcısı ateşlensin
    // (bare pump() zamanlayıcıları ÇALIŞTIRMAZ — saat ilerlemez).
    await tester.pump(const Duration(milliseconds: 20));
    await tester.pump(); // durum değişikliği ekrana yansır
    expect(find.textContaining('Limanlar yükleniyor'), findsOneWidget);
    gateway.pending!.complete(pinResult); // testi temiz bitir
    await tester.pumpAndSettle();
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
