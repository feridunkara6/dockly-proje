import 'package:dockly_mobile/config/flavor.dart';
import 'package:dockly_mobile/core/l10n/app_locale.dart';
import 'package:dockly_mobile/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Veri çevirisi turu (2026-07): istemci seçili uygulama dilini
/// Accept-Language başlığıyla sunucuya iletir; sunucu koy açıklamalarını
/// bu dilde döner (location_i18n). Dil değişince istemci yeniden kurulur.
ProviderContainer _container(AppLocale locale) {
  final ProviderContainer c = ProviderContainer(
    overrides: <Override>[
      appConfigProvider.overrideWithValue(AppConfig.dev),
      appLocaleProvider.overrideWith(() => AppLocaleController(locale)),
    ],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  test('istemci başlığı seçili dili taşır (ru)', () {
    final ProviderContainer c = _container(AppLocale.ru);
    final Map<String, dynamic> headers =
        c.read(docklyClientProvider).dio.options.headers;
    expect(headers['Accept-Language'], 'ru');
  });

  test('varsayılan dil Türkçe → başlık tr', () {
    final ProviderContainer c = _container(AppLocale.tr);
    expect(
      c.read(docklyClientProvider).dio.options.headers['Accept-Language'],
      'tr',
    );
  });

  test('dil değişince istemci yeni dille yeniden kurulur', () async {
    final ProviderContainer c = _container(AppLocale.tr);
    expect(
      c.read(docklyClientProvider).dio.options.headers['Accept-Language'],
      'tr',
    );
    await c.read(appLocaleProvider.notifier).set(AppLocale.es);
    expect(
      c.read(docklyClientProvider).dio.options.headers['Accept-Language'],
      'es',
    );
  });
}
