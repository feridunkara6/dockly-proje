import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/search/application/search_controller.dart';
import 'package:dockly_mobile/features/search/domain/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/search_fakes.dart';

ProviderContainer _containerWith(FakeSearchGateway gateway) {
  final ProviderContainer container = ProviderContainer(
    overrides: <Override>[
      searchGatewayProvider.overrideWithValue(gateway),
      searchDebounceProvider.overrideWithValue(Duration.zero),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

LocationSearchController _ctrl(ProviderContainer c) => c.read(searchControllerProvider.notifier);
SearchState _state(ProviderContainer c) => c.read(searchControllerProvider);

/// Debounce (zero) timer + Future.value çözülene dek bekler.
Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 20));

void main() {
  test('başlangıç: boş sorgu, kısa sorgu → arama yok, boş-durum gösterilmez', () {
    final ProviderContainer c = _containerWith(FakeSearchGateway());
    final SearchState s = _state(c);
    expect(s.query, '');
    expect(s.isQueryTooShort, isTrue);
    expect(s.results, isEmpty);
    expect(s.isEmpty, isFalse);
  });

  test('kısa sorgu (1 harf) → gateway çağrılmaz', () async {
    final FakeSearchGateway gateway =
        FakeSearchGateway(results: <LocationSummary>[sampleSummary('a', 'Alfa')]);
    final ProviderContainer c = _containerWith(gateway);
    _ctrl(c).onQueryChanged('a');
    await _settle();
    expect(gateway.queries, isEmpty);
    expect(_state(c).results, isEmpty);
  });

  test('yeterli sorgu → gateway çağrılır, sonuçlar dolar', () async {
    final FakeSearchGateway gateway = FakeSearchGateway(
      results: <LocationSummary>[sampleSummary('loc-1', 'D-Marin Göcek', ratingAvg: 4.8)],
    );
    final ProviderContainer c = _containerWith(gateway);
    _ctrl(c).onQueryChanged('göcek');
    await _settle();
    final SearchState s = _state(c);
    expect(gateway.queries, <String>['göcek']);
    expect(s.results.single.name, 'D-Marin Göcek');
    expect(s.isLoading, isFalse);
    expect(s.hasSearched, isTrue);
  });

  test('sonuç boş → isEmpty true', () async {
    final ProviderContainer c = _containerWith(FakeSearchGateway());
    _ctrl(c).onQueryChanged('zzz');
    await _settle();
    expect(_state(c).isEmpty, isTrue);
  });

  test('hata → failure set, hasSearched true', () async {
    final ProviderContainer c = _containerWith(FakeSearchGateway(error: const NetworkFailure()));
    _ctrl(c).onQueryChanged('göcek');
    await _settle();
    final SearchState s = _state(c);
    expect(s.failure, isA<NetworkFailure>());
    expect(s.hasSearched, isTrue);
  });

  test('tür filtresi seçilince gateway types ile çağrılır + durum güncellenir', () async {
    final FakeSearchGateway gateway =
        FakeSearchGateway(results: <LocationSummary>[sampleSummary('loc-1', 'Göcek')]);
    final ProviderContainer c = _containerWith(gateway);
    _ctrl(c).onQueryChanged('göcek');
    await _settle();
    _ctrl(c).toggleType('private_marina');
    await _settle();
    expect(_state(c).types, contains('private_marina'));
    expect(gateway.typeArgs.last, <String>['private_marina']);
  });

  test('tür filtresini kaldırınca types null ile çağrılır', () async {
    final FakeSearchGateway gateway =
        FakeSearchGateway(results: <LocationSummary>[sampleSummary('loc-1', 'Göcek')]);
    final ProviderContainer c = _containerWith(gateway);
    _ctrl(c).onQueryChanged('göcek');
    await _settle();
    _ctrl(c).toggleType('private_marina');
    await _settle();
    _ctrl(c).toggleType('private_marina'); // aynı türe tekrar dokun → kaldır
    await _settle();
    expect(_state(c).types, isEmpty);
    expect(gateway.typeArgs.last, isNull);
  });

  test('kısa sorguda tür seçimi arama tetiklemez ama durum güncellenir', () async {
    final FakeSearchGateway gateway = FakeSearchGateway();
    final ProviderContainer c = _containerWith(gateway);
    _ctrl(c).toggleType('private_marina');
    await _settle();
    expect(_state(c).types, contains('private_marina'));
    expect(gateway.queries, isEmpty);
  });

  test('sorguyu temizleyince sonuçlar sıfırlanır', () async {
    final FakeSearchGateway gateway =
        FakeSearchGateway(results: <LocationSummary>[sampleSummary('loc-1', 'Göcek')]);
    final ProviderContainer c = _containerWith(gateway);
    _ctrl(c).onQueryChanged('göcek');
    await _settle();
    expect(_state(c).results, isNotEmpty);
    _ctrl(c).onQueryChanged('');
    expect(_state(c).results, isEmpty);
    expect(_state(c).hasSearched, isFalse);
  });
}
