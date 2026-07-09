import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';

/// Harita ekranı durumu (docs/26 §4). Yeniden yükleme sırasında mevcut
/// marker'lar korunur (`isLoading` bindirme göstergesi); hata da veriyi silmez.
class MapState {
  const MapState({
    this.pins = const <LocationPin>[],
    this.clusters = const <Cluster>[],
    this.truncated = false,
    this.isLoading = false,
    this.failure,
    this.selectedPinId,
    this.hasLoadedOnce = false,
  });

  final List<LocationPin> pins;
  final List<Cluster> clusters;
  final bool truncated;
  final bool isLoading;
  final AppFailure? failure;
  final String? selectedPinId;

  /// En az bir yükleme tamamlandı mı? İlk yükleme bitmeden "boş durum" GÖSTERİLMEZ
  /// (aksi halde açılışta kısa süre yanlış "liman yok" mesajı yanıp söner — P9).
  final bool hasLoadedOnce;

  bool get hasData => pins.isNotEmpty || clusters.isNotEmpty;

  /// Boş durum ekranı: yalnızca bir yükleme BİTTİKTEN sonra veri yoksa gösterilir.
  bool get isEmpty => hasLoadedOnce && !hasData && !isLoading && failure == null;

  MapState copyWith({
    List<LocationPin>? pins,
    List<Cluster>? clusters,
    bool? truncated,
    bool? isLoading,
    AppFailure? failure,
    bool clearFailure = false,
    String? selectedPinId,
    bool clearSelection = false,
    bool? hasLoadedOnce,
  }) {
    return MapState(
      pins: pins ?? this.pins,
      clusters: clusters ?? this.clusters,
      truncated: truncated ?? this.truncated,
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
      selectedPinId: clearSelection ? null : (selectedPinId ?? this.selectedPinId),
      hasLoadedOnce: hasLoadedOnce ?? this.hasLoadedOnce,
    );
  }
}
