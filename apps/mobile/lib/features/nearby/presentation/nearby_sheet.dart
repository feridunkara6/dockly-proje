import 'dart:ui' show ImageFilter;

import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/location_type_labels.dart';
import '../../../core/origin_provider.dart';
import '../../detail/presentation/location_detail_screen.dart';
import '../application/nearby_controller.dart';

/// Harita altındaki "Yakınımdaki Bağlanma Noktaları" alt-sayfası (tasarım §07 phone
/// mockup'ı: Apple Maps tarzı peek durumu). Cam zemin + tutamaç + başlık ve
/// yatay mini-kart rayı (tasarım .mini-card: 132 px, kapak degradesi, ad,
/// "tip · ★puan · mesafe"). Haritada bakılan noktaya göre en yakın limanlar;
/// karta dokununca detay açılır. Boş/yükleniyor/hata → sessizce gizlenir.
class NearbySheet extends ConsumerWidget {
  const NearbySheet({super.key});

  /// Sorgu anahtarı ~1 km'ye yuvarlanır — her küçük kaydırmada istek atılmaz.
  static double _round2(double v) => (v * 100).roundToDouble() / 100;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GeoPoint? origin = ref.watch(originProvider);
    if (origin == null) return const SizedBox.shrink();
    final MapNearbyKey key =
        (lat: _round2(origin.lat), lon: _round2(origin.lon));
    final AsyncValue<List<LocationSummary>> async = ref.watch(mapNearbyProvider(key));
    final List<LocationSummary>? items = async.valueOrNull;
    if (items == null || items.isEmpty) return const SizedBox.shrink();

    final ThemeData theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.78),
            border: Border(
              top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.4)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Tutamaç (tasarım .handle: 36×4, yumuşak).
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(top: 8, bottom: 10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Yakınımdaki Bağlanma Noktaları',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  // Kart içeriği (64 kapak + metinler) + pay: taşma testte hata
                  // sayılır, farklı yazı ölçeklerine karşı bolluk bırakılır.
                  height: 134,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                    itemCount: items.length,
                    separatorBuilder: (BuildContext _, int __) => const SizedBox(width: 10),
                    itemBuilder: (BuildContext context, int i) =>
                        _NearbyMiniCard(item: items[i]),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Mini kart (tasarım .mini-card): 132 px genişlik, 12 px köşe, üstte tip
/// renkli kapak degradesi (64 px), altta ad + "tip · ★puan · mesafe".
class _NearbyMiniCard extends StatelessWidget {
  const _NearbyMiniCard({required this.item});

  final LocationSummary item;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String rating =
        item.ratingAvg != null ? ' · ★ ${item.ratingAvg!.toStringAsFixed(1)}' : '';
    final String subtitle =
        '${locationTypeLabelTr(item.type)}$rating · ${_fmtNm(item.distanceNm)} nm';
    return SizedBox(
      width: 132,
      child: Material(
        color: theme.colorScheme.surface,
        // Tasarım .mini-card: 12 px köşe + ince (hairline) çerçeve.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext _) => LocationDetailScreen(idOrSlug: item.id),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Tasarım .mini-img: 64 px yüksek tip-renkli kapak degradesi.
              DocklyCoverPlaceholder(type: item.type, height: 64),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 7, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Tasarım .mini-card ölçüleri SABİT (11.5/10 px): tema yazı
                    // ölçüsünden bağımsız → kart yüksekliği deterministik,
                    // RenderFlex taşması olmaz (CI kırmızısının kökü buydu).
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.1,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.2,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _fmtNm(double nm) =>
      nm >= 10 ? nm.round().toString() : nm.toStringAsFixed(1);
}
