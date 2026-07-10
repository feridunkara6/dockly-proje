import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

/// Taleplerim sekmesi (v1.0). Rezervasyon GEÇMİŞİ artık üyelik özelliğidir
/// (v1.0 rezervasyon modeli): misafir, limanla doğrudan iletişime geçerek talep
/// başlatır ama geçmiş tutulmaz. Bu ekran, giriş gelene dek bilgilendirir.
class ReservationsPlaceholderScreen extends StatelessWidget {
  const ReservationsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taleplerim')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const DocklyIcon(DocklyIcons.eventNoteOutlined, size: 48, color: DocklyColors.brandPrimary),
              const SizedBox(height: 12),
              Text(
                'Rezervasyon taleplerin burada görünecek.\n'
                'Bunun için giriş yapman gerekecek (yakında).\n\n'
                'Şimdilik bir limanın sayfasında "Rezervasyon Talebi"ne dokunarak '
                'marina ile doğrudan iletişime geçebilirsin.',
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
