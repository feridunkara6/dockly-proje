import 'package:dockly_mobile/features/favorites/application/favorites_controller.dart';
import 'package:dockly_mobile/features/favorites/domain/favorite_location.dart';
import 'package:dockly_mobile/features/favorites/presentation/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/favorites_fakes.dart';

Widget _app(FakeFavoritesStorage storage) => ProviderScope(
      overrides: <Override>[
        favoritesStorageProvider.overrideWithValue(storage),
      ],
      child: const MaterialApp(home: FavoritesScreen()),
    );

void main() {
  testWidgets('boşsa "Henüz favori yok" ipucu gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeFavoritesStorage()));
    await tester.pumpAndSettle();
    expect(find.textContaining('Henüz favori yok'), findsOneWidget);
  });

  testWidgets('favoriler listelenir', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeFavoritesStorage(<FavoriteLocation>[favA, favB])));
    await tester.pumpAndSettle();
    expect(find.text('Aliman'), findsOneWidget);
    expect(find.text('Bkoy'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('çıkar düğmesi favoriyi kaldırır', (WidgetTester tester) async {
    await tester.pumpWidget(_app(FakeFavoritesStorage(<FavoriteLocation>[favA])));
    await tester.pumpAndSettle();
    expect(find.text('Aliman'), findsOneWidget);

    await tester.tap(find.byTooltip('Favorilerden çıkar'));
    await tester.pumpAndSettle();

    expect(find.text('Aliman'), findsNothing);
    expect(find.textContaining('Henüz favori yok'), findsOneWidget);
  });
}
