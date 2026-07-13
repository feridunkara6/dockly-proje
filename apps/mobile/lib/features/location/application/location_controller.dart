import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/origin_provider.dart';
import '../../map/application/map_controller.dart';
import '../../map/domain/map_viewport.dart';
import '../data/location_service_stub.dart'
    if (dart.library.html) '../data/location_service_web.dart';
import '../domain/location_service.dart';

/// Konum servisi sağlayıcısı. Derleme hedefine göre (web/mobil) doğru uygulama
/// koşullu import ile gelir; testte sahte ile override edilir.
final Provider<LocationService> locationServiceProvider =
    Provider<LocationService>((ref) => const PlatformLocationService());

/// "Konumum" akışının durumu.
enum LocationStatus { idle, loading, located, denied }

/// Kullanıcının konumunu ister ve başarılıysa [originProvider]'a yazar — böylece
/// lokasyon detayındaki "deniz yolu" önizlemesi ve mesafe sıralaması kullanıcının
/// gerçek konumundan hesaplanır (docs vizyon: denizcilik-odaklı rota).
class LocationController extends Notifier<LocationStatus> {
  @override
  LocationStatus build() => LocationStatus.idle;

  Future<void> locateMe() async {
    state = LocationStatus.loading;
    final GeoPoint? pos = await ref.read(locationServiceProvider).current();
    if (pos == null) {
      state = LocationStatus.denied;
      return;
    }
    ref.read(originProvider.notifier).state = pos;
    // GPS konumu ayrıca saklanır (harita gezinmesi ezmesin) + haritadaki tekne
    // imleci görünsün ve kamera kullanıcıya odaklansın (kullanıcı isteği).
    ref.read(devicePositionProvider.notifier).state = pos;
    final int nextSeq = (ref.read(mapFocusProvider)?.seq ?? 0) + 1;
    ref.read(mapFocusProvider.notifier).state =
        MapFocusRequest(point: pos, seq: nextSeq);
    state = LocationStatus.located;
  }
}

final NotifierProvider<LocationController, LocationStatus> locationControllerProvider =
    NotifierProvider<LocationController, LocationStatus>(LocationController.new);
