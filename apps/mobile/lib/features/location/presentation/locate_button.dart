import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../application/location_controller.dart';

/// "Konumum" düğmesi (harita üstü kontrol). Dokununca tarayıcı/uygulama konum
/// izni ister; alınınca mesafeler ve "deniz yolu" kullanıcının konumundan
/// hesaplanır. İzin reddedilirse kısa bir bilgi mesajı gösterir.
class LocateButton extends ConsumerWidget {
  const LocateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n t = ref.watch(l10nProvider);
    final LocationStatus status = ref.watch(locationControllerProvider);

    ref.listen<LocationStatus>(locationControllerProvider, (LocationStatus? prev, LocationStatus next) {
      final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      if (next == LocationStatus.denied) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(t.locDenied)),
          );
      } else if (next == LocationStatus.located) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(t.locLocated),
              duration: const Duration(seconds: 3),
            ),
          );
      }
    });

    final bool loading = status == LocationStatus.loading;
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(24),
      child: IconButton(
        tooltip: t.locateTooltip,
        icon: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : DocklyIcon(
                DocklyIcons.navigation,
                color: status == LocationStatus.located ? DocklyColors.brandPrimary : null,
              ),
        onPressed:
            loading ? null : () => ref.read(locationControllerProvider.notifier).locateMe(),
      ),
    );
  }
}
