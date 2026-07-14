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

  testWidgets('kutucuklar içerikten bağımsız hepsi AYNI boyda (kullanıcı isteği)',
      (WidgetTester tester) async {
    // Dar alan: uzun değer ("karışık (kum/çamur/yosun)") 2 satıra sarar —
    // buna rağmen tüm kutular eşit yükseklikte olmalı.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: MaritimeInfoPanel(
                stats: <MaritimeStat>[
                  MaritimeStat(
                      icon: DocklyIcons.straighten, value: '7–8 m', label: 'Derinlik'),
                  MaritimeStat(
                      icon: DocklyIcons.amMooring,
                      value: 'karışık (kum/çamur/yosun)',
                      label: 'Dip tutunma'),
                  MaritimeStat(
                      icon: DocklyIcons.infoOutline, value: 'Ücretsiz', label: 'Ücret'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final double h1 =
        tester.getSize(find.byKey(const ValueKey<String>('stat-Derinlik'))).height;
    final double h2 =
        tester.getSize(find.byKey(const ValueKey<String>('stat-Dip tutunma'))).height;
    final double h3 =
        tester.getSize(find.byKey(const ValueKey<String>('stat-Ücret'))).height;
    expect(h2, h1);
    expect(h3, h1);
    expect(h1, kMaritimeStatTileHeight); // yazı ölçeği 1.0'da sabit yükseklik
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
