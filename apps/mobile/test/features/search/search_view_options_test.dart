import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/search/application/search_view_options.dart';
import 'package:flutter_test/flutter_test.dart';

LocationSummary _loc(
  String id, {
  double? rating,
  String price = 'paid',
  double lat = 40.0,
  double lon = 29.0,
}) =>
    LocationSummary(
      id: id,
      name: id,
      type: 'private_marina',
      position: GeoPoint(lat: lat, lon: lon),
      slug: id,
      coverMedia: null,
      ratingAvg: rating,
      ratingCount: 0,
      priceTier: price,
      city: null,
      waterBodyName: null,
      distanceNm: 0,
      amenityCodes: const <String>[],
      maxBoatLengthM: null,
      maxDraftM: null,
    );

List<String> _ids(List<LocationSummary> list) =>
    list.map((LocationSummary s) => s.id).toList();

void main() {
  test('relevance: sıra korunur, ücretsiz kapalı → tüm sonuçlar', () {
    final List<LocationSummary> input = <LocationSummary>[_loc('a'), _loc('b'), _loc('c')];
    final List<LocationSummary> out =
        applySearchView(input, freeOnly: false, sort: SearchSort.relevance);
    expect(_ids(out), <String>['a', 'b', 'c']);
  });

  test('ücretsiz süzgeci: yalnız price==free', () {
    final List<LocationSummary> input = <LocationSummary>[
      _loc('paid1', price: 'paid'),
      _loc('free1', price: 'free'),
      _loc('unknown1', price: 'unknown'),
    ];
    final List<LocationSummary> out =
        applySearchView(input, freeOnly: true, sort: SearchSort.relevance);
    expect(_ids(out), <String>['free1']);
  });

  test('puana göre: azalan, puansız (null) sona', () {
    final List<LocationSummary> input = <LocationSummary>[
      _loc('mid', rating: 3.5),
      _loc('none'),
      _loc('top', rating: 4.9),
    ];
    final List<LocationSummary> out =
        applySearchView(input, freeOnly: false, sort: SearchSort.rating);
    expect(_ids(out), <String>['top', 'mid', 'none']);
  });

  test('yakınlığa göre: origin varsa en yakından uzağa', () {
    final List<LocationSummary> input = <LocationSummary>[
      _loc('far', lon: 35.0),
      _loc('near', lon: 29.05),
    ];
    final List<LocationSummary> out = applySearchView(
      input,
      freeOnly: false,
      sort: SearchSort.distance,
      origin: const GeoPoint(lat: 40.0, lon: 29.0),
    );
    expect(_ids(out), <String>['near', 'far']);
  });

  test('yakınlığa göre: origin yoksa sıra korunur', () {
    final List<LocationSummary> input = <LocationSummary>[_loc('x'), _loc('y')];
    final List<LocationSummary> out =
        applySearchView(input, freeOnly: false, sort: SearchSort.distance);
    expect(_ids(out), <String>['x', 'y']);
  });
}
