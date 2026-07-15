import 'package:dockly_mobile/core/l10n/app_locale.dart';
import 'package:dockly_mobile/core/l10n/l10n_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mapDeviceLocale (cihaz dili → uygulama dili)', () {
    test('desteklenen diller doğru eşlenir (bölge kodundan bağımsız)', () {
      expect(mapDeviceLocale('tr-TR'), AppLocale.tr);
      expect(mapDeviceLocale('tr'), AppLocale.tr);
      expect(mapDeviceLocale('en-US'), AppLocale.en);
      expect(mapDeviceLocale('en_GB'), AppLocale.en);
      expect(mapDeviceLocale('es-419'), AppLocale.es); // Latin Amerika İspanyolcası
      expect(mapDeviceLocale('es-ES'), AppLocale.es);
      expect(mapDeviceLocale('ru-RU'), AppLocale.ru);
      expect(mapDeviceLocale('RU'), AppLocale.ru); // büyük harf toleransı
    });

    test('desteklenmeyen diller İngilizce\'ye düşer', () {
      expect(mapDeviceLocale('fr-FR'), AppLocale.en);
      expect(mapDeviceLocale('de-DE'), AppLocale.en);
      expect(mapDeviceLocale('el-GR'), AppLocale.en);
      expect(mapDeviceLocale(''), AppLocale.en);
    });
  });

  group('l10n tabloları', () {
    test('her dil kendi adıyla listelenir (menü kuralı)', () {
      expect(AppLocale.tr.nativeName, 'Türkçe');
      expect(AppLocale.en.nativeName, 'English');
      expect(AppLocale.es.nativeName, 'Español');
      expect(AppLocale.ru.nativeName, 'Русский');
    });

    test('TR tablosu mevcut arayüz metinleriyle birebir aynı', () {
      final L10n t = l10nOf(AppLocale.tr);
      expect(t.navExplore, 'Keşfet');
      expect(t.navProfile, 'Profil');
      expect(t.sectionBoat, 'Teknem');
      expect(t.accCta, 'Giriş yap veya kayıt ol');
      expect(t.sheetTitle, 'Hoş geldin, kaptan');
    });

    test('dört tablo da dolu ve birbirinden farklı', () {
      final List<L10n> all = AppLocale.values.map(l10nOf).toList();
      final Set<String> explores = all.map((L10n t) => t.navExplore).toSet();
      expect(explores.length, 4); // Keşfet/Explore/Explorar/Обзор
      for (final L10n t in all) {
        expect(t.boatLengthFmt, contains('{0}')); // yer tutucu unutulmamış
        expect(t.boatDraftFmt, contains('{0}'));
      }
    });

    test('fmt yer tutucuyu doldurur', () {
      expect(L10n.fmt('Boy {0} m', '12'), 'Boy 12 m');
      expect(L10n.fmt('Длина {0} м', '9.5'), 'Длина 9.5 м');
    });
  });
}
