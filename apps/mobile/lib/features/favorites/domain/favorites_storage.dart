import 'favorite_location.dart';

/// Favorilerin cihazda kalıcı saklanması (docs/26 clean architecture).
/// Kontrolcü somut depolama yerine bu soyutlamaya bağlanır — testte sahte ile
/// override edilir. En iyi çaba (best-effort): hata durumunda sessizce geçer,
/// asla fırlatmaz; böylece depolama yoksa uygulama yine misafir modda çalışır.
abstract interface class FavoritesStorage {
  Future<List<FavoriteLocation>> load();
  Future<void> save(List<FavoriteLocation> favorites);
}
