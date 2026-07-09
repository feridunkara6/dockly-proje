import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/my_boat.dart';

/// Kullanıcının teknesi — oturum içi (bellekte). Tanımlanınca "teknen sığar mı?"
/// rozetleri her lokasyonda görünür. Kalıcı saklama (shared_preferences) sonraki adımda.
class MyBoatController extends Notifier<MyBoat?> {
  @override
  MyBoat? build() => null;

  void set(MyBoat boat) => state = boat;

  void clear() => state = null;
}

final NotifierProvider<MyBoatController, MyBoat?> myBoatProvider =
    NotifierProvider<MyBoatController, MyBoat?>(MyBoatController.new);
