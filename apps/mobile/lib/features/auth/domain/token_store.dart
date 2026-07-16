import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

/// Gizli anahtar-değer deposu soyutlaması — üründe Keychain/Keystore
/// (flutter_secure_storage), testte sahte. TokenStore'dan ayrı tutulur ki
/// göç (migration) mantığı eklentisiz test edilebilsin.
abstract interface class SecretKv {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// flutter_secure_storage adaptörü: iOS Keychain / Android Keystore.
class KeychainKv implements SecretKv {
  const KeychainKv();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    // Android: Keystore destekli EncryptedSharedPreferences (modern yol).
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// MOBİL kalıcı depo (mağaza fazı — denetim bulgusu: token güvenli depoda
/// değildi). Refresh token iOS'ta Keychain'e yazılır. Eski sürümden gelen
/// kullanıcı için GÖÇ: güvenli depo boşsa prefs'teki token taşınır ve oradan
/// silinir — kimse oturumunu kaybetmez. Tüm işlemler hata yutar
/// (PrefsTokenStore ile aynı sözleşme): depo erişilemezse uygulama oturumsuz
/// sürer, ÇÖKMEZ.
class SecureTokenStore implements TokenStore {
  SecureTokenStore({SecretKv kv = const KeychainKv(), TokenStore? legacy})
      : _kv = kv,
        _legacy = legacy ?? PrefsTokenStore();

  static const String _key = 'moorira_refresh_token';

  final SecretKv _kv;
  final TokenStore _legacy;

  @override
  Future<void> saveRefreshToken(String token) async {
    try {
      await _kv.write(_key, token);
    } catch (_) {}
  }

  @override
  Future<String?> readRefreshToken() async {
    try {
      final String? secure = await _kv.read(_key);
      if (secure != null && secure.isNotEmpty) {
        return secure;
      }
      // Göç: eski prefs deposundan taşı (bir kez; sonrasında hep Keychain).
      final String? old = await _legacy.readRefreshToken();
      if (old == null || old.isEmpty) {
        return null;
      }
      await _kv.write(_key, old);
      await _legacy.clear();
      return old;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _kv.delete(_key);
    } catch (_) {}
    try {
      await _legacy.clear();
    } catch (_) {}
  }
}
