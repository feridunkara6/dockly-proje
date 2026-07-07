import 'package:dockly_core/dockly_core.dart';

/// Giriş sağlayıcıları (docs/23 §3). email/phone detay akışları 2.4c ekranlarında.
enum AuthProviderKind { apple, google, email, phone, guest }

/// Firebase kimlik köprüsü arayüzü (docs/26 §8). Sağlayıcı ile oturum açar ve
/// sunucuya verilecek Firebase ID token'ını döndürür. Gerçek implementasyon
/// (firebase_auth + Apple/Google eklentileri) bir Firebase projesi gerektirdiği
/// için 2.4c'de eklenecek; şimdilik arayüz + stub + testte sahte.
abstract interface class AuthGateway {
  Future<String> obtainIdToken(AuthProviderKind kind);
}

/// Firebase henüz yapılandırılmadığında kullanılan güvenli varsayılan.
/// Butona basılırsa kullanıcıya nazik bir mesaj gösterilir (çökme yok).
class StubAuthGateway implements AuthGateway {
  const StubAuthGateway();

  @override
  Future<String> obtainIdToken(AuthProviderKind kind) async {
    throw const UnexpectedFailure(
      'Giriş sağlayıcısı henüz hazır değil. Firebase kurulumu sonrası aktifleşecek.',
    );
  }
}
