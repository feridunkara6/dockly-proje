import 'package:dockly_mobile/features/favorites/domain/favorite_location.dart';
import 'package:dockly_mobile/features/favorites/domain/favorites_storage.dart';

/// Bellek-içi sahte favori deposu — testte gerçek `shared_preferences` yerine.
class FakeFavoritesStorage implements FavoritesStorage {
  FakeFavoritesStorage([this.initial = const <FavoriteLocation>[]]);

  List<FavoriteLocation> initial;
  List<FavoriteLocation> saved = const <FavoriteLocation>[];
  int saveCount = 0;

  @override
  Future<List<FavoriteLocation>> load() async => initial;

  @override
  Future<void> save(List<FavoriteLocation> favorites) async {
    saved = favorites;
    saveCount++;
  }
}

const FavoriteLocation favA =
    FavoriteLocation(id: 'a', name: 'Aliman', type: 'marina', city: 'Muğla');
const FavoriteLocation favB =
    FavoriteLocation(id: 'b', name: 'Bkoy', type: 'anchorage');
