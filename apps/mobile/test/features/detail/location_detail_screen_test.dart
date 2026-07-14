import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/core/origin_provider.dart';
import 'package:dockly_mobile/features/detail/application/location_detail_controller.dart';
import 'package:dockly_mobile/features/detail/domain/location_detail_gateway.dart';
import 'package:dockly_mobile/features/detail/presentation/location_detail_screen.dart';
import 'package:dockly_mobile/features/nearby/application/nearby_controller.dart';
import 'package:dockly_mobile/features/reviews/application/reviews_controller.dart';
import 'package:dockly_mobile/features/weather/application/weather_controller.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/detail_fakes.dart';
import '../../support/nearby_fakes.dart';
import '../../support/reviews_fakes.dart';
import '../../support/weather_fakes.dart';

/// İkonlar artık SVG tabanlı [DocklyIcon]; Material `find.byIcon` yerine ikon
/// verisiyle bulunur.
Finder _docklyIcon(DocklyIconData d) =>
    find.byWidgetPredicate((Widget w) => w is DocklyIcon && w.data == d);

/// Detay ekranı testleri: yakın-alternatifler ve yorumlar ağ geçitleri boş sahte
/// ile override edilir (aksi halde gerçek API zinciri appConfig'e ulaşıp fırlatır).
Widget _app(LocationDetailGateway gateway) {
  return ProviderScope(
    overrides: <Override>[
      locationDetailGatewayProvider.overrideWithValue(gateway),
      nearbyGatewayProvider.overrideWithValue(FakeNearbyGateway()),
      reviewsGatewayProvider.overrideWithValue(FakeReviewsGateway()),
      weatherGatewayProvider.overrideWithValue(FakeWeatherGateway()),
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
    // VHF '73' bilgi bölümünde (listede aşağıda) — tembel liste onu görünür
    // olana dek kaydır (aksi hâlde henüz çizilmemiş olur).
    await tester.scrollUntilVisible(find.text('73'), 300);
    expect(find.text('73'), findsOneWidget); // marina VHF kanalı
  });

  testWidgets('telefon iletişimi tıklanabilir → "aç" ikonu görünür (P0)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway()));
    await tester.pumpAndSettle();

    // İletişim bölümü listenin altında; tembel liste onu görünür olana dek
    // kaydır (aksi hâlde henüz çizilmemiş olur).
    await tester.scrollUntilVisible(_docklyIcon(DocklyIcons.openInNew), 300);
    expect(_docklyIcon(DocklyIcons.openInNew), findsOneWidget);
  });

  testWidgets('origin biliniyorsa deniz yolu bölümü gösterilir (P2)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          locationDetailGatewayProvider.overrideWithValue(FakeLocationDetailGateway()),
          nearbyGatewayProvider.overrideWithValue(FakeNearbyGateway()),
          reviewsGatewayProvider.overrideWithValue(FakeReviewsGateway()),
      weatherGatewayProvider.overrideWithValue(FakeWeatherGateway()),
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

  testWidgets('demirleme koyunda Rezervasyon Talebi YOK; notlar KOYA ÖZEL',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _app(FakeLocationDetailGateway(result: sampleAnchorageDetail)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rezervasyon Talebi'), findsNothing);
    await tester.scrollUntilVisible(find.text('Demirleme Notları'), 200);
    expect(find.text('Demirleme Notları'), findsOneWidget);
    expect(find.textContaining('ilk gelen demirler'), findsOneWidget);
    expect(find.textContaining('Ücretsiz demirleme alanı'), findsOneWidget);
    // Koya özel yapısal satırlar: zemin (holdingType=mud) + derinlik (7-8 m).
    expect(find.text('Zemin: Çamur'), findsOneWidget);
    expect(find.text('Derinlik: 7–8 m'), findsOneWidget);
    // Açıklamadaki demirleme + DİKKAT cümleleri karta taşındı (tek kopya)…
    expect(find.textContaining('tutuş iyidir'), findsOneWidget);
    expect(find.textContaining('tekil kaya'), findsOneWidget);
    // …koyu anlatan metin altta açıklama olarak duruyor. CI dersi: kart
    // uzadığı için açıklama görünür alanın DIŞINDA kalıyor ve tembel liste
    // onu kurmuyor — görünene dek kaydır, sonra doğrula.
    await tester.scrollUntilVisible(
        find.textContaining('her yönden korunaklı'), 200);
    expect(find.textContaining('her yönden korunaklı'), findsOneWidget);
    // Eski sabit içerik kalktı — koya özel olmayan öneri artık gösterilmez.
    expect(find.textContaining('Genel öneri'), findsNothing);
  });

  testWidgets('koya özel veri yoksa notlarda dürüst yedek metin gösterilir',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _app(FakeLocationDetailGateway(result: sampleBareAnchorageDetail)),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Demirleme Notları'), 200);
    expect(find.textContaining('kayıtlı zemin ve uyarı bilgisi henüz yok'),
        findsOneWidget);
    // İşaret içermeyen açıklama olduğu gibi altta kalır (tembel liste:
    // görünene dek kaydır — kart kısayken de güvenli, zaten görünürse
    // kaydırma hiç yapılmaz).
    await tester.scrollUntilVisible(
        find.textContaining('Zeytinlikler arasında'), 200);
    expect(find.textContaining('Zeytinlikler arasında'), findsOneWidget);
    // priceTier 'unknown' → "Ücretsiz" iddiası YOK (0-uydurma).
    expect(find.textContaining('Ücretsiz demirleme alanı'), findsNothing);
  });

  testWidgets('marinada Rezervasyon Talebi düğmesi DURUYOR',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeLocationDetailGateway()));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Rezervasyon Talebi'), 200);
    expect(find.text('Rezervasyon Talebi'), findsOneWidget);
  });
}
