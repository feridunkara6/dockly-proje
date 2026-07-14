import 'package:shared_preferences/shared_preferences.dart';

/// Oturum token deposu arayüzü (docs/26 §8). Access token bellekte tutulur;
/// yalnız refresh token kalıcıdır.
abstract interface class TokenStore {
  Future<void> saveRefreshToken(String token);
  Future<String?> readRefreshToken();
  Future<void> clear();
}

/// Bellek-içi depo — testlerde ve geçici durumlarda (yeniden başlatmada sıfırlanır).
class InMemoryTokenStore implements TokenStore {
  String? _refreshToken;

  @override
  Future<void> saveRefreshToken(String token) async {
    _refreshToken = token;
  }

  @override
  Future<String?> readRefreshToken() async => _refreshToken;

  @override
  Future<void> clear() async {
    _refreshToken = null;
  }
}

/// Kalıcı depo (shared_preferences → web'de localStorage): kullanıcı sekmeyi
/// kapatıp açınca oturumu sürer. GÜVENLİK NOTU (docs/24 §7): refresh token
/// tek kullanımlık ve dönüşümlüdür (rotating) — çalınsa bile ilk yenilemede
/// aile iptal edilir; mobil sürümde flutter_secure_storage'a geçilecek.
/// Tüm işlemler hata yutar: depo erişilemezse (test VM'i, kısıtlı tarayıcı)
/// uygulama oturumsuz devam eder, ÇÖKMEZ.
class PrefsTokenStore implements TokenStore {
  static const String _key = 'moorira_refresh_token';

  @override
  Future<void> saveRefreshToken(String token) async {
    try {
      final SharedPreferences p = await SharedPreferences.getInstance();
      await p.setString(_key, token);
    } catch (_) {}
  }

  @override
  Future<String?> readRefreshToken() async {
    try {
      final SharedPreferences p = await SharedPreferences.getInstance();
      return p.getString(_key);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clear() async {
    try {
      final SharedPreferences p = await SharedPreferences.getInstance();
      await p.remove(_key);
    } catch (_) {}
  }
}
