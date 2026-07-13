import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/search/domain/search_gateway.dart';

/// Test için örnek özet üretir.
LocationSummary sampleSummary(
  String id,
  String name, {
  double? ratingAvg,
  String type = 'private_marina',
  String? city = 'Fethiye',
  double distanceNm = 0,
  double? maxBoatLengthM,
  double? maxDraftM,
}) {
  return LocationSummary(
    id: id,
    name: name,
    type: type,
    position: const GeoPoint(lat: 36.75, lon: 28.93),
    slug: id,
    coverMedia: null,
    ratingAvg: ratingAvg,
    ratingCount: 3,
    priceTier: 'paid',
    city: city,
    waterBodyName: null,
    distanceNm: distanceNm,
    amenityCodes: const <String>[],
    maxBoatLengthM: maxBoatLengthM,
    maxDraftM: maxDraftM,
  );
}

/// `SearchGateway` yerine geçen sahte; çağrılan sorguları kaydeder.
class FakeSearchGateway implements SearchGateway {
  FakeSearchGateway({this.results = const <LocationSummary>[], this.error});

  List<LocationSummary> results;
  AppFailure? error;
  final List<String> queries = <String>[];
  final List<List<String>?> typeArgs = <List<String>?>[];
  final List<List<String>?> amenityArgs = <List<String>?>[];

  @override
  Future<List<LocationSummary>> search(
    String q, {
    List<String>? types,
    List<String>? amenities,
  }) {
    queries.add(q);
    typeArgs.add(types);
    amenityArgs.add(amenities);
    final AppFailure? err = error;
    if (err != null) return Future<List<LocationSummary>>.error(err);
    return Future<List<LocationSummary>>.value(results);
  }
}
