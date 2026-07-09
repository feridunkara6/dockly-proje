import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/location_type_labels.dart';
import '../../detail/presentation/location_detail_screen.dart';
import '../application/search_controller.dart';
import '../domain/search_state.dart';

/// Arama ekranı (S-07, docs/01-prd §6.13). Misafir: liman/koy/şehir adıyla arar,
/// sonuca dokununca detay açılır. Yazma eylemleri yok — tamamen misafir-dostu.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: ref.read(searchControllerProvider).query);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchState state = ref.watch(searchControllerProvider);
    final SearchController controller = ref.read(searchControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: TextField(
          controller: _ctrl,
          textInputAction: TextInputAction.search,
          onChanged: controller.onQueryChanged,
          decoration: InputDecoration(
            hintText: 'Liman, koy, şehir ara',
            border: InputBorder.none,
            suffixIcon: state.query.isEmpty
                ? const Icon(Icons.search)
                : IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: 'Temizle',
                    onPressed: () {
                      _ctrl.clear();
                      controller.onQueryChanged('');
                    },
                  ),
          ),
        ),
      ),
      body: _SearchBody(state: state, onRetry: () => controller.retry()),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody({required this.state, required this.onRetry});

  final SearchState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.isQueryTooShort) {
      return const _Hint(
        icon: Icons.search,
        message: 'Aramak için en az 2 harf yaz.\nÖrn. "Göcek" ya da "D-Marin".',
      );
    }
    if (state.isLoading && state.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.failure != null && state.results.isEmpty) {
      return _ErrorView(message: state.failure!.message, onRetry: onRetry);
    }
    if (state.isEmpty) {
      return const _Hint(
        icon: Icons.sailing_outlined,
        message: 'Sonuç bulunamadı.\nFarklı bir isim dene.',
      );
    }
    return ListView.separated(
      itemCount: state.results.length,
      separatorBuilder: (BuildContext _, int __) => const Divider(height: 1),
      itemBuilder: (BuildContext context, int i) => _ResultTile(item: state.results[i]),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({required this.item});

  final LocationSummary item;

  @override
  Widget build(BuildContext context) {
    final String subtitle = <String>[
      locationTypeLabelTr(item.type),
      if (_place(item) != null) _place(item)!,
    ].join(' · ');
    return ListTile(
      leading: Icon(Icons.place, size: 30, color: DocklyMapColors.forType(item.type)),
      title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: item.ratingAvg != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.star, size: 16, color: DocklyColors.warning),
                const SizedBox(width: 2),
                Text(item.ratingAvg!.toStringAsFixed(1)),
              ],
            )
          : null,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext _) => LocationDetailScreen(idOrSlug: item.id),
        ),
      ),
    );
  }

  static String? _place(LocationSummary item) {
    final List<String> parts = <String>[];
    if (item.city != null) parts.add(item.city!);
    if (item.waterBodyName != null) parts.add(item.waterBodyName!);
    return parts.isEmpty ? null : parts.join(', ');
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 48, color: DocklyColors.brandPrimary),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            DocklyButton(label: 'Tekrar dene', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
