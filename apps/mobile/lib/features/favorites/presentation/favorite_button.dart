import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../../auth/presentation/account_gate.dart';
import '../application/favorites_controller.dart';
import '../domain/favorite_location.dart';

/// Bir lokasyonu favorilere ekleyip çıkaran kalp düğmesi (detay ekranı başlığı).
/// Favoriyse dolu kırmızı kalp, değilse çizgi kalp gösterir.
/// ÜYELİK KAPISI (kullanıcı kararı 2026-07): favoriye EKLEME hesap ister;
/// çıkarma serbesttir (kullanıcının eski seçimini silmesi engellenmez).
class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({required this.favorite, super.key});

  final FavoriteLocation favorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFav = ref.watch(
      favoritesProvider.select(
        (List<FavoriteLocation> list) =>
            list.any((FavoriteLocation f) => f.id == favorite.id),
      ),
    );
    void toggleAndNotify() {
      final FavoritesController controller = ref.read(favoritesProvider.notifier);
      controller.toggle(favorite);
      final bool nowFav = controller.isFavorite(favorite.id);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(nowFav
                ? ref.read(l10nProvider).favAdded
                : ref.read(l10nProvider).favRemoved),
            duration: const Duration(seconds: 2),
          ),
        );
    }

    return IconButton(
      tooltip: isFav ? 'Favorilerden çıkar' : 'Favorilere ekle',
      icon: DocklyIcon(
        isFav ? DocklyIcons.favorite : DocklyIcons.favoriteBorder,
        color: isFav ? DocklyColors.error : null,
      ),
      onPressed: () {
        if (isFav) {
          toggleAndNotify(); // çıkarma kapısız
          return;
        }
        requireAccount(
          context,
          ref,
          message: ref.read(l10nProvider).gateFavMsg,
          onAllowed: toggleAndNotify,
        );
      },
    );
  }
}
