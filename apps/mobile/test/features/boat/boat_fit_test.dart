import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:dockly_mobile/features/boat/presentation/boat_fit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BoatFitBadge: üç durum doğru metni gösterir', (WidgetTester tester) async {
    const List<(BoatFit, String)> cases = <(BoatFit, String)>[
      (BoatFit.fits, 'Teknen sığar'),
      (BoatFit.tooBig, 'Teknen sığmayabilir'),
      (BoatFit.unknown, 'Uygunluk bilinmiyor'),
    ];
    for (final (BoatFit fit, String text) in cases) {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: BoatFitBadge(fit: fit))),
      );
      expect(find.text(text), findsOneWidget);
    }
  });

  testWidgets('BoatFitRow: tekne tanımsızsa "Tekneni tanımla" daveti gösterilir',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: BoatFitRow(maxBoatLengthM: 40, maxDraftM: 5)),
        ),
      ),
    );
    expect(find.textContaining('Tekneni tanımla'), findsOneWidget);
  });
}
