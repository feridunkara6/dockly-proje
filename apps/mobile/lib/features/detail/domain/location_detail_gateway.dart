import 'package:dockly_api/dockly_api.dart' show LocationDetail;

/// Lokasyon detay verisi ağ geçidi (docs/26 §4). Testte sahte ile override edilir;
/// böylece detay ekranı gerçek ağ olmadan test edilir.
abstract interface class LocationDetailGateway {
  Future<LocationDetail> fetch(String idOrSlug);
}
