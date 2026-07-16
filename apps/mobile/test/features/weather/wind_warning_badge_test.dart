import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/core/l10n/app_locale.dart';
import 'package:dockly_mobile/core/l10n/l10n_strings.dart';
import 'package:dockly_mobile/features/weather/application/weather_controller.dart';
import 'package:dockly_mobile/features/weather/presentation/wind_warning_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/weather_fakes.dart';

ForecastPoint _p(int hourOffset, double kn, int dirDeg) => ForecastPoint(
      time: DateTime.utc(2026, 7, 13, 9).add(Duration(hours: hourOffset)),
      windKn: kn,
      gustKn: null,
      windDirDeg: dirDeg,
      tempC: 24,
      symbol: null,
    );

Widget _app(Widget child, {required FakeWeatherGateway gateway}) {
  return ProviderScope(
    overrides: <Override>[weatherGatewayProvider.overrideWithValue(gateway)],
    child: MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child))),
  );
}

const GeoPoint konum = GeoPoint(lat: 36.99, lon: 27.65);

void main() {
  group('computeWindWarning (birim)', () {
    test('yön verisi yoksa uyarı üretilmez (tahmin yazılmaz)', () {
      expect(computeWindWarning(null, <ForecastPoint>[_p(0, 30, 180)]), isNull);
      expect(computeWindWarning('', <ForecastPoint>[_p(0, 30, 180)]), isNull);
    });

    test('rüzgâr açık yönden değilse uyarı yok', () {
      // Koy güneye (180°) açık; rüzgâr kuzeyden (0°) — fark 180° > 30°.
      expect(computeWindWarning('G', <ForecastPoint>[_p(0, 30, 0)]), isNull);
    });

    test('eşik altı rüzgâr uyarı üretmez', () {
      expect(computeWindWarning('G', <ForecastPoint>[_p(0, 12, 180)]), isNull);
    });

    test('açık yönden eşik üstü rüzgâr → yön + en yüksek kn', () {
      final WindWarning? w = computeWindWarning('G,GD', <ForecastPoint>[
        _p(0, 14, 180),
        _p(3, 22, 175), // güneyden 22 kn — en yüksek
        _p(6, 18, 140), // keşişleme sektörü
      ]);
      expect(w, isNotNull);
      expect(w!.dir, 'G');
      expect(w.maxKn, 22);
    });

    test('sektör payı ±30°: 205° güney sayılır, 220° sayılmaz', () {
      expect(computeWindWarning('G', <ForecastPoint>[_p(0, 20, 205)]), isNotNull);
      expect(computeWindWarning('G', <ForecastPoint>[_p(0, 20, 220)]), isNull);
    });

    test('24 saatten sonraki tahmin rozeti tetiklemez', () {
      expect(
        computeWindWarning('G', <ForecastPoint>[_p(0, 5, 180), _p(30, 40, 180)]),
        isNull,
      );
    });
  });

  test('l10n: rüzgâr rozeti alanları 4 dilde eksiksiz', () {
    for (final AppLocale l in AppLocale.values) {
      final L10n t = l10nOf(l);
      for (final String c in <String>['K', 'KD', 'D', 'GD', 'G', 'GB', 'B', 'KB']) {
        expect(t.windExposedLabels.containsKey(c), isTrue, reason: '$l $c');
      }
      expect(t.wwBadgeFmt, contains('{0}'));
      expect(t.wwBadgeFmt, contains('{1}'));
    }
    expect(l10nOf(AppLocale.tr).windExposedLabel('GB'), 'Lodosa açık');
    expect(l10nOf(AppLocale.en).windExposedLabel('GB'), 'Exposed to SW');
  });

  testWidgets('rozet: açık yönden kuvvetli rüzgârda görünür (TR metniyle)',
      (WidgetTester tester) async {
    final FakeWeatherGateway gw = FakeWeatherGateway(
      result: sampleForecast(windKn: 22, windDirDeg: 180),
    );
    await tester.pumpWidget(_app(
      const WindWarningBadge(exposedDirs: 'G', position: konum),
      gateway: gw,
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey<String>('wind-warning-badge')), findsOneWidget);
    expect(find.textContaining('Güneye açık'), findsOneWidget);
    expect(find.textContaining('22 kn'), findsOneWidget);
  });

  testWidgets('rozet: yön verisi yoksa ya da tahmin alınamazsa hiç çizilmez',
      (WidgetTester tester) async {
    // Yön verisi yok → tahmin bile istenmez.
    await tester.pumpWidget(_app(
      const WindWarningBadge(exposedDirs: null, position: konum),
      gateway: FakeWeatherGateway(result: sampleForecast(windKn: 30, windDirDeg: 180)),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey<String>('wind-warning-badge')), findsNothing);

    // Tahmin hatası → sessiz gizlenir.
    await tester.pumpWidget(_app(
      const WindWarningBadge(exposedDirs: 'G', position: konum),
      gateway: FakeWeatherGateway(),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey<String>('wind-warning-badge')), findsNothing);
  });

  testWidgets('rozet: açık yön rüzgârı eşik altındaysa görünmez',
      (WidgetTester tester) async {
    // Güneye açık ama rüzgâr kuzeybatıdan (310°) — sektör dışı.
    await tester.pumpWidget(_app(
      const WindWarningBadge(exposedDirs: 'G', position: konum),
      gateway: FakeWeatherGateway(result: sampleForecast(windKn: 22, windDirDeg: 310)),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey<String>('wind-warning-badge')), findsNothing);
  });
}
