import 'dart:async';

import 'package:dockly_core/dockly_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/api_map_locations_gateway.dart';
import '../domain/map_locations_gateway.dart';
import '../domain/map_state.dart';
import '../domain/map_viewport.dart';

/// Harita verisi ağ geçidi sağlayıcısı — testte sahte ile override edilir.
final Provider<MapLocationsGateway> mapLocationsGatewayProvider =
    Provider<MapLocationsGateway>(
  (ref) => ApiMapLocationsGateway(ref.watch(locationsApiProvider)),
);

/// Harita çağrılarının debounce süresi (docs/14 perf — pan/zoom sırasında
/// gereksiz istek olmasın). Testte `Duration.zero`'a override edilir.
final Provider<Duration> mapDebounceProvider =
    Provider<Duration>((ref) => const Duration(milliseconds: 300));

/// Harita ekranının beyni (docs/26 §4): görünüm değişimi → debounce → yükleme,
/// marker/cluster durumu, seçim, hata + retry. Somut haritadan bağımsızdır.
class MapController extends Notifier<MapState> {
  Timer? _debounce;
  MapViewport? _lastRequested;
  int _seq = 0;

  @override
  MapState build() {
    ref.onDispose(() => _debounce?.cancel());
    return const MapState();
  }

  MapLocationsGateway get _gateway => ref.read(mapLocationsGatewayProvider);

  /// Harita kaydırılınca/zoom'lanınca çağrılır — aynı görünüm tekrarlanmaz,
  /// hızlı değişimler debounce ile tek isteğe indirgenir.
  void onViewportChanged(MapViewport viewport, {List<String>? types}) {
    if (viewport == _lastRequested) return;
    _lastRequested = viewport;
    _debounce?.cancel();
    _debounce = Timer(
      ref.read(mapDebounceProvider),
      () => loadViewport(viewport, types: types),
    );
  }

  /// Anında (debounce'suz) yükleme — retry ve debounce zamanlayıcısı kullanır.
  /// Eş zamanlı çağrılarda yalnız en son yanıt uygulanır (stale koruması).
  Future<void> loadViewport(MapViewport viewport, {List<String>? types}) async {
    _lastRequested = viewport;
    final seq = ++_seq;
    state = state.copyWith(isLoading: true, clearFailure: true);
    try {
      final result = await _gateway.loadViewport(viewport, types: types);
      if (seq != _seq) return;
      state = state.copyWith(
        pins: result.locations,
        clusters: result.clusters,
        truncated: result.truncated,
        isLoading: false,
        clearFailure: true,
        hasLoadedOnce: true,
      );
    } on AppFailure catch (failure) {
      if (seq != _seq) return;
      state = state.copyWith(isLoading: false, failure: failure);
    }
  }

  void selectPin(String pinId) {
    state = state.copyWith(selectedPinId: pinId);
  }

  void clearSelection() {
    state = state.copyWith(clearSelection: true);
  }

  /// Hata ekranından son görünümü yeniden dener.
  Future<void> retry({List<String>? types}) async {
    final viewport = _lastRequested;
    if (viewport != null) await loadViewport(viewport, types: types);
  }
}

final NotifierProvider<MapController, MapState> mapControllerProvider =
    NotifierProvider<MapController, MapState>(MapController.new);
