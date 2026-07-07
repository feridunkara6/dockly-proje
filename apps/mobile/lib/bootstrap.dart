import 'package:dockly_api/dockly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/flavor.dart';

/// Uygulama giriş noktası — ProviderScope + config bağlama (docs/26 §1 bootstrap).
/// Auth ekranları ve router 2.4b'de eklenecek; şimdilik doğrulanabilir iskelet.
void bootstrap(AppConfig config) {
  runApp(
    ProviderScope(
      overrides: <Override>[appConfigProvider.overrideWithValue(config)],
      child: const DocklyApp(),
    ),
  );
}

/// Uygulama yapılandırması — kökten enjekte edilir (docs/26 §4 global state).
final Provider<AppConfig> appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError('appConfigProvider override edilmeli'),
);

/// API istemcisi sağlayıcısı — config'e bağlı (docs/26 §4 servis provider).
final Provider<DocklyClient> docklyClientProvider = Provider<DocklyClient>((ref) {
  final config = ref.watch(appConfigProvider);
  return DocklyClient(baseUrl: config.apiBaseUrl);
});

final Provider<AuthApi> authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(docklyClientProvider).dio);
});

class DocklyApp extends ConsumerWidget {
  const DocklyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Dockly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0C7BDC)),
        useMaterial3: true,
      ),
      home: const _SkeletonHome(),
    );
  }
}

/// 2.4a iskelet ekranı — 2.4b'de onboarding/auth ile değişecek.
class _SkeletonHome extends StatelessWidget {
  const _SkeletonHome();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Dockly', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('Denizdeki her nokta'),
          ],
        ),
      ),
    );
  }
}
