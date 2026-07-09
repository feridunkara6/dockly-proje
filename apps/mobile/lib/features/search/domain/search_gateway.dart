import 'package:dockly_api/dockly_api.dart';

/// Arama verisi ağ geçidi (docs/26 clean architecture). Kontrolcü somut API
/// yerine bu soyutlamaya bağlanır — böylece ağ olmadan test edilebilir.
abstract interface class SearchGateway {
  Future<List<LocationSummary>> search(String q, {List<String>? types});
}
