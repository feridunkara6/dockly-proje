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
  });

  final String navExplore, navSearch, navFavorites, navRequests, navProfile;
  final String profileTitle, emergencyTitle, emergencySub;
  final String sectionBoat, boatEmptyBody, boatDefineCta;
  final String boatLengthFmt, boatDraftFmt, boatDraftUnknown, editLabel, removeLabel;
  final String sectionAccount, accTitle, accBody, accCta, accOpen, signOut;
  final String sheetTitle, sheetSub, emailLabel, passwordLabel, signInBtn,
      registerBtn, orLabel, googleBtn, busyLabel, valEmail, valPassword;
  final String languageLabel;

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
