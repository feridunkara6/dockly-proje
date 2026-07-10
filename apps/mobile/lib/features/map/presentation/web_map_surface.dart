import 'package:dockly_api/dockly_api.dart' show Bbox;
import 'package:flutter/material.dart';

import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Web harita yüzeyi (Mapbox web'de çalışmaz). Açılışta Türkiye kıyısını kapsayan
/// bir görünüm bildirir — böylece liste verisi yüklenir — ve kullanıcıyı sağ
/// üstteki liste düğmesine yönlendirir. Mapbox import ETMEZ (web derlenebilirliği).
Widget webMapSurfaceBuilder(
  BuildContext context,
  MapSurfaceData data,
  MapSurfaceCallbacks callbacks,
) {
  return _WebMapSurface(callbacks: callbacks);
}

class _WebMapSurface extends StatefulWidget {
  const _WebMapSurface({required this.callbacks});

  final MapSurfaceCallbacks callbacks;

  @override
  State<_WebMapSurface> createState() => _WebMapSurfaceState();
}

class _WebMapSurfaceState extends State<_WebMapSurface> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Türkiye kıyısı — liman verisi yüklensin (liste görünümü için).
      widget.callbacks.onViewportChanged(
        const MapViewport(
          bbox: Bbox(minLon: 26.0, minLat: 36.0, maxLon: 30.5, maxLat: 41.5),
          zoom: 12,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFE9EEF2),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Web önizlemesinde harita gösterilmiyor.\n'
            'Sağ üstteki liste düğmesiyle limanları görebilirsin.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
