import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../favorites/presentation/favorites_screen.dart';
import '../../map/presentation/map_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../reservation/presentation/reservations_placeholder_screen.dart';
import '../../search/presentation/search_screen.dart';
import '../../welcome/presentation/welcome_prompt.dart';

/// Uygulama kabuğu — 5 sekmeli alt menü (docs/01-prd §6.13):
/// Keşfet (harita) · Arama · Favoriler · Taleplerim · Profil.
///
/// IndexedStack ile sekmeler arası geçişte durum korunur (harita konumu vb.).
/// Tüm sekmeler misafir modda çalışır (favoriler/talepler cihazda saklanır);
/// hesap/giriş geldiğinde bunlar buluta senkronlanacak.
class DocklyShell extends ConsumerStatefulWidget {
  const DocklyShell({super.key});

  @override
  ConsumerState<DocklyShell> createState() => _DocklyShellState();
}

class _DocklyShellState extends ConsumerState<DocklyShell> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    // İlk açılış karşılaması: "Teknen kaç metre?" (bir kez; wow kişiselleştirme).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) maybeShowWelcomePrompt(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const <Widget>[
          MapScreen(),
          SearchScreen(),
          FavoritesScreen(),
          ReservationsPlaceholderScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) => setState(() => _index = i),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: DocklyIcon(DocklyIcons.exploreOutlined),
            selectedIcon: DocklyIcon(DocklyIcons.explore),
            label: 'Keşfet',
          ),
          NavigationDestination(
            icon: DocklyIcon(DocklyIcons.search),
            selectedIcon: DocklyIcon(DocklyIcons.search),
            label: 'Arama',
          ),
          NavigationDestination(
            icon: DocklyIcon(DocklyIcons.favoriteBorder),
            selectedIcon: DocklyIcon(DocklyIcons.favorite),
            label: 'Favoriler',
          ),
          NavigationDestination(
            icon: DocklyIcon(DocklyIcons.eventNoteOutlined),
            selectedIcon: DocklyIcon(DocklyIcons.eventNote),
            label: 'Taleplerim',
          ),
          NavigationDestination(
            icon: DocklyIcon(DocklyIcons.personOutline),
            selectedIcon: DocklyIcon(DocklyIcons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
