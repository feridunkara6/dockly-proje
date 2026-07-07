import 'package:flutter/material.dart';

/// Design system renk token'ları (docs/00 §7, docs/09). Light/dark ThemeExtension'a
/// terfi bir sonraki mobil alt fazda; şimdilik statik token + ColorScheme yeterli.
abstract final class DocklyColors {
  static const Color brandPrimary = Color(0xFF0C7BDC);
  static const Color brandPrimaryDark = Color(0xFF3B9DF2);
  static const Color brandDeep = Color(0xFF0A2540);
  static const Color accentTurquoise = Color(0xFF2EC4B6);
  static const Color success = Color(0xFF30A46C);
  static const Color warning = Color(0xFFFFB224);
  static const Color error = Color(0xFFE5484D);
}
