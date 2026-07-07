import 'dart:async';

import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/map/application/map_controller.dart';
import 'package:dockly_mobile/features/map/domain/map_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/map_fakes.dart';

ProviderContainer _containerWith(
  FakeMapGateway gateway, {
  Duration debounce = Duration.zero,
}) {
  final container = ProviderContainer(
    overrides: <Override>[
      mapLocationsGatewayProvider.overrideWithValue(gateway),
      mapDebounceProvider.overrideWithValue(debounce),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

MapController _ctrl(ProviderContainer c) => c.read(mapControllerProvider.notifier);
MapState _state(ProviderContainer c) => c.read(mapControllerProvider);

void main() {
  test('başlangıç durumu boş (marker yok, yükleme yok)', () {
    final container = _containerWith(FakeMapGateway());
    final state = _state(container);
    expect(state.pins, isEmpty);
    expect(state.clusters, isEmpty);
    expect(state.isLoading, isFalse);
    expect(state.isEmpty, isTrue);
  });

  test('loadViewport başarı → pin modu verisi', () async {
    final container = _containerWith(FakeMapGateway(result: pinResult));
    await _ctrl(container).loadViewport(pinViewport);
    final state = _state(container);
    expect(state.pins.single.id, 'loc-1');
    expect(state.clusters, isEmpty);
    expect(state.isLoading, isFalse);
    expect(state.failure, isNull);
    expect(state.hasData, isTrue);
  });

  test('loadViewport cluster modu → balon verisi', () async {
    final container = _containerWith(FakeMapGateway(result: clusterResult));
    await _ctrl(container).loadViewport(clusterViewport);
    expect(_state(container).clusters.single.count, 34);
    expect(_state(container).pins, isEmpty);
  });

  test('hata → failure set edilir ama önceki marker korunur', () async {
    final gateway = FakeMapGateway(result: pinResult);
    final container = _containerWith(gateway);
    await _ctrl(container).loadViewport(pinViewport);
    expect(_state(container).pins, hasLength(1));

    gateway.error = const NetworkFailure();
    await _ctrl(container).loadViewport(clusterViewport);
    final state = _state(container);
    expect(state.failure, isA<NetworkFailure>());
    expect(state.isLoading, isFalse);
    expect(state.pins, hasLength(1)); // eski veri silinmedi
  });

  test('retry: hatadan sonra başarıyla toparlar', () async {
    final gateway = FakeMapGateway(error: const NetworkFailure());
    final container = _containerWith(gateway);
    await _ctrl(container).loadViewport(pinViewport);
    expect(_state(container).failure, isA<NetworkFailure>());

    gateway.error = null;
    gateway.result = pinResult;
    await _ctrl(container).retry();
    final state = _state(container);
    expect(state.failure, isNull);
    expect(state.pins.single.id, 'loc-1');
  });

  test('selectPin / clearSelection', () {
    final container = _containerWith(FakeMapGateway());
    _ctrl(container).selectPin('loc-1');
    expect(_state(container).selectedPinId, 'loc-1');
    _ctrl(container).clearSelection();
    expect(_state(container).selectedPinId, isNull);
  });

  test('onViewportChanged: aynı görünüm tekrar yüklenmez (dedup)', () async {
    final gateway = FakeMapGateway();
    final container = _containerWith(gateway);
    _ctrl(container).onViewportChanged(pinViewport);
    _ctrl(container).onViewportChanged(pinViewport); // aynı → atlanır
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(gateway.calls, hasLength(1));
  });

  test('onViewportChanged: farklı görünüm yüklenir', () async {
    final gateway = FakeMapGateway();
    final container = _containerWith(gateway);
    _ctrl(container).onViewportChanged(pinViewport);
    _ctrl(container).onViewportChanged(clusterViewport);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(gateway.calls, contains(clusterViewport));
  });

  test('stale koruması: eski yanıt geç gelirse yok sayılır (en son kazanır)', () async {
    final gateway = FakeMapGateway();
    final container = _containerWith(gateway);

    // İlk yükleme elle kontrol edilen completer ile askıda
    final slow = Completer<MapResult>();
    gateway.pending = slow;
    final firstFuture = _ctrl(container).loadViewport(pinViewport);

    // İkinci yükleme hızlı tamamlanır
    gateway.pending = null;
    gateway.result = clusterResult;
    await _ctrl(container).loadViewport(clusterViewport);
    expect(_state(container).clusters.single.count, 34);

    // Şimdi eski (yavaş) yanıt gelir — yok sayılmalı
    slow.complete(pinResult);
    await firstFuture;
    expect(_state(container).pins, isEmpty);
    expect(_state(container).clusters.single.count, 34);
  });
}
