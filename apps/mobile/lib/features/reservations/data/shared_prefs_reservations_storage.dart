import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/reservation_request.dart';
import '../domain/reservations_storage.dart';

/// `ReservationsStorage`'ın `shared_preferences` uygulaması. Talep listesini JSON
/// olarak cihazda saklar. Tüm işlemler en iyi çaba: hata olursa sessizce geçer.
class SharedPrefsReservationsStorage implements ReservationsStorage {
  const SharedPrefsReservationsStorage();

  static const String _key = 'reservations.v1';

  @override
  Future<List<ReservationRequest>> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) return <ReservationRequest>[];
      final Object? decoded = jsonDecode(raw);
      if (decoded is! List) return <ReservationRequest>[];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(ReservationRequest.fromJson)
          .toList(growable: false);
    } catch (_) {
      return <ReservationRequest>[];
    }
  }

  @override
  Future<void> save(List<ReservationRequest> requests) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String raw = jsonEncode(
        requests.map((ReservationRequest r) => r.toJson()).toList(growable: false),
      );
      await prefs.setString(_key, raw);
    } catch (_) {
      // en iyi çaba — sessizce geç
    }
  }
}
