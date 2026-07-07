import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:test/test.dart';

import 'support/fake_adapter.dart';

void main() {
  late FakeAdapter adapter;
  late AuthApi api;

  setUp(() {
    adapter = FakeAdapter();
    final client = DocklyClient(baseUrl: 'https://api.dockly.test');
    client.dio.httpClientAdapter = adapter;
    api = AuthApi(client.dio);
  });

  void enqueueValidBundle() {
    adapter.enqueueJson(200, <String, dynamic>{
      'accessToken': 'acc.token.value',
      'expiresIn': 900,
      'refreshToken': 'rt_abc',
      'user': <String, dynamic>{'id': 'u1', 'role': 'user', 'isGuest': false, 'locale': 'tr'},
    });
  }

  test('createSession: 200 → SessionBundle parse edilir; body doğru gönderilir', () async {
    enqueueValidBundle();
    final bundle = await api.createSession('firebase-id-token');
    expect(bundle.accessToken, 'acc.token.value');
    expect(bundle.expiresIn, 900);
    expect(bundle.user.role, 'user');
    expect(bundle.user.isGuest, isFalse);

    final sent = adapter.received.single;
    expect(sent.path, '/v1/auth/sessions');
    expect(sent.method, 'POST');
    expect((sent.data as Map)['firebaseIdToken'], 'firebase-id-token');
    expect(sent.headers['X-Request-Id'], isNotNull);
    expect(sent.headers['Accept-Language'], 'tr');
  });

  test('createSession: 422 → ValidationFailure (alan listesiyle)', () async {
    adapter.enqueueProblem(422, <String, dynamic>{
      'type': 'https://api.dockly.app/problems/validation-error',
      'title': 'Doğrulama hatası',
      'status': 422,
      'errors': <Map<String, dynamic>>[
        <String, dynamic>{'field': 'firebaseIdToken', 'code': 'too_small', 'message': 'kısa'},
      ],
    });
    final failure = await _capture(() => api.createSession('x'));
    expect(failure, isA<ValidationFailure>());
    expect((failure as ValidationFailure).errors.single.field, 'firebaseIdToken');
  });

  test('refresh: 401 invalid-token → AuthFailure', () async {
    adapter.enqueueProblem(401, <String, dynamic>{
      'type': 'https://api.dockly.app/problems/invalid-token',
      'title': 'Geçersiz kimlik',
      'status': 401,
    });
    final failure = await _capture(() => api.refresh('rt_bad'));
    expect(failure, isA<AuthFailure>());
  });

  test('createSession: 429 → RateLimitedFailure retryAfter taşır', () async {
    adapter.enqueueProblem(429, <String, dynamic>{
      'type': 'https://api.dockly.app/problems/rate-limited',
      'title': 'Çok fazla istek',
      'status': 429,
      'retryAfterSeconds': 30,
    });
    final failure = await _capture(() => api.createSession('x'));
    expect(failure, isA<RateLimitedFailure>());
    expect((failure as RateLimitedFailure).retryAfterSeconds, 30);
  });

  test('logout: 204 → hata yok, idempotent', () async {
    adapter.enqueueEmpty(204);
    await expectLater(api.logout('rt_abc'), completes);
    expect(adapter.received.single.method, 'DELETE');
  });

  test('logoutAll: Bearer başlığı gönderilir', () async {
    adapter.enqueueEmpty(204);
    await api.logoutAll('acc.token');
    expect(adapter.received.single.headers['Authorization'], 'Bearer acc.token');
  });

  test('5xx → ServerFailure (detay sızmaz)', () async {
    adapter.enqueueProblem(500, <String, dynamic>{
      'type': 'https://api.dockly.app/problems/internal',
      'title': 'Beklenmeyen hata',
      'status': 500,
    });
    final failure = await _capture(() => api.createSession('x'));
    expect(failure, isA<ServerFailure>());
  });
}

/// Bir Future'ın fırlattığı AppFailure'ı yakalar.
Future<AppFailure> _capture(Future<void> Function() action) async {
  try {
    await action();
    fail('AppFailure bekleniyordu ama hata fırlatılmadı');
  } on AppFailure catch (f) {
    return f;
  }
}
