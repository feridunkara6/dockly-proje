import 'dart:async';

import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/api_search_gateway.dart';
import '../domain/search_gateway.dart';
import '../domain/search_state.dart';

/// Arama ağ geçidi sağlayıcısı — testte sahte ile override edilir.
final Provider<SearchGateway> searchGatewayProvider = Provider<SearchGateway>(
  (ref) => ApiSearchGateway(ref.watch(locationsApiProvider)),
);

/// Yazdıkça aramanın debounce süresi (her tuşta istek olmasın). Testte
/// `Duration.zero`'a override edilir.
final Provider<Duration> searchDebounceProvider =
    Provider<Duration>((ref) => const Duration(milliseconds: 350));

/// Arama ekranının beyni (docs/26 §4): sorgu değişimi → debounce → yükleme,
/// sonuç/hata durumu. Kısa sorguda arama yapılmaz (backend ile aynı eşik).
class LocationSearchController extends Notifier<SearchState> {
  Timer? _debounce;
  int _seq = 0;

  @override
  SearchState build() {
    ref.onDispose(() => _debounce?.cancel());
    return const SearchState();
  }

  SearchGateway get _gateway => ref.read(searchGatewayProvider);

  /// Kullanıcı arama kutusuna yazdıkça çağrılır. Sorguyu günceller; yeterince
  /// uzunsa debounce ile arar, kısaysa sonuçları temizler (arama yapmaz).
  void onQueryChanged(String q) {
    _debounce?.cancel();
    final SearchState next = state.copyWith(query: q, clearFailure: true);
    // Olanak filtresi seçiliyken kısa/boş metin aramayı DURDURMAZ (keşif modu);
    // ikisi de yoksa sonuçlar temizlenir ve ipucu gösterilir.
    if (!next.canSearch) {
      state = next.copyWith(
        results: const <LocationSummary>[],
        hasSearched: false,
        isLoading: false,
      );
      return;
    }
    state = next;
    _debounce = Timer(ref.read(searchDebounceProvider), _run);
  }

  /// Tür filtresini aç/kapat; sorgu yeterliyse anında yeniden ara (kullanıcı
  /// bilinçli dokundu — debounce'a gerek yok).
  void toggleType(String type) {
    final Set<String> next = Set<String>.of(state.types);
    if (!next.add(type)) next.remove(type);
    state = state.copyWith(types: next);
    _debounce?.cancel();
    if (state.canSearch) unawaited(_run());
  }

  /// Olanak filtresini aç/kapat ("yakıtı olan" gibi; AND birleşir). Metin
  /// olmasa da arama koşulur; son filtre kapanınca ve metin de kısaysa
  /// sonuçlar temizlenir.
  void toggleAmenity(String code) {
    final Set<String> next = Set<String>.of(state.amenities);
    if (!next.add(code)) next.remove(code);
    state = state.copyWith(amenities: next, clearFailure: true);
    _debounce?.cancel();
    if (state.canSearch) {
      unawaited(_run());
    } else {
      state = state.copyWith(
        results: const <LocationSummary>[],
        hasSearched: false,
        isLoading: false,
      );
    }
  }

  Future<void> _run() async {
    final String q = state.query.trim();
    final bool textOk = q.length >= kMinSearchLen;
    if (!textOk && state.amenities.isEmpty) return;
    final int seq = ++_seq;
    state = state.copyWith(isLoading: true, clearFailure: true);
    try {
      final List<String>? types = state.types.isEmpty ? null : state.types.toList();
      final List<String>? amenities =
          state.amenities.isEmpty ? null : state.amenities.toList();
      final List<LocationSummary> results = await _gateway.search(
        textOk ? q : '',
        types: types,
        amenities: amenities,
      );
      if (seq != _seq) return;
      state = state.copyWith(
        results: results,
        isLoading: false,
        hasSearched: true,
        clearFailure: true,
      );
    } on AppFailure catch (failure) {
      if (seq != _seq) return;
      state = state.copyWith(isLoading: false, failure: failure, hasSearched: true);
    }
  }

  /// "Teknem sığar" filtresini aç/kapat (istemci tarafı — yeniden arama gerekmez).
  void toggleBoatFitOnly() {
    state = state.copyWith(boatFitOnly: !state.boatFitOnly);
  }

  /// Hata ekranından son sorguyu yeniden dener.
  Future<void> retry() async {
    if (state.canSearch) await _run();
  }
}

final NotifierProvider<LocationSearchController, SearchState> searchControllerProvider =
    NotifierProvider<LocationSearchController, SearchState>(LocationSearchController.new);
