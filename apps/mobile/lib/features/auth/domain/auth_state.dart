import 'package:dockly_api/dockly_api.dart';

/// Oturum durum makinesi (docs/26 §4 authState). Router/AuthGate bunu dinler.
sealed class AuthState {
  const AuthState();
}

/// Uygulama açılışı — saklanan token'dan oturum geri yükleniyor.
class AuthRestoring extends AuthState {
  const AuthRestoring();
}

/// Oturum yok — giriş ekranı gösterilir.
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Oturum açık. `user.isGuest` misafir/kayıtlı ayrımını taşır (docs/23 §3.3).
class Authenticated extends AuthState {
  const Authenticated(this.user);

  final SessionUser user;

  bool get isGuest => user.isGuest;
}
