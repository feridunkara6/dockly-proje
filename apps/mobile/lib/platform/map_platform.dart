import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' show MapboxOptions;

import '../features/map/presentation/map_surface.dart';
import '../features/map/presentation/mapbox_map_surface.dart';

/// Harita platform katmanı — MOBİL varsayılan. Mapbox'ı kullanır. Web derlemesi
/// bu dosya yerine `map_platform_web.dart`'ı koşullu import ile seçer, böylece
/// Mapbox web'de hiç derlenmez (bkz. bootstrap.dart).

/// Mapbox public erişim token'ını ayarlar (boşsa harita gri kalır, çökmez).
void applyMapAccessToken(String token) {
  if (token.isNotEmpty) {
    MapboxOptions.setAccessToken(token);
  }
}

/// Harita yüzeyini Mapbox ile bağlayan provider override'ları.
List<Override> mapPlatformOverrides() => <Override>[
      mapSurfaceBuilderProvider.overrideWithValue(mapboxMapSurfaceBuilder),
    ];
