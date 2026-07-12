import 'dart:async';

import 'package:dockly_api/dockly_api.dart' show DocklyClient;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/flavor.dart';
import 'core/providers.dart';
import 'features/auth/application/auth_controller.dart';
import 'features/auth/domain/auth_state.dart';
import 'features/auth/presentation/sign_in_screen.dart';
import 'features/shell/presentation/dockly_shell.dart';
// Harita platform katmanı: mobilde Mapbox, web'de liste-yüzeyi (Mapbox web'de
// derlenmez). Koşullu import ile doğru dosya seçilir.
import 'platform/map_platform.dart'
    if (dart.library.html) 'platform/map_platform_web.dart' as mapplat;

/// Mapbox public erişim token'ı — `--dart-define=MAPBOX_ACCESS_TOKEN=pk...` ile
/// gelir (repoya gömülmez). Boşsa harita gri kalır ama uygulama çökmez.
const String _mapboxToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

/// Uygulama giriş noktası — ProviderScope + config bağlama (docs/26 §1 bootstrap).
void bootstrap(AppConfig config) {
  WidgetsFlutterBinding.ensureInitialized();
  mapplat.applyMapAccessToken(_mapboxToken);
  // Sunucuyu HEMEN uyandır (fire-and-forget): ücretsiz barındırma uykudaysa,
  // kullanıcı daha ilk ekrana bakarken ısınma başlasın → veri daha erken gelir.
  unawaited(DocklyClient(baseUrl: config.apiBaseUrl).warmUp());
  runApp(
    ProviderScope(
      overrides: <Override>[
        appConfigProvider.overrideWithValue(config),
        ...mapplat.mapPlatformOverrides(),
      ],
      child: const DocklyApp(),
    ),
  );
}

class DocklyApp extends StatelessWidget {
  const DocklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moorira',
      debugShowCheckedModeBanner: false,
      theme: buildDocklyTheme(Brightness.light),
      darkTheme: buildDocklyTheme(Brightness.dark),
      // MVP: uygulama 5 sekmeli kabuğa açılır; ilk sekme harita (anonim/misafir
      // keşif). Giriş akışı (AuthGate/SignInScreen) Firebase 2.4c ile bağlanacak.
      home: const DocklyShell(),
    );
  }
}

/// Oturum durumuna göre ekran seçer (docs/26 §5 — tam GoRouter 2.4c'de).
class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  @override
  void initState() {
    super.initState();
    // Açılışta saklanan oturumu geri yükle (docs/26 §8).
    Future<void>.microtask(() => ref.read(authControllerProvider.notifier).restore());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return switch (state) {
      AuthRestoring() => const _SplashView(),
      Unauthenticated() => const SignInScreen(),
      Authenticated(:final user) => _HomePlaceholder(isGuest: user.isGuest),
    };
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Geçici ana ekran — asıl harita/ana sayfa Faz 3'te.
class _HomePlaceholder extends ConsumerWidget {
  const _HomePlaceholder({required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moorira')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(isGuest ? 'Merhaba, misafir kaptan' : 'Giriş yapıldı'),
            const SizedBox(height: 16),
            DocklyButton(
              label: 'Çıkış yap',
              variant: DocklyButtonVariant.secondary,
              onPressed: () => ref.read(authControllerProvider.notifier).logout(),
            ),
          ],
        ),
      ),
    );
  }
}
