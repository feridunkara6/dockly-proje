import 'dart:async';

import 'package:dockly_api/dockly_api.dart' show LocationDetail;
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/detail/application/location_detail_controller.dart';
import 'package:dockly_mobile/features/detail/domain/location_detail_gateway.dart';
import 'package:dockly_mobile/features/detail/presentation/location_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/detail_fakes.dart';

Widget _app(LocationDetailGateway gateway) {
  return ProviderScope(
    overrides: <Override>[locationDetailGatewayProvider.overrideWithValue(gateway)],
    child: const MaterialApp(home: LocationDetailScreen(idOrSlug: 'loc-1')),
  );
}

void main() {
  testWidgets('yükleme → içerik: başlık, tip, olanak ve marina VHF gösterilir',
      (WidgetTester tester) async {
    // Yanıtı elle kontrol et: önce yükleme görünmeli, tamamlanınca içerik.
    final FakeLocationDetailGateway gateway = FakeLocationDetailGateway();
    final Completer<LocationDetail> completer = Completer<LocationDetail>();
    gateway.pending = completer;

    await tester.pumpWidget(_app(gateway));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(sampleMarinaDetail);
    await tester.pumpAndSettle();

    expect(find.byKey(LocationDetailScreen.contentKey), findsOneWidget);
    expect(find.text('Özel Marina'), findsOneWidget);
    expect(find.text('D-Marin Göcek'), findsWidgets); // AppBar + gövde başlığı
    expect(find.text('Fethiye · Muğla'), findsOneWidget);
    expect(find.text('Su'), findsOneWidget); // olanak çipi
    expect(find.text('73'), findsOneWidget); // marina VHF kanalı
    expect(find.text('Maks. su çekimi'), findsOneWidget);
  });

  testWidgets('hata → mesaj + tekrar dene', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway(error: const NetworkFailure())));
    await tester.pumpAndSettle();
    expect(find.text('Tekrar dene'), findsOneWidget);
    expect(find.byKey(LocationDetailScreen.contentKey), findsNothing);
  });
}
