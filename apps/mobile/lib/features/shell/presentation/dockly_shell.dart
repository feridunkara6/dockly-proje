import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

import '../../map/presentation/map_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../search/presentation/search_screen.dart';

/// Uygulama kabuğu — 5 sekmeli alt menü (docs/01-prd §6.13):
/// Keşfet (harita) · Arama · Favoriler · Taleplerim · Profil.
///
/// IndexedStack ile sekmeler arası geçişte durum korunur (harita konumu vb.).
/// Keşfet, Arama ve Profil bağlı; Favoriler/Taleplerim şimdilik bilgilendirici
/// yer tutucudur (giriş/hesap sonraki fazda).
/// Not: giriş/sign-in Firebase (2.4c) ile geldiğinde hesap-gerektiren sekmeler
/// kayıt duvarına yönlendirecek; şimdilik misafir modda yer tutucu gösterilir.
class DocklyShell extends StatefulWidget {
  const DocklyShell({super.key});

  @override
  State<DocklyShell> createState() => _DocklyShellState();
}

class _DocklyShellState extends State<DocklyShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const <Widget>[
          MapScreen(),
          SearchScreen(),
          _PlaceholderTab(
            icon: DocklyIcons.favoriteBorder,
            title: 'Favoriler',
            message: 'Beğendiğin limanları burada toplayacaksın. (Giriş gerektirir)',
          ),
          _PlaceholderTab(
            icon: DocklyIcons.eventNoteOutlined,
            title: 'Taleplerim',
            message: 'Bıraktığın rezervasyon talepleri burada görünecek. (Giriş gerektirir)',
          ),
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

/// Henüz yapılmamış sekmeler için bilgilendirici yer tutucu ekran.
class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.icon, required this.title, required this.message});

  final DocklyIconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DocklyIcon(icon, size: 56, color: DocklyColors.brandPrimary),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
