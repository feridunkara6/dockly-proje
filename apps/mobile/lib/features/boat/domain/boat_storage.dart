import 'my_boat.dart';

/// Tekne bilgisinin cihazda kalıcı saklanması (docs/26 clean architecture).
/// Kontrolcü somut depolama yerine bu soyutlamaya bağlanır — testte sahte ile
/// override edilir. En iyi çaba (best-effort): hata durumunda sessizce geçer,
/// asla fırlatmaz; böylece depolama yoksa uygulama yine misafir modda çalışır.
abstract interface class BoatStorage {
  Future<MyBoat?> load();
  Future<void> save(MyBoat boat);
  Future<void> clear();
}
