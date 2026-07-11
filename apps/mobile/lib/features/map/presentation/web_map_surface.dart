import 'dart:async';
import 'dart:math' as math;

import 'package:dockly_api/dockly_api.dart' show Bbox, Cluster, LocationPin;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Web harita yüzeyi. Mapbox web'de çalışmadığı için tarayıcıda çalışan, jeton
/// istemeyen gerçek bir harita kullanılır: flutter_map + OpenStreetMap karoları.
/// Görsel dil, tasarım sistemi (design/dockly-design-system.html §06 Map
/// Markers) ile birebir: damla-formlu, beyaz konturlu tip-renkli pinler; cam
/// görünümlü dairede sayı taşıyan cluster'lar; seçili pin büyür. Cluster'a
/// dokununca kamera o bölgeye yaklaşır → sunucu tekil pinleri döndürür.

/// Açılışta yüklenecek varsayılan görünüm — Ege–Marmara–İstanbul kıyısı.
/// Her kenar ≤ 5° (sunucu bbox sınırı, docs/23 §9.5) → veri hemen gelir.
const Bbox _initialBbox = Bbox(minLon: 25.9, minLat: 36.6, maxLon: 30.2, maxLat: 41.1);
const int _initialZoom = 7;

Widget webMapSurfaceBuilder(
  BuildContext context,
  MapSurfaceData data,
  MapSurfaceCallbacks callbacks,
) {
  return _WebMapSurface(data: data, callbacks: callbacks);
}

class _WebMapSurface extends StatefulWidget {
  const _WebMapSurface({required this.data, required this.callbacks});

  final MapSurfaceData data;
  final MapSurfaceCallbacks callbacks;

  @override
  State<_WebMapSurface> createState() => _WebMapSurfaceState();
}

class _WebMapSurfaceState extends State<_WebMapSurface> {
  final MapController _map = MapController();
  Timer? _debounce;

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

  // Kullanıcı haritayı gezdirince, durulmasını bekleyip (debounce) yeni görünür
  // alanı bildir. Sunucu limiti gereği her kenar ≤ 5°'ye kırpılır.
  void _onMove(MapCamera camera, bool hasGesture) {
    if (!hasGesture) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => _emit(camera));
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
    final double targetZoom = math.min(_map.camera.zoom + 2.5, 14.0);
    _map.move(LatLng(c.position.lat, c.position.lon), targetZoom);
    _emit(_map.camera);
  }

  @override
  Widget build(BuildContext context) {
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
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'app.dockly.mobile',
          tileDisplay: const TileDisplay.instantaneous(),
          maxZoom: 19,
        ),
        // Denizcilik katmanı: OpenSeaMap seamark'ları (şamandıra, fener, liman
        // işaretleri) — açık lisanslı, jetonsuz. Şeffaf bindirme; yakın zoom'da
        // görünür hale gelir. (Navionics/C-MAP ticari lisans ister — v2 adayı.)
        TileLayer(
          urlTemplate: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
          userAgentPackageName: 'app.dockly.mobile',
          tileDisplay: const TileDisplay.instantaneous(),
          maxZoom: 18,
        ),
        MarkerLayer(
          markers: <Marker>[
            // Cluster'lar — cam dairede sayı (tasarım §06); dokununca yaklaş.
            for (final Cluster c in widget.data.clusters)
              Marker(
                point: LatLng(c.position.lat, c.position.lon),
                width: 48,
                height: 48,
                child: _ClusterMarker(count: c.count, onTap: () => _onClusterTap(c)),
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
        child: const Text(
          '© OpenStreetMap katkıcıları · OpenSeaMap',
          style: TextStyle(fontSize: 10, color: Color(0xFF0A2540)),
        ),
      ),
    );
  }
}

/// Damla-formlu liman pini (tasarım §06): tip rengi zemin, 2.5px beyaz kontur,
/// içinde beyaz tip ikonu; seçiliyse %25 büyür.
class _PinMarker extends StatelessWidget {
  const _PinMarker({required this.type, required this.selected, required this.onTap});

  final String type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = DocklyMapColors.forType(type);
    final double s = selected ? 40 : 32;
    return GestureDetector(
      onTap: onTap,
      child: Center(
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
      ),
    );
  }
}

/// Cluster işaretçisi (tasarım §06): cam görünümlü beyaz daire, 2px beyaz
/// kontur, kalın sayı. Dokununca kamera bölgeye yaklaşır.
class _ClusterMarker extends StatelessWidget {
  const _ClusterMarker({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(minWidth: 44),
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: const Color(0xC9FFFFFF),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFFFFF), width: 2),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x4D0A2540), blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Center(
            child: Text(
              '$count',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF0A2540),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
