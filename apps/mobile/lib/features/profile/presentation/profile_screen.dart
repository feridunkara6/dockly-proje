import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/account_section.dart';
import '../../boat/application/my_boat_controller.dart';
import '../../boat/domain/my_boat.dart';
import '../../boat/presentation/boat_sheet.dart';
import '../../emergency/presentation/emergency_screen.dart';

/// Profil sekmesi (misafir). Kalıcı tekne bilgisini gösterir/düzenler ve hesap
/// özelliklerini tanıtır. Giriş/hesap (favori, yorum yazma) sonraki fazda.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MyBoat? boat = ref.watch(myBoatProvider);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: <Widget>[
          // ACİL DURUM girişi en üstte — panik anında aranacak ilk yer burası.
          _EmergencyEntryCard(
            onOpen: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const EmergencyScreen()),
            ),
          ),
          const SizedBox(height: 24),
          Text('Teknem', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (boat == null)
            _BoatEmptyCard(onDefine: () => showBoatSheet(context))
          else
            _BoatCard(
              boat: boat,
              onEdit: () => showBoatSheet(context),
              onRemove: () => ref.read(myBoatProvider.notifier).clear(),
            ),
          const SizedBox(height: 28),
          Text('Hesap', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          // Giriş/kayıt (paket 1): oturum yoksa giriş kartı, varsa hesap kartı.
          const AccountSection(),
        ],
      ),
    );
  }
}

/// Kırmızı acil durum giriş kartı — tek dokunuşla Acil Durum sayfası.
class _EmergencyEntryCard extends StatelessWidget {
  const _EmergencyEntryCard({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.errorContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              DocklyIcon(DocklyIcons.errorOutline,
                  color: theme.colorScheme.onErrorContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Acil Durum',
                        style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onErrorContainer)),
                    const SizedBox(height: 2),
                    Text(
                      '158 · 112 · VHF 16 · MAYDAY şablonu · denizci alfabesi',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer
                              .withValues(alpha: 0.85)),
                    ),
                  ],
                ),
              ),
              DocklyIcon(DocklyIcons.arrowForward,
                  size: 18, color: theme.colorScheme.onErrorContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoatCard extends StatelessWidget {
  const _BoatCard({required this.boat, required this.onEdit, required this.onRemove});

  final MyBoat boat;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const DocklyIcon(DocklyIcons.sailing, color: DocklyColors.brandPrimary),
                const SizedBox(width: 10),
                Text('Boy ${_fmt(boat.lengthM)} m', style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              boat.draftM != null
                  ? 'Su çekimi ${_fmt(boat.draftM!)} m'
                  : 'Su çekimi belirtilmemiş',
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const DocklyIcon(DocklyIcons.edit, size: 18),
                  label: const Text('Düzenle'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onRemove,
                  icon: const DocklyIcon(DocklyIcons.deleteOutline, size: 18),
                  label: const Text('Kaldır'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _fmt(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}

class _BoatEmptyCard extends StatelessWidget {
  const _BoatEmptyCard({required this.onDefine});

  final VoidCallback onDefine;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Henüz tekne tanımlamadın. Tanımlarsan her limanda "teknen sığar mı?" '
              'işaretini görürsün. Bilgi cihazında kalır.',
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: DocklyButton(label: 'Tekneni tanımla', onPressed: onDefine),
            ),
          ],
        ),
      ),
    );
  }
}

// _InfoCard kaldırıldı: "Yakında hesap" bilgi kartının yerini gerçek
// AccountSection aldı (giriş/kayıt paketi 1, 2026-07).
