import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/shared_prefs_reservations_storage.dart';
import '../domain/reservation_request.dart';
import '../domain/reservations_storage.dart';

/// Talep depolama sağlayıcısı — testte sahte ile override edilir.
final Provider<ReservationsStorage> reservationsStorageProvider =
    Provider<ReservationsStorage>((ref) => const SharedPrefsReservationsStorage());

/// Misafir/yerel rezervasyon talepleri. "Rezervasyon Talebi Gönder" ile eklenir,
/// cihazda kalıcı olur ve "Taleplerim" sekmesinde listelenir. Hesap gerektirmez.
class ReservationsController extends Notifier<List<ReservationRequest>> {
  /// Restore tamamlanmadan kaldırılan id'ler — geç gelen restore geri EKLEMEZ.
  final Set<String> _removed = <String>{};

  @override
  List<ReservationRequest> build() {
    unawaited(_restore());
    return const <ReservationRequest>[];
  }

  ReservationsStorage get _storage => ref.read(reservationsStorageProvider);

  Future<void> _restore() async {
    final List<ReservationRequest> stored = await _storage.load();
    if (stored.isEmpty) return;
    final Map<String, ReservationRequest> byId = <String, ReservationRequest>{};
    for (final ReservationRequest r in stored) {
      if (!_removed.contains(r.id)) byId[r.id] = r;
    }
    for (final ReservationRequest r in state) {
      byId[r.id] = r;
    }
    // En yeni en üstte: createdAt'e göre azalan.
    final List<ReservationRequest> merged = byId.values.toList()
      ..sort((ReservationRequest a, ReservationRequest b) => b.createdAt.compareTo(a.createdAt));
    state = List<ReservationRequest>.unmodifiable(merged);
  }

  /// Yeni talebi en üste ekler ve cihaza kaydeder.
  void add(ReservationRequest request) {
    _removed.remove(request.id);
    state = List<ReservationRequest>.unmodifiable(<ReservationRequest>[request, ...state]);
    unawaited(_storage.save(state));
  }

  void remove(String id) {
    _removed.add(id);
    state = List<ReservationRequest>.unmodifiable(
      state.where((ReservationRequest r) => r.id != id),
    );
    unawaited(_storage.save(state));
  }
}

final NotifierProvider<ReservationsController, List<ReservationRequest>> reservationsProvider =
    NotifierProvider<ReservationsController, List<ReservationRequest>>(
        ReservationsController.new);
