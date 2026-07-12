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

/// Harita alt-sayfası "Yakınındaki Limanlar" sorgu anahtarı — merkez koordinat.
/// Çağıran taraf ~1 km'ye yuvarlar (her küçük kaydırışta yeni istek atılmasın;
/// sunucu cache'iyle de uyumlu). Record → yapısal eşitlik (family cache anahtarı).
typedef MapNearbyKey = ({double lat, double lon});

/// Alt-sayfa rayında gösterilecek maksimum kart sayısı.
const int kMapNearbyLimit = 10;

/// Haritada bakılan noktanın çevresindeki en yakın limanlar (docs/23 §9.6,
/// S-06 rayı) — tasarım §07 alt-sayfa mini-kartlarını besler. Mesafeye göre
/// artan sıralı gelir (sunucu sıralar).
final mapNearbyProvider =
    FutureProvider.family<List<LocationSummary>, MapNearbyKey>((ref, MapNearbyKey key) {
  return ref.watch(nearbyGatewayProvider).fetch(
        lat: key.lat,
        lon: key.lon,
        radiusNm: 25,
        limit: kMapNearbyLimit,
      );
});
