import 'dart:math';

import 'package:dio/dio.dart';

/// Dio örneği fabrikası (docs/26 §6). İstek kimliği + dil başlıkları burada;
/// auth/refresh interceptor'ı token deposu gerektirdiği için uygulama katmanında
/// (bir sonraki mobil alt faz) eklenir.
class DocklyClient {
  DocklyClient({required String baseUrl, String locale = 'tr', Dio? dio})
      : dio = dio ?? Dio() {
    this.dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 15)
      ..headers['Accept-Language'] = locale
      ..headers['Content-Type'] = 'application/json';
    this.dio.interceptors.add(_RequestIdInterceptor());
  }

  final Dio dio;

  /// Sunucuyu erkenden uyandırır (ücretsiz barındırmada uykudan dönüş uzun
  /// sürer; uygulama açılır açılmaz atılan bu hafif istek, kullanıcı haritaya
  /// bakarken sunucunun ısınmasını sağlar). En iyi çaba: hata yutulur.
  Future<void> warmUp() async {
    try {
      await dio.get<void>('/healthz');
    } catch (_) {
      // sessizce geç — asıl istekler kendi hatalarını yönetir
    }
  }
}

/// Her isteğe korelasyon kimliği ekler (docs/23 §18). Sunucu aynı başlığı yanıta yansıtır.
class _RequestIdInterceptor extends Interceptor {
  final Random _random = Random();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent('X-Request-Id', _generateId);
    handler.next(options);
  }

  String _generateId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List<String>.generate(24, (_) => chars[_random.nextInt(chars.length)]).join();
  }
}
