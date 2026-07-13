import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/map/domain/map_viewport.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:flutter/material.dart';

import 'map_fakes.dart';

/// Testte Mapbox yerine geçen sahte yüzey: açılışta bir görünüm bildirir
/// (kameranın durmasını taklit), pin/cluster'ları dokunulabilir çizer.
class FakeMapSurface extends StatefulWidget {
  const FakeMapSurface({
    required this.data,
    required this.callbacks,
    this.initialViewport = pinViewport,
    super.key,
  });

  final MapSurfaceData data;
  final MapSurfaceCallbacks callbacks;
  final MapViewport initialViewport;

  @override
  State<FakeMapSurface> createState() => _FakeMapSurfaceState();
}

class _FakeMapSurfaceState extends State<FakeMapSurface> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.callbacks.onViewportChanged(widget.initialViewport);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Üstte harita çipleri/kontrolleri var (MapScreen bindirmeleri); sahte
    // butonlar onların ALTINDA kalsın ki testte dokunuşlar engellenmesin.
    return ListView(
      padding: const EdgeInsets.only(top: 120),
      children: <Widget>[
        for (final LocationPin pin in widget.data.pins)
          TextButton(
            key: ValueKey<String>('pin-${pin.id}'),
            onPressed: () => widget.callbacks.onPinTap(pin.id),
            child: Text(pin.name),
          ),
        for (final (int i, Cluster c) in widget.data.clusters.indexed)
          TextButton(
            key: ValueKey<String>('cluster-$i'),
            onPressed: () => widget.callbacks.onClusterTap(c),
            child: Text('cluster ${c.count}'),
          ),
        if (widget.data.selectedPinId != null)
          Text(
            'secili:${widget.data.selectedPinId}',
            key: const ValueKey<String>('selection'),
          ),
        // Kullanıcı konumu (tekne imleci) ve kamera odak isteği — testte
        // metin olarak temsil edilir.
        if (widget.data.devicePosition != null)
          Text(
            'ben:${widget.data.devicePosition!.lat},${widget.data.devicePosition!.lon}',
            key: const ValueKey<String>('device-boat'),
          ),
        if (widget.data.focus != null)
          Text(
            'odak:${widget.data.focus!.point.lat},${widget.data.focus!.point.lon},${widget.data.focus!.seq}',
            key: const ValueKey<String>('map-focus'),
          ),
      ],
    );
  }
}

/// `mapSurfaceBuilderProvider` override'ında kullanılacak sahte yüzey fabrikası.
MapSurfaceBuilder fakeMapSurfaceBuilder({MapViewport initialViewport = pinViewport}) {
  return (BuildContext context, MapSurfaceData data, MapSurfaceCallbacks callbacks) =>
      FakeMapSurface(data: data, callbacks: callbacks, initialViewport: initialViewport);
}
