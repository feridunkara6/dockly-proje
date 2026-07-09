import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

/// Detayda çalışma saatleri + sezon bölümü (docs/23 §11.3). Veri yoksa gizlenir.
///
/// NOT: `day_of_week` 0–6 (docs/22). Standart Postgres/JS düzeni varsayıldı:
/// 0 = Pazar … 6 = Cumartesi. Veri farklı bir düzen kullanıyorsa `_dayNamesTr`
/// tek satırda güncellenir.
class OperatingInfo extends StatelessWidget {
  const OperatingInfo({
    required this.hours,
    required this.seasons,
    required this.is24h,
    super.key,
  });

  final List<Hour> hours;
  final List<Season> seasons;
  final bool is24h;

  static const List<String> _dayNamesTr = <String>[
    'Pazar', 'Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi',
  ];
  // Türk haftası: Pazartesi → Pazar sırası.
  static const List<int> _weekOrder = <int>[1, 2, 3, 4, 5, 6, 0];
  static const List<String> _monthsTr = <String>[
    '', 'Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Widget> children = <Widget>[];

    if (is24h) {
      children
        ..add(_title(theme, 'Çalışma saatleri'))
        ..add(const _Row(label: 'Her gün', value: '24 saat açık'));
    } else if (hours.isNotEmpty) {
      children.add(_title(theme, 'Çalışma saatleri'));
      for (final int dow in _weekOrder) {
        final List<Hour> dayHours = hours.where((Hour h) => h.dayOfWeek == dow).toList();
        if (dayHours.isEmpty) continue;
        final String open = dayHours
            .where((Hour h) => h.opensAt != null && h.closesAt != null)
            .map((Hour h) => '${h.opensAt}–${h.closesAt}')
            .join(', ');
        children.add(_Row(label: _dayNamesTr[dow], value: open.isEmpty ? 'Kapalı' : open));
      }
    }

    if (seasons.isNotEmpty) {
      children.add(_title(theme, 'Sezon'));
      for (final Season s in seasons) {
        children.add(_Row(label: 'Açık', value: '${_fmtMonthDay(s.opensOn)} – ${_fmtMonthDay(s.closesOn)}'));
      }
    }

    if (children.isEmpty) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[const SizedBox(height: 20), ...children],
    );
  }

  Widget _title(ThemeData theme, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: theme.textTheme.titleMedium),
      );

  static String _fmtMonthDay(String? mmdd) {
    if (mmdd == null) return '?';
    final List<String> parts = mmdd.split('-');
    if (parts.length != 2) return mmdd;
    final int? m = int.tryParse(parts[0]);
    final int? d = int.tryParse(parts[1]);
    if (m == null || d == null || m < 1 || m > 12) return mmdd;
    return '$d ${_monthsTr[m]}';
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: DocklyColors.brandDeep)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
