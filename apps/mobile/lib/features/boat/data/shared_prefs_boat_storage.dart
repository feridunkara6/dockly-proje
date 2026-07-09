import 'package:shared_preferences/shared_preferences.dart';

import '../domain/boat_storage.dart';
import '../domain/my_boat.dart';

/// `BoatStorage`'ın `shared_preferences` uygulaması. Tekne boyu/su çekimini
/// cihazda saklar. Tüm işlemler en iyi çaba: hata olursa sessizce geçer (ör.
/// test ortamında eklenti yoksa) — uygulama akışı bozulmaz.
class SharedPrefsBoatStorage implements BoatStorage {
  const SharedPrefsBoatStorage();

  static const String _lenKey = 'boat.lengthM';
  static const String _draftKey = 'boat.draftM';

  @override
  Future<MyBoat?> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final double? len = prefs.getDouble(_lenKey);
      if (len == null) return null;
      return MyBoat(lengthM: len, draftM: prefs.getDouble(_draftKey));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(MyBoat boat) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_lenKey, boat.lengthM);
      final double? draft = boat.draftM;
      if (draft != null) {
        await prefs.setDouble(_draftKey, draft);
      } else {
        await prefs.remove(_draftKey);
      }
    } catch (_) {
      // en iyi çaba — sessizce geç
    }
  }

  @override
  Future<void> clear() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_lenKey);
      await prefs.remove(_draftKey);
    } catch (_) {
      // en iyi çaba — sessizce geç
    }
  }
}
