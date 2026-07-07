/// Oturum paketi DTO'ları — sunucu `SessionBundle` sözleşmesi (docs/23 §3.1).
/// Elle yazılmış immutable sınıflar (2.4a'da codegen'siz; freezed'e geçiş bir
/// sonraki mobil alt fazında değerlendirilecek — mimari etkilenmez, docs/26 §6).
class SessionUser {
  const SessionUser({
    required this.id,
    required this.role,
    required this.isGuest,
    required this.locale,
  });

  final String id;
  final String role;
  final bool isGuest;
  final String locale;

  factory SessionUser.fromJson(Map<String, dynamic> json) => SessionUser(
        id: json['id'] as String,
        role: json['role'] as String,
        isGuest: json['isGuest'] as bool,
        locale: json['locale'] as String,
      );
}

class SessionBundle {
  const SessionBundle({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;

  /// Access token ömrü (saniye).
  final int expiresIn;
  final String refreshToken;
  final SessionUser user;

  factory SessionBundle.fromJson(Map<String, dynamic> json) => SessionBundle(
        accessToken: json['accessToken'] as String,
        expiresIn: json['expiresIn'] as int,
        refreshToken: json['refreshToken'] as String,
        user: SessionUser.fromJson(json['user'] as Map<String, dynamic>),
      );
}
