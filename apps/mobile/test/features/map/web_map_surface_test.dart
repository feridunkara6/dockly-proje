import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/map/domain/map_viewport.dart';
import 'package:dockly_mobile/features/map/presentation/map_surface.dart';
import 'package:dockly_mobile/features/map/presentation/web_map_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('web yüzeyi açılışta görünüm bildirir + liste yönlendirmesi gösterir',
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
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => webMapSurfaceBuilder(context, data, callbacks),
          ),
        ),
      ),
    );
    await tester.pump(); // postFrame callback çalışsın

    expect(reported, isNotNull);
    expect(find.textContaining('liste düğmesiyle'), findsOneWidget);
  });
}
