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
    this.title,
    this.label,
    this.height,
    super.key,
  });

  final String type;

  /// Verilirse kapak "hero" olur: altta okunurluk degradesi üstünde büyük isim
  /// (ör. marina adı) + tip ikonu gösterilir. Verilmezse ortada tip ikonu.
  final String? title;

  final String? label;

  /// Verilirse sabit yükseklik; verilmezse 16:9 en-boy oranı kullanılır.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final Color base = DocklyMapColors.forType(type);
    final Color deep = Color.lerp(base, DocklyColors.brandDeep, 0.55) ?? base;
    final DocklyIconData icon = DocklyIcons.forLocationType(type);
    final String? label = this.label;
    final String? title = this.title;

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
          // Başlık yoksa: ortada tip ikonu (eski davranış — kart/küçük kullanım).
          if (title == null)
            Center(
              child: DocklyIcon(icon, size: 46, color: Colors.white.withValues(alpha: 0.95)),
            ),
          // Başlık varsa: altta okunurluk degradesi + isim "hero" + tip ikonu.
          if (title != null) ...<Widget>[
            const Positioned(left: 0, right: 0, bottom: 0, child: _BottomScrim()),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DocklyIcon(icon, size: 18, color: Colors.white.withValues(alpha: 0.95)),
                      if (label != null) ...<Widget>[
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.92),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Başlık yokken sol-üst etiket (eski davranış).
          if (label != null && title == null)
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

/// Hero başlığın altında okunurluğu artıran hafif koyu degrade (alttan yukarı).
class _BottomScrim extends StatelessWidget {
  const _BottomScrim();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            Colors.black.withValues(alpha: 0.48),
            Colors.black.withValues(alpha: 0.0),
          ],
        ),
      ),
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
