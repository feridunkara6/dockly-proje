import 'package:flutter/material.dart';

/// Design system renk token'ları (docs/09, design/dockly-design-system.html).
/// Marka, durum ve yüzey/metin renkleri birebir tasarım sisteminden alınmıştır.
abstract final class DocklyColors {
  // Marka
  static const Color brandPrimary = Color(0xFF0C7BDC);
  static const Color brandPrimaryDark = Color(0xFF3B9DF2);
  static const Color brandDeep = Color(0xFF0A2540);
  static const Color accentTurquoise = Color(0xFF2EC4B6);

  // Durum
  static const Color success = Color(0xFF30A46C);
  static const Color warning = Color(0xFFFFB224);
  static const Color error = Color(0xFFE5484D);

  // Yüzey/arka plan + metin — AÇIK tema
  static const Color bgBase = Color(0xFFF7F9FC);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color text1 = Color(0xFF0F1728);
  static const Color text2 = Color(0xFF5B6B84);
  static const Color hairline = Color(0x140F1728); // rgba(15,23,40,.08)

  // Yüzey/arka plan + metin — KOYU tema
  static const Color bgBaseDark = Color(0xFF0B1220);
  static const Color bgSurfaceDark = Color(0xFF141C2B);
  static const Color text1Dark = Color(0xFFF2F5F9);
  static const Color text2Dark = Color(0xFF93A1B8);
  static const Color hairlineDark = Color(0x14F2F5F9);
}
