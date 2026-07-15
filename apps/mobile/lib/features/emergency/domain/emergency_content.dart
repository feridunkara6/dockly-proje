/// Acil Durum sayfasının SABİT içeriği — tamamen çevrimdışı çalışır (denizde
/// bağlantı yokken de açılır). Saf veri + saf fonksiyonlar: test edilebilir.
///
/// KAYNAK GÜVENİLİRLİĞİ: buradaki numaralar uluslararası/ulusal SABİT acil
/// numaralardır (TR Sahil Güvenlik 158, AB ortak acil 112, Yunan Sahil
/// Güvenliği 108, VHF Kanal 16) — sık değişen ticari veri değildir.
library;

/// Tek bir acil çağrı numarası (ülke bölümlerinde listelenir).
class EmergencyNumber {
  const EmergencyNumber({
    required this.label,
    required this.number,
    required this.detail,
  });

  /// Kullanıcıya gösterilen ad (ör. "Sahil Güvenlik").
  final String label;

  /// Aranacak numara (kısa kod ya da tam numara).
  final String number;

  /// Ne zaman/nasıl kullanılacağına dair tek cümle.
  final String detail;
}

/// Türkiye acil numaraları.
const List<EmergencyNumber> trEmergencyNumbers = <EmergencyNumber>[
  EmergencyNumber(
    label: 'Sahil Güvenlik',
    number: '158',
    detail: 'Denizde her tür acil durum — Türkiye kıyılarında 7/24.',
  ),
  EmergencyNumber(
    label: 'Acil Çağrı Merkezi',
    number: '112',
    detail: 'Genel acil (ambulans/itfaiye/polis) — denizden de yönlendirir.',
  ),
];

/// Yunanistan acil numaraları.
const List<EmergencyNumber> grEmergencyNumbers = <EmergencyNumber>[
  EmergencyNumber(
    label: 'Acil Çağrı (AB ortak)',
    number: '112',
    detail: 'Tüm AB ülkelerinde geçerli tek acil numara — İngilizce yanıt verilir.',
  ),
  EmergencyNumber(
    label: 'Yunan Sahil Güvenliği',
    number: '108',
    detail: 'Hellenic Coast Guard deniz acil hattı — Yunan sularında.',
  ),
];

/// Fonetik (denizci) alfabesinde tek harf/rakam.
class PhoneticLetter {
  const PhoneticLetter(this.symbol, this.word, this.saying);

  /// Harf ya da rakam ("A", "7").
  final String symbol;

  /// Uluslararası kelime ("Alfa").
  final String word;

  /// Türkçe okunuşu ("AL-FA").
  final String saying;
}

/// NATO/ICAO fonetik alfabesi — telsizde harf kodlamanın evrensel standardı.
const List<PhoneticLetter> phoneticAlphabet = <PhoneticLetter>[
  PhoneticLetter('A', 'Alfa', 'AL-FA'),
  PhoneticLetter('B', 'Bravo', 'BRA-VO'),
  PhoneticLetter('C', 'Charlie', 'ÇAR-Lİ'),
  PhoneticLetter('D', 'Delta', 'DEL-TA'),
  PhoneticLetter('E', 'Echo', 'E-KO'),
  PhoneticLetter('F', 'Foxtrot', 'FOKS-TROT'),
  PhoneticLetter('G', 'Golf', 'GOLF'),
  PhoneticLetter('H', 'Hotel', 'HO-TEL'),
  PhoneticLetter('I', 'India', 'İN-Dİ-A'),
  PhoneticLetter('J', 'Juliett', 'CU-Lİ-ET'),
  PhoneticLetter('K', 'Kilo', 'Kİ-LO'),
  PhoneticLetter('L', 'Lima', 'Lİ-MA'),
  PhoneticLetter('M', 'Mike', 'MAYK'),
  PhoneticLetter('N', 'November', 'NO-VEM-BIR'),
  PhoneticLetter('O', 'Oscar', 'OS-KAR'),
  PhoneticLetter('P', 'Papa', 'PA-PA'),
  PhoneticLetter('Q', 'Quebec', 'KE-BEK'),
  PhoneticLetter('R', 'Romeo', 'RO-ME-O'),
  PhoneticLetter('S', 'Sierra', 'Sİ-E-RA'),
  PhoneticLetter('T', 'Tango', 'TAN-GO'),
  PhoneticLetter('U', 'Uniform', 'YU-Nİ-FORM'),
  PhoneticLetter('V', 'Victor', 'VİK-TIR'),
  PhoneticLetter('W', 'Whiskey', 'VİS-Kİ'),
  PhoneticLetter('X', 'X-ray', 'EKS-REY'),
  PhoneticLetter('Y', 'Yankee', 'YEN-Kİ'),
  PhoneticLetter('Z', 'Zulu', 'ZU-LU'),
];

/// Rakamların telsiz okunuşu (ICAO) — özellikle 9 ("niner") karışmasın diye.
const List<PhoneticLetter> phoneticNumbers = <PhoneticLetter>[
  PhoneticLetter('0', 'Zero', 'Zİ-RO'),
  PhoneticLetter('1', 'One', 'UAN'),
  PhoneticLetter('2', 'Two', 'TU'),
  PhoneticLetter('3', 'Three', 'TIRİ'),
  PhoneticLetter('4', 'Four', 'FO-IR'),
  PhoneticLetter('5', 'Five', 'FAYF'),
  PhoneticLetter('6', 'Six', 'SİKS'),
  PhoneticLetter('7', 'Seven', 'SE-VIN'),
  PhoneticLetter('8', 'Eight', 'EYT'),
  PhoneticLetter('9', 'Niner', 'NAY-NIR'),
];

/// Ondalık dereceyi denizci biçimine çevirir: 36°30'00.0"K 029°15'00.0"D.
/// Yarıküre Türkçe kısaltılır (K/G, D/B) — telsizde de böyle okunur.
String formatDms(double lat, double lon) {
  String part(double v, String pos, String neg, int degWidth) {
    final String h = v >= 0 ? pos : neg;
    final double a = v.abs();
    int deg = a.floor();
    final double minFull = (a - deg) * 60;
    int min = minFull.floor();
    double sec = (minFull - min) * 60;
    // Yuvarlama taşması (59.95" → 60.0") dakika/dereceye devredilir.
    if (double.parse(sec.toStringAsFixed(1)) >= 60.0) {
      sec = 0;
      min += 1;
      if (min == 60) {
        min = 0;
        deg += 1;
      }
    }
    final String d = deg.toString().padLeft(degWidth, '0');
    final String m = min.toString().padLeft(2, '0');
    final String s = sec.toStringAsFixed(1).padLeft(4, '0');
    return "$d°$m'$s\"$h";
  }

  return '${part(lat, 'K', 'G', 2)} ${part(lon, 'D', 'B', 3)}';
}

/// MAYDAY çağrı şablonu — tekne adı tanımlıysa kişiselleştirilir. BÜYÜK harf:
/// panik anında okunacak metin bağırarak okunur; alan adları parantezlidir.
String maydayTemplate({String? boatName, String? position}) {
  final String rawName = boatName?.trim() ?? '';
  final String name = rawName.isEmpty ? '(TEKNE ADI)' : rawName.toUpperCase();
  final String pos =
      position ?? '(KOORDİNAT ya da bilinen yere göre yön/mesafe)';
  return 'MAYDAY, MAYDAY, MAYDAY\n'
      'BURASI $name, $name, $name\n'
      'MAYDAY $name\n'
      'KONUMUM: $pos\n'
      'TEHLİKE: (su alıyoruz / yangın / karaya oturduk / sağlık)\n'
      'TEKNEDE (KİŞİ SAYISI) KİŞİ VAR\n'
      'YARDIM İSTİYORUM. TAMAM.';
}

/// Uluslararası (İngilizce) MAYDAY şablonu — telsizde uluslararası dil
/// İngilizce'dir; TR dışındaki uygulama dillerinde bu şablon gösterilir.
String maydayTemplateEn({String? boatName, String? position}) {
  final String name = (boatName == null || boatName.trim().isEmpty)
      ? '(BOAT NAME)'
      : boatName.trim().toUpperCase();
  final String pos = position ?? '(READ YOUR POSITION)';
  return 'MAYDAY, MAYDAY, MAYDAY\n'
      'THIS IS $name, $name, $name\n'
      'MAYDAY $name\n'
      'MY POSITION IS: $pos\n'
      'NATURE OF DISTRESS: (taking water / fire / medical ...)\n'
      'PERSONS ON BOARD: (number)\n'
      'I REQUIRE IMMEDIATE ASSISTANCE\n'
      'OVER';
}
