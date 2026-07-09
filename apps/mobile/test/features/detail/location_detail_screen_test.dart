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
  testWidgets('detay yüklenince içerik gösterilir (tip + marina VHF)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway()));
    await tester.pumpAndSettle(); // Future.value çözülür → içerik.

    expect(find.byKey(LocationDetailScreen.contentKey), findsOneWidget);
    expect(find.text('Özel Marina'), findsOneWidget); // private_marina etiketi
    expect(find.text('73'), findsOneWidget); // marina VHF kanalı
    // Telefon iletişimi tıklanabilir → "harici uygulamada aç" ikonu görünür (P0).
    expect(find.byIcon(Icons.open_in_new), findsOneWidget);
  });

  testWidgets('hata → mesaj + tekrar dene', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway(error: const NetworkFailure())));
    await tester.pumpAndSettle();
    expect(find.text('Tekrar dene'), findsOneWidget);
    expect(find.byKey(LocationDetailScreen.contentKey), findsNothing);
  });
}
