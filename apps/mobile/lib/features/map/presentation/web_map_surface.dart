import 'dart:async';
import 'dart:math' as math;

import 'package:dockly_api/dockly_api.dart' show Bbox, Cluster, LocationPin;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../boat/application/my_boat_controller.dart';
import '../../boat/domain/my_boat.dart';
import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Web harita yüzeyi. Mapbox web'de çalışmadığı için tarayıcıda çalışan gerçek
/// bir harita kullanılır: flutter_map + MapTiler yumuşak stil (anahtar varsa)
/// ya da OpenStreetMap karoları (anahtarsız güvenli düşüş).
/// Görsel dil, tasarım sistemi (design/dockly-design-system.html §06 Map
/// Markers) ile birebir: damla-formlu, beyaz konturlu tip-renkli pinler; cam
/// görünümlü dairede sayı taşıyan cluster'lar; seçili pin büyür. Cluster'a
/// dokununca kamera o bölgeye yaklaşır → sunucu tekil pinleri döndürür.

/// Açılışta yüklenecek varsayılan görünüm — Ege–Marmara–İstanbul kıyısı.
/// Her kenar ≤ 5° (sunucu bbox sınırı, docs/23 §9.5) → veri hemen gelir.
const Bbox _initialBbox = Bbox(minLon: 25.9, minLat: 36.6, maxLon: 30.2, maxLat: 41.1);
const int _initialZoom = 7;

/// Harita stili: MAP_TILE_KEY verilirse MapTiler'ın stilleri kullanılır.
/// Varsayılan: aquarelle (suluboya — renkli ama "gerçek harita" hissinden uzak,
/// ürün kararı). MAP_TILE_STYLE ile ör. ocean/dataviz/streets-v2-pastel
/// seçilebilir. Anahtar yoksa OSM'e güvenli düşüş — harita asla boş kalmaz.
const String _tileKey = String.fromEnvironment('MAP_TILE_KEY');
const String _tileStyle =
    String.fromEnvironment('MAP_TILE_STYLE', defaultValue: 'aquarelle');
final String _baseTileUrl = _tileKey.isEmpty
    ? 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
    : 'https://api.maptiler.com/maps/$_tileStyle/256/{z}/{x}/{y}.png?key=$_tileKey';
final String _attributionText = _tileKey.isEmpty
    ? '© OpenStreetMap katkıcıları · OpenSeaMap'
    : '© MapTiler · © OpenStreetMap katkıcıları · OpenSeaMap';

Widget webMapSurfaceBuilder(
  BuildContext context,
  MapSurfaceData data,
  MapSurfaceCallbacks callbacks,
) {
  return _WebMapSurface(data: data, callbacks: callbacks);
}

class _WebMapSurface extends ConsumerStatefulWidget {
  const _WebMapSurface({required this.data, required this.callbacks});

  final MapSurfaceData data;
  final MapSurfaceCallbacks callbacks;

  @override
  ConsumerState<_WebMapSurface> createState() => _WebMapSurfaceState();
}

/// Sunucu pin eşiğinin aynası (apps/api cluster.ts MIN_PIN_ZOOM): zoom ≥ 10 →
/// pin modu. Eşik GEÇİLİRKEN debounce beklenmez — pinler anında istenir.
const int _minPinZoom = 10;

class _WebMapSurfaceState extends ConsumerState<_WebMapSurface> {
  final MapController _map = MapController();
  Timer? _debounce;
  double _lastZoom = 7; // _initialZoom ile hizalı; eşik-geçişi tespiti için

  @override
  void initState() {
    super.initState();
    // Açılışta varsayılan bölgeyi bildir → pinler/cluster'lar yüklensin.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.callbacks.onViewportChanged(
        const MapViewport(bbox: _initialBbox, zoom: _initialZoom),
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // Kullanıcı haritayı gezdirince, durulmasını bekleyip (kısa debounce) yeni
  // görünür alanı bildir. Sunucu limiti gereği her kenar ≤ 5°'ye kırpılır.
  // İSTİSNA: zoom pin eşiğini (10) GEÇERKEN hiç beklenmez — balonlardan pinlere
  // geçiş isteği parmak daha ekrandayken atılır, pinler gecikmeden dağılır.
  void _onMove(MapCamera camera, bool hasGesture) {
    if (!hasGesture) return;
    final bool crossedPinThreshold =
        (_lastZoom.round() >= _minPinZoom) != (camera.zoom.round() >= _minPinZoom);
    _lastZoom = camera.zoom;
    _debounce?.cancel();
    if (crossedPinThreshold) {
      _emit(camera);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 150), () => _emit(camera));
  }

  void _emit(MapCamera camera) {
    if (!mounted) return;
    final LatLngBounds b = camera.visibleBounds;
    const double maxSpan = 5.0;
    double west = b.west, east = b.east, south = b.south, north = b.north;
    final double cLon = (west + east) / 2, cLat = (south + north) / 2;
    if (east - west > maxSpan) {
      west = cLon - maxSpan / 2;
      east = cLon + maxSpan / 2;
    }
    if (north - south > maxSpan) {
      south = cLat - maxSpan / 2;
      north = cLat + maxSpan / 2;
    }
    widget.callbacks.onViewportChanged(
      MapViewport(
        bbox: Bbox(minLon: west, minLat: south, maxLon: east, maxLat: north),
        zoom: camera.zoom.round(),
      ),
    );
  }

  /// Cluster'a dokununca: kontrolcüye haber ver + kamerayı o bölgeye yaklaştır,
  /// ardından yeni görünümü bildir (programatik hareket onPositionChanged'te
  /// hasGesture=false geldiği için elle emit edilir).
  void _onClusterTap(Cluster c) {
    widget.callbacks.onClusterTap(c);
    // Pin eşiği 10 olduğundan hedef en az 10.5 — baloncuğa dokunuş her zaman
    // tekil pin bölgesine indirir (bir kez daha dokunma gereği kalmaz).
    final double targetZoom = math.min(math.max(_map.camera.zoom + 2.5, 10.5), 14.0);
    _lastZoom = targetZoom; // programatik hareket — eşik-geçiş takibi güncel kalsın
    _map.move(LatLng(c.position.lat, c.position.lon), targetZoom);
    _emit(_map.camera);
  }

  @override
  Widget build(BuildContext context) {
    // Tekne tanımlıysa pinlerde uyum rozeti gösterilir (wow kişiselleştirme).
    final MyBoat? boat = ref.watch(myBoatProvider);
    return FlutterMap(
      mapController: _map,
      options: MapOptions(
        initialCenter: const LatLng(38.85, 28.05),
        initialZoom: _initialZoom.toDouble(),
        minZoom: 4,
        maxZoom: 18,
        onPositionChanged: _onMove,
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: _baseTileUrl,
          userAgentPackageName: 'app.moorira.mobile',
          tileDisplay: const TileDisplay.instantaneous(),
          maxZoom: 19,
        ),
        // Denizcilik katmanı: OpenSeaMap seamark'ları (şamandıra, fener, liman
        // işaretleri) — açık lisanslı, jetonsuz. Şeffaf bindirme; yakın zoom'da
        // görünür hale gelir. (Navionics/C-MAP ticari lisans ister — v2 adayı.)
        TileLayer(
          urlTemplate: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
          userAgentPackageName: 'app.moorira.mobile',
          tileDisplay: const TileDisplay.instantaneous(),
          maxZoom: 18,
        ),
        MarkerLayer(
          markers: <Marker>[
            // Cluster'lar — ÜLKE renkli baloncukta sayı + ülke kodu; kalabalık
            // büyür, dokununca yaklaşır. (TR mavi, GR turkuaz.)
            for (final Cluster c in widget.data.clusters)
              Marker(
                point: LatLng(c.position.lat, c.position.lon),
                width: 64,
                height: 64,
                child: _ClusterMarker(
                  count: c.count,
                  countryCode: c.countryCode,
                  onTap: () => _onClusterTap(c),
                ),
              ),
            // Tekil pinler — damla form, tip rengi, beyaz kontur + beyaz ikon.
            // Damlanın ucu koordinata basar (alignment: topCenter).
            for (final LocationPin p in widget.data.pins)
              Marker(
                point: LatLng(p.position.lat, p.position.lon),
                width: 44,
                height: 44,
                alignment: Alignment.topCenter,
                child: _PinMarker(
                  type: p.type,
                  selected: p.id == widget.data.selectedPinId,
                  fit: computeBoatFit(
                    boat: boat,
                    maxBoatLengthM: p.maxBoatLengthM,
                    maxDraftM: p.maxDraftM,
                  ),
                  onTap: () => widget.callbacks.onPinTap(p.id),
                ),
              ),
          ],
        ),
        // Yasal atıf: OSM karoları + OpenSeaMap katmanı (ODbL/CC — zorunlu).
        const _MapAttribution(),
      ],
    );
  }
}

/// Sağ-alt köşede zorunlu kaynak atfı (ODbL/CC): yarı saydam şerit üstünde
/// küçük metin. Harici bileşen yerine yerli — davranışı tamamen bizde.
class _MapAttribution extends StatelessWidget {
  const _MapAttribution();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xB3FFFFFF),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          _attributionText,
          style: const TextStyle(fontSize: 10, color: Color(0xFF0A2540)),
        ),
      ),
    );
  }
}

/// Damla-formlu liman pini (tasarım §06): tip rengi zemin, 2.5px beyaz kontur,
/// içinde beyaz tip ikonu; seçiliyse %25 büyür. Tekne tanımlıysa sağ-üstte
/// uyum rozeti: yeşil = sığar, turuncu = sığmayabilir (bilinmiyorsa rozet yok).
class _PinMarker extends StatelessWidget {
  const _PinMarker({
    required this.type,
    required this.selected,
    required this.onTap,
    this.fit = BoatFit.unknown,
  });

  final String type;
  final bool selected;
  final VoidCallback onTap;
  final BoatFit fit;

  @override
  Widget build(BuildContext context) {
    final Color color = DocklyMapColors.forType(type);
    final double s = selected ? 40 : 32;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          if (fit != BoatFit.unknown)
            Positioned(
              right: 0,
              top: 0,
              child: _FitDot(fits: fit == BoatFit.fits),
            ),
          _pinBody(color, s),
        ].reversed.toList(growable: false),
      ),
    );
  }

  Widget _pinBody(Color color, double s) {
    return Center(
        child: Transform.rotate(
          // CSS eşleniği: rotate(-45deg) → damlanın ucu (bottomLeft) aşağı bakar.
          angle: -math.pi / 4,
          child: Container(
            width: s,
            height: s,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(s / 2),
                topRight: Radius.circular(s / 2),
                bottomRight: Radius.circular(s / 2),
                bottomLeft: const Radius.circular(4),
              ),
              border: Border.all(color: const Color(0xFFFFFFFF), width: 2.5),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Color(0x590A2540), blurRadius: 12, offset: Offset(0, 4)),
              ],
            ),
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Center(
                child: DocklyIcon(
                  DocklyIcons.forLocationType(type),
                  size: s * 0.48,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
    );
  }
}

/// Pin köşesindeki uyum rozeti: yeşil (sığar) / turuncu (sığmayabilir), beyaz
/// konturlu küçük daire — haritada tek bakışta uygunluk.
class _FitDot extends StatelessWidget {
  const _FitDot({required this.fits});

  final bool fits;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: fits ? DocklyColors.success : DocklyColors.warning,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFFFFFFF), width: 1.5),
      ),
      child: Center(
        child: DocklyIcon(
          fits ? DocklyIcons.checkCircle : DocklyIcons.errorOutline,
          size: 9,
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

/// Cluster işaretçisi: ÜLKEYE göre renklenen baloncuk — Türkiye marka mavisi,
/// Yunanistan Ege turkuazı (bilinmeyen ülke: kayrak grisi). Beyaz kontur +
/// beyaz kalın sayı, altında küçük ülke kodu. Kalabalık bölge daha büyük
/// baloncuk (<10 → 40, <50 → 50, 50+ → 60). Dokununca kamera bölgeye yaklaşır.
class _ClusterMarker extends StatelessWidget {
  const _ClusterMarker({
    required this.count,
    required this.onTap,
    this.countryCode = '',
  });

  final int count;
  final VoidCallback onTap;
  final String countryCode;

  @override
  Widget build(BuildContext context) {
    final double s = count >= 50 ? 60 : (count >= 10 ? 50 : 40);
    // Ülke → renk eşlemesi tasarım paketinde (ham hex yasak — docs/09 §0).
    final List<Color> colors = <Color>[
      DocklyMapColors.clusterColorForCountry(countryCode),
      DocklyMapColors.clusterDeepColorForCountry(countryCode),
    ];
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: s,
          height: s,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFFFFF), width: 2.5),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x590A2540), blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$count',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: s * 0.30,
                  height: 1.05,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
              if (countryCode.isNotEmpty)
                Text(
                  countryCode,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: s * 0.16,
                    height: 1.0,
                    letterSpacing: 0.6,
                    color: const Color(0xD9FFFFFF),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
