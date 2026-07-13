import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_mobile/features/weather/application/weather_controller.dart';
import 'package:dockly_mobile/features/weather/presentation/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/weather_fakes.dart';

Widget _app(FakeWeatherGateway gateway) {
  return ProviderScope(
    overrides: <Override>[weatherGatewayProvider.overrideWithValue(gateway)],
    child: const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: WeatherCard(position: GeoPoint(lat: 36.75, lon: 28.93)),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('tahmin gelince: başlık, knot + yön + hamle, atıf ve tahmindir ibaresi',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeWeatherGateway(result: sampleForecast())));
    await tester.pumpAndSettle();

    expect(find.text('Rüzgâr & Hava'), findsOneWidget);
    expect(find.text('14.2 kn'), findsOneWidget); // şimdiki hız — kaynaktan aynen
    expect(find.text('KB'), findsOneWidget); // 310° → Kuzeybatı
    expect(find.text('Hamle 22.4 kn'), findsOneWidget); // gust ayrıca gösterilir
    expect(find.textContaining('MET Norway'), findsOneWidget); // zorunlu atıf
    expect(find.textContaining('Tahmindir'), findsOneWidget); // dürüstlük ibaresi
  });

  testWidgets('kaynak hatasında kart sessizce gizlenir (detay sayfası bozulmaz)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeWeatherGateway()));
    await tester.pumpAndSettle();
    expect(find.text('Rüzgâr & Hava'), findsNothing);
  });

  test('compassTr: 8 yön doğru eşlenir', () {
    expect(compassTr(0), 'K');
    expect(compassTr(45), 'KD');
    expect(compassTr(90), 'D');
    expect(compassTr(135), 'GD');
    expect(compassTr(180), 'G');
    expect(compassTr(225), 'GB');
    expect(compassTr(270), 'B');
    expect(compassTr(310), 'KB');
    expect(compassTr(359), 'K');
  });
}
