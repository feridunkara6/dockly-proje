import 'package:dockly_mobile/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('açılışta marka + slogan görünür; süre dolunca içeriğe geçilir',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashGate(
          duration: Duration(milliseconds: 200),
          child: Scaffold(body: Text('HARITA')),
        ),
      ),
    );

    // Açılış ekranı: marka ve slogan ekranda, içerik henüz yok.
    expect(find.text('Moorira'), findsOneWidget);
    expect(find.text('Denizde yerini bul.'), findsOneWidget);
    expect(find.text('HARITA'), findsNothing);

    // Süre dolar + geçiş animasyonu biter → içerik görünür, açılış kaybolur.
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('HARITA'), findsOneWidget);
    expect(find.text('Moorira'), findsNothing);
  });
}
