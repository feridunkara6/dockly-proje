import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:test/test.dart';

import 'support/fake_adapter.dart';

void main() {
  late FakeAdapter adapter;
  late LocationsApi api;

  setUp(() {
    adapter = FakeAdapter();
    final client = DocklyClient(baseUrl: 'https://api.dockly.test');
    client.dio.httpClientAdapter = adapter;
    api = LocationsApi(client.dio);
  });

  const bbox = Bbox(minLon: 28.90, minLat: 36.70, maxLon: 29.00, maxLat: 36.80);

  test('mapByBbox pin modu: parse + query paramları', () async {
    adapter.enqueueJson(200, <String, dynamic>{
      'clusters': <dynamic>[],
      'locations': <dynamic>[
        <String, dynamic>{
          'id': 'loc-1',
          'name': 'D-Marin Göcek',
          'type': 'private_marina',
          'position': <String, dynamic>{'lat': 36.75, 'lon': 28.93},
          'ratingAvg': 4.8,
          'priceTier': 'paid',
        },
      ],
      'truncated': false,
    });

    final result = await api.mapByBbox(bbox: bbox, zoom: 13, types: <String>['private_marina', 'fuel_pier']);
    expect(result.locations, hasLength(1));
    expect(result.clusters, isEmpty);
    expect(result.truncated, isFalse);
    final pin = result.locations.single;
    expect(pin.id, 'loc-1');
    expect(pin.type, 'private_marina');
    expect(pin.position.lat, 36.75);
    expect(pin.ratingAvg, 4.8);

    final sent = adapter.received.single;
    expect(sent.path, '/v1/locations');
    expect(sent.method, 'GET');
    expect(sent.queryParameters['bbox'], '28.9,36.7,29.0,36.8');
    expect(sent.queryParameters['zoom'], 13);
    expect(sent.queryParameters['type'], <String>['private_marina', 'fuel_pier']);
  });

  test('mapByBbox cluster modu: balon parse (position, count, bbox)', () async {
    adapter.enqueueJson(200, <String, dynamic>{
      'clusters': <dynamic>[
        <String, dynamic>{
          'position': <String, dynamic>{'lat': 40.0, 'lon': 30.0},
          'count': 34,
          'bbox': <dynamic>[29.5, 39.5, 30.5, 40.5],
        },
      ],
      'locations': <dynamic>[],
      'truncated': false,
    });

    final result = await api.mapByBbox(bbox: bbox, zoom: 6);
    expect(result.locations, isEmpty);
    expect(result.clusters, hasLength(1));
    final c = result.clusters.single;
    expect(c.count, 34);
    expect(c.position.lon, 30.0);
    expect(c.bbox.maxLat, 40.5);
    // zoom var, type yok → yalnız bbox + zoom gönderilir
    expect(adapter.received.single.queryParameters.containsKey('type'), isFalse);
  });

  test('nearby: LocationSummary listesi + query paramları', () async {
    adapter.enqueueJson(200, <String, dynamic>{
      'data': <dynamic>[
        <String, dynamic>{
          'id': 'loc-2',
          'name': 'E2E Göcek Yakıt',
          'type': 'fuel_pier',
          'position': <String, dynamic>{'lat': 36.76, 'lon': 28.94},
          'slug': 'e2e-gocek-fuel',
          'coverMedia': null,
          'ratingAvg': null,
          'ratingCount': 5,
          'priceTier': 'unknown',
          'city': null,
          'waterBodyName': null,
          'distanceNm': 1.4,
          'amenityCodes': <dynamic>['electricity', 'water'],
        },
      ],
    });

    final list = await api.nearby(lat: 36.75, lon: 28.93, radiusNm: 10, limit: 20);
    expect(list, hasLength(1));
    final s = list.single;
    expect(s.slug, 'e2e-gocek-fuel');
    expect(s.coverMedia, isNull);
    expect(s.ratingAvg, isNull);
    expect(s.distanceNm, 1.4);
    expect(s.amenityCodes, <String>['electricity', 'water']);

    final sent = adapter.received.single;
    expect(sent.path, '/v1/locations/nearby');
    expect(sent.queryParameters['lat'], 36.75);
    expect(sent.queryParameters['radiusNm'], 10);
    expect(sent.queryParameters['limit'], 20);
  });

  test('mapByBbox 422 → ValidationFailure', () async {
    adapter.enqueueProblem(422, <String, dynamic>{
      'type': 'https://api.dockly.app/problems/validation-error',
      'title': 'Doğrulama hatası',
      'status': 422,
      'errors': <Map<String, dynamic>>[
        <String, dynamic>{'field': 'bbox', 'code': 'bbox-too-large', 'message': 'çok geniş'},
      ],
    });
    final failure = await _capture(() => api.mapByBbox(bbox: bbox, zoom: 8));
    expect(failure, isA<ValidationFailure>());
    expect((failure as ValidationFailure).errors.single.code, 'bbox-too-large');
  });
}

Future<AppFailure> _capture(Future<void> Function() action) async {
  try {
    await action();
  } on AppFailure catch (failure) {
    return failure;
  }
  throw StateError('beklenen AppFailure fırlatılmadı');
}
