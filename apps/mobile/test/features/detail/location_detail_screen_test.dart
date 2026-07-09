import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/core/origin_provider.dart';
import 'package:dockly_mobile/features/detail/application/location_detail_controller.dart';
import 'package:dockly_mobile/features/detail/domain/location_detail_gateway.dart';
import 'package:dockly_mobile/features/detail/presentation/location_detail_screen.dart';
import 'package:dockly_mobile/features/nearby/application/nearby_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/detail_fakes.dart';
import '../../support/nearby_fakes.dart';

/// Detay ekranı testleri: yakın-alternatifler ağ geçidi boş sahte ile override
/// edilir (aksi halde gerçek API zinciri appConfig'e ulaşıp fırlatır).
Widget _app(LocationDetailGateway gateway) {
  return ProviderScope(
    overrides: <Override>[
      locationDetailGatewayProvider.overrideWithValue(gateway),
      nearbyGatewayProvider.overrideWithValue(FakeNearbyGateway()),
    ],
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
  });

  testWidgets('telefon iletişimi tıklanabilir → "aç" ikonu görünür (P0)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway()));
    await tester.pumpAndSettle();

    // İletişim bölümü listenin altında; tembel liste onu görünür olana dek
    // kaydır (aksi hâlde henüz çizilmemiş olur).
    await tester.scrollUntilVisible(find.byIcon(Icons.open_in_new), 300);
    expect(find.byIcon(Icons.open_in_new), findsOneWidget);
  });

  testWidgets('origin biliniyorsa deniz yolu bölümü gösterilir (P2)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          locationDetailGatewayProvider.overrideWithValue(FakeLocationDetailGateway()),
          nearbyGatewayProvider.overrideWithValue(FakeNearbyGateway()),
          originProvider.overrideWith((ref) => const GeoPoint(lat: 40.0, lon: 28.93)),
        ],
        child: const MaterialApp(home: LocationDetailScreen(idOrSlug: 'loc-1')),
      ),
    );
    await tester.pumpAndSettle();
    // Deniz yolu bölümü listede aşağıda olabilir → görünene dek kaydır.
    await tester.scrollUntilVisible(find.textContaining('Deniz yolu'), 200);
    expect(find.textContaining('Deniz yolu'), findsOneWidget);
  });

  testWidgets('hata → mesaj + tekrar dene', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway(error: const NetworkFailure())));
    await tester.pumpAndSettle();
    expect(find.text('Tekrar dene'), findsOneWidget);
    expect(find.byKey(LocationDetailScreen.contentKey), findsNothing);
  });
}
