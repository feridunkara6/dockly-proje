import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';

/// Taleplerim sekmesi (v1.0). Rezervasyon GEÇMİŞİ artık üyelik özelliğidir
/// (v1.0 rezervasyon modeli): misafir, limanla doğrudan iletişime geçerek talep
/// başlatır ama geçmiş tutulmaz. Bu ekran, giriş gelene dek bilgilendirir.
class ReservationsPlaceholderScreen extends ConsumerWidget {
  const ReservationsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n t = ref.watch(l10nProvider);
    return Scaffold(
      appBar: AppBar(title: Text(t.navRequests)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const DocklyIcon(DocklyIcons.eventNoteOutlined, size: 48, color: DocklyColors.brandPrimary),
              const SizedBox(height: 12),
              Text(
                t.reqBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
