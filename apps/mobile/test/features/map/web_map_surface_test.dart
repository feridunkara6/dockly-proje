import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/map/domain/map_viewport.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:dockly_mobile/features/map/presentation/web_map_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('web yüzeyi geçerli görünüm bildirir + liste düğmesi gösterir',
      (WidgetTester tester) async {
    MapViewport? reported;
    final MapSurfaceCallbacks callbacks = MapSurfaceCallbacks(
      onViewportChanged: (MapViewport v) => reported = v,
      onPinTap: (String _) {},
      onClusterTap: (_) {},
    );
    const MapSurfaceData data = MapSurfaceData(
      pins: <LocationPin>[],
      clusters: <Cluster>[],
      selectedPinId: null,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) => webMapSurfaceBuilder(context, data, callbacks),
            ),
          ),
        ),
      ),
    );
    await tester.pump(); // postFrame callback çalışsın

    expect(reported, isNotNull);
    // bbox her kenarı ≤ 5° olmalı (sunucu sınırı — aksi halde 422).
    expect(reported!.bbox.maxLat - reported!.bbox.minLat, lessThanOrEqualTo(5.0));
    expect(reported!.bbox.maxLon - reported!.bbox.minLon, lessThanOrEqualTo(5.0));
    expect(find.text('Limanları listede gör'), findsOneWidget);
  });
}
