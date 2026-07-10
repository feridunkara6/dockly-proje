import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/favorite_location.dart';
import '../domain/favorites_storage.dart';

/// `FavoritesStorage`'ın `shared_preferences` uygulaması. Favori listesini JSON
/// olarak cihazda saklar. Tüm işlemler en iyi çaba: hata olursa sessizce geçer
/// (ör. test ortamında eklenti yoksa) — uygulama akışı bozulmaz.
class SharedPrefsFavoritesStorage implements FavoritesStorage {
  const SharedPrefsFavoritesStorage();

  static const String _key = 'favorites.v1';

  @override
  Future<List<FavoriteLocation>> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return <FavoriteLocation>[];
      final Object? decoded = jsonDecode(raw);
      if (decoded is! List) return <FavoriteLocation>[];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(FavoriteLocation.fromJson)
          .toList(growable: false);
    } catch (_) {
      return <FavoriteLocation>[];
    }
  }

  @override
  Future<void> save(List<FavoriteLocation> favorites) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String raw = jsonEncode(
        favorites.map((FavoriteLocation f) => f.toJson()).toList(growable: false),
      );
      await prefs.setString(_key, raw);
    } catch (_) {
      // en iyi çaba — sessizce geç
    }
  }
}
