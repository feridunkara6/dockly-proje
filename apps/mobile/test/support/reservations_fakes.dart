import 'package:dockly_mobile/features/reservations/domain/reservation_request.dart';
import 'package:dockly_mobile/features/reservations/domain/reservations_storage.dart';

/// Bellek-içi sahte talep deposu — testte gerçek `shared_preferences` yerine.
class FakeReservationsStorage implements ReservationsStorage {
  FakeReservationsStorage([this.initial = const <ReservationRequest>[]]);

  List<ReservationRequest> initial;
  List<ReservationRequest> saved = const <ReservationRequest>[];
  int saveCount = 0;

  @override
  Future<List<ReservationRequest>> load() async => initial;

  @override
  Future<void> save(List<ReservationRequest> requests) async {
    saved = requests;
    saveCount++;
  }
}

const ReservationRequest reqA = ReservationRequest(
  id: 'a',
  locationId: 'loc-a',
  locationName: 'A Marina',
  locationType: 'private_marina',
  createdAt: '2026-01-01T10:00:00.000',
);

const ReservationRequest reqB = ReservationRequest(
  id: 'b',
  locationId: 'loc-b',
  locationName: 'B Koyu',
  locationType: 'anchorage',
  createdAt: '2026-02-01T10:00:00.000',
  boatLengthM: 12,
  contactPhone: '0555 000 00 00',
  note: 'Ağustos ortası, 1 tekne',
);
