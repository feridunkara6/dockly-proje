import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/shared_prefs_favorites_storage.dart';
import '../domain/favorite_location.dart';
import '../domain/favorites_storage.dart';

/// Favori depolama sağlayıcısı — testte sahte ile override edilir.
final Provider<FavoritesStorage> favoritesStorageProvider =
    Provider<FavoritesStorage>((ref) => const SharedPrefsFavoritesStorage());

/// Misafir/yerel favoriler. Kalp simgesine dokununca lokasyon buraya eklenir ve
/// cihazda kalıcı olur (uygulama yeniden açılınca geri yüklenir). Hesap
/// gerektirmez — "önce misafir" (docs/01-prd). Depolama en iyi çaba.
class FavoritesController extends Notifier<List<FavoriteLocation>> {
  /// Açılış-yüklemesi (restore) tamamlanmadan kullanıcının kaldırdığı id'ler —
  /// geç gelen restore bunları geri EKLEMEZ (yarış koruması).
  final Set<String> _removed = <String>{};

  @override
  List<FavoriteLocation> build() {
    unawaited(_restore());
    return const <FavoriteLocation>[];
  }

  FavoritesStorage get _storage => ref.read(favoritesStorageProvider);

  /// Açılışta cihazdan yükler; kayıtlıları, oturum içinde erken eklenenlerle
  /// birleştirir (id'ye göre benzersiz). Erken kaldırılanları geri getirmez.
  Future<void> _restore() async {
    final List<FavoriteLocation> stored = await _storage.load();
    if (stored.isEmpty) return;
    final Map<String, FavoriteLocation> byId = <String, FavoriteLocation>{};
    for (final FavoriteLocation f in stored) {
      if (!_removed.contains(f.id)) byId[f.id] = f;
    }
    for (final FavoriteLocation f in state) {
      byId[f.id] = f;
    }
    state = byId.values.toList(growable: false);
  }

  bool isFavorite(String id) => state.any((FavoriteLocation f) => f.id == id);

  void toggle(FavoriteLocation favorite) {
    if (isFavorite(favorite.id)) {
      remove(favorite.id);
    } else {
      add(favorite);
    }
  }

  void add(FavoriteLocation favorite) {
    _removed.remove(favorite.id);
    if (isFavorite(favorite.id)) return;
    state = <FavoriteLocation>[...state, favorite];
    unawaited(_storage.save(state));
  }

  void remove(String id) {
    _removed.add(id);
    state = state.where((FavoriteLocation f) => f.id != id).toList(growable: false);
    unawaited(_storage.save(state));
  }
}

final NotifierProvider<FavoritesController, List<FavoriteLocation>> favoritesProvider =
    NotifierProvider<FavoritesController, List<FavoriteLocation>>(FavoritesController.new);
