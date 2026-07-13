import 'package:dockly_api/dockly_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/flavor.dart';

/// Uygulama-geneli çekirdek sağlayıcılar (docs/26 §4). Feature modülleri bunlara
/// bağlanır; böylece bootstrap ↔ feature döngüsel bağımlılığı oluşmaz.

/// Kökten enjekte edilen yapılandırma (bootstrap override eder).
final Provider<AppConfig> appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError('appConfigProvider override edilmeli'),
);

/// Config'e bağlı Dio istemcisi.
final Provider<DocklyClient> docklyClientProvider = Provider<DocklyClient>((ref) {
  final config = ref.watch(appConfigProvider);
  return DocklyClient(baseUrl: config.apiBaseUrl);
});

/// Auth API istemcisi.
final Provider<AuthApi> authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(docklyClientProvider).dio);
});

/// Lokasyon (harita/nearby/detay) API istemcisi — anonim uçlar.
final Provider<LocationsApi> locationsApiProvider = Provider<LocationsApi>((ref) {
  return LocationsApi(ref.watch(docklyClientProvider).dio);
});

/// Rüzgâr/hava tahmini API istemcisi — anonim uç (MET Norway, sunucu proksili).
final Provider<WeatherApi> weatherApiProvider = Provider<WeatherApi>((ref) {
  return WeatherApi(ref.watch(docklyClientProvider).dio);
});
