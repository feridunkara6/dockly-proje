import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

import '../../map/presentation/map_screen.dart';

/// Uygulama kabuğu — 5 sekmeli alt menü (docs/01-prd §6.13):
/// Keşfet (harita) · Arama · Favoriler · Taleplerim · Profil.
///
/// IndexedStack ile sekmeler arası geçişte durum korunur (harita konumu vb.).
/// Keşfet dışındaki 4 sekme şimdilik bilgilendirici yer tutucudur — ilgili
/// özellikler (arama, favoriler, talepler, profil) sonraki fazlarda bağlanacak.
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
          _PlaceholderTab(
            icon: Icons.search,
            title: 'Arama',
            message: 'Liman, koy, şehir ve ilçe araması yakında burada olacak.',
          ),
          _PlaceholderTab(
            icon: Icons.favorite_border,
            title: 'Favoriler',
            message: 'Beğendiğin limanları burada toplayacaksın. (Giriş gerektirir)',
          ),
          _PlaceholderTab(
            icon: Icons.event_note_outlined,
            title: 'Taleplerim',
            message: 'Bıraktığın rezervasyon talepleri burada görünecek. (Giriş gerektirir)',
          ),
          _PlaceholderTab(
            icon: Icons.person_outline,
            title: 'Profil',
            message: 'Profil, tekne bilgilerin ve ayarlar yakında burada olacak.',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) => setState(() => _index = i),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Keşfet',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Arama',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Taleplerim',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
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

  final IconData icon;
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
              Icon(icon, size: 56, color: DocklyColors.brandPrimary),
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
