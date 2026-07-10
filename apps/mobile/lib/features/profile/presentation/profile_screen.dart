import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../boat/application/my_boat_controller.dart';
import '../../boat/domain/my_boat.dart';
import '../../boat/presentation/boat_sheet.dart';

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
          const _InfoCard(
            icon: Icons.lock_outline,
            message:
                'Yakında: hesap oluşturarak favori limanlarını kaydet, yorum yaz '
                've rezervasyon iste. Şimdilik tüm keşif özellikleri giriş '
                'gerektirmeden açık.',
          ),
        ],
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
                const Icon(Icons.sailing, color: DocklyColors.brandPrimary),
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
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Düzenle'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline, size: 18),
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: DocklyColors.brandDeep),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
