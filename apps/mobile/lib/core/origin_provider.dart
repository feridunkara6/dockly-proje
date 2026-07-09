import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kullanıcının güncel referans konumu — deniz-rota önizlemesinin "başlangıç"
/// noktası (docs vizyon: denizcilik-odaklı rota). v1: harita, görüntülenen
/// alanın merkezini buraya yazar; ileride GPS ile gerçek konum gelecek (P2.c).
/// `null` = henüz bilinmiyor (rota gösterilmez).
final StateProvider<GeoPoint?> originProvider = StateProvider<GeoPoint?>((ref) => null);
