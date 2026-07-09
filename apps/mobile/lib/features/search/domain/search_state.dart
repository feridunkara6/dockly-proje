import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';

/// Minimum anlamlı arama uzunluğu (backend ile aynı eşik — docs/23 §9).
const int kMinSearchLen = 2;

/// Arama ekranı durumu (docs/26 §4). Yeni sorgu gelince eski sonuçlar korunur
/// (üstüne yükleme göstergesi biner); hata veriyi silmez.
class SearchState {
  const SearchState({
    this.query = '',
    this.results = const <LocationSummary>[],
    this.isLoading = false,
    this.failure,
    this.hasSearched = false,
  });

  final String query;
  final List<LocationSummary> results;
  final bool isLoading;
  final AppFailure? failure;

  /// En az bir arama tamamlandı mı? İlk arama bitmeden "sonuç yok" GÖSTERİLMEZ.
  final bool hasSearched;

  /// Sorgu anlamlı uzunlukta değil (kısa) — arama yapılmaz, ipucu gösterilir.
  bool get isQueryTooShort => query.trim().length < kMinSearchLen;

  /// Boş durum: yeterli sorgu var, arama bitti, hata yok ve sonuç boş.
  bool get isEmpty =>
      !isQueryTooShort && hasSearched && !isLoading && failure == null && results.isEmpty;

  SearchState copyWith({
    String? query,
    List<LocationSummary>? results,
    bool? isLoading,
    AppFailure? failure,
    bool clearFailure = false,
    bool? hasSearched,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}
