import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';

/// Detay kapak görseli: fotoğrafı 16:9 gösterir. Dış lisanslı (CC/Commons)
/// görsellerde fotoğrafçı + lisans atfını görselin altına bindirir — CC şartı
/// gereği atıf HER ZAMAN görünür. Yükleme ve hata durumları zarifçe ele alınır.
class CoverPhoto extends StatelessWidget {
  const CoverPhoto({required this.cover, super.key});

  final CoverMedia cover;

  @override
  Widget build(BuildContext context) {
    final String? credit = cover.credit;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              cover.url,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? progress) {
                if (progress == null) return child;
                return const ColoredBox(
                  color: Color(0x11000000),
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object error, StackTrace? stack) {
                return ColoredBox(
                  color: const Color(0x11000000),
                  child: Center(
                    child: DocklyIcon(
                      DocklyIcons.imageOff,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
            if (credit != null && credit.isNotEmpty)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _CreditBar(credit: credit, license: cover.license),
              ),
          ],
        ),
      ),
    );
  }
}

/// Atıf şeridi: fotoğrafın altında okunur kalması için hafif koyu degrade üstünde
/// "fotoğrafçı · lisans" metni.
class _CreditBar extends StatelessWidget {
  const _CreditBar({required this.credit, required this.license});

  final String credit;
  final String? license;

  @override
  Widget build(BuildContext context) {
    final String text =
        (license == null || license!.isEmpty) ? credit : '$credit · $license';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[Color(0x99000000), Color(0x00000000)],
        ),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 11),
      ),
    );
  }
}
