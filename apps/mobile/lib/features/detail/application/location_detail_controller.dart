import 'package:dockly_api/dockly_api.dart' show LocationDetail;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/api_location_detail_gateway.dart';
import '../domain/location_detail_gateway.dart';

/// Detay ağ geçidi sağlayıcısı — testte sahte ile override edilir.
final Provider<LocationDetailGateway> locationDetailGatewayProvider =
    Provider<LocationDetailGateway>(
  (ref) => ApiLocationDetailGateway(ref.watch(locationsApiProvider)),
);

/// Lokasyon detayını id/slug başına getiren sağlayıcı (S-09). AsyncValue ile
/// yükleme/hata/veri durumlarını taşır; hata `AppFailure` olarak yayılır.
final locationDetailProvider = FutureProvider.family<LocationDetail, String>(
  (ref, String idOrSlug) => ref.watch(locationDetailGatewayProvider).fetch(idOrSlug),
);
