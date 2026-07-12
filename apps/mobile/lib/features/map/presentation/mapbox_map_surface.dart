import 'dart:async';

import 'package:dockly_api/dockly_api.dart' show Bbox, Cluster, LocationPin;
import 'package:dockly_ui/dockly_ui.dart' show DocklyMapColors;
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../domain/map_viewport.dart';
import 'map_surface.dart';

/// Gerçek Mapbox harita yüzeyi (docs/13 §5.1) — `MapSurface` soyutlamasını uygular.
/// Erişim token'ı bootstrap'ta `MapboxOptions.setAccessToken` ile verilir (repoya
/// gömülmez, `--dart-define` ile gelir). Pin'ler daire, cluster'lar sayı balonu.
///
/// Render stratejisi (Faz B.2): her güncellemede TÜM annotation'ları silip yeniden
/// yaratmak yerine FARK (diff) uygulanır — eklenen pin yaratılır, kaybolan silinir,
/// yalnız seçim durumu değişen pin yeniden çizilir (O(değişen), O(hepsi) değil).
/// Ayrıca eşzamanlılık kilidi iç içe render'ları (hayalet marker) önler; dispose
/// sonrası asenkron çağrılar `_disposed` ile susturulur (native kaynak/çökme koruması).
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

  /// pinId → çizili annotation (fark için).
  final Map<String, CircleAnnotation> _pinAnnotations = <String, CircleAnnotation>{};

  /// annotationId → pinId (dokunma çözümü için).
  final Map<String, String> _annotationToPin = <String, String>{};

  /// Cluster'lar zoom'la topluca değişir → tümüyle yenilenir (pinlerle aynı anda olmaz).
  final List<CircleAnnotation> _clusterAnnotations = <CircleAnnotation>[];
  final List<PointAnnotation> _clusterLabels = <PointAnnotation>[];
  final Map<String, Cluster> _annotationToCluster = <String, Cluster>{};

  String? _lastSelectedPinId;
  bool _rendering = false;
  bool _renderQueued = false;
  bool _disposed = false;
  Timer? _idleTimer;

  /// Türkiye merkezli açılış görünümü (düşük zoom → cluster modu).
  static final CameraOptions _initialCamera = CameraOptions(
    center: Point(coordinates: Position(35.2, 39.0)),
    zoom: 5,
  );

  @override
  void didUpdateWidget(covariant MapboxMapSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    unawaited(_render());
  }

  @override
  void dispose() {
    _disposed = true;
    _idleTimer?.cancel();
    _map = null;
    _circles = null;
    _labels = null;
    super.dispose();
  }

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    await map.setCamera(_initialCamera);
    if (_disposed) return;
    _circles = await map.annotations.createCircleAnnotationManager();
    _labels = await map.annotations.createPointAnnotationManager();
    if (_disposed) return;
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
      unawaited(_flyToCluster(cluster));
    }
  }

  /// Kamera hareket edince (debounce sonrası) görünen bbox + zoom bildirilir.
  void _onCameraChanged(CameraChangedEventData data) {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(milliseconds: 350), _reportViewport);
  }

  Future<void> _reportViewport() async {
    final MapboxMap? map = _map;
    if (map == null || _disposed) return;
    final CameraState camera = await map.getCameraState();
    if (_disposed) return;
    final CoordinateBounds bounds = await map.coordinateBoundsForCamera(
      CameraOptions(
        center: camera.center,
        zoom: camera.zoom,
        bearing: camera.bearing,
        pitch: camera.pitch,
      ),
    );
    if (_disposed) return;
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

  /// Eşzamanlılık kilidi: aynı anda tek render koşar; sırasında gelen istek tek
  /// bir ek tur olarak kuyruğa alınır (iç içe render → hayalet marker önlenir).
  Future<void> _render() async {
    if (_disposed) return;
    if (_rendering) {
      _renderQueued = true;
      return;
    }
    _rendering = true;
    try {
      do {
        _renderQueued = false;
        await _renderOnce();
      } while (_renderQueued && !_disposed);
    } finally {
      _rendering = false;
    }
  }

  Future<void> _renderOnce() async {
    final CircleAnnotationManager? circles = _circles;
    final PointAnnotationManager? labels = _labels;
    if (circles == null || labels == null || _disposed) return;

    final MapSurfaceData data = widget.data;
    final String? selectedId = data.selectedPinId;

    // --- PINLER: fark uygula ---
    final Set<String> newPinIds = <String>{for (final LocationPin p in data.pins) p.id};

    // Kaybolan pinleri sil.
    final List<String> goneIds =
        _pinAnnotations.keys.where((String id) => !newPinIds.contains(id)).toList();
    for (final String id in goneIds) {
      final CircleAnnotation? ann = _pinAnnotations.remove(id);
      if (ann != null) {
        _annotationToPin.remove(ann.id);
        await circles.delete(ann);
        if (_disposed) return;
      }
    }

    // Yeni pin ekle; seçim durumu değişen pini yeniden çiz.
    for (final LocationPin pin in data.pins) {
      final bool selected = pin.id == selectedId;
      final CircleAnnotation? existing = _pinAnnotations[pin.id];
      if (existing == null) {
        await _createPin(circles, pin, selected: selected);
        if (_disposed) return;
      } else {
        final bool wasSelected = pin.id == _lastSelectedPinId;
        if (selected != wasSelected) {
          _annotationToPin.remove(existing.id);
          await circles.delete(existing);
          if (_disposed) return;
          await _createPin(circles, pin, selected: selected);
          if (_disposed) return;
        }
      }
    }

    // --- CLUSTER'LAR: topluca yenile (tekil delete → pinler korunur) ---
    for (final CircleAnnotation ann in _clusterAnnotations) {
      _annotationToCluster.remove(ann.id);
      await circles.delete(ann);
      if (_disposed) return;
    }
    _clusterAnnotations.clear();
    for (final PointAnnotation lbl in _clusterLabels) {
      await labels.delete(lbl);
      if (_disposed) return;
    }
    _clusterLabels.clear();

    for (final Cluster cluster in data.clusters) {
      final Point geometry =
          Point(coordinates: Position(cluster.position.lon, cluster.position.lat));
      final CircleAnnotation ann = await circles.create(
        CircleAnnotationOptions(
          geometry: geometry,
          // Kibar/pastel baloncuk: açık dolgu + ülkeye göre canlı halka
          // (TR mavi, GR turkuaz) — web ile aynı semantik.
          circleColor: DocklyMapColors.clusterFillArgbForCountry(cluster.countryCode),
          circleRadius: 18.0,
          circleStrokeColor:
              DocklyMapColors.clusterAccentArgbForCountry(cluster.countryCode),
          circleStrokeWidth: 2.0,
        ),
      );
      if (_disposed) return;
      _clusterAnnotations.add(ann);
      _annotationToCluster[ann.id] = cluster;
      final PointAnnotation lbl = await labels.create(
        PointAnnotationOptions(
          geometry: geometry,
          textField: '${cluster.count}',
          // Açık pastel dolguda okunması için sayı vurgu renginde.
          textColor: DocklyMapColors.clusterAccentArgbForCountry(cluster.countryCode),
          textSize: 12.0,
        ),
      );
      if (_disposed) return;
      _clusterLabels.add(lbl);
    }

    _lastSelectedPinId = selectedId;
  }

  /// Tek pin annotation'ı yaratır ve dokunma haritasına işler.
  Future<void> _createPin(
    CircleAnnotationManager circles,
    LocationPin pin, {
    required bool selected,
  }) async {
    final CircleAnnotation annotation = await circles.create(
      CircleAnnotationOptions(
        geometry: Point(coordinates: Position(pin.position.lon, pin.position.lat)),
        // Dolgu = location_type kanonik rengi (docs/09 §1.4); seçili pin 1.3× ölçek
        // + beyaz halka (renk değişmez — renk tip anlamına rezerve).
        circleColor: DocklyMapColors.argbForType(pin.type),
        circleRadius: selected ? 9.1 : 7.0,
        circleStrokeColor: DocklyMapColors.strokeArgb,
        circleStrokeWidth: 2.0,
      ),
    );
    _pinAnnotations[pin.id] = annotation;
    _annotationToPin[annotation.id] = pin.id;
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      key: const ValueKey<String>('dockly-mapbox'),
      onMapCreated: _onMapCreated,
      onCameraChangeListener: _onCameraChanged,
    );
  }
}

/// `mapSurfaceBuilderProvider` override'ında kullanılan gerçek yüzey fabrikası.
Widget mapboxMapSurfaceBuilder(
  BuildContext context,
  MapSurfaceData data,
  MapSurfaceCallbacks callbacks,
) =>
    MapboxMapSurface(data: data, callbacks: callbacks);
