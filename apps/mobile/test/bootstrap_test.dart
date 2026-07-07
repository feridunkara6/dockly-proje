import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/bootstrap.dart';
import 'package:dockly_mobile/config/flavor.dart';
import 'package:dockly_mobile/core/providers.dart';
import 'package:dockly_mobile/features/auth/application/auth_controller.dart';
import 'package:dockly_mobile/features/auth/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/auth_fakes.dart';

void main() {
  testWidgets('AuthGate: restore null → SignInScreen (S-03) gösterilir', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(FakeAuthRepository(restoreResult: null)),
        ],
        child: const MaterialApp(home: AuthGate()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SignInScreen), findsOneWidget);
    expect(find.text('Hoş geldin, kaptan.'), findsOneWidget);
  });

  testWidgets('AuthGate: restore oturum → ana ekran (çıkış butonlu)', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(FakeAuthRepository(restoreResult: testGuest)),
        ],
        child: const MaterialApp(home: AuthGate()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Merhaba, misafir kaptan'), findsOneWidget);
    expect(find.text('Çıkış yap'), findsOneWidget);
  });

  test('appConfigProvider override edilmeden okunursa fail-fast', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(() => container.read(appConfigProvider), throwsUnimplementedError);
  });

  test('docklyClientProvider config baseUrl ile kurulur', () {
    final container = ProviderContainer(
      overrides: <Override>[appConfigProvider.overrideWithValue(AppConfig.dev)],
    );
    addTearDown(container.dispose);
    expect(container.read(docklyClientProvider).dio.options.baseUrl, AppConfig.dev.apiBaseUrl);
  });

  test('authApiProvider çözülür (DI grafiği sağlam)', () {
    final container = ProviderContainer(
      overrides: <Override>[appConfigProvider.overrideWithValue(AppConfig.dev)],
    );
    addTearDown(container.dispose);
    expect(container.read(authApiProvider), isA<AuthApi>());
  });
}
