import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/favorites_controller.dart';
import '../domain/favorite_location.dart';

/// Bir lokasyonu favorilere ekleyip çıkaran kalp düğmesi (detay ekranı başlığı).
/// Favoriyse dolu kırmızı kalp, değilse çizgi kalp gösterir. Misafir-dostu:
/// hesap gerektirmez, seçim cihazda kalır.
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
    return IconButton(
      tooltip: isFav ? 'Favorilerden çıkar' : 'Favorilere ekle',
      icon: DocklyIcon(
        isFav ? DocklyIcons.favorite : DocklyIcons.favoriteBorder,
        color: isFav ? DocklyColors.error : null,
      ),
      onPressed: () {
        final FavoritesController controller = ref.read(favoritesProvider.notifier);
        controller.toggle(favorite);
        final bool nowFav = controller.isFavorite(favorite.id);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(nowFav ? 'Favorilere eklendi' : 'Favorilerden çıkarıldı'),
              duration: const Duration(seconds: 2),
            ),
          );
      },
    );
  }
}
