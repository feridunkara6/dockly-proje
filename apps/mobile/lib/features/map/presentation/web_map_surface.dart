import 'package:dockly_api/dockly_api.dart' show Bbox;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/map_controller.dart';
import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Web harita yüzeyi (Mapbox web'de çalışmaz). Açılışta Türkiye kıyısını kapsayan
/// GEÇERLİ bir görünüm bildirir (kenar ≤ 5° — bbox sınırı) — böylece liman verisi
/// yüklenir — ve belirgin bir düğmeyle liste görünümüne geçirir. Mapbox import ETMEZ.
Widget webMapSurfaceBuilder(
  BuildContext context,
  MapSurfaceData data,
  MapSurfaceCallbacks callbacks,
) {
  return _WebMapSurface(callbacks: callbacks);
}

class _WebMapSurface extends ConsumerStatefulWidget {
  const _WebMapSurface({required this.callbacks});

  final MapSurfaceCallbacks callbacks;

  @override
  ConsumerState<_WebMapSurface> createState() => _WebMapSurfaceState();
}

class _WebMapSurfaceState extends ConsumerState<_WebMapSurface> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ege–Marmara–İstanbul kıyısı; her kenar ≤ 5° (bbox sınırı, docs/23 §9.5).
      widget.callbacks.onViewportChanged(
        const MapViewport(
          bbox: Bbox(minLon: 26.0, minLat: 36.5, maxLon: 30.3, maxLat: 41.2),
          zoom: 12,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFE9EEF2),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.map_outlined, size: 48, color: DocklyColors.brandDeep),
              const SizedBox(height: 12),
              const Text(
                'Web önizlemesinde harita gösterilmiyor.\n'
                'Limanları liste olarak görebilirsin.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              DocklyButton(
                label: 'Limanları listede gör',
                onPressed: () => ref.read(mapViewIsListProvider.notifier).state = true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
