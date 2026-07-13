/// Olanak kodu → Türkçe etiket (arama filtre çipleri için yerel sözlük).
/// Detay sayfası etiketleri sunucudan i18n ile gelir; burada yalnız arama
/// çiplerinde gereken kısa adlar tutulur. Bilinmeyen kod → kodun kendisi.
const Map<String, String> _amenityLabelsTr = <String, String>{
  'fuel': 'Yakıt',
  'water': 'Su',
  'electricity': 'Elektrik',
  'shower': 'Duş',
  'restaurant': 'Restoran',
  'market': 'Market',
  'wifi': 'Wi-Fi',
  'wc': 'WC',
  'laundry': 'Çamaşırhane',
  'security': 'Güvenlik',
  'pump_out': 'Atık alımı',
  'crane': 'Vinç',
  'travel_lift': 'Travel lift',
  'technical_service': 'Teknik servis',
};

String amenityLabelTr(String code) => _amenityLabelsTr[code] ?? code;

/// Arama ekranında çip olarak sunulan olanaklar (denizcinin en sık aradıkları;
/// sunucu limiti 8 filtre — liste bilinçli 8 tutuldu).
const List<String> kSearchAmenities = <String>[
  'fuel',
  'water',
  'electricity',
  'shower',
  'restaurant',
  'market',
  'wifi',
  'wc',
];
