import 'package:dockly_mobile/features/detail/domain/anchorage_notes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('splitAnchorageDescription (saf işlev)', () {
    test('üç sınıf cümle doğru kovalara ayrılır', () {
      final AnchorageDescriptionSplit s = splitAnchorageDescription(
        'Kekova\'nın en büyük koyu; her yönden korunaklı. '
        '7-8 m çamura demirlenir, tutuş iyidir. '
        'Dikkat: adacıkların batısında üzerinde 3,5 m su olan tekil kaya.',
      );
      expect(s.general, 'Kekova\'nın en büyük koyu; her yönden korunaklı.');
      expect(s.anchoring, <String>['7-8 m çamura demirlenir, tutuş iyidir.']);
      expect(s.warnings.single, contains('tekil kaya'));
    });

    test('BÜYÜK harfli DİKKAT (noktalı İ, U+0130) yakalanır', () {
      final AnchorageDescriptionSplit s = splitAnchorageDescription(
        'Güzel bir koy. DİKKAT: geçitte su seviyesinde kayalar var.',
      );
      expect(s.warnings.single, contains('kayalar'));
      expect(s.general, 'Güzel bir koy.');
    });

    test('kaçının / uzak durun gibi uyarı fiilleri de uyarı sayılır', () {
      final AnchorageDescriptionSplit s = splitAnchorageDescription(
        '5-7 m kuma demirlenir. Çayırlı bölgelerden kaçının. '
        'Feribot rıhtımının doğusu sığdır — uzak durun.',
      );
      expect(s.anchoring.single, contains('kuma demirlenir'));
      expect(s.warnings.length, 2);
      expect(s.general, isNull);
    });

    test('uyarı sınıfı zemin sınıfından ÖNCE gelir (çift işaretli cümle)', () {
      final AnchorageDescriptionSplit s = splitAnchorageDescription(
        'DİKKAT: çapa tutuşu ZAYIF — yalnız uygun havada.',
      );
      expect(s.warnings, hasLength(1));
      expect(s.anchoring, isEmpty);
    });

    test('"demirleme alanı" tanım cümlesi GENEL kalır (fiil değil)', () {
      final AnchorageDescriptionSplit s = splitAnchorageDescription(
        'Adacığın güneyindeki demirleme alanı berrak sularıyla bilinir.',
      );
      expect(s.general, contains('demirleme alanı'));
      expect(s.anchoring, isEmpty);
      expect(s.warnings, isEmpty);
    });

    test('null / boş açıklama → tümü boş', () {
      expect(splitAnchorageDescription(null).isEmpty, isTrue);
      expect(splitAnchorageDescription('   ').isEmpty, isTrue);
    });

    test('işaretsiz açıklama olduğu gibi genel metin olur', () {
      final AnchorageDescriptionSplit s =
          splitAnchorageDescription('Zeytinlikler arasında sessiz bir koy.');
      expect(s.general, 'Zeytinlikler arasında sessiz bir koy.');
      expect(s.anchoring, isEmpty);
      expect(s.warnings, isEmpty);
    });
  });
}
