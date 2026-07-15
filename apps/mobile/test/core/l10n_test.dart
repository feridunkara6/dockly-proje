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

    test('tip ve olanak etiketleri 4 dilde eksiksiz', () {
      const List<String> types = <String>['private_marina','municipal_marina',
        'municipal_pier','guest_mooring','restaurant_pier','fuel_pier',
        'boat_club','mooring_point','buoy'];
      const List<String> amenities = <String>['fuel','water','electricity',
        'shower','restaurant','market','wifi','wc','laundry','security',
        'pump_out','crane','travel_lift','technical_service'];
      for (final AppLocale l in AppLocale.values) {
        final L10n t = l10nOf(l);
        for (final String c in types) {
          expect(t.typeLabels.containsKey(c), isTrue, reason: '$l $c');
        }
        for (final String c in amenities) {
          expect(t.amenityLabels.containsKey(c), isTrue, reason: '$l $c');
        }
      }
      expect(l10nOf(AppLocale.tr).typeLabel('private_marina'), 'Özel Marina');
      expect(l10nOf(AppLocale.en).typeLabel('private_marina'), 'Private Marina');
      expect(l10nOf(AppLocale.ru).amenityLabel('water'), 'Вода');
      expect(l10nOf(AppLocale.es).amenityLabel('fuel'), 'Combustible');
      // bilinmeyen kod güvenli düşer
      expect(l10nOf(AppLocale.en).typeLabel('yeni_tip'), 'Mooring Point');
      expect(l10nOf(AppLocale.en).amenityLabel('yeni_kod'), 'yeni_kod');
    });

    test('paket 3a alanları 4 dilde dolu ve ayrık', () {
      final Set<String> anchors = AppLocale.values.map((AppLocale l) => l10nOf(l).anchorTitle).toSet();
      expect(anchors.length, 4);
      for (final AppLocale l in AppLocale.values) {
        final L10n t = l10nOf(l);
        for (final String c in <String>['sand','mud','weed','rock','mixed']) {
          expect(t.holdingLabels.containsKey(c), isTrue, reason: '$l $c');
        }
        expect(t.anchorZeminFmt, contains('{0}'));
        expect(t.seaRouteLineFmt, contains('{1}'));
      }
      expect(l10nOf(AppLocale.es).anchorTitle, 'Notas de fondeo');
      expect(l10nOf(AppLocale.ru).gateTitle, 'Нужен аккаунт');
    });

    test('fmt yer tutucuyu doldurur', () {
      expect(L10n.fmt('Boy {0} m', '12'), 'Boy 12 m');
      expect(L10n.fmt('Длина {0} м', '9.5'), 'Длина 9.5 м');
    });
  });
}
