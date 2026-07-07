import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/bootstrap.dart';
import 'package:dockly_mobile/config/flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DocklyApp iskeleti "Dockly" başlığını render eder', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: DocklyApp()),
    );
    expect(find.text('Dockly'), findsOneWidget);
    expect(find.text('Denizdeki her nokta'), findsOneWidget);
  });

  test('appConfigProvider override edilmeden okunursa hata verir (fail-fast)', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(() => container.read(appConfigProvider), throwsUnimplementedError);
  });

  test('docklyClientProvider config baseUrl ile kurulur', () {
    final container = ProviderContainer(
      overrides: <Override>[appConfigProvider.overrideWithValue(AppConfig.dev)],
    );
    addTearDown(container.dispose);
    final client = container.read(docklyClientProvider);
    expect(client.dio.options.baseUrl, AppConfig.dev.apiBaseUrl);
  });

  test('authApiProvider çözülür (DI grafiği sağlam)', () {
    final container = ProviderContainer(
      overrides: <Override>[appConfigProvider.overrideWithValue(AppConfig.dev)],
    );
    addTearDown(container.dispose);
    expect(container.read(authApiProvider), isA<AuthApi>());
  });
}
