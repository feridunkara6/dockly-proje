import 'dart:async';

import 'package:dockly_api/dockly_api.dart' show Bbox, LocationPin;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Web harita yüzeyi. Mapbox web'de çalışmadığı için burada tarayıcıda çalışan,
/// jeton (token) istemeyen gerçek bir harita kullanılır: flutter_map +
/// OpenStreetMap karoları. Pinler marker olarak çizilir; kamera hareket edince
/// görünür alan (bbox) sunucuya bildirilir. Mapbox import ETMEZ.

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
    // Açılışta varsayılan bölgeyi bildir (kamera henüz hazır olmasa da) → pinler
    // yüklensin. build sırasında sağlayıcı güncellemesi olmasın diye postFrame.
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
          tileDisplay: TileDisplay.instantaneous(),
          maxZoom: 19,
        ),
        MarkerLayer(
          markers: <Marker>[
            for (final LocationPin p in widget.data.pins)
              Marker(
                point: LatLng(p.position.lat, p.position.lon),
                width: 40,
                height: 40,
                child: _PinMarker(
                  type: p.type,
                  selected: p.id == widget.data.selectedPinId,
                  onTap: () => widget.callbacks.onPinTap(p.id),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Harita üstünde tek bir liman işareti: tipe göre renkli, beyaz kenarlı yuvarlak
/// + beyaz tip ikonu. Seçiliyse biraz büyür.
class _PinMarker extends StatelessWidget {
  const _PinMarker({required this.type, required this.selected, required this.onTap});

  final String type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = DocklyMapColors.forType(type);
    final double s = selected ? 34 : 26;
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: s,
          height: s,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFFFFF), width: 2),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x40000000), blurRadius: 3, offset: Offset(0, 1)),
            ],
          ),
          child: Center(
            child: DocklyIcon(
              DocklyIcons.forLocationType(type),
              size: s * 0.55,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
