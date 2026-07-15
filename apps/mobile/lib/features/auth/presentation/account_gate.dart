import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../application/auth_controller.dart';
import '../domain/auth_state.dart';
import 'account_section.dart';

/// Üyelik kapısı (kullanıcı kararı 2026-07): favoriye ekleme, rezervasyon
/// talebi ve marina/liman telefonla arama HESAP ister. Bilgilere bakmak
/// serbesttir; kapı yalnız EYLEM anında çıkar, gezinmeyi hiç engellemez.
/// Acil Durum sayfasındaki aramalar bilinçli olarak kapı DIŞIDIR (güvenlik).

/// Oturum "gerçek hesap" mı? (misafir kimliği hesap sayılmaz.)
bool hasAccount(WidgetRef ref) {
  final AuthState s = ref.read(authControllerProvider);
  return s is Authenticated && !s.isGuest;
}

/// Hesap varsa [onAllowed] hemen çalışır; yoksa "Hesap gerekli" sayfası
/// açılır, oradan giriş/kayıt yapılırsa eylem OTOMATİK devam eder (kullanıcı
/// düğmeye ikinci kez basmak zorunda kalmaz).
Future<void> requireAccount(
  BuildContext context,
  WidgetRef ref, {
  required String message,
  required VoidCallback onAllowed,
}) async {
  if (hasAccount(ref)) {
    onAllowed();
    return;
  }
  final bool? goSignIn = await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    builder: (_) => AccountRequiredSheetBody(message: message),
  );
  if (goSignIn != true || !context.mounted) return;
  await showSignInSheet(context);
  if (context.mounted && hasAccount(ref)) onAllowed();
}

/// "Hesap gerekli" alt sayfası — testlerde doğrudan bulunabilsin diye public.
class AccountRequiredSheetBody extends ConsumerWidget {
  const AccountRequiredSheetBody({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final L10n t = ref.watch(l10nProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              DocklyIcon(DocklyIcons.lockOutline, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Text(t.gateTitle,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Text(message, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(
            t.gateFreeNote,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          DocklyButton(
            label: t.accCta,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.gateNotNow),
          ),
        ],
      ),
    );
  }
}
