import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('etiketi gösterir ve dokunma onPressed tetikler', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(
      _host(DocklyButton(label: 'Devam et', onPressed: () => tapped++)),
    );
    expect(find.text('Devam et'), findsOneWidget);
    await tester.tap(find.byType(DocklyButton));
    await tester.pump();
    expect(tapped, 1);
  });

  testWidgets('loading: spinner gösterir, dokunma engellenir', (tester) async {
    var tapped = 0;
    await tester.pumpWidget(
      _host(DocklyButton(label: 'Gönder', loading: true, onPressed: () => tapped++)),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Gönder'), findsNothing);
    await tester.tap(find.byType(DocklyButton));
    await tester.pump();
    expect(tapped, 0);
  });

  testWidgets('onPressed null → devre dışı', (tester) async {
    await tester.pumpWidget(_host(const DocklyButton(label: 'Pasif', onPressed: null)));
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('secondary varyant OutlinedButton kullanır', (tester) async {
    await tester.pumpWidget(
      _host(DocklyButton(
        label: 'İkincil',
        variant: DocklyButtonVariant.secondary,
        onPressed: () {},
      )),
    );
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('icon verilince ikon + etiket render eder', (tester) async {
    await tester.pumpWidget(
      _host(DocklyButton(label: 'Google', icon: Icons.login, onPressed: () {})),
    );
    expect(find.byIcon(Icons.login), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
  });
}
