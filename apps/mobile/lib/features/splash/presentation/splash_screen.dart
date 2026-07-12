import 'dart:async';
import 'dart:math' as math;

import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

/// Açılış (splash) kapısı: uygulama/site her açılışta önce markalı açılış
/// ekranını gösterir, ardından yumuşak bir geçişle asıl içeriğe (harita
/// kabuğuna) döner. Süre kısa tutulur — açılış ekranı aynı zamanda ilk veri
/// yüklemesinin saniyelerini de şık kapatır.
class SplashGate extends StatefulWidget {
  const SplashGate({
    required this.child,
    // 1600ms: marka görünür ama bekletmez (algılanan-hız kararı; eskisi 2400).
    this.duration = const Duration(milliseconds: 1600),
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
/// Scaffold + SizedBox.expand: TAM EKRAN kaplar ve Material zemini sağlar
/// (aksi hâlde metinler sarı alt çizgiyle çizilir, degrade şerit kalır).
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[DocklyColors.brandPrimary, DocklyColors.brandDeep],
            ),
          ),
          child: _SplashContent(),
        ),
      ),
    );
  }
}

/// Canlı yelkenli sahnesi: tekne dalgada usulca salınır, beyaz rüzgar çizgileri
/// esintiyle geçer ve tekneden denize bir demir iner, hafifçe aşıp geri oturur
/// ("demir tuttu" hissi — Moorira'nın 'denizde yerini bul' ruhu). Marka kuralı
/// gereği yalnız mavi + beyaz kullanılır.
class _AnimatedSail extends StatefulWidget {
  const _AnimatedSail();

  @override
  State<_AnimatedSail> createState() => _AnimatedSailState();
}

class _AnimatedSailState extends State<_AnimatedSail> with TickerProviderStateMixin {
  /// Sürekli dalga + rüzgar döngüsü.
  late final AnimationController _wave = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();

  /// Tek seferlik demir atma (kısa bir gecikmeyle başlar — önce tekne belirir).
  late final AnimationController _drop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );

  Timer? _dropDelay;

  @override
  void initState() {
    super.initState();
    _dropDelay = Timer(const Duration(milliseconds: 250), () {
      if (mounted) _drop.forward();
    });
  }

  @override
  void dispose() {
    _dropDelay?.cancel();
    _wave.dispose();
    _drop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[_wave, _drop]),
      builder: (BuildContext context, Widget? child) {
        final double phase = _wave.value * 2 * math.pi;
        final double bob = math.sin(phase) * 3;
        // easeOutBack: hedefi hafif aşıp geri döner → demir "oturur".
        final double drop = Curves.easeOutBack.transform(_drop.value);
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: _SplashScenePainter(t: _wave.value, bob: bob, drop: drop),
              ),
            ),
            // Tekne: aşağı-yukarı salınım + minik yatış (dalga hissi).
            Transform.translate(
              offset: Offset(0, 2 + bob),
              child: Transform.rotate(
                angle: math.sin(phase + 0.8) * 0.05,
                child: child,
              ),
            ),
            // Demir: teknenin UCUNDAN (baş taraf, merkezden +20 px) halatla
            // iner; ilk karelerde görünmez (gövde ardında).
            Positioned(
              top: 60 + drop * 24,
              child: Transform.translate(
                offset: const Offset(20, 0),
                child: Opacity(
                  opacity: (_drop.value * 3).clamp(0.0, 1.0).toDouble(),
                  child: const DocklyIcon(
                    DocklyIcons.amMooring,
                    size: 18,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: const DocklyIcon(DocklyIcons.sailing, size: 64, color: Color(0xFFFFFFFF)),
    );
  }
}

/// Sahne boyacısı: esintiyle süzülen rüzgar çizgileri + demir halatı.
class _SplashScenePainter extends CustomPainter {
  const _SplashScenePainter({required this.t, required this.bob, required this.drop});

  /// 0..1 dalga döngüsü.
  final double t;

  /// Teknenin anlık dikey salınımı (px) — halat tekneyle birlikte oynar.
  final double bob;

  /// 0..~1.1 demir inişi (easeOutBack sonrası değer).
  final double drop;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wind = Paint()
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    // (dikey konum oranı, faz kayması, uzunluk) — üç ayrı esinti çizgisi.
    const List<List<double>> lines = <List<double>>[
      <double>[0.18, 0.00, 30],
      <double>[0.42, 0.38, 22],
      <double>[0.30, 0.72, 26],
    ];
    for (final List<double> l in lines) {
      final double p = (t + l[1]) % 1.0;
      final double x = -32 + p * (size.width + 64);
      final double y = size.height * l[0];
      // Kenarda görünmez, ortada belirgin (yumuşak esinti).
      wind.color = const Color(0xFFFFFFFF).withValues(alpha: 0.45 * math.sin(p * math.pi));
      canvas.drawLine(Offset(x, y), Offset(x + l[2], y), wind);
    }
    // Demir halatı: teknenin UCUNDAN (baş, merkez +20 px) demire ince beyaz hat.
    if (drop > 0.02) {
      final Paint rope = Paint()
        ..color = const Color(0xB3FFFFFF)
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;
      final double cx = size.width / 2 + 20;
      canvas.drawLine(Offset(cx, 56 + bob), Offset(cx, 62 + drop * 24), rope);
    }
  }

  @override
  bool shouldRepaint(_SplashScenePainter old) =>
      old.t != t || old.bob != bob || old.drop != drop;
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
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
            // Canlı yelkenli: dalgada salınır, arkasından rüzgar çizgileri geçer.
            const SizedBox(width: 160, height: 104, child: _AnimatedSail()),
            const SizedBox(height: 16),
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
    );
  }
}
