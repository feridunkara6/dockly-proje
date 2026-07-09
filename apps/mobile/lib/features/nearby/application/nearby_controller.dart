import 'package:dockly_api/dockly_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/api_nearby_gateway.dart';
import '../domain/nearby_gateway.dart';

/// Yakın ağ geçidi sağlayıcısı — testte sahte ile override edilir.
final Provider<NearbyGateway> nearbyGatewayProvider = Provider<NearbyGateway>(
  (ref) => ApiNearbyGateway(ref.watch(locationsApiProvider)),
);

/// Yakın-alternatifler sorgu anahtarı: merkez (lat/lon) + hariç tutulacak
/// lokasyon (merkezin kendisi). Record → yapısal eşitlik (family cache anahtarı).
typedef NearbyKey = ({double lat, double lon, String excludeId});

/// Gösterilecek maksimum alternatif sayısı.
const int kNearbyAltLimit = 5;

/// Bir lokasyonun çevresindeki alternatif bağlama noktaları (docs/23 §9.6,
/// vizyon: "dolu/uygun değilse plan B"). Merkezin kendisi (excludeId) çıkarılır;
/// en yakın [kNearbyAltLimit] tanesi mesafeye göre döner.
final nearbyAlternativesProvider =
    FutureProvider.family<List<LocationSummary>, NearbyKey>((ref, NearbyKey key) async {
  final List<LocationSummary> all = await ref.watch(nearbyGatewayProvider).fetch(
        lat: key.lat,
        lon: key.lon,
        radiusNm: 15,
        limit: kNearbyAltLimit + 3,
      );
  return all
      .where((LocationSummary s) => s.id != key.excludeId)
      .take(kNearbyAltLimit)
      .toList(growable: false);
});
