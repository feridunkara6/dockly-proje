import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/location_controller.dart';

/// "Konumum" düğmesi (harita üstü kontrol). Dokununca tarayıcı/uygulama konum
/// izni ister; alınınca mesafeler ve "deniz yolu" kullanıcının konumundan
/// hesaplanır. İzin reddedilirse kısa bir bilgi mesajı gösterir.
class LocateButton extends ConsumerWidget {
  const LocateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationStatus status = ref.watch(locationControllerProvider);

    ref.listen<LocationStatus>(locationControllerProvider, (LocationStatus? prev, LocationStatus next) {
      final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      if (next == LocationStatus.denied) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Konum alınamadı. Tarayıcı/uygulama konum iznini kontrol et.'),
            ),
          );
      } else if (next == LocationStatus.located) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Konumun alındı — mesafeler ve deniz yolu artık senden hesaplanıyor.'),
              duration: Duration(seconds: 3),
            ),
          );
      }
    });

    final bool loading = status == LocationStatus.loading;
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(24),
      child: IconButton(
        tooltip: 'Konumum',
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
