import 'reservation_request.dart';

/// Rezervasyon taleplerinin cihazda kalıcı saklanması (docs/26 clean
/// architecture). Kontrolcü bu soyutlamaya bağlanır — testte sahte ile override
/// edilir. En iyi çaba: hata durumunda sessizce geçer, asla fırlatmaz.
abstract interface class ReservationsStorage {
  Future<List<ReservationRequest>> load();
  Future<void> save(List<ReservationRequest> requests);
}
