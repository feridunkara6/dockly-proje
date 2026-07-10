import 'package:dockly_api/dockly_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../route/domain/sea_route.dart' show haversineNm;

/// Arama sonuçlarının istemci-tarafı sıralaması.
/// - relevance: sunucudan gelen alaka sırası (varsayılan)
/// - rating: puana göre azalan
/// - distance: kullanıcının konumuna (originProvider) göre en yakından uzağa
enum SearchSort { relevance, rating, distance }

/// Seçili sıralama — arama kutusunun altındaki çiplerle değişir (istemci tarafı,
/// yeni sorgu tetiklemez).
final StateProvider<SearchSort> searchSortProvider =
    StateProvider<SearchSort>((ref) => SearchSort.relevance);

/// "Ücretsiz" süzgeci açık mı? Açıksa yalnızca `priceTier == 'free'` gösterilir.
final StateProvider<bool> searchFreeOnlyProvider = StateProvider<bool>((ref) => false);

/// Eldeki sonuçlara "ücretsiz" süzgeci + sıralamayı uygular. Sunucu sorgusunu
/// DEĞİŞTİRMEZ; yalnızca mevcut listeyi yeniden düzenler (saf fonksiyon → test kolay).
List<LocationSummary> applySearchView(
  List<LocationSummary> input, {
  required bool freeOnly,
  required SearchSort sort,
  GeoPoint? origin,
}) {
  Iterable<LocationSummary> out = input;
  if (freeOnly) {
    out = out.where((LocationSummary s) => s.priceTier == 'free');
  }
  final List<LocationSummary> list = out.toList();
  switch (sort) {
    case SearchSort.relevance:
      break; // sunucu sırası korunur
    case SearchSort.rating:
      list.sort((LocationSummary a, LocationSummary b) =>
          (b.ratingAvg ?? -1).compareTo(a.ratingAvg ?? -1));
    case SearchSort.distance:
      final GeoPoint? o = origin;
      if (o != null) {
        list.sort((LocationSummary a, LocationSummary b) =>
            haversineNm(o, a.position).compareTo(haversineNm(o, b.position)));
      }
  }
  return list;
}
