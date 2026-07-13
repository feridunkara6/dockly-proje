import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';

/// Minimum anlamlı arama uzunluğu (backend ile aynı eşik — docs/23 §9).
const int kMinSearchLen = 2;

/// Arama ekranı durumu (docs/26 §4). Yeni sorgu gelince eski sonuçlar korunur
/// (üstüne yükleme göstergesi biner); hata veriyi silmez.
class SearchState {
  const SearchState({
    this.query = '',
    this.types = const <String>{},
    this.amenities = const <String>{},
    this.boatFitOnly = false,
    this.results = const <LocationSummary>[],
    this.isLoading = false,
    this.failure,
    this.hasSearched = false,
  });

  final String query;

  /// Seçili `location_type` kodları (boş = tüm türler). Aramayı daraltır.
  final Set<String> types;

  /// Seçili olanak kodları (AND — hepsi bulunmalı). Boş = filtre yok.
  /// Olanak seçiliyken METİN OLMADAN da arama yapılır (keşif modu).
  final Set<String> amenities;

  /// "Teknem sığar" filtresi açık mı? Açıksa (ve tekne tanımlıysa) teknenin
  /// kesinlikle sığmadığı sonuçlar gizlenir (istemci tarafı).
  final bool boatFitOnly;
  final List<LocationSummary> results;
  final bool isLoading;
  final AppFailure? failure;

  /// En az bir arama tamamlandı mı? İlk arama bitmeden "sonuç yok" GÖSTERİLMEZ.
  final bool hasSearched;

  /// Sorgu anlamlı uzunlukta değil (kısa) — tek başına arama yapılmaz.
  bool get isQueryTooShort => query.trim().length < kMinSearchLen;

  /// Arama koşulabilir mi: yeterli metin YA DA en az bir olanak filtresi.
  bool get canSearch => !isQueryTooShort || amenities.isNotEmpty;

  /// Boş durum: aranabilir durumda, arama bitti, hata yok ve sonuç boş.
  bool get isEmpty =>
      canSearch && hasSearched && !isLoading && failure == null && results.isEmpty;

  SearchState copyWith({
    String? query,
    Set<String>? types,
    Set<String>? amenities,
    bool? boatFitOnly,
    List<LocationSummary>? results,
    bool? isLoading,
    AppFailure? failure,
    bool clearFailure = false,
    bool? hasSearched,
  }) {
    return SearchState(
      query: query ?? this.query,
      types: types ?? this.types,
      amenities: amenities ?? this.amenities,
      boatFitOnly: boatFitOnly ?? this.boatFitOnly,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}
