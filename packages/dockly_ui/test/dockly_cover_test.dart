import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('kapak yer tutucu: etiket + tip ikonu çizer', (WidgetTester tester) async {
    await tester.pumpWidget(
      _host(const SizedBox(
        width: 300,
        child: DocklyCoverPlaceholder(type: 'private_marina', label: 'Özel Marina'),
      )),
    );
    expect(find.text('Özel Marina'), findsOneWidget);
    // Merkez ikon + silik motif → en az bir DocklyIcon.
    expect(find.byType(DocklyIcon), findsWidgets);
  });

  testWidgets('tip avatarı: ikon çizer', (WidgetTester tester) async {
    await tester.pumpWidget(_host(const DocklyTypeAvatar(type: 'mooring_point')));
    expect(find.byType(DocklyIcon), findsOneWidget);
  });
}
