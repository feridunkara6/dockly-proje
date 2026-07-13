import 'package:dockly_mobile/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _gate(DateTime time, {Duration duration = const Duration(milliseconds: 200)}) {
  return ProviderScope(
    child: MaterialApp(
      home: SplashGate(
        duration: duration,
        now: () => time,
        child: const Scaffold(body: Text('HARITA')),
      ),
    ),
  );
}

/// Adı verilen açılış görselini taşıyan Image widget'ını bulur.
Finder _asset(String name) => find.byWidgetPredicate((Widget w) =>
    w is Image &&
    w.image is AssetImage &&
    (w.image as AssetImage).assetName.contains(name));

void main() {
  test('gece kabulü: 19:00 ve sonrası ile 07:00 öncesi gecedir', () {
    expect(splashIsNight(DateTime(2026, 1, 1, 12)), isFalse);
    expect(splashIsNight(DateTime(2026, 1, 1, 18, 59)), isFalse);
    expect(splashIsNight(DateTime(2026, 1, 1, 19)), isTrue);
    expect(splashIsNight(DateTime(2026, 1, 1, 23)), isTrue);
    expect(splashIsNight(DateTime(2026, 1, 1, 5)), isTrue);
    expect(splashIsNight(DateTime(2026, 1, 1, 7)), isFalse);
  });

  testWidgets('gündüz (12:00): aydınlık görsel + rota; içerik ARKADA hazırlanır',
      (WidgetTester tester) async {
    await tester.pumpWidget(_gate(DateTime(2026, 7, 13, 12)));
    await tester.pump();

    expect(_asset('splash_gunduz'), findsOneWidget);
    expect(_asset('splash_gece'), findsNothing);
    expect(find.byKey(const ValueKey<String>('splash-route')), findsOneWidget);
    // PERF sözleşmesi: içerik açılış ekranı görünürken de KURULUDUR (arkada
    // yüklenir) — kararma bitince hazır harita karşılar.
    expect(find.text('HARITA'), findsOneWidget);

    // Süre dolar + kararma biter → açılış katmanı ağaçtan tamamen kalkar.
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('HARITA'), findsOneWidget);
    expect(_asset('splash_gunduz'), findsNothing);
    expect(find.byKey(const ValueKey<String>('splash-route')), findsNothing);
  });

  testWidgets('gece (22:00): koyu görsel kullanılır', (WidgetTester tester) async {
    await tester.pumpWidget(_gate(DateTime(2026, 7, 13, 22)));
    await tester.pump();

    expect(_asset('splash_gece'), findsOneWidget);
    expect(_asset('splash_gunduz'), findsNothing);

    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 700));
    expect(_asset('splash_gece'), findsNothing);
    expect(find.text('HARITA'), findsOneWidget);
  });

  testWidgets('sabaha karşı (05:00) da koyu görsel kullanılır',
      (WidgetTester tester) async {
    await tester.pumpWidget(_gate(DateTime(2026, 7, 13, 5)));
    await tester.pump();
    expect(_asset('splash_gece'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('HARITA'), findsOneWidget);
  });
}
