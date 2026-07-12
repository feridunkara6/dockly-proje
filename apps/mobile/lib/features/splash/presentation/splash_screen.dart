import 'dart:async';

import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

/// Açılış (splash) kapısı: uygulama/site her açılışta önce markalı açılış
/// ekranını gösterir, ardından yumuşak bir geçişle asıl içeriğe (harita
/// kabuğuna) döner. Süre kısa tutulur — açılış ekranı aynı zamanda ilk veri
/// yüklemesinin saniyelerini de şık kapatır.
class SplashGate extends StatefulWidget {
  const SplashGate({
    required this.child,
    this.duration = const Duration(milliseconds: 2400),
    super.key,
  });

  final Widget child;

  /// Açılış ekranının minimum görünme süresi (testte kısaltılır).
  final Duration duration;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  Timer? _timer;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, () {
      if (mounted) setState(() => _done = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 550),
      child: _done ? widget.child : const _SplashScreen(),
    );
  }
}

/// Marka açılış ekranı: deniz degradesi üstünde yelken ikonu, Moorira yazısı
/// ve slogan. Öğeler yumuşak biçimde belirir (tek seferlik, sonlu animasyon).
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[DocklyColors.brandPrimary, DocklyColors.brandDeep],
        ),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (BuildContext context, double t, Widget? child) {
          return Opacity(
            opacity: t,
            child: Transform.translate(offset: Offset(0, 14 * (1 - t)), child: child),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const DocklyIcon(DocklyIcons.sailing, size: 72, color: Color(0xFFFFFFFF)),
            const SizedBox(height: 20),
            const Text(
              'Moorira',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 42,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Denizde yerini bul.',
              style: TextStyle(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.85),
                fontSize: 16,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
