import 'package:shared_preferences/shared_preferences.dart';

import '../domain/welcome_store.dart';

/// `WelcomeStore`'un `shared_preferences` uygulaması. DİKKAT: hata durumunda
/// `wasShown` TRUE döner — depolama bozuksa kullanıcıya her açılışta soru
/// sormaktansa hiç sormamak tercih edilir (test ortamı dahil).
class SharedPrefsWelcomeStore implements WelcomeStore {
  const SharedPrefsWelcomeStore();

  static const String _key = 'welcome.v1.shown';

  @override
  Future<bool> wasShown() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key) ?? false;
    } catch (_) {
      return true; // en iyi çaba: bozuk depoda nag'leme
    }
  }

  @override
  Future<void> markShown() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, true);
    } catch (_) {
      // sessizce geç
    }
  }
}
