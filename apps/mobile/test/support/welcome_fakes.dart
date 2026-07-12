import 'package:dockly_mobile/features/boat/domain/boat_storage.dart';
import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:dockly_mobile/features/welcome/domain/welcome_store.dart';

/// Testte `WelcomeStore` yerine geçen sahte.
class FakeWelcomeStore implements WelcomeStore {
  FakeWelcomeStore({this.shown = false});

  bool shown;
  int markCount = 0;

  @override
  Future<bool> wasShown() async => shown;

  @override
  Future<void> markShown() async {
    shown = true;
    markCount += 1;
  }
}

/// Testte `BoatStorage` yerine geçen sahte (bellek içi).
class FakeBoatStorage implements BoatStorage {
  FakeBoatStorage({this.boat});

  MyBoat? boat;

  @override
  Future<MyBoat?> load() async => boat;

  @override
  Future<void> save(MyBoat value) async => boat = value;

  @override
  Future<void> clear() async => boat = null;
}
