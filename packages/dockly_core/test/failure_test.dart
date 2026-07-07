import 'package:dockly_core/dockly_core.dart';
import 'package:test/test.dart';

void main() {
  group('AppFailure', () {
    test('sealed alt tipleri AppFailure ve Exception', () {
      const failures = <AppFailure>[
        NetworkFailure(),
        TimeoutFailure(),
        AuthFailure(),
        GuestNotAllowedFailure(),
        ForbiddenFailure(),
        NotFoundFailure(),
        ConflictFailure('conflict-state'),
        RateLimitedFailure(30),
        ServerFailure(),
        UnexpectedFailure(),
        ValidationFailure(<FieldError>[]),
      ];
      for (final f in failures) {
        expect(f, isA<Exception>());
        expect(f.message, isNotEmpty);
      }
    });

    test('ConflictFailure kodu taşır', () {
      const f = ConflictFailure('duplicate-review');
      expect(f.code, 'duplicate-review');
    });

    test('RateLimitedFailure retryAfter taşır (null da olabilir)', () {
      expect(const RateLimitedFailure(42).retryAfterSeconds, 42);
      expect(const RateLimitedFailure(null).retryAfterSeconds, isNull);
    });

    test('ValidationFailure alan hatalarını taşır', () {
      const f = ValidationFailure(<FieldError>[
        FieldError(field: 'email', code: 'invalid', message: 'Geçersiz'),
      ]);
      expect(f.errors, hasLength(1));
      expect(f.errors.first.field, 'email');
    });

    test('FieldError.fromJson eksik alanlara güvenli varsayılan verir', () {
      final e = FieldError.fromJson(<String, dynamic>{});
      expect(e.field, '(root)');
      expect(e.code, 'invalid');
    });

    test('switch üzerinde exhaustive eşleme (sealed garanti)', () {
      String label(AppFailure f) => switch (f) {
            NetworkFailure() => 'net',
            TimeoutFailure() => 'timeout',
            AuthFailure() => 'auth',
            GuestNotAllowedFailure() => 'guest',
            ForbiddenFailure() => 'forbidden',
            NotFoundFailure() => 'notfound',
            ValidationFailure() => 'validation',
            ConflictFailure() => 'conflict',
            RateLimitedFailure() => 'rate',
            ServerFailure() => 'server',
            UnexpectedFailure() => 'unexpected',
          };
      expect(label(const NetworkFailure()), 'net');
      expect(label(const ConflictFailure('x')), 'conflict');
    });
  });
}
