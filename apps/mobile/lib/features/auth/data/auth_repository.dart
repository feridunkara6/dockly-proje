import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';

import '../domain/auth_gateway.dart';
import '../domain/token_store.dart';

/// Auth repository sözleşmesi (docs/26 §2 data katmanı).
abstract interface class AuthRepository {
  /// Sağlayıcıyla giriş: gateway → sunucu oturumu → token saklama → kullanıcı.
  Future<SessionUser> signIn(AuthProviderKind kind);

  /// Açılışta saklanan refresh token'dan oturumu geri yükler; yoksa/geçersizse null.
  Future<SessionUser?> restore();

  /// Çıkış: sunucuda aile iptali (best-effort) + yerel temizlik.
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthApi api,
    required AuthGateway gateway,
    required TokenStore store,
  })  : _api = api,
        _gateway = gateway,
        _store = store;

  final AuthApi _api;
  final AuthGateway _gateway;
  final TokenStore _store;

  @override
  Future<SessionUser> signIn(AuthProviderKind kind) async {
    final idToken = await _gateway.obtainIdToken(kind);
    final bundle = await _api.createSession(idToken);
    await _store.saveRefreshToken(bundle.refreshToken);
    return bundle.user;
  }

  @override
  Future<SessionUser?> restore() async {
    final refreshToken = await _store.readRefreshToken();
    if (refreshToken == null) return null;
    try {
      final bundle = await _api.refresh(refreshToken);
      await _store.saveRefreshToken(bundle.refreshToken);
      return bundle.user;
    } on AppFailure {
      // Geçersiz/expired refresh → yerel temizlik, sessiz düşüş (docs/26 §8).
      await _store.clear();
      return null;
    }
  }

  @override
  Future<void> logout() async {
    final refreshToken = await _store.readRefreshToken();
    if (refreshToken != null) {
      try {
        await _api.logout(refreshToken);
      } on AppFailure {
        // Çıkış her hâlükârda yerelde tamamlanır; sunucu hatası yutulur.
      }
    }
    await _store.clear();
  }
}
