import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/map/domain/map_viewport.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:dockly_mobile/features/map/presentation/web_map_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('web yüzeyi gerçek harita çizer: cluster sayısı + pin görünür, görünüm bildirilir',
      (WidgetTester tester) async {
    MapViewport? reported;
    final MapSurfaceCallbacks callbacks = MapSurfaceCallbacks(
      onViewportChanged: (MapViewport v) => reported = v,
      onPinTap: (String _) {},
      onClusterTap: (_) {},
    );
    const MapSurfaceData data = MapSurfaceData(
      pins: <LocationPin>[
        LocationPin(
          id: 'p1',
          name: 'D-Marin Göcek',
          type: 'private_marina',
          position: GeoPoint(lat: 36.75, lon: 28.93),
          ratingAvg: 4.8,
          priceTier: 'paid',
        ),
      ],
      clusters: <Cluster>[
        Cluster(
          position: GeoPoint(lat: 40.9, lon: 29.05),
          count: 33,
          bbox: Bbox(minLon: 28.8, minLat: 40.0, maxLon: 30.2, maxLat: 41.4),
        ),
      ],
      selectedPinId: null,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => webMapSurfaceBuilder(context, data, callbacks),
          ),
        ),
      ),
    );
    await tester.pump(); // postFrame callback çalışsın (açılış görünümü)

    // Gerçek harita + cluster sayısı çizildi (tasarım §06).
    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.text('33'), findsOneWidget);

    // Açılışta geçerli bir görünüm bildirilir (pinler yüklensin).
    expect(reported, isNotNull);
    // bbox her kenarı ≤ 5° olmalı (sunucu sınırı — aksi halde 422).
    expect(reported!.bbox.maxLat - reported!.bbox.minLat, lessThanOrEqualTo(5.0));
    expect(reported!.bbox.maxLon - reported!.bbox.minLon, lessThanOrEqualTo(5.0));
  });
}
