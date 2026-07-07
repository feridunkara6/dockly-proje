import 'bootstrap.dart';
import 'config/flavor.dart';

/// Varsayılan giriş (dev). Flavor'a özel main_dev/main_stg/main_prod girişleri
/// build yapılandırmasıyla (docs/26 §17) bir sonraki alt fazda eklenecek.
void main() {
  bootstrap(AppConfig.dev);
}
