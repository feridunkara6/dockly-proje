import 'package:dockly_mobile/features/reservations/application/reservations_controller.dart';
import 'package:dockly_mobile/features/reservations/domain/reservation_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/reservations_fakes.dart';

void main() {
  ProviderContainer makeContainer(FakeReservationsStorage storage) => ProviderContainer(
        overrides: <Override>[
          reservationsStorageProvider.overrideWithValue(storage),
        ],
      );

  test('ekle → en üste koyar ve cihaza kaydeder', () {
    final FakeReservationsStorage storage = FakeReservationsStorage();
    final ProviderContainer container = makeContainer(storage);
    addTearDown(container.dispose);
    final ReservationsController controller = container.read(reservationsProvider.notifier);

    expect(container.read(reservationsProvider), isEmpty);

    controller.add(reqA);
    controller.add(reqB); // en son eklenen en üstte
    final List<ReservationRequest> list = container.read(reservationsProvider);
    expect(list.map((ReservationRequest r) => r.id).toList(), <String>['b', 'a']);
    expect(storage.saveCount, 2);
  });

  test('sil → talebi kaldırır', () {
    final ProviderContainer container = makeContainer(FakeReservationsStorage());
    addTearDown(container.dispose);
    final ReservationsController controller = container.read(reservationsProvider.notifier);

    controller.add(reqA);
    controller.add(reqB);
    controller.remove('a');
    expect(container.read(reservationsProvider).map((ReservationRequest r) => r.id).toList(),
        <String>['b']);
  });

  test('restore cihazdakileri yükler ve tarihe göre (yeni üstte) sıralar', () async {
    final FakeReservationsStorage storage =
        FakeReservationsStorage(<ReservationRequest>[reqA, reqB]);
    final ProviderContainer container = makeContainer(storage);
    addTearDown(container.dispose);
    container.read(reservationsProvider.notifier); // build → restore

    await Future<void>.delayed(Duration.zero);

    final List<ReservationRequest> list = container.read(reservationsProvider);
    expect(list.map((ReservationRequest r) => r.id).toList(), <String>['b', 'a']);
  });
}
