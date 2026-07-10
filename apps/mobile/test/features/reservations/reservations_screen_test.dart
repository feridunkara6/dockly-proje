import 'package:dockly_mobile/features/reservations/application/reservations_controller.dart';
import 'package:dockly_mobile/features/reservations/domain/reservation_request.dart';
import 'package:dockly_mobile/features/reservations/presentation/reservations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/reservations_fakes.dart';

Widget _app(FakeReservationsStorage storage) => ProviderScope(
      overrides: <Override>[
        reservationsStorageProvider.overrideWithValue(storage),
      ],
      child: const MaterialApp(home: ReservationsScreen()),
    );

void main() {
  testWidgets('boşsa "Henüz talebin yok" ipucu gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeReservationsStorage()));
    await tester.pumpAndSettle();
    expect(find.textContaining('Henüz talebin yok'), findsOneWidget);
  });

  testWidgets('talepler listelenir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeReservationsStorage(<ReservationRequest>[reqB, reqA])));
    await tester.pumpAndSettle();
    expect(find.text('A Marina'), findsOneWidget);
    expect(find.text('B Koyu'), findsOneWidget);
    expect(find.textContaining('Ağustos ortası'), findsOneWidget); // reqB notu
  });

  testWidgets('sil düğmesi talebi kaldırır', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeReservationsStorage(<ReservationRequest>[reqA])));
    await tester.pumpAndSettle();
    expect(find.text('A Marina'), findsOneWidget);

    await tester.tap(find.byTooltip('Talebi sil'));
    await tester.pumpAndSettle();

    expect(find.text('A Marina'), findsNothing);
    expect(find.textContaining('Henüz talebin yok'), findsOneWidget);
  });
}
