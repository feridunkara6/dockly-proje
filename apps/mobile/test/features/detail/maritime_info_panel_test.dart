import 'package:dockly_mobile/features/detail/presentation/maritime_info_panel.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('stat kartları değer + etiketi gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MaritimeInfoPanel(
            stats: <MaritimeStat>[
              MaritimeStat(icon: DocklyIcons.radio, value: '73', label: 'VHF kanalı'),
              MaritimeStat(icon: DocklyIcons.amMooring, value: '380', label: 'Bağlama'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Denizci Bilgileri'), findsOneWidget);
    expect(find.text('73'), findsOneWidget);
    expect(find.text('VHF kanalı'), findsOneWidget);
    expect(find.text('380'), findsOneWidget);
    expect(find.text('Bağlama'), findsOneWidget);
  });

  testWidgets('stat yoksa panel yer kaplamaz (boş durum)', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: MaritimeInfoPanel(stats: <MaritimeStat>[])),
      ),
    );

    expect(find.text('Denizci Bilgileri'), findsNothing);
    expect(find.byType(MaritimeInfoPanel), findsOneWidget);
  });
}
