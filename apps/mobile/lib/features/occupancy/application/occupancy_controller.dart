import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../auth/application/auth_controller.dart';

/// KOY DOLULUK BİLDİRİMİ (2026-07 ayrıştırma paketi ①).
///
/// Kurallar:
/// - Bildirim HESAP ister (üyelik kapısı arayüzde `requireAccount` ile,
///   sunucuda guard ile — iki katman tutarlı).
/// - Kullanıcı başına lokasyon başına TEK bildirim: yenisi eskisinin üstüne
///   yazar (fikir değişikliği serbest, sayı şişirme imkânsız).
/// - Gösterim yalnız SON 6 SAAT penceresine bakar; pencere boşsa hiçbir şey
///   gösterilmez — tahmin yok (0 uydurma veri ilkesinin arayüz uzantısı).

/// Bildirim ağ geçidi — testte sahte ile override edilir.
abstract interface class OccupancyGateway {
  Future<OccupancySummary> report(String idOrSlug, String level, GeoPoint position);
}

class ApiOccupancyGateway implements OccupancyGateway {
  ApiOccupancyGateway(this._api, this._tokenProvider);

  final LocationsApi _api;
  final Future<String?> Function() _tokenProvider;

  @override
  Future<OccupancySummary> report(
      String idOrSlug, String level, GeoPoint position) async {
    final String? token = await _tokenProvider();
    if (token == null) {
      // Arayüz kapısı normalde buraya düşürmez; oturum süresi ağ yokken
      // dolmuşsa güvenli tarafta kal: standart oturum hatası fırlat.
      throw const AuthFailure('Oturum yenilenemedi — lütfen tekrar giriş yapın.');
    }
    return _api.reportOccupancy(
        idOrSlug: idOrSlug, level: level, position: position, accessToken: token);
  }
}

final Provider<OccupancyGateway> occupancyGatewayProvider =
    Provider<OccupancyGateway>((ref) {
  return ApiOccupancyGateway(
    ref.watch(locationsApiProvider),
    () => ref.read(authRepositoryProvider).validAccessToken(),
  );
});

/// Bildirim SONRASI yerel tazeleme: detay yanıtındaki özet, sunucu HTTP
/// önbelleği yüzünden birkaç dakika eski kalabilir — bildirim yapan kullanıcı
/// kendi ekranında SONUCU HEMEN görmelidir. Bu harita, idOrSlug → en güncel
/// özet olarak bildirim yanıtını saklar; ekran `detail.occupancy` yerine
/// önce bunu okur.
class OccupancyOverrides extends Notifier<Map<String, OccupancySummary>> {
  @override
  Map<String, OccupancySummary> build() => <String, OccupancySummary>{};

  Future<OccupancySummary> report(
      String idOrSlug, String level, GeoPoint position) async {
    final OccupancySummary summary =
        await ref.read(occupancyGatewayProvider).report(idOrSlug, level, position);
    state = <String, OccupancySummary>{...state, idOrSlug: summary};
    return summary;
  }
}

final NotifierProvider<OccupancyOverrides, Map<String, OccupancySummary>>
    occupancyOverridesProvider =
    NotifierProvider<OccupancyOverrides, Map<String, OccupancySummary>>(
        OccupancyOverrides.new);
