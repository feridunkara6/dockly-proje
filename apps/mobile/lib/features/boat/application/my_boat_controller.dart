import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/shared_prefs_boat_storage.dart';
import '../domain/boat_storage.dart';
import '../domain/my_boat.dart';

/// Tekne depolama sağlayıcısı — testte sahte ile override edilir.
final Provider<BoatStorage> boatStorageProvider =
    Provider<BoatStorage>((ref) => const SharedPrefsBoatStorage());

/// Kullanıcının teknesi. Tanımlanınca "teknen sığar mı?" rozetleri her
/// lokasyonda görünür ve bilgi cihazda kalıcıdır (uygulama yeniden açılınca
/// geri yüklenir). Depolama en iyi çaba — yoksa bellek içi çalışır.
class MyBoatController extends Notifier<MyBoat?> {
  /// Kullanıcı açılış-yüklemesi tamamlanmadan tekneyi değiştirdi/sildi mi?
  /// Öyleyse geç gelen `_restore` kullanıcının seçimini EZMEZ (yarış koruması).
  bool _touched = false;

  @override
  MyBoat? build() {
    unawaited(_restore());
    return null;
  }

  BoatStorage get _storage => ref.read(boatStorageProvider);

  /// Açılışta cihazdan yükler; kayıt varsa VE kullanıcı henüz dokunmadıysa uygular.
  Future<void> _restore() async {
    final MyBoat? boat = await _storage.load();
    if (_touched || boat == null) return;
    state = boat;
  }

  void set(MyBoat boat) {
    _touched = true;
    state = boat;
    unawaited(_storage.save(boat));
  }

  void clear() {
    _touched = true;
    state = null;
    unawaited(_storage.clear());
  }
}

final NotifierProvider<MyBoatController, MyBoat?> myBoatProvider =
    NotifierProvider<MyBoatController, MyBoat?>(MyBoatController.new);
