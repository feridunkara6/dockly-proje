import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

/// Tek bir denizci istatistiği: ikon + değer + etiket. Detay ekranındaki
/// "Denizci Bilgileri" panelinde kart olarak gösterilir. Salt-veri modeli —
/// hangi veriyi göstereceğine detay ekranı karar verir (uydurma veri yok:
/// yalnız dolu alanlar stat'a çevrilir).
@immutable
class MaritimeStat {
  const MaritimeStat({required this.icon, required this.value, required this.label});

  final DocklyIconData icon;
  final String value;
  final String label;
}

/// Boyut + türe özel denizci verisini, taranması kolay bir stat-kart ızgarasında
/// gösterir (2 sütun). Değer yoksa (stats boş) hiç yer kaplamaz — böylece veri
/// dolmamış lokasyonlarda boş bir başlık görünmez.
class MaritimeInfoPanel extends StatelessWidget {
  const MaritimeInfoPanel({
    required this.stats,
    this.title = 'Denizci Bilgileri',
    super.key,
  });

  final List<MaritimeStat> stats;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) return const SizedBox.shrink();
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            const double gap = 10;
            // İki sütun; dar ekranlarda taşarsa Wrap alt satıra alır.
            final double tileWidth = (constraints.maxWidth - gap) / 2;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: <Widget>[
                for (final MaritimeStat s in stats)
                  SizedBox(width: tileWidth, child: _StatTile(stat: s)),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final MaritimeStat stat;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DocklyColors.bgSurface,
        border: Border.all(color: DocklyColors.hairline),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          DocklyIcon(stat.icon, size: 22, color: DocklyColors.brandPrimary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  stat.value,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  stat.label,
                  style: theme.textTheme.bodySmall?.copyWith(color: DocklyColors.brandDeep),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
