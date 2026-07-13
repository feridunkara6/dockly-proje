import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:test/test.dart';

import 'support/fake_adapter.dart';

void main() {
  late FakeAdapter adapter;
  late WeatherApi api;

  setUp(() {
    adapter = FakeAdapter();
    final client = DocklyClient(baseUrl: 'https://api.dockly.test');
    client.dio.httpClientAdapter = adapter;
    api = WeatherApi(client.dio);
  });

  test('forecast: parse (knot/hamle/yön/sıcaklık/atıf) + query paramları', () async {
    adapter.enqueueJson(200, <String, dynamic>{
      'points': <dynamic>[
        <String, dynamic>{
          'time': '2026-07-13T09:00:00Z',
          'windKn': 9.7,
          'gustKn': 15.6,
          'windDirDeg': 310,
          'tempC': 24.4,
          'symbol': 'clearsky_day',
        },
        <String, dynamic>{
          // gust/symbol yok → null kalır (uydurma değer YOK).
          'time': '2026-07-13T10:00:00Z',
          'windKn': 11.7,
          'windDirDeg': 300,
          'tempC': 24.0,
        },
      ],
      'fetchedAt': '2026-07-13T09:05:00Z',
      'attribution': 'MET Norway (CC BY 4.0)',
    });

    final WeatherForecast f = await api.forecast(lat: 36.75, lon: 28.93);
    expect(f.points, hasLength(2));
    expect(f.points.first.windKn, 9.7);
    expect(f.points.first.gustKn, 15.6);
    expect(f.points.first.windDirDeg, 310);
    expect(f.points.first.symbol, 'clearsky_day');
    expect(f.points.last.gustKn, isNull);
    expect(f.points.last.symbol, isNull);
    expect(f.attribution, contains('MET Norway'));
    expect(f.fetchedAt.toUtc().hour, 9);

    final sent = adapter.received.single;
    expect(sent.path, '/v1/weather');
    expect(sent.queryParameters['lat'], 36.75);
    expect(sent.queryParameters['lon'], 28.93);
  });

  test('sunucu hatası → AppFailure eşlemesi', () async {
    adapter.enqueueJson(503, <String, dynamic>{
      'type': 'https://api.dockly.app/problems/service-unavailable',
      'title': 'Servis geçici olarak kullanılamıyor',
      'status': 503,
    });
    expect(
      () => api.forecast(lat: 36.75, lon: 28.93),
      throwsA(isA<AppFailure>()),
    );
  });
}
