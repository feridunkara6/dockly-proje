import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/auth_repository.dart';
import '../domain/auth_gateway.dart';
import '../domain/auth_state.dart';
import '../domain/token_store.dart';

/// Giriş sağlayıcısı — Firebase kurulunca StubAuthGateway gerçek impl ile override edilir.
final Provider<AuthGateway> authGatewayProvider =
    Provider<AuthGateway>((ref) => const StubAuthGateway());

/// Token deposu — 2.4c'de secure storage impl ile override edilecek (keepAlive).
final Provider<TokenStore> tokenStoreProvider =
    Provider<TokenStore>((ref) => InMemoryTokenStore());

final Provider<AuthRepository> authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    api: ref.watch(authApiProvider),
    gateway: ref.watch(authGatewayProvider),
    store: ref.watch(tokenStoreProvider),
  );
});

/// Oturum durumu (docs/26 §4). Ekranlar bunu izler; hata istisna olarak fırlar,
/// çağıran ekran yakalayıp AppFailure.message'ı gösterir.
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthRestoring();

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  /// Açılışta çağrılır — saklanan oturumu geri yükler.
  Future<void> restore() async {
    final user = await _repo.restore();
    state = user == null ? const Unauthenticated() : Authenticated(user);
  }

  /// Sağlayıcıyla giriş; başarısızlıkta AppFailure fırlatır (durum değişmez).
  Future<void> signIn(AuthProviderKind kind) async {
    final user = await _repo.signIn(kind);
    state = Authenticated(user);
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const Unauthenticated();
  }
}

final NotifierProvider<AuthController, AuthState> authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
