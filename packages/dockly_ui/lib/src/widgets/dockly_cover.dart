import 'package:flutter/material.dart';

import '../theme/dockly_colors.dart';
import '../theme/dockly_map_colors.dart';
import 'dockly_icon.dart';

/// Fotoğrafı olmayan lokasyonlar için tasarımlı kapak görseli (detay hero).
/// Tipe göre renk (DocklyMapColors) + marka derinliğine geçen degrade + büyük
/// silik denizcilik motifi + ortada tip ikonu; sol üstte küçük etiket. Böylece
/// fotoğraf gelmese de sayfa "tasarlanmış" ve dolu görünür.
class DocklyCoverPlaceholder extends StatelessWidget {
  const DocklyCoverPlaceholder({
    required this.type,
    this.label,
    this.height,
    super.key,
  });

  final String type;
  final String? label;

  /// Verilirse sabit yükseklik; verilmezse 16:9 en-boy oranı kullanılır.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final Color base = DocklyMapColors.forType(type);
    final Color deep = Color.lerp(base, DocklyColors.brandDeep, 0.55) ?? base;
    final DocklyIconData icon = DocklyIcons.forLocationType(type);
    final String? label = this.label;

    final Widget inner = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[base, deep],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Silik büyük motif (sağ-alt) — derinlik hissi.
          Positioned(
            right: -18,
            bottom: -26,
            child: DocklyIcon(icon, size: 140, color: Colors.white.withValues(alpha: 0.14)),
          ),
          Center(
            child: DocklyIcon(icon, size: 46, color: Colors.white.withValues(alpha: 0.95)),
          ),
          if (label != null)
            Positioned(
              left: 14,
              top: 14,
              child: _Chip(label: label),
            ),
        ],
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: height != null
          ? SizedBox(height: height, width: double.infinity, child: inner)
          : AspectRatio(aspectRatio: 16 / 9, child: inner),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Liste/kart öğeleri için küçük, tipe göre renkli görsel (fotoğraf yerine).
/// Yuvarlatılmış kare + degrade + beyaz tip ikonu.
class DocklyTypeAvatar extends StatelessWidget {
  const DocklyTypeAvatar({required this.type, this.size = 44, super.key});

  final String type;
  final double size;

  @override
  Widget build(BuildContext context) {
    final Color base = DocklyMapColors.forType(type);
    final Color deep = Color.lerp(base, DocklyColors.brandDeep, 0.45) ?? base;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[base, deep],
        ),
      ),
      child: Center(
        child: DocklyIcon(
          DocklyIcons.forLocationType(type),
          size: size * 0.52,
          color: Colors.white,
        ),
      ),
    );
  }
}
