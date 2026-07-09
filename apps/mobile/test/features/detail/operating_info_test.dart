import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/detail/presentation/operating_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child)));

void main() {
  testWidgets('çalışma saatleri: açık gün + kapalı gün', (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(const OperatingInfo(
      hours: <Hour>[
        Hour(dayOfWeek: 1, opensAt: '08:00', closesAt: '22:00'),
        Hour(dayOfWeek: 2, opensAt: null, closesAt: null),
      ],
      seasons: <Season>[],
      is24h: false,
    )));
    expect(find.text('Çalışma saatleri'), findsOneWidget);
    expect(find.text('Pazartesi'), findsOneWidget);
    expect(find.text('08:00–22:00'), findsOneWidget);
    expect(find.text('Salı'), findsOneWidget);
    expect(find.text('Kapalı'), findsOneWidget);
  });

  testWidgets('7/24 → her gün 24 saat açık', (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(
      const OperatingInfo(hours: <Hour>[], seasons: <Season>[], is24h: true),
    ));
    expect(find.text('Çalışma saatleri'), findsOneWidget);
    expect(find.text('24 saat açık'), findsOneWidget);
  });

  testWidgets('sezon aralığı gösterilir', (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(const OperatingInfo(
      hours: <Hour>[],
      seasons: <Season>[Season(opensOn: '04-01', closesOn: '10-31')],
      is24h: false,
    )));
    expect(find.text('Sezon'), findsOneWidget);
    expect(find.text('1 Nis – 31 Eki'), findsOneWidget);
  });

  testWidgets('veri yoksa bölüm gizlenir', (WidgetTester tester) async {
    await tester.pumpWidget(_wrap(
      const OperatingInfo(hours: <Hour>[], seasons: <Season>[], is24h: false),
    ));
    expect(find.text('Çalışma saatleri'), findsNothing);
    expect(find.text('Sezon'), findsNothing);
  });
}
