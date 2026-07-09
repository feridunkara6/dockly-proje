/// `location_type` kodu → Türkçe etiket (docs/09 §1.4, docs/01-prd §6.6).
/// i18n (TR+EN) gelene dek etiketlerin merkezî kaynağı burasıdır; birden çok
/// ekran (harita kartı, lokasyon detayı) buradan tüketir.
String locationTypeLabelTr(String type) {
  switch (type) {
    case 'private_marina':
      return 'Özel Marina';
    case 'municipal_marina':
      return 'Belediye Marinası';
    case 'municipal_pier':
      return 'Belediye İskelesi';
    case 'guest_mooring':
      return 'Misafir Bağlama Noktası';
    case 'restaurant_pier':
      return 'Restoran İskelesi';
    case 'fuel_pier':
      return 'Yakıt İskelesi';
    case 'boat_club':
      return 'Tekne Kulübü';
    case 'mooring_point':
      return 'Bağlama Noktası';
    case 'buoy':
      return 'Şamandıra';
    default:
      return 'Bağlama Noktası';
  }
}

/// `price_tier` kodu → Türkçe etiket. `unknown` → null (rozet gösterilmez).
String? priceTierLabelTr(String tier) {
  switch (tier) {
    case 'free':
      return 'Ücretsiz';
    case 'paid':
      return 'Ücretli';
    default:
      return null;
  }
}

/// Demirleme dip tutunma tipi kodu → Türkçe (docs/22 ck_anchorage_details_holding_type).
String holdingTypeLabelTr(String code) {
  switch (code) {
    case 'sand':
      return 'kum';
    case 'mud':
      return 'çamur';
    case 'weed':
      return 'yosun';
    case 'rock':
      return 'kaya';
    case 'mixed':
      return 'karışık (kum/çamur/yosun)';
    default:
      return code;
  }
}
