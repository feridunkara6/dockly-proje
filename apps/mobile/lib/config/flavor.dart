/// Ortam ayrımı (docs/26 §17). Gerçek değerler `--dart-define-from-file` ile gelir;
/// burada yalnız tip güvenli erişim ve varsayılanlar.
enum Flavor { dev, staging, prod }

class AppConfig {
  const AppConfig({required this.flavor, required this.apiBaseUrl});

  final Flavor flavor;
  final String apiBaseUrl;

  static const AppConfig dev = AppConfig(
    flavor: Flavor.dev,
    apiBaseUrl: 'http://localhost:3000',
  );

  bool get isProd => flavor == Flavor.prod;
}
