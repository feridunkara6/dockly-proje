import 'dart:ui' as ui;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Uygulama dilleri (kullanıcı kararı 2026-07): Türkçe + İngilizce +
/// İspanyolca + Rusça. Cihaz dilinden OTOMATİK seçilir; kullanıcı Profil'deki
/// küçük açılır menüden elle değiştirebilir (seçim cihazda saklanır).
enum AppLocale { tr, en, es, ru }

extension AppLocaleX on AppLocale {
  /// Dil menüsünde her dil KENDİ adıyla yazılır (evrensel kural: kullanıcı
  /// yanlış dile düşmüşse bile kendi dilini tanıyabilsin).
  String get nativeName {
    switch (this) {
      case AppLocale.tr:
        return 'Türkçe';
      case AppLocale.en:
        return 'English';
      case AppLocale.es:
        return 'Español';
      case AppLocale.ru:
        return 'Русский';
    }
  }
}

/// Cihaz dili etiketi → desteklenen dil. Bilinmeyen diller İngilizce'ye düşer
/// (uluslararası varsayılan). Saf işlev — birim testli.
AppLocale mapDeviceLocale(String languageTag) {
  final String lang = languageTag.toLowerCase().split(RegExp('[-_]')).first;
  switch (lang) {
    case 'tr':
      return AppLocale.tr;
    case 'es':
      return AppLocale.es;
    case 'ru':
      return AppLocale.ru;
    default:
      return AppLocale.en;
  }
}

const String _prefsKey = 'moorira_locale';

/// Açılışta dil: 1) kullanıcının kayıtlı seçimi, 2) cihaz dili, 3) İngilizce.
/// Depo erişilemezse sessizce cihaz diline düşer (test VM'i, kısıtlı tarayıcı).
Future<AppLocale> readInitialLocale() async {
  try {
    final SharedPreferences p = await SharedPreferences.getInstance();
    final String? saved = p.getString(_prefsKey);
    if (saved != null) return AppLocale.values.byName(saved);
  } catch (_) {}
  try {
    return mapDeviceLocale(ui.PlatformDispatcher.instance.locale.toLanguageTag());
  } catch (_) {
    return AppLocale.en;
  }
}

/// Dil durumu. Varsayılan TÜRKÇE — testler ve bootstrap'sız ağaçlar marka
/// dilinde çalışır; gerçek algılama bootstrap'ta [readInitialLocale] ile
/// yapılıp override edilir.
class AppLocaleController extends Notifier<AppLocale> {
  AppLocaleController([this._initial = AppLocale.tr]);

  final AppLocale _initial;

  @override
  AppLocale build() => _initial;

  Future<void> set(AppLocale locale) async {
    state = locale;
    try {
      final SharedPreferences p = await SharedPreferences.getInstance();
      await p.setString(_prefsKey, locale.name);
    } catch (_) {
      // Depo yoksa seçim yalnız bu oturumda kalır — çökme yok.
    }
  }
}

final NotifierProvider<AppLocaleController, AppLocale> appLocaleProvider =
    NotifierProvider<AppLocaleController, AppLocale>(AppLocaleController.new);
