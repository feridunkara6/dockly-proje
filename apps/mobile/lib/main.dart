import 'bootstrap.dart';
import 'config/flavor.dart';

/// API adresi — `--dart-define=API_BASE_URL=https://...` ile gelir (web/prod
/// derlemesinde sunucu adresi); verilmezse yerel geliştirme varsayılanı.
const String _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:3000',
);

/// Varsayılan giriş (dev). Flavor'a özel main_dev/main_stg/main_prod girişleri
/// build yapılandırmasıyla (docs/26 §17) bir sonraki alt fazda eklenecek.
Future<void> main() {
  return bootstrap(const AppConfig(flavor: Flavor.dev, apiBaseUrl: _apiBaseUrl));
}
