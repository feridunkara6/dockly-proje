import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Bir Dockly ikonunu (tasarım sistemi çizgi ikon seti) temsil eder.
///
/// [_body] yalnızca SVG'nin iç öğelerini (path/line/circle/polygon) tutar; sarmalayıcı
/// `<svg>` çerçevesi (24×24 grid, 2px çizgi, yuvarlak uçlu — tasarım sistemi §ikon)
/// [DocklyIcon] tarafından eklenir. Böylece tüm ikonlar tek tip stille çizilir ve
/// ikon FONTUNA bağlı kalmaz — bu, web'de (özellikle mobil Safari) ikonların
/// gösterilmesini garanti eder (Material ikon fontu bazı web derlemelerinde yüklenmez).
@immutable
class DocklyIconData {
  const DocklyIconData(this._body);

  final String _body;

  String get _svg =>
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" '
      'fill="none" stroke="#000000" stroke-width="2" '
      'stroke-linecap="round" stroke-linejoin="round">$_body</svg>';

  @override
  bool operator ==(Object other) =>
      other is DocklyIconData && other._body == _body;

  @override
  int get hashCode => _body.hashCode;
}

/// Tasarım sistemi çizgi ikonunu SVG (path tabanlı) olarak çizer — ikon fontuna
/// bağlı DEĞİLDİR, bu yüzden web'de güvenilir görünür. Renk/boyut verilmezse
/// çevredeki [IconTheme]'den alınır (NavigationBar, IconButton, buton vb. böylece
/// ikonu doğru renklendirir).
class DocklyIcon extends StatelessWidget {
  const DocklyIcon(this.data, {this.size, this.color, super.key});

  final DocklyIconData? data;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final DocklyIconData? data = this.data;
    final IconThemeData iconTheme = IconTheme.of(context);
    final double resolvedSize = size ?? iconTheme.size ?? 24;
    if (data == null) {
      return SizedBox(width: resolvedSize, height: resolvedSize);
    }
    final Color resolvedColor = color ?? iconTheme.color ?? const Color(0xFF0F1728);
    return SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: SvgPicture.string(
        data._svg,
        width: resolvedSize,
        height: resolvedSize,
        colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
      ),
    );
  }
}

/// Dockly çizgi ikon kataloğu — tasarım sistemiyle aynı estetik (24×24, 2px çizgi,
/// yuvarlak uç/köşe; Feather/Lucide tarzı). Adlar Material karşılıklarına yakın
/// tutuldu (geçiş kolay olsun diye). Dolgulu varyantlar (yıldız, kalp, kişi, nokta)
/// `fill` + `stroke="none"` kullanır.
abstract final class DocklyIcons {
  // Konum / harita
  static const DocklyIconData place = DocklyIconData(
    '<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>'
    '<circle cx="12" cy="10" r="3"/>',
  );
  static const DocklyIconData mapOutlined = DocklyIconData(
    '<polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"/>'
    '<line x1="8" y1="2" x2="8" y2="18"/>'
    '<line x1="16" y1="6" x2="16" y2="22"/>',
  );
  static const DocklyIconData viewList = DocklyIconData(
    '<line x1="8" y1="6" x2="21" y2="6"/>'
    '<line x1="8" y1="12" x2="21" y2="12"/>'
    '<line x1="8" y1="18" x2="21" y2="18"/>'
    '<line x1="3" y1="6" x2="3.01" y2="6"/>'
    '<line x1="3" y1="12" x2="3.01" y2="12"/>'
    '<line x1="3" y1="18" x2="3.01" y2="18"/>',
  );
  static const DocklyIconData navigation = DocklyIconData(
    '<polygon points="3 11 22 2 13 21 11 13 3 11"/>',
  );

  // Genel eylemler
  static const DocklyIconData close = DocklyIconData(
    '<line x1="18" y1="6" x2="6" y2="18"/>'
    '<line x1="6" y1="6" x2="18" y2="18"/>',
  );
  static const DocklyIconData clear = close;
  static const DocklyIconData arrowForward = DocklyIconData(
    '<line x1="5" y1="12" x2="19" y2="12"/>'
    '<polyline points="12 5 19 12 12 19"/>',
  );
  static const DocklyIconData search = DocklyIconData(
    '<circle cx="11" cy="11" r="8"/>'
    '<line x1="21" y1="21" x2="16.65" y2="16.65"/>',
  );
  static const DocklyIconData edit = DocklyIconData(
    '<path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/>',
  );
  static const DocklyIconData deleteOutline = DocklyIconData(
    '<polyline points="3 6 5 6 21 6"/>'
    '<path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>'
    '<line x1="10" y1="11" x2="10" y2="17"/>'
    '<line x1="14" y1="11" x2="14" y2="17"/>',
  );
  static const DocklyIconData openInNew = DocklyIconData(
    '<path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>'
    '<polyline points="15 3 21 3 21 9"/>'
    '<line x1="10" y1="14" x2="21" y2="3"/>',
  );

  // Durum / bilgi
  static const DocklyIconData checkCircle = DocklyIconData(
    '<path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>'
    '<polyline points="22 4 12 14.01 9 11.01"/>',
  );
  static const DocklyIconData errorOutline = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<line x1="12" y1="8" x2="12" y2="12"/>'
    '<line x1="12" y1="16" x2="12.01" y2="16"/>',
  );
  static const DocklyIconData helpOutline = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/>'
    '<line x1="12" y1="17" x2="12.01" y2="17"/>',
  );
  static const DocklyIconData infoOutline = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<line x1="12" y1="16" x2="12" y2="12"/>'
    '<line x1="12" y1="8" x2="12.01" y2="8"/>',
  );
  static const DocklyIconData verified = DocklyIconData(
    '<path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 '
    '4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 '
    '4 4 0 0 1 0-6.76z"/>'
    '<polyline points="9 12 11 14 15 10"/>',
  );
  static const DocklyIconData lockOutline = DocklyIconData(
    '<rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>'
    '<path d="M7 11V7a5 5 0 0 1 10 0v4"/>',
  );
  static const DocklyIconData imageOff = DocklyIconData(
    '<line x1="2" y1="2" x2="22" y2="22"/>'
    '<path d="M10.41 10.41a2 2 0 1 1-2.83-2.83"/>'
    '<line x1="13.5" y1="13.5" x2="6" y2="21"/>'
    '<line x1="18" y1="12" x2="21" y2="15"/>'
    '<path d="M3.59 3.59A2 2 0 0 0 3 5v14a2 2 0 0 0 2 2h14c.55 0 1.05-.22 1.41-.59"/>'
    '<path d="M21 15V5a2 2 0 0 0-2-2H9"/>',
  );

  // İletişim
  static const DocklyIconData phone = DocklyIconData(
    '<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 '
    '19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 '
    '2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7 '
    'A2 2 0 0 1 22 16.92z"/>',
  );
  static const DocklyIconData phoneOutlined = phone;
  static const DocklyIconData chat = DocklyIconData(
    '<path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7 '
    'a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8z"/>',
  );
  static const DocklyIconData email = DocklyIconData(
    '<path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>'
    '<polyline points="22 6 12 13 2 6"/>',
  );
  static const DocklyIconData mailOutline = email;
  static const DocklyIconData language = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<line x1="2" y1="12" x2="22" y2="12"/>'
    '<path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/>',
  );
  static const DocklyIconData social = language;
  static const DocklyIconData radio = DocklyIconData(
    '<circle cx="12" cy="12" r="2"/>'
    '<path d="M4.93 19.07a10 10 0 0 1 0-14.14"/>'
    '<path d="M7.76 16.24a6 6 0 0 1 0-8.48"/>'
    '<path d="M16.24 7.76a6 6 0 0 1 0 8.48"/>'
    '<path d="M19.07 4.93a10 10 0 0 1 0 14.14"/>',
  );

  // Denizcilik / tekne
  static const DocklyIconData sailing = DocklyIconData(
    '<path d="M22 18H2a4 4 0 0 0 4 4h12a4 4 0 0 0 4-4z"/>'
    '<path d="M21 14 10 2 3 14h18z"/>'
    '<path d="M10 2v16"/>',
  );
  static const DocklyIconData sailingOutlined = sailing;
  static const DocklyIconData straighten = DocklyIconData(
    '<path d="M21.3 8.7 8.7 21.3a1 1 0 0 1-1.4 0l-4.6-4.6a1 1 0 0 1 0-1.4L15.3 2.7a1 1 0 0 1 1.4 0'
    'l4.6 4.6a1 1 0 0 1 0 1.4z"/>'
    '<path d="m7.5 10.5 2 2"/>'
    '<path d="m10.5 7.5 2 2"/>'
    '<path d="m13.5 4.5 2 2"/>'
    '<path d="m4.5 13.5 2 2"/>',
  );

  // Sekmeler
  static const DocklyIconData exploreOutlined = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"/>',
  );
  static const DocklyIconData explore = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" '
    'fill="#000000" stroke="none"/>',
  );
  static const DocklyIconData personOutline = DocklyIconData(
    '<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>'
    '<circle cx="12" cy="7" r="4"/>',
  );
  static const DocklyIconData person = DocklyIconData(
    '<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" fill="#000000" stroke="none"/>'
    '<circle cx="12" cy="7" r="4" fill="#000000" stroke="none"/>',
  );
  static const DocklyIconData favoriteBorder = DocklyIconData(
    '<path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78'
    'l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>',
  );
  static const DocklyIconData favorite = DocklyIconData(
    '<path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78'
    'l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" '
    'fill="#000000" stroke="none"/>',
  );
  static const DocklyIconData eventNoteOutlined = DocklyIconData(
    '<rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>'
    '<line x1="16" y1="2" x2="16" y2="6"/>'
    '<line x1="8" y1="2" x2="8" y2="6"/>'
    '<line x1="3" y1="10" x2="21" y2="10"/>',
  );
  static const DocklyIconData eventNote = eventNoteOutlined;

  // Yıldız / nokta
  static const DocklyIconData star = DocklyIconData(
    '<path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" '
    'fill="#000000" stroke="none"/>',
  );
  static const DocklyIconData starBorder = DocklyIconData(
    '<path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>',
  );
  static const DocklyIconData circle = DocklyIconData(
    '<circle cx="12" cy="12" r="9" fill="#000000" stroke="none"/>',
  );

  // Giriş sağlayıcıları
  static const DocklyIconData apple = DocklyIconData(
    '<path d="M12 20.94c1.5 0 2.75 1.06 4 1.06 3 0 6-8 6-12.22A4.91 4.91 0 0 0 17 5c-2.22 0-4 1.44-5 2'
    '-1-.56-2.78-2-5-2a4.9 4.9 0 0 0-5 4.78C2 14 5 22 8 22c1.25 0 2.5-1.06 4-1.06z"/>'
    '<path d="M10 2c1 .5 2 2 2 5"/>',
  );
  static const DocklyIconData google = DocklyIconData(
    '<circle cx="12" cy="12" r="10"/>'
    '<circle cx="12" cy="12" r="4"/>'
    '<line x1="21.17" y1="8" x2="12" y2="8"/>'
    '<line x1="3.95" y1="6.06" x2="8.54" y2="14"/>'
    '<line x1="10.88" y1="21.94" x2="15.46" y2="8"/>',
  );
}
