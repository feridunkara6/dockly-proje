import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../application/auth_controller.dart';
import '../domain/auth_gateway.dart';
import '../domain/auth_state.dart';

/// Profil sekmesindeki "Hesap" bölümü (paket 1 — giriş/kayıt, kullanıcı onayı
/// 2026-07). Oturum yoksa giriş kartı, varsa hesap kartı gösterir. Misafir
/// modu İLKEDİR: giriş hiçbir keşif özelliği için zorunlu değildir.
class AccountSection extends ConsumerWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState state = ref.watch(authControllerProvider);
    final L10n t = ref.watch(l10nProvider);
    if (state is Authenticated && !state.isGuest) {
      return _SignedInCard(
        t: t,
        email: ref.watch(authGatewayProvider).currentEmail,
        onSignOut: () => ref.read(authControllerProvider.notifier).logout(),
      );
    }
    return _SignInCard(t: t, onSignIn: () => showSignInSheet(context));
  }
}

/// Oturum kapalı: fayda anlatan giriş kartı.
class _SignInCard extends StatelessWidget {
  const _SignInCard({required this.t, required this.onSignIn});

  final L10n t;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              DocklyIcon(DocklyIcons.personOutline, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(t.accTitle,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(t.accBody, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: DocklyButton(
              label: t.accCta,
              icon: DocklyIcons.personOutline,
              onPressed: onSignIn,
            ),
          ),
        ],
      ),
    );
  }
}

/// Oturum açık: e-posta + çıkış.
class _SignedInCard extends StatelessWidget {
  const _SignedInCard({required this.t, required this.email, required this.onSignOut});

  final L10n t;
  final String? email;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          DocklyIcon(DocklyIcons.person, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(t.accOpen,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                if (email != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(email!,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ],
            ),
          ),
          TextButton(onPressed: onSignOut, child: Text(t.signOut)),
        ],
      ),
    );
  }
}

/// Giriş/kayıt alt sayfasını açar (CI dersi: uzun sayfa → isScrollControlled
/// + SingleChildScrollView, klavye için viewInsets dolgusu).
Future<void> showSignInSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: const SingleChildScrollView(child: SignInSheetBody()),
    ),
  );
}

/// Alt sayfa gövdesi — testlerde doğrudan bulunabilsin diye public.
class SignInSheetBody extends ConsumerStatefulWidget {
  const SignInSheetBody({super.key});

  @override
  ConsumerState<SignInSheetBody> createState() => _SignInSheetBodyState();
}

class _SignInSheetBodyState extends ConsumerState<SignInSheetBody> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// Basit istemci doğrulaması — asıl doğrulama Firebase'de.
  String? _validate() {
    final L10n t = ref.read(l10nProvider);
    final String email = _email.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      return t.valEmail;
    }
    if (_password.text.length < 6) {
      return t.valPassword;
    }
    return null;
  }

  Future<void> _submitEmail({required bool register}) async {
    final String? invalid = _validate();
    if (invalid != null) {
      setState(() => _error = invalid);
      return;
    }
    await _run(() => ref.read(authControllerProvider.notifier).signInEmail(
          email: _email.text.trim(),
          password: _password.text,
          register: register,
        ));
  }

  Future<void> _submitGoogle() {
    return _run(() =>
        ref.read(authControllerProvider.notifier).signIn(AuthProviderKind.google));
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      if (mounted) Navigator.of(context).pop(); // başarı → sayfa kapanır
    } on AppFailure catch (f) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = f.message;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = 'Giriş yapılamadı. Tekrar deneyin.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final L10n t = ref.watch(l10nProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(t.sheetTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            t.sheetSub,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _email,
            enabled: !_busy,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const <String>[AutofillHints.email],
            decoration: InputDecoration(
              labelText: t.emailLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _password,
            enabled: !_busy,
            obscureText: true,
            autofillHints: const <String>[AutofillHints.password],
            decoration: InputDecoration(
              labelText: t.passwordLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          if (_error != null) ...<Widget>[
            const SizedBox(height: 10),
            Text(
              _error!,
              key: const ValueKey<String>('auth-error'),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          DocklyButton(
            label: _busy ? t.busyLabel : t.signInBtn,
            onPressed: _busy ? null : () => _submitEmail(register: false),
          ),
          const SizedBox(height: 8),
          DocklyButton(
            label: t.registerBtn,
            variant: DocklyButtonVariant.secondary,
            onPressed: _busy ? null : () => _submitEmail(register: true),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(t.orLabel,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 16),
          DocklyButton(
            label: t.googleBtn,
            variant: DocklyButtonVariant.secondary,
            onPressed: _busy ? null : _submitGoogle,
          ),
        ],
      ),
    );
  }
}
