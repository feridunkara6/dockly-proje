import 'package:dio/dio.dart';
import 'package:dockly_core/dockly_core.dart';

/// RFC 9457 `application/problem+json` → `AppFailure` (docs/26 §6 ProblemInterceptor,
/// §13 eşleme). `type` URI'sinin son parçası makine sözleşmesidir; istemci mesajı değil
/// KODU eşler. Ham hata asla UI'a sızmaz.
AppFailure mapDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const TimeoutFailure();
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.cancel:
      return const NetworkFailure('İstek iptal edildi.');
    case DioExceptionType.badCertificate:
      return const NetworkFailure('Güvenli bağlantı kurulamadı.');
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      final response = error.response;
      if (response == null) return const NetworkFailure();
      return mapProblemResponse(response.statusCode, response.data);
  }
}

/// Status + gövde (problem+json beklenir) → AppFailure.
AppFailure mapProblemResponse(int? status, Object? body) {
  final problem = body is Map<String, dynamic> ? body : const <String, dynamic>{};
  final type = _typeSlug(problem['type']);
  final detail = problem['detail'] as String?;
  final title = problem['title'] as String?;
  final message = detail ?? title;

  switch (type) {
    case 'invalid-token':
    case 'token-expired':
      return AuthFailure(message ?? 'Oturum geçersiz.');
    case 'guest-not-allowed':
      return GuestNotAllowedFailure(message ?? 'Bu işlem için hesap gerekli.');
    case 'forbidden':
      return ForbiddenFailure(message ?? 'Yetkiniz yok.');
    case 'not-found':
      return NotFoundFailure(message ?? 'Bulunamadı.');
    case 'validation-error':
      return ValidationFailure(_parseErrors(problem['errors']), message ?? 'Doğrulama hatası.');
    case 'duplicate-review':
    case 'duplicate-request':
    case 'conflict-state':
      return ConflictFailure(type!, message ?? 'İşlem şu an yapılamıyor.');
    case 'rate-limited':
      return RateLimitedFailure(_retryAfter(problem), message ?? 'Çok fazla istek.');
    case 'payload-too-large':
      return UnexpectedFailure(message ?? 'İçerik çok büyük.');
    default:
      if (status != null && status >= 500) return ServerFailure(message ?? 'Sunucu hatası.');
      if (status == 401) return AuthFailure(message ?? 'Oturum geçersiz.');
      if (status == 403) return ForbiddenFailure(message ?? 'Yetkiniz yok.');
      if (status == 404) return NotFoundFailure(message ?? 'Bulunamadı.');
      return UnexpectedFailure(message ?? 'Bir şeyler ters gitti.');
  }
}

String? _typeSlug(Object? type) {
  if (type is! String || type.isEmpty) return null;
  final trimmed = type.endsWith('/') ? type.substring(0, type.length - 1) : type;
  final slash = trimmed.lastIndexOf('/');
  return slash == -1 ? trimmed : trimmed.substring(slash + 1);
}

List<FieldError> _parseErrors(Object? raw) {
  if (raw is! List) return const <FieldError>[];
  return raw
      .whereType<Map<String, dynamic>>()
      .map(FieldError.fromJson)
      .toList(growable: false);
}

int? _retryAfter(Map<String, dynamic> problem) {
  final value = problem['retryAfterSeconds'];
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}
