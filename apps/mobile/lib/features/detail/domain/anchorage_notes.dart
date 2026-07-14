/// Demirleme koyu açıklamasını cümle cümle üç kovaya ayıran SAF işlev
/// (widget'tan bağımsız — birim testli):
///
/// 1. `warnings`  — DİKKAT/UYARI cümleleri (kayalık, sığlık, zayıf tutuş…)
/// 2. `anchoring` — zemin/demirleme tekniği cümleleri ("7-8 m çamura demirlenir")
/// 3. `general`   — koyu anlatan geri kalan metin (detay sayfasında altta kalır)
///
/// ÜRÜN KARARI (2026-07): "Demirleme Notları" kartı sabit genel öneri yerine
/// KOYA ÖZEL zemin + dikkat bilgisi gösterir; koyu anlatan yazı açıklama olarak
/// altta kalır. 0-uydurma ilkesi: yalnız açıklamada ZATEN VAR OLAN cümleler
/// taşınır, yeni içerik üretilmez.
library;

class AnchorageDescriptionSplit {
  const AnchorageDescriptionSplit({
    required this.general,
    required this.anchoring,
    required this.warnings,
  });

  /// Koyu anlatan metin (boşsa null — açıklama bloğu gizlenir).
  final String? general;

  /// Zemin/demirleme cümleleri ("… çamura demirlenir, tutuş iyidir").
  final List<String> anchoring;

  /// Dikkat/uyarı cümleleri ("DİKKAT: … tekil kaya").
  final List<String> warnings;

  bool get isEmpty => general == null && anchoring.isEmpty && warnings.isEmpty;
}

/// Türkçe güvenli küçük harfe çevirme: Dart `toLowerCase` 'İ' (U+0130) harfini
/// "i + birleşen nokta"ya çevirir ve `contains('dikkat')` kaçar; önce İ→i,
/// I→ı eşleyerek bunu önleriz.
String _trLower(String s) =>
    s.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();

/// Cümle sonu: nokta/ünlem/soru + boşluk. Ondalıklar Türkçe virgülle ("3,5 m")
/// yazıldığından nokta çakışması yok; veri setinde "St." benzeri kısaltma da
/// bulunmuyor (üretici doğrulaması).
final RegExp _sentenceEnd = RegExp(r'(?<=[.!?])\s+');

/// Uyarı işaretleri — veri setindeki gerçek kullanım tarandı (153 koy):
/// hepsi gerçek tehlike uyarısı, "dikkat çekici" gibi olumlu kullanım yok.
const List<String> _warningMarkers = <String>[
  'dikkat',
  'uyarı',
  'önemli',
  'kaçının',
  'uzak durun',
  'sakının',
  'tehlike',
];

/// Zemin/demirleme tekniği işaretleri. 'demirlen' bilinçli: "demirlenir /
/// demirlenin" fiillerini yakalar ama "demirleme alanı" gibi tanım cümlelerini
/// (koyu anlatan metin) genel kısımda bırakır.
const List<String> _anchoringMarkers = <String>[
  'demirlen',
  'tutuş',
  'çapa',
  'kaloma',
];

AnchorageDescriptionSplit splitAnchorageDescription(String? description) {
  final String text = (description ?? '').trim();
  if (text.isEmpty) {
    return const AnchorageDescriptionSplit(
      general: null,
      anchoring: <String>[],
      warnings: <String>[],
    );
  }

  final List<String> general = <String>[];
  final List<String> anchoring = <String>[];
  final List<String> warnings = <String>[];

  for (final String raw in text.split(_sentenceEnd)) {
    final String sentence = raw.trim();
    if (sentence.isEmpty) continue;
    final String low = _trLower(sentence);
    // Uyarı sınıfı ÖNCE bakılır: "DİKKAT: çapa tutuşu zayıf" hem uyarı hem
    // zemin işareti taşır — kullanıcı için önemli olan uyarı vurgusudur.
    if (_warningMarkers.any(low.contains)) {
      warnings.add(sentence);
    } else if (_anchoringMarkers.any(low.contains)) {
      anchoring.add(sentence);
    } else {
      general.add(sentence);
    }
  }

  return AnchorageDescriptionSplit(
    general: general.isEmpty ? null : general.join(' '),
    anchoring: anchoring,
    warnings: warnings,
  );
}
