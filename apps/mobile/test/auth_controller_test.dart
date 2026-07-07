import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/auth/application/auth_controller.dart';
import 'package:dockly_mobile/features/auth/domain/auth_gateway.dart';
import 'package:dockly_mobile/features/auth/domain/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/auth_fakes.dart';

ProviderContainer _containerWith(FakeAuthRepository repo) {
  final container = ProviderContainer(
    overrides: <Override>[authRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('başlangıç durumu AuthRestoring', () {
    final container = _containerWith(FakeAuthRepository());
    expect(container.read(authControllerProvider), isA<AuthRestoring>());
  });

  test('restore: token yoksa Unauthenticated', () async {
    final container = _containerWith(FakeAuthRepository(restoreResult: null));
    await container.read(authControllerProvider.notifier).restore();
    expect(container.read(authControllerProvider), isA<Unauthenticated>());
  });

  test('restore: geçerli oturum → Authenticated (kullanıcıyla)', () async {
    final container = _containerWith(FakeAuthRepository(restoreResult: testUser));
    await container.read(authControllerProvider.notifier).restore();
    final state = container.read(authControllerProvider);
    expect(state, isA<Authenticated>());
    expect((state as Authenticated).user.id, 'u1');
  });

  test('signIn başarı → Authenticated; repoya doğru sağlayıcı iletilir', () async {
    final repo = FakeAuthRepository(signInResult: testGuest);
    final container = _containerWith(repo);
    await container.read(authControllerProvider.notifier).signIn(AuthProviderKind.guest);
    expect(repo.signInCalls, <AuthProviderKind>[AuthProviderKind.guest]);
    final state = container.read(authControllerProvider);
    expect(state, isA<Authenticated>());
    expect((state as Authenticated).isGuest, isTrue);
  });

  test('signIn hata → AppFailure fırlar, durum değişmez (AuthRestoring)', () async {
    final repo = FakeAuthRepository(signInError: const NetworkFailure());
    final container = _containerWith(repo);
    await expectLater(
      container.read(authControllerProvider.notifier).signIn(AuthProviderKind.apple),
      throwsA(isA<NetworkFailure>()),
    );
    expect(container.read(authControllerProvider), isA<AuthRestoring>());
  });

  test('logout → Unauthenticated ve repo.logout çağrılır', () async {
    final repo = FakeAuthRepository(restoreResult: testUser);
    final container = _containerWith(repo);
    await container.read(authControllerProvider.notifier).restore();
    await container.read(authControllerProvider.notifier).logout();
    expect(repo.loggedOut, isTrue);
    expect(container.read(authControllerProvider), isA<Unauthenticated>());
  });
}
