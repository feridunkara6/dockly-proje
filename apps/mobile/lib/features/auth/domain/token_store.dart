/// Oturum token deposu arayüzü (docs/26 §8). Access token bellekte tutulur;
/// yalnız refresh token kalıcıdır. Kalıcı güvenli depo (flutter_secure_storage)
/// 2.4c'de gelir — o zamana dek bellek-içi depo (yeniden başlatmada sıfırlanır,
/// gerçek giriş henüz olmadığından güvenli).
abstract interface class TokenStore {
  Future<void> saveRefreshToken(String token);
  Future<String?> readRefreshToken();
  Future<void> clear();
}

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
