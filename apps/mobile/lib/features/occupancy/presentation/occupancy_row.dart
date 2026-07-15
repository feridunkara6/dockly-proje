import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart' show AppFailure;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../../auth/presentation/account_gate.dart';
import '../application/occupancy_controller.dart';

/// Doluluk düzeyi renkleri: durum renkleriyle aynı dil (yeşil/turuncu/kırmızı).
Color occupancyColor(String level) {
  switch (level) {
    case 'empty':
      return DocklyColors.success;
    case 'moderate':
      return DocklyColors.warning;
    default:
      return DocklyColors.error;
  }
}

/// "x dk/sa önce" etiketi — dakika altı "az önce" olur; 6 saatlik pencere
/// aşımı zaten sunucuda elendiği için gün birimi gerekmez.
String occupancyAgo(L10n t, DateTime reportedAt, DateTime now) {
  final Duration d = now.difference(reportedAt);
  if (d.inMinutes < 1) return t.agoJustNow;
  if (d.inMinutes < 60) return L10n.fmt(t.agoMinFmt, d.inMinutes.toString());
  return L10n.fmt(t.agoHourFmt, d.inHours.toString());
}

/// Detay ekranındaki doluluk satırı: son bildirim (varsa) + bildirme eylemi.
/// [initial] detay yanıtından gelir; kullanıcı bildirince yerel geçersiz kılma
/// haritası (occupancyOverridesProvider) daha taze özeti sağlar — HTTP
/// önbelleği yüzünden bekletmeden ekran anında güncellenir.
class OccupancyRow extends ConsumerWidget {
  const OccupancyRow({
    required this.idOrSlug,
    required this.initial,
    this.now,
    super.key,
  });

  final String idOrSlug;
  final OccupancySummary? initial;

  /// Saat kaynağı — testte sabitlenir; null → [DateTime.now].
  final DateTime Function()? now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n t = ref.watch(l10nProvider);
    final OccupancySummary? summary =
        ref.watch(occupancyOverridesProvider)[idOrSlug] ?? initial;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: <Widget>[
          if (summary != null)
            Expanded(child: _OccupancyChip(summary: summary, now: now))
          else
            const Spacer(),
          TextButton.icon(
            key: const ValueKey<String>('occupancy-report-button'),
            icon: const DocklyIcon(DocklyIcons.social, size: 18),
            label: Text(t.occReportCta),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            onPressed: () => requireAccount(
              context,
              ref,
              message: t.gateOccupancyMsg,
              onAllowed: () => _showReportSheet(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showReportSheet(BuildContext context, WidgetRef ref) async {
    final String? level = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      builder: (_) => const OccupancySheetBody(),
    );
    if (level == null || !context.mounted) return;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final L10n t = ref.read(l10nProvider);
    try {
      await ref.read(occupancyOverridesProvider.notifier).report(idOrSlug, level);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(t.occReported)));
    } on AppFailure catch (f) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(f.message)));
    }
  }
}

class _OccupancyChip extends ConsumerWidget {
  const _OccupancyChip({required this.summary, this.now});

  final OccupancySummary summary;
  final DateTime Function()? now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n t = ref.watch(l10nProvider);
    final ThemeData theme = Theme.of(context);
    final Color color = occupancyColor(summary.level);
    final String ago = occupancyAgo(t, summary.reportedAt, (now ?? DateTime.now)());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            L10n.fmt2(t.occChipFmt, t.occupancyLabel(summary.level), ago),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (summary.reportCount > 1) ...<Widget>[
          const SizedBox(width: 6),
          Text(
            '(${L10n.fmt(t.occCountFmt, summary.reportCount.toString())})',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ],
    );
  }
}

/// Doluluk bildirme alt sayfası — üç düzey, tek dokunuş. Testlerde doğrudan
/// bulunabilsin diye public.
class OccupancySheetBody extends ConsumerWidget {
  const OccupancySheetBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n t = ref.watch(l10nProvider);
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(t.occSheetTitle,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          for (final String level in <String>['empty', 'moderate', 'full'])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(level),
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: occupancyColor(level),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(t.occupancyLabel(level)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 4),
          Text(
            t.occSheetNote,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
