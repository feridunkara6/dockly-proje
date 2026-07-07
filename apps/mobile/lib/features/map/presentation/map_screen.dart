import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/map_controller.dart';
import '../domain/map_state.dart';
import 'map_surface.dart';

/// Harita ekranı (S-06). Somut harita yüzeyi üstüne durum katmanları:
/// yükleme, boş, hata+retry, "çok fazla sonuç" ipucu (docs/26 §4, docs/23 §9.5).
class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MapState state = ref.watch(mapControllerProvider);
    final MapController controller = ref.read(mapControllerProvider.notifier);
    final MapSurfaceBuilder surfaceBuilder = ref.watch(mapSurfaceBuilderProvider);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: surfaceBuilder(
              context,
              MapSurfaceData(
                pins: state.pins,
                clusters: state.clusters,
                selectedPinId: state.selectedPinId,
              ),
              MapSurfaceCallbacks(
                onViewportChanged: controller.onViewportChanged,
                onPinTap: controller.selectPin,
                onClusterTap: (_) => controller.clearSelection(),
              ),
            ),
          ),
          if (state.isLoading && state.hasData)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(minHeight: 3),
            ),
          if (state.truncated) const _TruncatedHint(),
          if (state.isLoading && !state.hasData)
            const Positioned.fill(child: _CenterProgress()),
          if (state.isEmpty) const Positioned.fill(child: _EmptyView()),
          if (state.failure != null)
            Positioned.fill(
              child: _ErrorView(
                message: state.failure!.message,
                onRetry: () => controller.retry(),
              ),
            ),
        ],
      ),
    );
  }
}

class _CenterProgress extends StatelessWidget {
  const _CenterProgress();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Bu bölgede henüz liman yok. Haritayı kaydırmayı deneyin.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _TruncatedHint extends StatelessWidget {
  const _TruncatedHint();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 24,
      right: 24,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Bu bölgede çok fazla liman var — daha fazlasını görmek için yakınlaştırın.',
            textAlign: TextAlign.center,
          ),
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
