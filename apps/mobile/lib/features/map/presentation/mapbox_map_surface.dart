import 'dart:async';

import 'package:dockly_api/dockly_api.dart' show Bbox, Cluster, LocationPin;
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Gerçek Mapbox harita yüzeyi (docs/13 §5.1) — `MapSurface` soyutlamasını uygular.
/// Erişim token'ı bootstrap'ta `MapboxOptions.setAccessToken` ile verilir (repoya
/// gömülmez, `--dart-define` ile gelir). Pin'ler daire, cluster'lar sayı balonu.
class MapboxMapSurface extends StatefulWidget {
  const MapboxMapSurface({required this.data, required this.callbacks, super.key});

  final MapSurfaceData data;
  final MapSurfaceCallbacks callbacks;

  @override
  State<MapboxMapSurface> createState() => _MapboxMapSurfaceState();
}

class _MapboxMapSurfaceState extends State<MapboxMapSurface> {
  MapboxMap? _map;
  CircleAnnotationManager? _circles;
  PointAnnotationManager? _labels;
  final Map<String, String> _annotationToPin = <String, String>{};
  final Map<String, Cluster> _annotationToCluster = <String, Cluster>{};
  Timer? _idleTimer;

  /// Türkiye merkezli açılış görünümü (düşük zoom → cluster modu).
  static final CameraOptions _initialCamera = CameraOptions(
    center: Point(coordinates: Position(35.2, 39.0)),
    zoom: 5,
  );

  @override
  void didUpdateWidget(covariant MapboxMapSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    _render();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    super.dispose();
  }

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    _circles = await map.annotations.createCircleAnnotationManager();
    _labels = await map.annotations.createPointAnnotationManager();
    _circles!.tapEvents(onTap: _onCircleTap);
    await _render();
  }

  void _onCircleTap(CircleAnnotation annotation) {
    final String? pinId = _annotationToPin[annotation.id];
    if (pinId != null) {
      widget.callbacks.onPinTap(pinId);
      return;
    }
    final Cluster? cluster = _annotationToCluster[annotation.id];
    if (cluster != null) {
      widget.callbacks.onClusterTap(cluster);
      _flyToCluster(cluster);
    }
  }

  /// Kamera hareket edince (debounce sonrası) görünen bbox + zoom bildirilir.
  void _onCameraChanged(CameraChangedEventData data) {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(milliseconds: 350), _reportViewport);
  }

  Future<void> _reportViewport() async {
    final MapboxMap? map = _map;
    if (map == null) return;
    final CameraState camera = await map.getCameraState();
    final CoordinateBounds bounds = await map.coordinateBoundsForCamera(
      CameraOptions(
        center: camera.center,
        zoom: camera.zoom,
        bearing: camera.bearing,
        pitch: camera.pitch,
      ),
    );
    final Position sw = bounds.southwest.coordinates;
    final Position ne = bounds.northeast.coordinates;
    widget.callbacks.onViewportChanged(
      MapViewport(
        bbox: Bbox(
          minLon: sw.lng.toDouble(),
          minLat: sw.lat.toDouble(),
          maxLon: ne.lng.toDouble(),
          maxLat: ne.lat.toDouble(),
        ),
        zoom: camera.zoom.round(),
      ),
    );
  }

  Future<void> _flyToCluster(Cluster cluster) async {
    await _map?.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(cluster.position.lon, cluster.position.lat)),
        zoom: 12,
      ),
      MapAnimationOptions(duration: 800),
    );
  }

  Future<void> _render() async {
    final CircleAnnotationManager? circles = _circles;
    final PointAnnotationManager? labels = _labels;
    if (circles == null || labels == null) return;

    await circles.deleteAll();
    await labels.deleteAll();
    _annotationToPin.clear();
    _annotationToCluster.clear();

    for (final LocationPin pin in widget.data.pins) {
      final bool selected = pin.id == widget.data.selectedPinId;
      final CircleAnnotation annotation = await circles.create(
        CircleAnnotationOptions(
          geometry: Point(coordinates: Position(pin.position.lon, pin.position.lat)),
          circleColor: selected ? 0xFFEA4335 : 0xFF0C7BDC,
          circleRadius: selected ? 11.0 : 7.0,
          circleStrokeColor: 0xFFFFFFFF,
          circleStrokeWidth: 2.0,
        ),
      );
      _annotationToPin[annotation.id] = pin.id;
    }

    for (final Cluster cluster in widget.data.clusters) {
      final Point geometry =
          Point(coordinates: Position(cluster.position.lon, cluster.position.lat));
      final CircleAnnotation annotation = await circles.create(
        CircleAnnotationOptions(
          geometry: geometry,
          circleColor: 0xFF0C7BDC,
          circleRadius: 18.0,
          circleStrokeColor: 0xFFFFFFFF,
          circleStrokeWidth: 2.0,
        ),
      );
      _annotationToCluster[annotation.id] = cluster;
      await labels.create(
        PointAnnotationOptions(
          geometry: geometry,
          textField: '${cluster.count}',
          textColor: 0xFFFFFFFF,
          textSize: 12.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      key: const ValueKey<String>('dockly-mapbox'),
      cameraOptions: _initialCamera,
      onMapCreated: _onMapCreated,
      onCameraChangeListener: _onCameraChanged,
    );
  }
}

/// `mapSurfaceBuilderProvider` override'ında kullanılan gerçek yüzey fabrikası.
final MapSurfaceBuilder mapboxMapSurfaceBuilder = (
  BuildContext context,
  MapSurfaceData data,
  MapSurfaceCallbacks callbacks,
) =>
    MapboxMapSurface(data: data, callbacks: callbacks);
