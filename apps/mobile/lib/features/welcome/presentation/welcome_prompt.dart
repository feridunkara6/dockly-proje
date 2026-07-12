import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../boat/application/my_boat_controller.dart';
import '../../boat/domain/my_boat.dart';
import '../../boat/presentation/boat_sheet.dart';
import '../data/shared_prefs_welcome_store.dart';
import '../domain/welcome_store.dart';

/// Karşılama deposu sağlayıcısı — testte sahte ile override edilir.
final Provider<WelcomeStore> welcomeStoreProvider =
    Provider<WelcomeStore>((ref) => const SharedPrefsWelcomeStore());

/// İlk açılışta BİR KEZ "Teknen kaç metre?" sorusunu gösterir (wow anı: cevap
/// verilirse tüm liman/arama sonuçlarında "teknen sığar mı?" rozetleri anında
/// kişiselleşir). Gösterilmez: daha önce soruldu ya da tekne zaten tanımlı.
Future<void> maybeShowWelcomePrompt(BuildContext context, WidgetRef ref) async {
  final WelcomeStore store = ref.read(welcomeStoreProvider);
  if (await store.wasShown()) return;
  // Tekne zaten var mı? Bellek + cihaz deposu (açılış geri-yükleme yarışına
  // karşı doğrudan depoya da bakılır) — varsa soruya gerek yok.
  final MyBoat? stored = await ref.read(boatStorageProvider).load();
  if (!context.mounted) return;
  if (stored != null || ref.read(myBoatProvider) != null) {
    await store.markShown();
    return;
  }
  // Soru bir kez sorulur — kullanıcı kaydırıp kapatsa bile tekrar nag'lenmez.
  await store.markShown();
  if (!context.mounted) return;
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext sheetContext) => WelcomeSheetBody(
      onPickLength: (double m) {
        ref.read(myBoatProvider.notifier).set(MyBoat(lengthM: m));
        Navigator.of(sheetContext).pop();
      },
      onCustom: () {
        Navigator.of(sheetContext).pop();
        // Ana bağlam üzerinden tam tekne sayfası (boy + su çekimi).
        if (context.mounted) showBoatSheet(context);
      },
      onSkip: () => Navigator.of(sheetContext).pop(),
    ),
  );
}

/// Karşılama içeriği: tek soru + hızlı boy seçenekleri. Ayrı widget — test edilir.
class WelcomeSheetBody extends StatelessWidget {
  const WelcomeSheetBody({
    required this.onPickLength,
    required this.onCustom,
    required this.onSkip,
    super.key,
  });

  final void Function(double lengthM) onPickLength;
  final VoidCallback onCustom;
  final VoidCallback onSkip;

  static const List<double> _quickLengths = <double>[8, 10, 12, 15, 18, 24];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const DocklyIcon(DocklyIcons.sailing, color: DocklyColors.brandPrimary),
              const SizedBox(width: 10),
              Text('Hoş geldin, kaptan', style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Teknen kaç metre? Söylersen her limanda "teknen sığar mı?" '
            'işaretini görürsün. Bilgi yalnız cihazında kalır.',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final double m in _quickLengths)
                ActionChip(
                  label: Text('${m.toInt()} m'),
                  onPressed: () => onPickLength(m),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              TextButton(onPressed: onCustom, child: const Text('Farklı bir boy gir')),
              const Spacer(),
              TextButton(onPressed: onSkip, child: const Text('Şimdilik geç')),
            ],
          ),
        ],
      ),
    );
  }
}
