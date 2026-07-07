import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:test/test.dart';

void main() {
  group('mapProblemResponse (docs/26 §13 eşleme)', () {
    test('type URI son parçasına göre eşler', () {
      expect(
        mapProblemResponse(403, <String, dynamic>{
          'type': 'https://api.dockly.app/problems/guest-not-allowed',
        }),
        isA<GuestNotAllowedFailure>(),
      );
      expect(
        mapProblemResponse(409, <String, dynamic>{
          'type': 'https://api.dockly.app/problems/duplicate-review',
        }),
        isA<ConflictFailure>(),
      );
    });

    test('ConflictFailure kodu type son parçasından alır', () {
      final f = mapProblemResponse(409, <String, dynamic>{
        'type': 'https://api.dockly.app/problems/conflict-state',
      });
      expect((f as ConflictFailure).code, 'conflict-state');
    });

    test('bilinmeyen type + status ile makul geri düşüş', () {
      expect(mapProblemResponse(500, null), isA<ServerFailure>());
      expect(mapProblemResponse(404, const <String, dynamic>{}), isA<NotFoundFailure>());
      expect(mapProblemResponse(401, const <String, dynamic>{}), isA<AuthFailure>());
      expect(mapProblemResponse(418, const <String, dynamic>{}), isA<UnexpectedFailure>());
    });

    test('detail mesajı korunur', () {
      final f = mapProblemResponse(404, <String, dynamic>{
        'type': 'https://api.dockly.app/problems/not-found',
        'detail': 'Lokasyon yok.',
      });
      expect(f.message, 'Lokasyon yok.');
    });

    test('retryAfterSeconds string olsa da parse edilir', () {
      final f = mapProblemResponse(429, <String, dynamic>{
        'type': 'https://api.dockly.app/problems/rate-limited',
        'retryAfterSeconds': '15',
      });
      expect((f as RateLimitedFailure).retryAfterSeconds, 15);
    });
  });
}
