/// Uygulamanın tek hata dili (docs/26 §13). Sunucunun RFC 9457 `Problem`'i
/// (docs/23 §5) bu sealed aileye eşlenir; UI yalnız bu tipleri tanır, ham
/// HTTP/`type` string'i asla görmez.
sealed class AppFailure implements Exception {
  const AppFailure(this.message);

  /// Kullanıcıya gösterilebilir, yerelleştirilmiş mesaj.
  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

/// Ağ erişilemedi / bağlantı koptu.
class NetworkFailure extends AppFailure {
  const NetworkFailure([super.message = 'Bağlantı kurulamadı.']);
}

/// İstek zaman aşımına uğradı.
class TimeoutFailure extends AppFailure {
  const TimeoutFailure([super.message = 'İstek zaman aşımına uğradı.']);
}

/// Geçersiz/expired token — istemci oturumu düşürür (docs/23 §5).
class AuthFailure extends AppFailure {
  const AuthFailure([super.message = 'Oturum geçersiz.']);
}

/// Misafir yazma denemesi → istemci soft-gate açar (docs/26 §13).
class GuestNotAllowedFailure extends AppFailure {
  const GuestNotAllowedFailure([super.message = 'Bu işlem için hesap gerekli.']);
}

/// Yetki yok.
class ForbiddenFailure extends AppFailure {
  const ForbiddenFailure([super.message = 'Bu işlem için yetkiniz yok.']);
}

/// Kaynak bulunamadı (veya sahiplik dışı — sunucu sızdırmaz).
class NotFoundFailure extends AppFailure {
  const NotFoundFailure([super.message = 'Bulunamadı.']);
}

/// Alan doğrulama hataları (422) — forma alan-bazlı eşlenir.
class ValidationFailure extends AppFailure {
  const ValidationFailure(this.errors, [super.message = 'Doğrulama hatası.']);

  final List<FieldError> errors;
}

/// Durum çakışması (409) — makine-okur kod ile (duplicate-review, conflict-state...).
class ConflictFailure extends AppFailure {
  const ConflictFailure(this.code, [super.message = 'İşlem şu an yapılamıyor.']);

  final String code;
}

/// Hız sınırı (429) — istemci geri çekilir.
class RateLimitedFailure extends AppFailure {
  const RateLimitedFailure(this.retryAfterSeconds, [super.message = 'Çok fazla istek.']);

  final int? retryAfterSeconds;
}

/// Sunucu tarafı beklenmeyen (5xx).
class ServerFailure extends AppFailure {
  const ServerFailure([super.message = 'Beklenmeyen bir hata oluştu.']);
}

/// Sınıflandırılamayan istemci-tarafı hata.
class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure([super.message = 'Bir şeyler ters gitti.']);
}

/// Alan bazlı doğrulama hatası (docs/23 §5 `errors[]`).
class FieldError {
  const FieldError({required this.field, required this.code, required this.message});

  final String field;
  final String code;
  final String message;

  factory FieldError.fromJson(Map<String, dynamic> json) => FieldError(
        field: (json['field'] as String?) ?? '(root)',
        code: (json['code'] as String?) ?? 'invalid',
        message: (json['message'] as String?) ?? '',
      );
}
