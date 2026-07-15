import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_strings.dart';
import '../../detail/presentation/location_detail_screen.dart';
import '../application/favorites_controller.dart';
import '../domain/favorite_location.dart';

/// Favoriler sekmesi (misafir/yerel). Kalp ile eklenen limanları listeler;
/// dokununca detayları açılır. Boşsa nasıl favori eklenir bilgisini gösterir.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FavoriteLocation> favorites = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(ref.watch(l10nProvider).navFavorites)),
      body: favorites.isEmpty
          ? const _EmptyFavorites()
          : ListView.separated(
              itemCount: favorites.length,
              separatorBuilder: (BuildContext _, int __) => const Divider(height: 1),
              itemBuilder: (BuildContext context, int i) =>
                  _FavoriteTile(favorite: favorites[i]),
            ),
    );
  }
}

class _FavoriteTile extends ConsumerWidget {
  const _FavoriteTile({required this.favorite});

  final FavoriteLocation favorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String subtitle = <String>[
      ref.watch(l10nProvider).typeLabel(favorite.type),
      if (favorite.city != null) favorite.city!,
    ].join(' · ');
    return ListTile(
      leading: DocklyTypeAvatar(type: favorite.type),
      title: Text(favorite.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        tooltip: ref.watch(l10nProvider).favRemoveTooltip,
        icon: const DocklyIcon(DocklyIcons.favorite, color: DocklyColors.error),
        onPressed: () => ref.read(favoritesProvider.notifier).remove(favorite.id),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext _) => LocationDetailScreen(idOrSlug: favorite.id),
        ),
      ),
    );
  }
}

class _EmptyFavorites extends ConsumerWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const DocklyIcon(DocklyIcons.favoriteBorder, size: 48, color: DocklyColors.brandPrimary),
            const SizedBox(height: 12),
            Text(
              ref.watch(l10nProvider).favEmpty,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
