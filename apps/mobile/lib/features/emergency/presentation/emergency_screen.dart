import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/external_links.dart';
import '../../../core/origin_provider.dart';
import '../../boat/application/my_boat_controller.dart';
import '../domain/emergency_content.dart';

/// ACİL DURUM sayfası — amatör denizci için tek bakışta: kimi ararım (TR/GR),
/// neredeyim (kopyalanabilir koordinat), telsizde ne derim (MAYDAY şablonu +
/// temel kurallar) ve harfleri nasıl kodlarım (denizci alfabesi).
/// TAMAMEN ÇEVRİMDIŞI: tüm içerik sabittir, ağ gerektirmez.
class EmergencyScreen extends ConsumerWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final GeoPoint? origin = ref.watch(originProvider);
    final String? brand = ref.watch(myBoatProvider)?.brand;
    final String? posText =
        origin == null ? null : formatDms(origin.lat, origin.lon);
    return Scaffold(
      appBar: AppBar(title: const Text('Acil Durum')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: <Widget>[
          _DistressCard(theme: theme),
          const SizedBox(height: 12),
          _PositionCard(theme: theme, posText: posText, origin: origin),
          const SizedBox(height: 12),
          _MaydayCard(theme: theme, brand: brand, posText: posText),
          const SizedBox(height: 12),
          _RadioBasicsCard(theme: theme),
          const SizedBox(height: 12),
          _AlphabetCard(theme: theme),
        ],
      ),
    );
  }
}

/// Üst kırmızı bölüm: telsiz kanalı + tek dokunuşla arama düğmeleri.
class _DistressCard extends StatelessWidget {
  const _DistressCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              DocklyIcon(DocklyIcons.errorOutline,
                  color: theme.colorScheme.onErrorContainer),
              const SizedBox(width: 10),
              Text(
                'Tehlikede misin?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Önce telsiz: VHF Kanal 16 (156,8 MHz) — uluslararası tehlike ve '
            'çağrı kanalı. Telsiz yoksa telefonla ara:',
            style: TextStyle(color: theme.colorScheme.onErrorContainer),
          ),
          const SizedBox(height: 12),
          Text('TÜRKİYE',
              style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onErrorContainer)),
          const SizedBox(height: 6),
          for (final EmergencyNumber n in trEmergencyNumbers)
            _CallRow(theme: theme, n: n),
          const SizedBox(height: 10),
          Text('YUNANİSTAN',
              style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onErrorContainer)),
          const SizedBox(height: 6),
          for (final EmergencyNumber n in grEmergencyNumbers)
            _CallRow(theme: theme, n: n),
        ],
      ),
    );
  }
}

class _CallRow extends StatelessWidget {
  const _CallRow({required this.theme, required this.n});

  final ThemeData theme;
  final EmergencyNumber n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${n.label} · ${n.number}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onErrorContainer)),
                Text(n.detail,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onErrorContainer
                            .withValues(alpha: 0.8))),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
              visualDensity: VisualDensity.compact,
            ),
            onPressed: () => launchContact(context, 'phone', n.number),
            icon: const DocklyIcon(DocklyIcons.phone, size: 16),
            label: Text(n.number),
          ),
        ],
      ),
    );
  }
}

/// Konum kartı: harita merkezinin koordinatı (DMS + ondalık) ve kopyalama.
class _PositionCard extends StatelessWidget {
  const _PositionCard({required this.theme, required this.posText, required this.origin});

  final ThemeData theme;
  final String? posText;
  final GeoPoint? origin;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.place,
      title: 'Konumun',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (posText == null || origin == null)
            const Text(
              'Konum henüz alınamadı — haritayı açıp bulunduğun bölgeye '
              'geldiğinde burada koordinat görünür.',
            )
          else ...<Widget>[
            Text(posText!,
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800, fontFamily: 'monospace')),
            const SizedBox(height: 2),
            Text(
              'Ondalık: ${origin!.lat.toStringAsFixed(5)}, ${origin!.lon.toStringAsFixed(5)}',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: () => _copy(context,
                    '$posText (${origin!.lat.toStringAsFixed(5)}, ${origin!.lon.toStringAsFixed(5)})'),
                icon: const DocklyIcon(DocklyIcons.navigation, size: 16),
                label: const Text('Koordinatı kopyala'),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            'Not: Bu koordinat GPS değil, haritada baktığın alanın merkezidir. '
            'Acil bildirimde mümkünse teknenin GPS/plotter konumunu okuyun.',
            style: theme.textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

/// MAYDAY / PAN PAN / SECURITE kartı — kopyalanabilir şablonla.
class _MaydayCard extends StatelessWidget {
  const _MaydayCard({required this.theme, required this.brand, required this.posText});

  final ThemeData theme;
  final String? brand;
  final String? posText;

  @override
  Widget build(BuildContext context) {
    final String template = maydayTemplate(boatName: brand, position: posText);
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.radio,
      title: 'MAYDAY çağrısı (can tehlikesi)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '1) Telsizi VHF Kanal 16\'ya al.\n'
            '2) Mandala bas, yavaş ve net konuş.\n'
            '3) Aşağıdaki sırayla oku; yanıt gelmezse 1 dakika sonra tekrarla.',
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              template,
              style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace', fontWeight: FontWeight.w600, height: 1.5),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: () => _copy(context, template),
              icon: const DocklyIcon(DocklyIcons.radio, size: 16),
              label: const Text('Şablonu kopyala'),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'MAYDAY yalnız CAN TEHLİKESİNDE kullanılır. Acil ama can tehlikesi '
            'yoksa: "PAN PAN, PAN PAN, PAN PAN". Seyir güvenliği duyurusu için: '
            '"SECURITE, SECURITE, SECURITE" (sekürite okunur).',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

/// Temel telsiz kuralları — amatör denizciye beş madde.
class _RadioBasicsCard extends StatelessWidget {
  const _RadioBasicsCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    const List<String> rules = <String>[
      'Kanal 16 her zaman dinlemede kalsın; çağrıdan sonra çalışma kanalına geçilir.',
      'Konuşmadan önce kanalı DİNLE — başkasının acil çağrısını ezme.',
      'Söz bitince "TAMAM" (over) de; görüşme tamamen bitince "KAPATIYORUM" (out).',
      'DSC\'li telsizde kırmızı DISTRESS tuşu (Kanal 70) konum ve kimliğini otomatik yollar — kapağını kaldırıp 5 saniye basılı tut.',
      'Telsiz yoksa: yukarıdaki numaraları GSM ile ara; telefonda da aynı şablonu kullan.',
    ];
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.infoOutline,
      title: 'Temel telsiz kuralları',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final String r in rules)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('•  ', style: theme.textTheme.bodyMedium),
                  Expanded(child: Text(r)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Denizci (NATO fonetik) alfabesi — harfler + rakamlar.
class _AlphabetCard extends StatelessWidget {
  const _AlphabetCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.chat,
      title: 'Denizci Alfabesi',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Telsizde tekne adı ve çağrı işareti bu kelimelerle kodlanır — '
            '"POYRAZ" = Papa, Oscar, Yankee, Romeo, Alfa, Zulu.',
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final PhoneticLetter l in phoneticAlphabet)
                _LetterChip(theme: theme, l: l),
            ],
          ),
          const SizedBox(height: 12),
          Text('Rakamlar',
              style: theme.textTheme.labelMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final PhoneticLetter l in phoneticNumbers)
                _LetterChip(theme: theme, l: l),
            ],
          ),
        ],
      ),
    );
  }
}

class _LetterChip extends StatelessWidget {
  const _LetterChip({required this.theme, required this.l});

  final ThemeData theme;
  final PhoneticLetter l;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('${l.symbol} · ${l.word}',
              style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 11.5)),
          Text(l.saying,
              style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant, fontSize: 10)),
        ],
      ),
    );
  }
}

/// Ortak bölüm kartı iskeleti (rüzgâr kartıyla aynı görsel dil).
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.theme,
    required this.icon,
    required this.title,
    required this.child,
  });

  final ThemeData theme;
  final DocklyIconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
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
              DocklyIcon(icon, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

/// Metni panoya kopyalar ve kısa onay gösterir.
Future<void> _copy(BuildContext context, String text) async {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  await Clipboard.setData(ClipboardData(text: text));
  messenger.showSnackBar(const SnackBar(content: Text('Kopyalandı.')));
}
