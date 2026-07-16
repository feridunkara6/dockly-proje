import 'package:dockly_mobile/features/auth/domain/token_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Sahte gizli depo — Keychain davranışını eklentisiz taklit eder.
class FakeKv implements SecretKv {
  final Map<String, String> data = <String, String>{};
  bool fail = false;

  @override
  Future<String?> read(String key) async {
    if (fail) throw Exception('keychain erişilemedi');
    return data[key];
  }

  @override
  Future<void> write(String key, String value) async {
    if (fail) throw Exception('keychain erişilemedi');
    data[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    if (fail) throw Exception('keychain erişilemedi');
    data.remove(key);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String key = 'moorira_refresh_token';

  test('SecureTokenStore: yaz → oku → temizle döngüsü', () async {
    final FakeKv kv = FakeKv();
    final SecureTokenStore store =
        SecureTokenStore(kv: kv, legacy: InMemoryTokenStore());
    await store.saveRefreshToken('rt-1');
    expect(await store.readRefreshToken(), 'rt-1');
    expect(kv.data[key], 'rt-1');
    await store.clear();
    expect(await store.readRefreshToken(), isNull);
  });

  test("GÖÇ: eski prefs'teki token Keychain'e taşınır ve prefs temizlenir",
      () async {
    SharedPreferences.setMockInitialValues(<String, Object>{key: 'eski-token'});
    final FakeKv kv = FakeKv();
    final SecureTokenStore store =
        SecureTokenStore(kv: kv, legacy: PrefsTokenStore());

    // İlk okuma eski depodan taşır — kullanıcı oturumunu KAYBETMEZ.
    expect(await store.readRefreshToken(), 'eski-token');
    expect(kv.data[key], 'eski-token');
    final SharedPreferences p = await SharedPreferences.getInstance();
    expect(p.getString(key), isNull); // eski kopya silindi (tek nüsha kuralı)
  });

  test('güvenli depo doluysa göç denenmez, Keychain değeri kazanır', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{key: 'prefs-token'});
    final FakeKv kv = FakeKv();
    kv.data[key] = 'keychain-token';
    final SecureTokenStore store =
        SecureTokenStore(kv: kv, legacy: PrefsTokenStore());
    expect(await store.readRefreshToken(), 'keychain-token');
  });

  test('depo hatası YUTULUR: hiçbir işlem fırlatmaz, okuma null döner', () async {
    final FakeKv kv = FakeKv()..fail = true;
    final SecureTokenStore store =
        SecureTokenStore(kv: kv, legacy: InMemoryTokenStore());
    await store.saveRefreshToken('t'); // fırlatmamalı
    expect(await store.readRefreshToken(), isNull);
    await store.clear(); // fırlatmamalı
  });
}
