import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_mobile/core/origin_provider.dart';
import 'package:dockly_mobile/features/location/application/location_controller.dart';
import 'package:dockly_mobile/features/map/application/map_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/location_fakes.dart';

void main() {
  test('konum alınınca origin yazılır ve durum "located" olur', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        locationServiceProvider.overrideWithValue(
          FakeLocationService(const GeoPoint(lat: 40.0, lon: 29.0)),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(originProvider), isNull);

    await container.read(locationControllerProvider.notifier).locateMe();

    expect(container.read(locationControllerProvider), LocationStatus.located);
    final GeoPoint? origin = container.read(originProvider);
    expect(origin?.lat, 40.0);
    expect(origin?.lon, 29.0);
    // GPS ayrıca saklanır (harita gezinmesi ezmesin) + kamera odak isteği.
    expect(container.read(devicePositionProvider)?.lat, 40.0);
    expect(container.read(mapFocusProvider)?.seq, 1);
    expect(container.read(mapFocusProvider)?.point.lon, 29.0);
  });

  test('ikinci konum isteğinde odak seq artar (aynı nokta yutulmaz)', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        locationServiceProvider.overrideWithValue(
          FakeLocationService(const GeoPoint(lat: 40.0, lon: 29.0)),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(locationControllerProvider.notifier).locateMe();
    await container.read(locationControllerProvider.notifier).locateMe();
    expect(container.read(mapFocusProvider)?.seq, 2);
  });

  test('konum alınamazsa durum "denied", origin null kalır', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        locationServiceProvider.overrideWithValue(FakeLocationService(null)),
      ],
    );
    addTearDown(container.dispose);

    await container.read(locationControllerProvider.notifier).locateMe();

    expect(container.read(locationControllerProvider), LocationStatus.denied);
    expect(container.read(originProvider), isNull);
    expect(container.read(devicePositionProvider), isNull);
    expect(container.read(mapFocusProvider), isNull);
  });
}
