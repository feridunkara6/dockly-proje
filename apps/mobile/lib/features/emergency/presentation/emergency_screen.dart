import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/external_links.dart';
import '../../../core/l10n/app_locale.dart';
import '../../../core/l10n/l10n_strings.dart';
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
    final L10n t = ref.watch(l10nProvider);
    // Telsizde uluslararası dil İngilizce'dir: TR dışındaki dillerde MAYDAY
    // şablonu İngilizce gösterilir (doğru denizcilik pratiği).
    final bool trLocale = ref.watch(appLocaleProvider) == AppLocale.tr;
    // GPS konumu VARSA o kullanılır (kullanıcı isteği: paylaşılan konuma göre
    // tam koordinat); yoksa harita merkezi en iyi çabadır.
    final GeoPoint? device = ref.watch(devicePositionProvider);
    final GeoPoint? origin = device ?? ref.watch(originProvider);
    final bool isGps = device != null;
    final String? brand = ref.watch(myBoatProvider)?.brand;
    final String? posText =
        origin == null ? null : formatDms(origin.lat, origin.lon);
    return Scaffold(
      appBar: AppBar(title: Text(t.emergencyTitle)),
      // Geniş ekranda (web/tablet) içerik ortalanır ve okunur genişlikte kalır;
      // telefonda tam genişlik. Kart içi düzenler LayoutBuilder ile uyarlanır.
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: <Widget>[
              _DistressCard(theme: theme, t: t),
              const SizedBox(height: 12),
              _PositionCard(
                theme: theme,
                t: t,
                posText: posText,
                origin: origin,
                isGps: isGps,
              ),
              const SizedBox(height: 12),
              _MaydayCard(
                theme: theme,
                t: t,
                brand: brand,
                posText: posText,
                trLocale: trLocale,
              ),
              const SizedBox(height: 12),
              _RadioBasicsCard(theme: theme, t: t),
              const SizedBox(height: 12),
              _AlphabetCard(theme: theme, t: t),
            ],
          ),
        ),
      ),
    );
  }
}

/// Üst kırmızı bölüm: telsiz kanalı + tek dokunuşla arama düğmeleri.
class _DistressCard extends StatelessWidget {
  const _DistressCard({required this.theme, required this.t});

  final ThemeData theme;
  final L10n t;

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
                t.emgDistressTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            t.emgDistressBody,
            style: TextStyle(color: theme.colorScheme.onErrorContainer),
          ),
          const SizedBox(height: 12),
          // CİHAZA UYARLANIR ızgara: dar telefonda 2, geniş ekranda 4 sütun.
          // Uzun etiketler tek satırda kısaltılır — kart aşağı sarkmaz.
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c) {
              final int cols = c.maxWidth >= 480 ? 4 : 2;
              final double w = (c.maxWidth - (cols - 1) * 8) / cols;
              final List<(String, EmergencyNumber)> entries =
                  <(String, EmergencyNumber)>[
                for (final EmergencyNumber n in trEmergencyNumbers) ('TR', n),
                for (final EmergencyNumber n in grEmergencyNumbers) ('GR', n),
              ];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final (String country, EmergencyNumber n) in entries)
                    SizedBox(
                      width: w,
                      child: _CallTile(theme: theme, t: t, country: country, n: n),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            t.emg112Note,
            style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onErrorContainer.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }
}

/// Tek dokunuşla arayan kompakt numara kutusu: ülke — NUMARA — kurum adı.
class _CallTile extends StatelessWidget {
  const _CallTile({
    required this.theme,
    required this.t,
    required this.country,
    required this.n,
  });

  final ThemeData theme;
  final L10n t;
  final String country;
  final EmergencyNumber n;

  /// Kurum etiketi numaraya göre yerelleşir (158 → Sahil Güvenlik, 108 →
  /// Hellenic CG, 112 → acil çağrı) — içerik listesi TR kalır, görünüm çevrilir.
  String get _label => switch (n.number) {
        '158' => t.emgCoastGuard,
        '108' => t.emgHellenicCG,
        _ => t.emgCall,
      };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.colorScheme.error,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => launchContact(context, 'phone', n.number),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  DocklyIcon(DocklyIcons.phone,
                      size: 13, color: theme.colorScheme.onError),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      country == 'TR' ? t.emgCountryTr : t.emgCountryGr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: theme.colorScheme.onError.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                n.number,
                maxLines: 1,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onError,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10.5,
                  color: theme.colorScheme.onError.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Konum kartı: harita merkezinin koordinatı (DMS + ondalık) ve kopyalama.
class _PositionCard extends StatelessWidget {
  const _PositionCard({
    required this.theme,
    required this.t,
    required this.posText,
    required this.origin,
    required this.isGps,
  });

  final ThemeData theme;
  final L10n t;
  final String? posText;
  final GeoPoint? origin;

  /// true → koordinat cihazın GPS'inden; false → harita merkezinden.
  final bool isGps;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.place,
      title: t.emgPositionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (posText == null || origin == null)
            Text(t.emgNoPosition)
          else ...<Widget>[
            Text(posText!,
                style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800, fontFamily: 'monospace')),
            const SizedBox(height: 2),
            Text(
              L10n.fmt(t.emgDecimalFmt,
                  '${origin!.lat.toStringAsFixed(5)}, ${origin!.lon.toStringAsFixed(5)}'),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: () => _copy(context, t,
                    '$posText (${origin!.lat.toStringAsFixed(5)}, ${origin!.lon.toStringAsFixed(5)})'),
                icon: const DocklyIcon(DocklyIcons.navigation, size: 16),
                label: Text(t.emgCopyCoord),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            isGps ? t.emgGpsNote : t.emgMapCenterNote,
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
  const _MaydayCard({
    required this.theme,
    required this.t,
    required this.brand,
    required this.posText,
    required this.trLocale,
  });

  final ThemeData theme;
  final L10n t;
  final String? brand;
  final String? posText;
  final bool trLocale;

  @override
  Widget build(BuildContext context) {
    final String template = trLocale
        ? maydayTemplate(boatName: brand, position: posText)
        : maydayTemplateEn(boatName: brand, position: posText);
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.radio,
      title: t.emgMaydayTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(t.emgMaydaySteps),
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
              onPressed: () => _copy(context, t, template),
              icon: const DocklyIcon(DocklyIcons.radio, size: 16),
              label: Text(t.emgCopyTemplate),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t.emgPanPanNote,
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
  const _RadioBasicsCard({required this.theme, required this.t});

  final ThemeData theme;
  final L10n t;

  @override
  Widget build(BuildContext context) {
    final List<String> rules = t.radioRules;
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.infoOutline,
      title: t.emgRadioTitle,
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
  const _AlphabetCard({required this.theme, required this.t});

  final ThemeData theme;
  final L10n t;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      theme: theme,
      icon: DocklyIcons.chat,
      title: t.emgAlphabetTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(t.emgAlphabetBody),
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
          Text(t.emgNumbersTitle,
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
Future<void> _copy(BuildContext context, L10n t, String text) async {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  await Clipboard.setData(ClipboardData(text: text));
  messenger.showSnackBar(SnackBar(content: Text(t.copiedLabel)));
}
