import 'package:dockly_mobile/features/favorites/application/favorites_controller.dart';
import 'package:dockly_mobile/features/favorites/domain/favorite_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/favorites_fakes.dart';

void main() {
  ProviderContainer makeContainer(FakeFavoritesStorage storage) => ProviderContainer(
        overrides: <Override>[
          favoritesStorageProvider.overrideWithValue(storage),
        ],
      );

  test('ekle / çıkar / toggle çalışır ve cihaza kaydeder', () {
    final FakeFavoritesStorage storage = FakeFavoritesStorage();
    final ProviderContainer container = makeContainer(storage);
    addTearDown(container.dispose);
    final FavoritesController controller = container.read(favoritesProvider.notifier);

    expect(container.read(favoritesProvider), isEmpty);

    controller.add(favA);
    expect(controller.isFavorite('a'), isTrue);
    expect(container.read(favoritesProvider).length, 1);

    controller.toggle(favB); // ekler
    expect(container.read(favoritesProvider).length, 2);

    controller.toggle(favA); // çıkarır
    expect(controller.isFavorite('a'), isFalse);
    expect(storage.saved.map((FavoriteLocation f) => f.id).toList(), <String>['b']);
  });

  test('aynı lokasyon iki kez eklenmez', () {
    final ProviderContainer container = makeContainer(FakeFavoritesStorage());
    addTearDown(container.dispose);
    final FavoritesController controller = container.read(favoritesProvider.notifier);

    controller.add(favA);
    controller.add(favA);
    expect(container.read(favoritesProvider).length, 1);
  });

  test('restore cihazdakileri yükler ve erken eklenenle birleştirir', () async {
    final FakeFavoritesStorage storage = FakeFavoritesStorage(<FavoriteLocation>[favA]);
    final ProviderContainer container = makeContainer(storage);
    addTearDown(container.dispose);
    final FavoritesController controller = container.read(favoritesProvider.notifier);

    controller.add(favB); // restore tamamlanmadan
    await Future<void>.delayed(Duration.zero); // restore çalışsın

    final Set<String> ids =
        container.read(favoritesProvider).map((FavoriteLocation f) => f.id).toSet();
    expect(ids, <String>{'a', 'b'});
  });
}
