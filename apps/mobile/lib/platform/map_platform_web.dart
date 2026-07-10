import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/map/presentation/map_surface.dart';
import '../features/map/presentation/web_map_surface.dart';

/// Harita platform katmanı — WEB. Mapbox web'de çalışmadığından hiç import
/// edilmez; harita yüzeyi yerine liste-yönlendiren bir web yüzeyi kullanılır.

/// Web'de Mapbox yok — token'a gerek yok.
void applyMapAccessToken(String token) {}

/// Web harita yüzeyini bağlayan provider override'ları.
List<Override> mapPlatformOverrides() => <Override>[
      mapSurfaceBuilderProvider.overrideWithValue(webMapSurfaceBuilder),
    ];
