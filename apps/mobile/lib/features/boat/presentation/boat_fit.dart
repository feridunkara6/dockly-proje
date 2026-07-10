import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/my_boat_controller.dart';
import '../domain/my_boat.dart';
import 'boat_sheet.dart';

/// Lokasyon detayında tekne uygunluğu satırı: tekne tanımlıysa rozet gösterir,
/// tanımsızsa "Tekneni tanımla" davetini gösterir (docs/01-prd §6.5).
class BoatFitRow extends ConsumerWidget {
  const BoatFitRow({required this.maxBoatLengthM, required this.maxDraftM, super.key});

  final double? maxBoatLengthM;
  final double? maxDraftM;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MyBoat? boat = ref.watch(myBoatProvider);
    if (boat == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: ActionChip(
          avatar: const DocklyIcon(DocklyIcons.straighten, size: 18),
          label: const Text('Teknen sığar mı? · Tekneni tanımla'),
          onPressed: () => showBoatSheet(context),
        ),
      );
    }
    final BoatFit fit = computeBoatFit(
      boat: boat,
      maxBoatLengthM: maxBoatLengthM,
      maxDraftM: maxDraftM,
    );
    return Row(
      children: <Widget>[
        BoatFitBadge(fit: fit),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => showBoatSheet(context),
          child: const Text('Değiştir'),
        ),
      ],
    );
  }
}

/// Tekne uygunluğu rozeti (renk + ikon + metin).
class BoatFitBadge extends StatelessWidget {
  const BoatFitBadge({required this.fit, super.key});

  final BoatFit fit;

  @override
  Widget build(BuildContext context) {
    final (DocklyIconData icon, String label, Color color) = switch (fit) {
      BoatFit.fits => (DocklyIcons.checkCircle, 'Teknen sığar', DocklyColors.success),
      BoatFit.tooBig => (DocklyIcons.errorOutline, 'Teknen sığmayabilir', DocklyColors.warning),
      BoatFit.unknown => (DocklyIcons.helpOutline, 'Uygunluk bilinmiyor', DocklyColors.brandDeep),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DocklyIcon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
