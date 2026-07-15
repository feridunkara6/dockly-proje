import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_locale.dart';

/// Arayüz metinleri — 4 dil (TR/EN/ES/RU). Alanlar derleyici-denetimlidir:
/// yeni bir metin eklenince 4 tabloda da doldurulmak ZORUNDADIR (eksik alan =
/// derleme hatası; çeviri asla sessizce unutulamaz).
///
/// TR değerleri uygulamadaki MEVCUT metinlerin birebir aynısıdır — testler ve
/// varsayılan görünüm değişmez. {0} yer tutucusu [fmt] ile doldurulur.
class L10n {
  const L10n({
    required this.navExplore,
    required this.navSearch,
    required this.navFavorites,
    required this.navRequests,
    required this.navProfile,
    required this.profileTitle,
    required this.emergencyTitle,
    required this.emergencySub,
    required this.sectionBoat,
    required this.boatEmptyBody,
    required this.boatDefineCta,
    required this.boatLengthFmt,
    required this.boatDraftFmt,
    required this.boatDraftUnknown,
    required this.editLabel,
    required this.removeLabel,
    required this.sectionAccount,
    required this.accTitle,
    required this.accBody,
    required this.accCta,
    required this.accOpen,
    required this.signOut,
    required this.sheetTitle,
    required this.sheetSub,
    required this.emailLabel,
    required this.passwordLabel,
    required this.signInBtn,
    required this.registerBtn,
    required this.orLabel,
    required this.googleBtn,
    required this.busyLabel,
    required this.valEmail,
    required this.valPassword,
    required this.languageLabel,
    required this.typeLabels,
    required this.amenityLabels,
    required this.fitChip,
    required this.freeChip,
    required this.sortRating,
    required this.sortNearby,
    required this.searchHint,
    required this.clearTooltip,
    required this.searchPrompt,
    required this.noResults,
    required this.retryLabel,
    required this.locateTooltip,
    required this.locDenied,
    required this.locLocated,
    required this.mapViewTooltip,
    required this.listViewTooltip,
    required this.offlineBanner,
    required this.emptyArea,
    required this.tooManyHint,
    required this.loadingHarbors,
    required this.nmUnit,
  });

  final String navExplore, navSearch, navFavorites, navRequests, navProfile;
  final String profileTitle, emergencyTitle, emergencySub;
  final String sectionBoat, boatEmptyBody, boatDefineCta;
  final String boatLengthFmt, boatDraftFmt, boatDraftUnknown, editLabel, removeLabel;
  final String sectionAccount, accTitle, accBody, accCta, accOpen, signOut;
  final String sheetTitle, sheetSub, emailLabel, passwordLabel, signInBtn,
      registerBtn, orLabel, googleBtn, busyLabel, valEmail, valPassword;
  final String languageLabel;

  /// Lokasyon tipi kodu → etiket (harita/arama çipleri; 9 kod).
  final Map<String, String> typeLabels;

  /// Olanak kodu → etiket (arama filtre çipleri; 14 kod).
  final Map<String, String> amenityLabels;

  final String fitChip, freeChip, sortRating, sortNearby;
  final String searchHint, clearTooltip, searchPrompt, noResults, retryLabel;
  final String locateTooltip, locDenied, locLocated;
  final String mapViewTooltip, listViewTooltip;
  final String offlineBanner, emptyArea, tooManyHint, loadingHarbors, nmUnit;

  String typeLabel(String code) => typeLabels[code] ?? typeLabels['mooring_point']!;
  String amenityLabel(String code) => amenityLabels[code] ?? code;

  /// '{0}' yer tutucusunu doldurur: fmt('Boy {0} m', '12') → 'Boy 12 m'.
  static String fmt(String template, String value) =>
      template.replaceFirst('{0}', value);
}

const L10n _tr = L10n(
  navExplore: 'Keşfet',
  navSearch: 'Arama',
  navFavorites: 'Favoriler',
  navRequests: 'Taleplerim',
  navProfile: 'Profil',
  profileTitle: 'Profil',
  emergencyTitle: 'Acil Durum',
  emergencySub: '158 · 112 · VHF 16 · MAYDAY şablonu · denizci alfabesi',
  sectionBoat: 'Teknem',
  boatEmptyBody:
      'Henüz tekne tanımlamadın. Tanımlarsan her limanda "teknen sığar mı?" '
      'işaretini görürsün. Bilgi cihazında kalır.',
  boatDefineCta: 'Tekneni tanımla',
  boatLengthFmt: 'Boy {0} m',
  boatDraftFmt: 'Su çekimi {0} m',
  boatDraftUnknown: 'Su çekimi belirtilmemiş',
  editLabel: 'Düzenle',
  removeLabel: 'Kaldır',
  sectionAccount: 'Hesap',
  accTitle: 'Hesabınla her cihazda',
  accBody: 'Giriş yaparsan favori limanların ve tekne bilgin hesabında saklanır; '
      'telefon değişse de kaybolmaz. Keşif için giriş gerekmez — misafir '
      'modda her şey açık.',
  accCta: 'Giriş yap veya kayıt ol',
  accOpen: 'Hesabın açık',
  signOut: 'Çıkış yap',
  sheetTitle: 'Hoş geldin, kaptan',
  sheetSub: 'Favorilerin ve teknen hesabında saklansın.',
  emailLabel: 'E-posta',
  passwordLabel: 'Şifre (en az 6 karakter)',
  signInBtn: 'Giriş yap',
  registerBtn: 'Kayıt ol',
  orLabel: 'veya',
  googleBtn: 'Google ile devam et',
  busyLabel: 'Bekleyin…',
  valEmail: 'Geçerli bir e-posta adresi yaz.',
  valPassword: 'Şifre en az 6 karakter olmalı.',
  languageLabel: 'Dil',
  typeLabels: <String, String>{
    'private_marina': 'Özel Marina',
    'municipal_marina': 'Belediye Marinası',
    'municipal_pier': 'Belediye İskelesi',
    'guest_mooring': 'Misafir Bağlama Noktası',
    'restaurant_pier': 'Restoran İskelesi',
    'fuel_pier': 'Yakıt İskelesi',
    'boat_club': 'Tekne Kulübü',
    'mooring_point': 'Bağlama Noktası',
    'buoy': 'Şamandıra',
  },
  amenityLabels: <String, String>{
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
  },
  fitChip: 'Teknem sığar',
  freeChip: 'Ücretsiz',
  sortRating: 'Puana göre',
  sortNearby: 'Yakınıma göre',
  searchHint: 'Liman, koy, şehir ara',
  clearTooltip: 'Temizle',
  searchPrompt: 'Aramak için en az 2 harf yaz\nya da üstten bir olanak seç (örn. Yakıt, Duş).',
  noResults: 'Sonuç bulunamadı.\nFarklı bir isim ya da filtre dene.',
  retryLabel: 'Tekrar dene',
  locateTooltip: 'Konumum',
  locDenied: 'Konum alınamadı. Tarayıcı/uygulama konum iznini kontrol et.',
  locLocated: 'Konumun alındı — mesafeler ve deniz yolu artık senden hesaplanıyor.',
  mapViewTooltip: 'Harita görünümü',
  listViewTooltip: 'Liste görünümü',
  offlineBanner: 'Çevrimdışı — son görülen limanlar',
  emptyArea: 'Bu bölgede henüz liman yok. Haritayı kaydırmayı deneyin.',
  tooManyHint: 'Bu bölgede çok fazla liman var — daha fazlasını görmek için yakınlaştırın.',
  loadingHarbors: 'Limanlar yükleniyor…\nİlk açılışta bu 1 dakikayı bulabilir.',
  nmUnit: 'dnz mili',
);

const L10n _en = L10n(
  navExplore: 'Explore',
  navSearch: 'Search',
  navFavorites: 'Favorites',
  navRequests: 'Requests',
  navProfile: 'Profile',
  profileTitle: 'Profile',
  emergencyTitle: 'Emergency',
  emergencySub: '158 · 112 · VHF 16 · MAYDAY template · phonetic alphabet',
  sectionBoat: 'My Boat',
  boatEmptyBody:
      'You haven\'t added your boat yet. Add it to see the "will my boat '
      'fit?" badge at every harbor. The info stays on your device.',
  boatDefineCta: 'Add your boat',
  boatLengthFmt: 'Length {0} m',
  boatDraftFmt: 'Draft {0} m',
  boatDraftUnknown: 'Draft not set',
  editLabel: 'Edit',
  removeLabel: 'Remove',
  sectionAccount: 'Account',
  accTitle: 'Your account, every device',
  accBody: 'Sign in and your favorite harbors and boat info are saved to your '
      'account — nothing is lost when you switch phones. No sign-in needed '
      'to explore: guest mode stays fully open.',
  accCta: 'Sign in or sign up',
  accOpen: 'Signed in',
  signOut: 'Sign out',
  sheetTitle: 'Welcome, captain',
  sheetSub: 'Keep your favorites and boat in your account.',
  emailLabel: 'Email',
  passwordLabel: 'Password (min 6 characters)',
  signInBtn: 'Sign in',
  registerBtn: 'Sign up',
  orLabel: 'or',
  googleBtn: 'Continue with Google',
  busyLabel: 'Please wait…',
  valEmail: 'Enter a valid email address.',
  valPassword: 'Password must be at least 6 characters.',
  languageLabel: 'Language',
  typeLabels: <String, String>{
    'private_marina': 'Private Marina',
    'municipal_marina': 'Municipal Marina',
    'municipal_pier': 'Municipal Pier',
    'guest_mooring': 'Guest Mooring',
    'restaurant_pier': 'Restaurant Pier',
    'fuel_pier': 'Fuel Pier',
    'boat_club': 'Boat Club',
    'mooring_point': 'Mooring Point',
    'buoy': 'Buoy',
  },
  amenityLabels: <String, String>{
    'fuel': 'Fuel',
    'water': 'Water',
    'electricity': 'Electricity',
    'shower': 'Shower',
    'restaurant': 'Restaurant',
    'market': 'Market',
    'wifi': 'Wi-Fi',
    'wc': 'WC',
    'laundry': 'Laundry',
    'security': 'Security',
    'pump_out': 'Pump-out',
    'crane': 'Crane',
    'travel_lift': 'Travel lift',
    'technical_service': 'Technical service',
  },
  fitChip: 'My boat fits',
  freeChip: 'Free',
  sortRating: 'By rating',
  sortNearby: 'Near me',
  searchHint: 'Search harbor, cove, city',
  clearTooltip: 'Clear',
  searchPrompt: 'Type at least 2 letters to search\nor pick an amenity above (e.g. Fuel, Shower).',
  noResults: 'No results.\nTry a different name or filter.',
  retryLabel: 'Try again',
  locateTooltip: 'My location',
  locDenied: 'Couldn\'t get your location. Check the location permission.',
  locLocated: 'Location acquired — distances and sea routes now start from you.',
  mapViewTooltip: 'Map view',
  listViewTooltip: 'List view',
  offlineBanner: 'Offline — last seen harbors',
  emptyArea: 'No harbors in this area yet. Try panning the map.',
  tooManyHint: 'Too many harbors here — zoom in to see more.',
  loadingHarbors: 'Loading harbors…\nFirst launch can take up to a minute.',
  nmUnit: 'nm',
);

const L10n _es = L10n(
  navExplore: 'Explorar',
  navSearch: 'Buscar',
  navFavorites: 'Favoritos',
  navRequests: 'Solicitudes',
  navProfile: 'Perfil',
  profileTitle: 'Perfil',
  emergencyTitle: 'Emergencia',
  emergencySub: '158 · 112 · VHF 16 · plantilla MAYDAY · alfabeto náutico',
  sectionBoat: 'Mi barco',
  boatEmptyBody:
      'Aún no has añadido tu barco. Añádelo para ver el aviso "¿cabe mi '
      'barco?" en cada puerto. La información se queda en tu dispositivo.',
  boatDefineCta: 'Añadir mi barco',
  boatLengthFmt: 'Eslora {0} m',
  boatDraftFmt: 'Calado {0} m',
  boatDraftUnknown: 'Calado no indicado',
  editLabel: 'Editar',
  removeLabel: 'Quitar',
  sectionAccount: 'Cuenta',
  accTitle: 'Tu cuenta, en todos tus dispositivos',
  accBody: 'Inicia sesión y tus puertos favoritos y tu barco se guardan en tu '
      'cuenta; no se pierden al cambiar de teléfono. Para explorar no hace '
      'falta cuenta: el modo invitado sigue abierto.',
  accCta: 'Inicia sesión o regístrate',
  accOpen: 'Sesión iniciada',
  signOut: 'Cerrar sesión',
  sheetTitle: 'Bienvenido, capitán',
  sheetSub: 'Guarda tus favoritos y tu barco en tu cuenta.',
  emailLabel: 'Correo electrónico',
  passwordLabel: 'Contraseña (mín. 6 caracteres)',
  signInBtn: 'Iniciar sesión',
  registerBtn: 'Registrarse',
  orLabel: 'o',
  googleBtn: 'Continuar con Google',
  busyLabel: 'Espera…',
  valEmail: 'Escribe un correo electrónico válido.',
  valPassword: 'La contraseña debe tener al menos 6 caracteres.',
  languageLabel: 'Idioma',
  typeLabels: <String, String>{
    'private_marina': 'Puerto deportivo privado',
    'municipal_marina': 'Puerto deportivo municipal',
    'municipal_pier': 'Muelle municipal',
    'guest_mooring': 'Amarre de visitantes',
    'restaurant_pier': 'Muelle de restaurante',
    'fuel_pier': 'Muelle de combustible',
    'boat_club': 'Club náutico',
    'mooring_point': 'Punto de fondeo',
    'buoy': 'Boya',
  },
  amenityLabels: <String, String>{
    'fuel': 'Combustible',
    'water': 'Agua',
    'electricity': 'Electricidad',
    'shower': 'Ducha',
    'restaurant': 'Restaurante',
    'market': 'Mercado',
    'wifi': 'Wi-Fi',
    'wc': 'WC',
    'laundry': 'Lavandería',
    'security': 'Seguridad',
    'pump_out': 'Bombeo de aguas',
    'crane': 'Grúa',
    'travel_lift': 'Travel lift',
    'technical_service': 'Servicio técnico',
  },
  fitChip: 'Mi barco cabe',
  freeChip: 'Gratis',
  sortRating: 'Por puntuación',
  sortNearby: 'Cerca de mí',
  searchHint: 'Busca puerto, cala, ciudad',
  clearTooltip: 'Borrar',
  searchPrompt: 'Escribe al menos 2 letras\no elige un servicio arriba (p. ej. Combustible, Ducha).',
  noResults: 'Sin resultados.\nPrueba otro nombre u otro filtro.',
  retryLabel: 'Reintentar',
  locateTooltip: 'Mi ubicación',
  locDenied: 'No se pudo obtener tu ubicación. Revisa el permiso de ubicación.',
  locLocated: 'Ubicación obtenida: las distancias y rutas parten ahora de ti.',
  mapViewTooltip: 'Vista de mapa',
  listViewTooltip: 'Vista de lista',
  offlineBanner: 'Sin conexión — últimos puertos vistos',
  emptyArea: 'Aún no hay puertos en esta zona. Mueve el mapa.',
  tooManyHint: 'Demasiados puertos aquí: acerca el mapa para ver más.',
  loadingHarbors: 'Cargando puertos…\nEl primer inicio puede tardar un minuto.',
  nmUnit: 'mn',
);

const L10n _ru = L10n(
  navExplore: 'Обзор',
  navSearch: 'Поиск',
  navFavorites: 'Избранное',
  navRequests: 'Запросы',
  navProfile: 'Профиль',
  profileTitle: 'Профиль',
  emergencyTitle: 'Экстренная помощь',
  emergencySub: '158 · 112 · УКВ 16 · шаблон MAYDAY · фонетический алфавит',
  sectionBoat: 'Моя лодка',
  boatEmptyBody:
      'Вы ещё не добавили свою лодку. Добавьте её, чтобы видеть отметку '
      '«поместится ли лодка» в каждой гавани. Данные остаются на устройстве.',
  boatDefineCta: 'Добавить лодку',
  boatLengthFmt: 'Длина {0} м',
  boatDraftFmt: 'Осадка {0} м',
  boatDraftUnknown: 'Осадка не указана',
  editLabel: 'Изменить',
  removeLabel: 'Удалить',
  sectionAccount: 'Аккаунт',
  accTitle: 'Ваш аккаунт — на всех устройствах',
  accBody: 'Войдите — и избранные гавани и данные лодки сохранятся в аккаунте; '
      'при смене телефона ничего не пропадёт. Для просмотра вход не нужен: '
      'гостевой режим полностью открыт.',
  accCta: 'Войти или зарегистрироваться',
  accOpen: 'Вы вошли',
  signOut: 'Выйти',
  sheetTitle: 'Добро пожаловать, капитан',
  sheetSub: 'Сохраняйте избранное и лодку в аккаунте.',
  emailLabel: 'Эл. почта',
  passwordLabel: 'Пароль (не менее 6 символов)',
  signInBtn: 'Войти',
  registerBtn: 'Регистрация',
  orLabel: 'или',
  googleBtn: 'Продолжить с Google',
  busyLabel: 'Подождите…',
  valEmail: 'Введите корректный адрес эл. почты.',
  valPassword: 'Пароль должен содержать не менее 6 символов.',
  languageLabel: 'Язык',
  typeLabels: <String, String>{
    'private_marina': 'Частная марина',
    'municipal_marina': 'Муниципальная марина',
    'municipal_pier': 'Муниципальный причал',
    'guest_mooring': 'Гостевая стоянка',
    'restaurant_pier': 'Причал ресторана',
    'fuel_pier': 'Топливный причал',
    'boat_club': 'Яхт-клуб',
    'mooring_point': 'Якорная стоянка',
    'buoy': 'Буй',
  },
  amenityLabels: <String, String>{
    'fuel': 'Топливо',
    'water': 'Вода',
    'electricity': 'Электричество',
    'shower': 'Душ',
    'restaurant': 'Ресторан',
    'market': 'Магазин',
    'wifi': 'Wi-Fi',
    'wc': 'Туалет',
    'laundry': 'Прачечная',
    'security': 'Охрана',
    'pump_out': 'Откачка',
    'crane': 'Кран',
    'travel_lift': 'Травел-лифт',
    'technical_service': 'Техсервис',
  },
  fitChip: 'Лодка поместится',
  freeChip: 'Бесплатно',
  sortRating: 'По рейтингу',
  sortNearby: 'Рядом со мной',
  searchHint: 'Порт, бухта, город',
  clearTooltip: 'Очистить',
  searchPrompt: 'Введите минимум 2 буквы\nили выберите удобство сверху (напр. Топливо, Душ).',
  noResults: 'Ничего не найдено.\nПопробуйте другое имя или фильтр.',
  retryLabel: 'Повторить',
  locateTooltip: 'Моё местоположение',
  locDenied: 'Не удалось определить местоположение. Проверьте разрешение.',
  locLocated: 'Местоположение получено — расстояния и маршруты теперь от вас.',
  mapViewTooltip: 'Карта',
  listViewTooltip: 'Список',
  offlineBanner: 'Офлайн — последние гавани',
  emptyArea: 'В этом районе пока нет гаваней. Подвиньте карту.',
  tooManyHint: 'Слишком много гаваней — приблизьте карту.',
  loadingHarbors: 'Загрузка гаваней…\nПервый запуск может занять до минуты.',
  nmUnit: 'мор. миль',
);

/// Saf eşleme — birim testli.
L10n l10nOf(AppLocale locale) {
  switch (locale) {
    case AppLocale.tr:
      return _tr;
    case AppLocale.en:
      return _en;
    case AppLocale.es:
      return _es;
    case AppLocale.ru:
      return _ru;
  }
}

/// Ekranların tükettiği sağlayıcı: dil değişince bağlı tüm ekranlar yeniden çizilir.
final Provider<L10n> l10nProvider =
    Provider<L10n>((ref) => l10nOf(ref.watch(appLocaleProvider)));
