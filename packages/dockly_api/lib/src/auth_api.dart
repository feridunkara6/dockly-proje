import 'package:dio/dio.dart';

import 'dto/session.dart';
import 'problem_mapper.dart';

/// `/v1/auth/sessions*` istemcisi (docs/23 §3.4). Tüm hatalar `AppFailure`'a eşlenir;
/// çağıran ham DioException görmez.
class AuthApi {
  const AuthApi(this._dio);

  final Dio _dio;

  /// Kayıt + giriş + misafir tek uç (Firebase ID token köprüsü).
  Future<SessionBundle> createSession(String firebaseIdToken) async {
    return _call(() async {
      final res = await _dio.post<Map<String, dynamic>>(
        '/v1/auth/sessions',
        data: <String, dynamic>{'firebaseIdToken': firebaseIdToken},
      );
      return SessionBundle.fromJson(res.data!);
    });
  }

  /// Rotating refresh — eski token iptal, yenisi aynı ailede.
  Future<SessionBundle> refresh(String refreshToken) async {
    return _call(() async {
      final res = await _dio.post<Map<String, dynamic>>(
        '/v1/auth/sessions/refresh',
        data: <String, dynamic>{'refreshToken': refreshToken},
      );
      return SessionBundle.fromJson(res.data!);
    });
  }

  /// Çıkış — refresh ailesini düşürür (idempotent).
  Future<void> logout(String refreshToken) async {
    return _call(() async {
      await _dio.delete<void>(
        '/v1/auth/sessions',
        data: <String, dynamic>{'refreshToken': refreshToken},
      );
    });
  }

  /// Tüm cihazlardan çıkış (Bearer gerekli).
  Future<void> logoutAll(String accessToken) async {
    return _call(() async {
      await _dio.delete<void>(
        '/v1/auth/sessions/all',
        options: Options(headers: <String, dynamic>{'Authorization': 'Bearer $accessToken'}),
      );
    });
  }

  Future<T> _call<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw mapDioError(error);
    }
  }
}
