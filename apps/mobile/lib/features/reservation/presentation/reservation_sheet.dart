import 'package:dockly_api/dockly_api.dart' show Contact;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../../boat/application/my_boat_controller.dart';
import '../../boat/domain/my_boat.dart';
import '../domain/reservation_option.dart';
import '../domain/reservation_strategy.dart';

/// "Rezervasyon Talebi" alt sayfası (v1.0). Otomatik rezervasyon YAPMAZ —
/// lokasyonun iletişim yöntemlerini strateji öncelik sırasıyla (telefon →
/// WhatsApp → e-posta → web) sunar; kullanıcı seçince ilgili uygulama açılır ve
/// hazır mesaj (tekne bilgisiyle) kullanılabilir. Hiç iletişim yoksa bilgilendirir.
Future<void> showReservationSheet(
  BuildContext context, {
  required String locationName,
  required List<Contact> contacts,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext _) =>
        ReservationSheetBody(locationName: locationName, contacts: contacts),
  );
}

class ReservationSheetBody extends ConsumerWidget {
  const ReservationSheetBody({
    required this.locationName,
    required this.contacts,
    super.key,
  });

  final String locationName;
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final L10n t = ref.watch(l10nProvider);
    final MyBoat? boat = ref.watch(myBoatProvider);
    final List<ReservationOption> options = ref
        .read(reservationStrategyProvider)
        .options(contacts, boatLengthM: boat?.lengthM);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(t.rezTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(locationName, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 4),
          Text(t.rezIntro),
          const SizedBox(height: 16),
          if (options.isEmpty)
            const _NoContact()
          else
            for (int i = 0; i < options.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: DocklyButton(
                    label: options[i].label,
                    icon: _iconFor(options[i].channel),
                    variant: i == 0
                        ? DocklyButtonVariant.primary
                        : DocklyButtonVariant.secondary,
                    onPressed: () =>
                        _launchReservation(context, options[i].uri, t.linkFailed),
                  ),
                ),
              ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

DocklyIconData _iconFor(ReservationChannel channel) => switch (channel) {
      ReservationChannel.phone => DocklyIcons.phone,
      ReservationChannel.whatsapp => DocklyIcons.chat,
      ReservationChannel.email => DocklyIcons.email,
      ReservationChannel.website => DocklyIcons.language,
    };

Future<void> _launchReservation(
    BuildContext context, Uri uri, String failMessage) async {
  // Context'i await ÖNCESİNDE yakala (use_build_context_synchronously).
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  final NavigatorState navigator = Navigator.of(context);
  bool ok = false;
  try {
    ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    ok = false;
  }
  if (ok) {
    navigator.pop();
  } else {
    messenger.showSnackBar(SnackBar(content: Text(failMessage)));
  }
}

class _NoContact extends ConsumerWidget {
  const _NoContact();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DocklyIcon(
          DocklyIcons.infoOutline,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(ref.watch(l10nProvider).rezNoContact)),
      ],
    );
  }
}
