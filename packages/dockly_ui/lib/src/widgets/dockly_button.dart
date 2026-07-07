import 'package:flutter/material.dart';

/// Buton varyantları (docs/10 component library).
enum DocklyButtonVariant { primary, secondary }

/// Dockly birincil/ikincil buton (docs/09 §buton, docs/10). Yükleme durumunda
/// genişliğini korur, metin yerine spinner gösterir ve dokunmayı engeller.
class DocklyButton extends StatelessWidget {
  const DocklyButton({
    required this.label,
    required this.onPressed,
    this.variant = DocklyButtonVariant.primary,
    this.loading = false,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final DocklyButtonVariant variant;
  final bool loading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = loading ? null : onPressed;
    final child = loading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          )
        : _Label(label: label, icon: icon);

    switch (variant) {
      case DocklyButtonVariant.primary:
        return FilledButton(onPressed: effectiveOnPressed, child: child);
      case DocklyButtonVariant.secondary:
        return OutlinedButton(onPressed: effectiveOnPressed, child: child);
    }
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
