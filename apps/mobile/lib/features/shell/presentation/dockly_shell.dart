import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../favorites/presentation/favorites_screen.dart';
import '../../map/presentation/map_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../reservation/presentation/reservations_placeholder_screen.dart';
import '../../search/presentation/search_screen.dart';
import '../../splash/presentation/splash_screen.dart';
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

  /// PERF (tembel sekmeler): açılışta yalnız Keşfet kurulur; diğer sekmeler
  /// İLK ziyarette kurulur ve sonra durumunu korur (IndexedStack canlı tutar).
  /// Açılışta 5 ekran yerine 1 ekran kurmak ilk kareyi belirgin hızlandırır.
  final List<bool> _built = <bool>[true, false, false, false, false];

  ProviderSubscription<bool>? _splashSub;

  @override
  void initState() {
    super.initState();
    // İlk açılış karşılaması: "Teknenin markası/boyu?" (bir kez). Uygulama
    // artık açılış ekranının ARKASINDA kurulduğundan, soru açılış görseli
    // kaybolduktan SONRA sorulur (splashDoneProvider) — fotoğrafın üstüne
    // sayfa fırlamasın.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ref.read(splashDoneProvider)) {
        maybeShowWelcomePrompt(context, ref);
        return;
      }
      _splashSub = ref.listenManual<bool>(splashDoneProvider, (bool? prev, bool next) {
        if (!next) return;
        _splashSub?.close();
        _splashSub = null;
        if (mounted) maybeShowWelcomePrompt(context, ref);
      });
    });
  }

  @override
  void dispose() {
    _splashSub?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    // Tasarım sistemi §5 (glass tab bar) + mockup: açık cam zemin (0.72 beyaz),
    // ince üst çizgi, PILL GÖSTERGESİZ sekmeler — seçili sekme marka mavisi
    // ikon + etiket, seçili olmayanlar ikincil gri. Dark modda cam koyu yüzey.
    final Color selected =
        dark ? DocklyColors.brandPrimaryDark : DocklyColors.brandPrimary;
    final Color unselected = dark ? DocklyColors.text2Dark : DocklyColors.text2;
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          const MapScreen(), // her zaman canlı (harita durumu korunur)
          _built[1] ? const SearchScreen() : const SizedBox.shrink(),
          _built[2] ? const FavoritesScreen() : const SizedBox.shrink(),
          _built[3] ? const ReservationsPlaceholderScreen() : const SizedBox.shrink(),
          _built[4] ? const ProfileScreen() : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // bg.glass: light rgba(255,255,255,0.72) / dark rgba(20,28,43,0.72).
          color: dark ? const Color(0xB8141C2B) : const Color(0xB8FFFFFF),
          border: Border(
            top: BorderSide(
              color: dark ? DocklyColors.hairlineDark : DocklyColors.hairline,
            ),
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            height: 64,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            // Mockup'ta seçim pill'i YOK — renk değişimi yeterli.
            indicatorColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            iconTheme: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) => IconThemeData(
                size: 24,
                color: states.contains(WidgetState.selected) ? selected : unselected,
              ),
            ),
            labelTextStyle: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) => TextStyle(
                fontSize: 11,
                height: 1.2,
                fontWeight: states.contains(WidgetState.selected)
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: states.contains(WidgetState.selected) ? selected : unselected,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (int i) => setState(() {
              _built[i] = true; // ilk ziyarette kur, sonra canlı tut
              _index = i;
            }),
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
        ),
      ),
    );
  }
}
