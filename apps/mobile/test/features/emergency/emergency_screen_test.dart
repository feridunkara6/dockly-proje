import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_mobile/core/origin_provider.dart';
import 'package:dockly_mobile/features/boat/application/my_boat_controller.dart';
import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:dockly_mobile/features/emergency/domain/emergency_content.dart';
import 'package:dockly_mobile/features/emergency/presentation/emergency_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Sabit tekne döndüren kontrolcü (depolamaya gitmez).
class _FixedBoat extends MyBoatController {
  _FixedBoat(this._boat);
  final MyBoat _boat;
  @override
  MyBoat? build() => _boat;
}

Widget _app({GeoPoint? origin, MyBoat? boat}) {
  return ProviderScope(
    overrides: <Override>[
      if (origin != null) originProvider.overrideWith((ref) => origin),
      if (boat != null) myBoatProvider.overrideWith(() => _FixedBoat(boat)),
    ],
    child: const MaterialApp(home: EmergencyScreen()),
  );
}

void main() {
  group('emergency_content (birim)', () {
    test('formatDms: ondalık → denizci biçimi (K/D, dolgulu)', () {
      expect(formatDms(36.5, 29.25), '36°30\'00.0"K 029°15\'00.0"D');
      expect(formatDms(-10.5, -3.25), '10°30\'00.0"G 003°15\'00.0"B');
    });

    test('formatDms: saniye yuvarlaması 60"a taşarsa dakika devreder', () {
      // 36.999999° → 37°00'00.0" (36°60' değil!)
      expect(formatDms(36.999999, 29.0), startsWith('37°00\''));
    });

    test('maydayTemplate: tekne adı BÜYÜK yazılır ve 3 kez tekrarlanır', () {
      final String t = maydayTemplate(boatName: 'Poyraz', position: 'X');
      expect(t, contains('MAYDAY, MAYDAY, MAYDAY'));
      expect('POYRAZ'.allMatches(t).length, 4); // BURASI ×3 + MAYDAY satırı
      expect(t, contains('KONUMUM: X'));
    });

    test('maydayTemplate: tekne adı yoksa doldurulabilir alan kalır', () {
      expect(maydayTemplate(), contains('(TEKNE ADI)'));
    });

    test('alfabe 26 harf + 10 rakam eksiksiz', () {
      expect(phoneticAlphabet.length, 26);
      expect(phoneticNumbers.length, 10);
      expect(phoneticAlphabet.first.word, 'Alfa');
      expect(phoneticAlphabet.last.word, 'Zulu');
    });
  });

  testWidgets('acil numaralar TR + GR tek dokunuş düğmeleriyle görünür',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('Tehlikede misin?'), findsOneWidget);
    expect(find.text('158'), findsOneWidget); // arama düğmesi
    expect(find.text('108'), findsOneWidget);
    expect(find.text('112'), findsNWidgets(2)); // TR ve GR bölümlerinde
    expect(find.textContaining('Sahil Güvenlik'), findsWidgets);
    expect(find.textContaining('Kanal 16'), findsWidgets);
  });

  testWidgets('konum yoksa yönlendirme metni; koordinat düğmesi çıkmaz',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.textContaining('Konum henüz alınamadı'), findsOneWidget);
    expect(find.text('Koordinatı kopyala'), findsNothing);
  });

  testWidgets('konum varsa DMS gösterilir ve kopyalama panoya yazar',
      (WidgetTester tester) async {
    final List<MethodCall> calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        calls.add(call);
        return null;
      },
    );
    await tester.pumpWidget(_app(origin: const GeoPoint(lat: 36.5, lon: 29.25)));
    await tester.pumpAndSettle();

    expect(find.text('36°30\'00.0"K 029°15\'00.0"D'), findsOneWidget);
    // CI dersi: düğme görünür alanın ALTINDA kalabiliyor — kaydır ve kaydırmanın
    // işlemesi için bir kare çizdir; yoksa tap boşa gider (hit test dışı).
    await tester.ensureVisible(find.text('Koordinatı kopyala'));
    await tester.pump();
    await tester.tap(find.text('Koordinatı kopyala'));
    await tester.pumpAndSettle();

    final MethodCall copy =
        calls.lastWhere((MethodCall c) => c.method == 'Clipboard.setData');
    expect((copy.arguments as Map<Object?, Object?>)['text'],
        contains('36°30\'00.0"K'));
    expect(find.text('Kopyalandı.'), findsOneWidget);
    // SnackBar'ın kendini kapatma zamanlayıcısını akıt (CI dersi: test sonunda
    // bekleyen Timer kalırsa çerçeve testi kırmızıya çevirir).
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('MAYDAY şablonu tekne markasıyla kişiselleşir ve kopyalanır',
      (WidgetTester tester) async {
    final List<MethodCall> calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        calls.add(call);
        return null;
      },
    );
    await tester.pumpWidget(
        _app(boat: const MyBoat(lengthM: 12, brand: 'Beneteau')));
    await tester.pumpAndSettle();

    // CI dersi: scrollUntilVisible yalnız "ağaçta bulunana" kadar kaydırır —
    // düğme görünür alana girmeden dokunuş boşa gider. ensureVisible + pump
    // ile gerçekten ekrana getir.
    await tester.ensureVisible(find.text('Şablonu kopyala'));
    await tester.pump();
    expect(find.textContaining('BURASI BENETEAU'), findsOneWidget);
    await tester.tap(find.text('Şablonu kopyala'));
    await tester.pumpAndSettle();
    final MethodCall copy =
        calls.lastWhere((MethodCall c) => c.method == 'Clipboard.setData');
    expect((copy.arguments as Map<Object?, Object?>)['text'],
        contains('MAYDAY, MAYDAY, MAYDAY'));
    // SnackBar zamanlayıcısını akıt (bekleyen Timer testi kırmızıya çevirir).
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('denizci alfabesi ve telsiz kuralları sayfada yer alır',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Denizci Alfabesi'), 300);
    expect(find.textContaining('Alfa'), findsWidgets);
    await tester.scrollUntilVisible(find.textContaining('Z · Zulu'), 300);
    expect(find.textContaining('9 · Niner'), findsOneWidget);
  });
}
