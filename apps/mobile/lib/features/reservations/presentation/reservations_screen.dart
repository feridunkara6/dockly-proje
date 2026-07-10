import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/location_type_labels.dart';
import '../../detail/presentation/location_detail_screen.dart';
import '../application/reservations_controller.dart';
import '../domain/reservation_request.dart';

/// Taleplerim sekmesi (misafir/yerel). "Rezervasyon Talebi Gönder" ile bırakılan
/// talepleri listeler; dokununca limanın detayına gider. Boşsa nasıl talep
/// bırakılacağını anlatır.
class ReservationsScreen extends ConsumerWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ReservationRequest> requests = ref.watch(reservationsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Taleplerim')),
      body: requests.isEmpty
          ? const _EmptyReservations()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: requests.length,
              separatorBuilder: (BuildContext _, int __) => const SizedBox(height: 4),
              itemBuilder: (BuildContext context, int i) =>
                  _ReservationCard(request: requests[i]),
            ),
    );
  }
}

class _ReservationCard extends ConsumerWidget {
  const _ReservationCard({required this.request});

  final ReservationRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final List<String> meta = <String>[
      locationTypeLabelTr(request.locationType),
      'Talep: ${_fmtDate(request.createdAt)}',
    ];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(request.locationName, style: theme.textTheme.titleMedium),
                ),
                IconButton(
                  tooltip: 'Talebi sil',
                  icon: const DocklyIcon(DocklyIcons.deleteOutline, size: 20),
                  onPressed: () => ref.read(reservationsProvider.notifier).remove(request.id),
                ),
              ],
            ),
            Text(meta.join(' · '), style: theme.textTheme.bodySmall),
            if (request.boatLengthM != null) ...<Widget>[
              const SizedBox(height: 6),
              Text('Teknen: boy ${_fmtNum(request.boatLengthM!)} m'
                  '${request.boatDraftM != null ? ' · su çekimi ${_fmtNum(request.boatDraftM!)} m' : ''}'),
            ],
            if (request.contactPhone != null) ...<Widget>[
              const SizedBox(height: 4),
              Text('İletişim: ${request.contactPhone}'),
            ],
            if (request.note != null) ...<Widget>[
              const SizedBox(height: 4),
              Text(request.note!, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: DocklyButton(
                label: 'Limanı gör',
                variant: DocklyButtonVariant.secondary,
                icon: DocklyIcons.arrowForward,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext _) =>
                        LocationDetailScreen(idOrSlug: request.locationId),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyReservations extends StatelessWidget {
  const _EmptyReservations();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const DocklyIcon(DocklyIcons.eventNoteOutlined, size: 48, color: DocklyColors.brandPrimary),
            const SizedBox(height: 12),
            Text(
              'Henüz talebin yok.\nBir limanın sayfasında "Rezervasyon Talebi Gönder"e '
              'dokunarak talep bırakabilirsin. Bilgi cihazında kalır.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

/// ISO tarihi "gg.aa.yyyy" biçimine getirir; ayrıştırılamazsa tarih kısmını verir.
String _fmtDate(String iso) {
  final DateTime? d = DateTime.tryParse(iso);
  if (d == null) return iso.split('T').first;
  String two(int n) => n < 10 ? '0$n' : '$n';
  return '${two(d.day)}.${two(d.month)}.${d.year}';
}

String _fmtNum(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();
