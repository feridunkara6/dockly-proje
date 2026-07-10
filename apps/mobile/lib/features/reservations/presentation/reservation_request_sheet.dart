import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../boat/application/my_boat_controller.dart';
import '../../boat/domain/my_boat.dart';
import '../../boat/presentation/boat_sheet.dart';
import '../application/reservations_controller.dart';
import '../domain/reservation_request.dart';

/// "Rezervasyon Talebi Gönder" alt sayfası. Tekne bilgisi "Teknem"den otomatik
/// gelir; iletişim ve serbest not (tarih, tekne sayısı vb.) alınır. Talep cihazda
/// saklanır — marinaya gerçek iletim sonraki fazda.
Future<void> showReservationSheet(
  BuildContext context, {
  required String locationId,
  required String locationName,
  required String locationType,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext _) => _ReservationSheet(
      locationId: locationId,
      locationName: locationName,
      locationType: locationType,
    ),
  );
}

class _ReservationSheet extends ConsumerStatefulWidget {
  const _ReservationSheet({
    required this.locationId,
    required this.locationName,
    required this.locationType,
  });

  final String locationId;
  final String locationName;
  final String locationType;

  @override
  ConsumerState<_ReservationSheet> createState() => _ReservationSheetState();
}

class _ReservationSheetState extends ConsumerState<_ReservationSheet> {
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _noteCtrl;

  @override
  void initState() {
    super.initState();
    _phoneCtrl = TextEditingController();
    _noteCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final MyBoat? boat = ref.read(myBoatProvider);
    final String phone = _phoneCtrl.text.trim();
    final String note = _noteCtrl.text.trim();
    final DateTime now = DateTime.now();
    final ReservationRequest request = ReservationRequest(
      id: '${widget.locationId}-${now.microsecondsSinceEpoch}',
      locationId: widget.locationId,
      locationName: widget.locationName,
      locationType: widget.locationType,
      createdAt: now.toIso8601String(),
      boatLengthM: boat?.lengthM,
      boatDraftM: boat?.draftM,
      contactPhone: phone.isEmpty ? null : phone,
      note: note.isEmpty ? null : note,
    );

    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    ref.read(reservationsProvider.notifier).add(request);
    Navigator.of(context).pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Talebin kaydedildi. "Taleplerim" sekmesinden görebilirsin.'),
          duration: Duration(seconds: 3),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MyBoat? boat = ref.watch(myBoatProvider);
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
          Text('Rezervasyon Talebi', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(widget.locationName, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 4),
          const Text(
            'Talebin şimdilik cihazında kaydedilir ve "Taleplerim"de görünür. '
            'Marinaya doğrudan iletim yakında.',
          ),
          const SizedBox(height: 16),
          _BoatLine(boat: boat, onDefine: () => showBoatSheet(context)),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'İletişim telefonu — opsiyonel',
              hintText: 'ör. 05xx xxx xx xx',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteCtrl,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Not (tarih, tekne sayısı, ihtiyaçlar) — opsiyonel',
              hintText: 'ör. 12–15 Ağustos, 1 tekne, elektrik/su lazım',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: DocklyButton(
              label: 'Talebi kaydet',
              icon: DocklyIcons.eventNote,
              onPressed: _submit,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// Talebe eklenecek tekne bilgisini gösterir; tanımsızsa tanımlama daveti sunar.
class _BoatLine extends StatelessWidget {
  const _BoatLine({required this.boat, required this.onDefine});

  final MyBoat? boat;
  final VoidCallback onDefine;

  @override
  Widget build(BuildContext context) {
    final MyBoat? boat = this.boat;
    if (boat == null) {
      return Row(
        children: <Widget>[
          const DocklyIcon(DocklyIcons.sailing, size: 18, color: DocklyColors.brandPrimary),
          const SizedBox(width: 8),
          const Expanded(child: Text('Tekne bilgisi eklenmedi')),
          TextButton(onPressed: onDefine, child: const Text('Tekne ekle')),
        ],
      );
    }
    final String draft =
        boat.draftM != null ? ' · su çekimi ${_fmt(boat.draftM!)} m' : '';
    return Row(
      children: <Widget>[
        const DocklyIcon(DocklyIcons.sailing, size: 18, color: DocklyColors.brandPrimary),
        const SizedBox(width: 8),
        Expanded(child: Text('Teknen: boy ${_fmt(boat.lengthM)} m$draft')),
      ],
    );
  }

  static String _fmt(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();
}
