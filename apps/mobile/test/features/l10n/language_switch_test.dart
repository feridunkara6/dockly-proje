import 'package:dockly_mobile/core/l10n/app_locale.dart';
import 'package:dockly_mobile/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app({AppLocale? locale}) {
  return ProviderScope(
    overrides: <Override>[
      if (locale != null)
        appLocaleProvider.overrideWith(() => AppLocaleController(locale)),
    ],
    child: const MaterialApp(home: ProfileScreen()),
  );
}

void main() {
  testWidgets('varsayılan dil Türkçe; dil satırı ve menü değeri görünür',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.text('Teknem'), findsOneWidget);
    expect(find.text('Dil'), findsOneWidget);
    expect(find.text('Türkçe'), findsOneWidget); // menünün seçili değeri
  });

  testWidgets('menüden İngilizce seçilince ekran ANINDA İngilizceleşir',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Türkçe'));
    await tester.pumpAndSettle(); // açılır menü
    expect(find.text('English'), findsWidgets);
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();

    expect(find.text('My Boat'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Emergency'), findsOneWidget);
    expect(find.text('Teknem'), findsNothing);
  });

  testWidgets('Rusça override → profil Rusça açılır (otomatik algılama yolu)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(locale: AppLocale.ru));
    await tester.pumpAndSettle();
    expect(find.text('Моя лодка'), findsOneWidget);
    expect(find.text('Язык'), findsOneWidget);
    expect(find.text('Русский'), findsOneWidget);
  });

  testWidgets('İspanyolca override → profil İspanyolca açılır',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(locale: AppLocale.es));
    await tester.pumpAndSettle();
    expect(find.text('Mi barco'), findsOneWidget);
    expect(find.text('Idioma'), findsOneWidget);
  });
}
