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
  });

  final List<LocationPin> pins;
  final List<Cluster> clusters;
  final bool truncated;
  final bool isLoading;
  final AppFailure? failure;
  final String? selectedPinId;

  bool get hasData => pins.isNotEmpty || clusters.isNotEmpty;

  /// İlk yükleme henüz veri getirmedi ve hata/yükleme yok → boş durum ekranı.
  bool get isEmpty => !hasData && !isLoading && failure == null;

  MapState copyWith({
    List<LocationPin>? pins,
    List<Cluster>? clusters,
    bool? truncated,
    bool? isLoading,
    AppFailure? failure,
    bool clearFailure = false,
    String? selectedPinId,
    bool clearSelection = false,
  }) {
    return MapState(
      pins: pins ?? this.pins,
      clusters: clusters ?? this.clusters,
      truncated: truncated ?? this.truncated,
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
      selectedPinId: clearSelection ? null : (selectedPinId ?? this.selectedPinId),
    );
  }
}
