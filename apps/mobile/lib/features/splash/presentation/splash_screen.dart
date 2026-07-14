import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Açılış (splash) kapısı: uygulama her açılışta önce markalı açılış ekranını
/// gösterir, ardından yumuşak geçişle asıl içeriğe döner. GÜNDÜZ/GECE duyarlı:
/// 07:00-19:00 arası aydınlık deniz fotoğrafı, hava karardıktan sonra koyu
/// gece fotoğrafı kullanılır (ürün kararı — profesyonel marka açılışı).
/// Açılış ekranı hâlâ görünürken alttaki uygulamanın "beklemesi" gereken
/// işler (karşılama sorusu gibi) bu sağlayıcıyı dinler. Varsayılan TRUE:
/// SplashGate KULLANILMADAN kurulan ağaçlarda (testler) hiçbir şey beklemez;
/// SplashGate açılışta false yapar, bitince true'ya çevirir.
final StateProvider<bool> splashDoneProvider = StateProvider<bool>((ref) => true);

class SplashGate extends ConsumerStatefulWidget {
  const SplashGate({
    required this.child,
    // 1500ms: kullanıcı isteği (açılış hızlansın) — çizim ~0.95sn'e
    // sıkıştırıldı; marka animasyonu korunur ama bekletmez.
    this.duration = const Duration(milliseconds: 1500),
    this.now,
    super.key,
  });

  final Widget child;

  /// Açılış ekranının minimum görünme süresi (testte kısaltılır).
  final Duration duration;

  /// Saat kaynağı — testte sabitlenir; null → [DateTime.now].
  final DateTime Function()? now;

  @override
  ConsumerState<SplashGate> createState() => _SplashGateState();
}

/// Gece kabulü: 19:00 dahil sonrası ya da 07:00 öncesi ("hava kararınca").
bool splashIsNight(DateTime t) => t.hour >= 19 || t.hour < 7;

class _SplashGateState extends ConsumerState<SplashGate> {
  Timer? _timer;
  Timer? _removeTimer;
  bool _done = false; // süre doldu → kararma başlar
  bool _gone = false; // kararma bitti → açılış ağaçtan kalkar

  @override
  void initState() {
    super.initState();
    // PERF (algılanan hız): uygulama açılış ekranının ARKASINDA hemen kurulur;
    // harita, karolar ve veri splash oynarken yüklenir — kararma bittiğinde
    // kullanıcı HAZIR bir haritayla karşılaşır (soğuk başlangıç kasması biter).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(splashDoneProvider.notifier).state = false;
    });
    _timer = Timer(widget.duration, () {
      if (!mounted) return;
      setState(() => _done = true);
      ref.read(splashDoneProvider.notifier).state = true;
      // Kararma animasyonu bitince açılış katmanı tamamen kaldırılır
      // (animasyon denetleyicileri dursun — arka planda boşa iş yapmasın).
      _removeTimer = Timer(const Duration(milliseconds: 500), () {
        if (mounted) setState(() => _gone = true);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _removeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime t = (widget.now ?? DateTime.now)();
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        widget.child,
        if (!_gone)
          IgnorePointer(
            ignoring: _done,
            child: AnimatedOpacity(
              opacity: _done ? 0 : 1,
              duration: const Duration(milliseconds: 450),
              child: _SplashScreen(variant: splashIsNight(t) ? _gece : _gunduz),
            ),
          ),
      ],
    );
  }
}

/// Fotoğrafın piksel boyutu — kapak (cover) kırpma matematiğinin referansı.
/// İki görsel de aynı boyuttadır.
const Size _splashImageSize = Size(853, 1844);

/// Bir açılış görseli + üstüne çizilecek rotanın görsel-uzayı koordinatları
/// (0..1 normalize). Rota, TEKNEDEN çıkıp kıvrılarak ÇAPA işaretine gider;
/// noktalar her görselin kendi tekne/su kompozisyonuna göre ayarlanmıştır.
class _SplashVariant {
  const _SplashVariant({
    required this.asset,
    required this.start,
    required this.c1,
    required this.c2,
    required this.end,
  });

  final String asset;
  final Offset start; // tekne (çizginin çıkış noktası)
  final Offset c1; // bezier kontrol 1
  final Offset c2; // bezier kontrol 2
  final Offset end; // çapa pini
}

const _SplashVariant _gunduz = _SplashVariant(
  asset: 'assets/splash/splash_gunduz.jpg',
  start: Offset(0.475, 0.735),
  c1: Offset(0.61, 0.78),
  c2: Offset(0.72, 0.59),
  end: Offset(0.825, 0.600),
);

const _SplashVariant _gece = _SplashVariant(
  asset: 'assets/splash/splash_gece.jpg',
  start: Offset(0.335, 0.585),
  c1: Offset(0.44, 0.46),
  c2: Offset(0.67, 0.72),
  end: Offset(0.840, 0.565),
);

/// Fotoğrafın EKRANDAKİ yerleşim dikdörtgeni (cihaza uyum):
/// - DİKEY ekran (telefon): cover — fotoğraf ekranı doldurur, taşan kırpılır.
/// - YATAY ekran (bilgisayar/yatay tablet): contain — fotoğraf TAM BOY ortada
///   görünür (yarım görünme ve dev büyütmeden doğan kalite kaybı biter);
///   kenarlar aynı fotoğrafın bulanık dolgusuyla kaplanır.
Rect _splashImageRect(Size screen) {
  final bool wide = screen.width > screen.height;
  final double sx = screen.width / _splashImageSize.width;
  final double sy = screen.height / _splashImageSize.height;
  final double scale = wide ? math.min(sx, sy) : math.max(sx, sy);
  final double dw = _splashImageSize.width * scale;
  final double dh = _splashImageSize.height * scale;
  return Rect.fromLTWH(
    (screen.width - dw) / 2,
    (screen.height - dh) / 2,
    dw,
    dh,
  );
}

/// Görsel-uzayı normalize noktayı, fotoğrafın ekran dikdörtgenindeki gerçek
/// konumuna çevirir — çizgi her yerleşimde teknenin üzerine oturur.
Offset _mapInRect(Offset norm, Rect r) =>
    Offset(r.left + norm.dx * r.width, r.top + norm.dy * r.height);

/// Tam ekran fotoğraf + animasyonlu rota: kesik çizgi tekneden çapaya doğru
/// ÇİZİLEREK uzar, sonra kesikler rota boyunca akmaya devam eder; çapa pini
/// çizgi varınca yumuşakça belirir.
class _SplashScreen extends StatefulWidget {
  const _SplashScreen({required this.variant});

  final _SplashVariant variant;

  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen>
    with TickerProviderStateMixin {
  bool _precached = false;

  /// Tek seferlik: çizginin tekneden çapaya uzaması.
  late final AnimationController _draw = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 950),
  )..forward();

  /// Sürekli: kesiklerin rota boyunca akışı (yaşayan his).
  late final AnimationController _march = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_precached) {
      _precached = true;
      // PERF: fotoğraf ilk karede hazır olsun (beyaz parlamayı önler).
      precacheImage(AssetImage(widget.variant.asset), context);
    }
  }

  @override
  void dispose() {
    _draw.dispose();
    _march.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _SplashVariant v = widget.variant;
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints c) {
          final Size screen = Size(c.maxWidth, c.maxHeight);
          final Rect rect = _splashImageRect(screen);
          final bool wide = screen.width > screen.height;
          final Offset pin = _mapInRect(v.end, rect);
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (wide) ...<Widget>[
                // BİLGİSAYAR/YATAY: zemin, aynı fotoğrafın bulanık dolgusu —
                // bilinçli bulanık olduğundan büyütme kalitesi göze batmaz.
                RepaintBoundary(
                  child: ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                    child: Image.asset(
                      v.asset,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
                // Hafif karartma: ortadaki net fotoğraf öne çıksın.
                const ColoredBox(color: Color(0x2E06141F)),
                // Fotoğrafın TAMAMI, ekran yüksekliğinde ve NET (küçültme —
                // büyütme değil → kalite korunur).
                Positioned.fromRect(
                  rect: rect,
                  child: Image.asset(
                    v.asset,
                    fit: BoxFit.fill,
                    gaplessPlayback: true,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ] else
                // TELEFON (dikey): fotoğraf ekranı kaplar (cover).
                Image.asset(
                  v.asset,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.medium,
                ),
              AnimatedBuilder(
                animation: Listenable.merge(<Listenable>[_draw, _march]),
                builder: (BuildContext context, Widget? _) {
                  return CustomPaint(
                    key: const ValueKey<String>('splash-route'),
                    painter: _RoutePainter(
                      variant: v,
                      rect: rect,
                      progress: Curves.easeInOut.transform(_draw.value),
                      phase: _march.value,
                    ),
                  );
                },
              ),
              // Çapa pini: rota varmak üzereyken belirir + hafifçe büyür.
              AnimatedBuilder(
                animation: _draw,
                builder: (BuildContext context, Widget? child) {
                  final double t = ((_draw.value - 0.72) / 0.28).clamp(0.0, 1.0);
                  return Positioned(
                    left: pin.dx - 23,
                    top: pin.dy - 23,
                    child: Opacity(
                      opacity: t,
                      child: Transform.scale(
                        scale: 0.6 + 0.4 * Curves.easeOutBack.transform(t),
                        child: child,
                      ),
                    ),
                  );
                },
                child: const _AnchorPin(),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Rota çizgisi ressamı: kübik bezier boyunca kesik çizgi. `progress` çizginin
/// ne kadarının göründüğünü (0..1), `phase` kesiklerin akış kaymasını belirler.
class _RoutePainter extends CustomPainter {
  _RoutePainter({
    required this.variant,
    required this.rect,
    required this.progress,
    required this.phase,
  });

  final _SplashVariant variant;

  /// Fotoğrafın ekrandaki yerleşimi — rota noktaları buna göre eşlenir.
  final Rect rect;
  final double progress;
  final double phase;

  static const double _dash = 11;
  static const double _gap = 9;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.02) return;
    final Offset p0 = _mapInRect(variant.start, rect);
    final Offset p1 = _mapInRect(variant.c1, rect);
    final Offset p2 = _mapInRect(variant.c2, rect);
    final Offset p3 = _mapInRect(variant.end, rect);
    final Path path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    final ui.PathMetric metric = path.computeMetrics().first;
    final double visible = metric.length * progress;

    final Paint line = Paint()
      ..color = const Color(0xF2FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    // Okunurluk: fotoğraf üstünde ince koyu hare (iki geçişli çizim).
    final Paint halo = Paint()
      ..color = const Color(0x330A2540)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    const double period = _dash + _gap;
    // phase 0→1: kesikler çapaya DOĞRU akar (deniz rotası hissi).
    for (final Paint p in <Paint>[halo, line]) {
      for (double s = phase * period - period; s < visible; s += period) {
        final double a = math.max(0, s);
        final double b = math.min(visible, s + _dash);
        if (b > a) canvas.drawPath(metric.extractPath(a, b), p);
      }
    }
  }

  @override
  bool shouldRepaint(_RoutePainter old) =>
      old.progress != progress ||
      old.phase != phase ||
      old.variant != variant ||
      old.rect != rect;
}

/// Çapa pini — görsellerdeki dille: beyaz konturlu daire içinde çapa, altında
/// küçük işaret ucu. Fotoğrafla bütünleşsin diye zemin hafif saydamdır.
class _AnchorPin extends StatelessWidget {
  const _AnchorPin();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 52,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0x1FFFFFFF),
              border: Border.all(color: const Color(0xF2FFFFFF), width: 2.4),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x330A2540),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: DocklyIcon(
                DocklyIcons.amMooring,
                size: 21,
                color: Color(0xF2FFFFFF),
              ),
            ),
          ),
          // İşaret ucu: daireden denize inen küçük üçgen (damla hissi).
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 9,
              height: 9,
              transform: Matrix4.translationValues(0, -5, 0),
              decoration: const BoxDecoration(color: Color(0xF2FFFFFF)),
            ),
          ),
        ],
      ),
    );
  }
}
