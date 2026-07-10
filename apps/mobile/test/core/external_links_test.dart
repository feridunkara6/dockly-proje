import 'package:dockly_mobile/core/external_links.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('contactUri (P0 — tıklanabilir iletişim)', () {
    test('telefon → tel: şeması, + korunur', () {
      expect(contactUri('phone', '+90 252 645 12 34').toString(), 'tel:+902526451234');
    });

    test('telefon → +\'sız yerel numara rakamlaşır', () {
      expect(contactUri('phone', '0252 645 12 34').toString(), 'tel:02526451234');
    });

    test('whatsapp → wa.me, yerel 0 ülke koduna çevrilir', () {
      expect(contactUri('whatsapp', '0532 111 22 33').toString(), 'https://wa.me/905321112233');
    });

    test('whatsapp → zaten ülke kodlu numara korunur', () {
      expect(contactUri('whatsapp', '+90 532 111 22 33').toString(), 'https://wa.me/905321112233');
    });

    test('website → şema yoksa https eklenir', () {
      expect(contactUri('website', 'dmarin.com').toString(), 'https://dmarin.com');
    });

    test('website → mevcut https korunur', () {
      expect(contactUri('website', 'https://dmarin.com/gocek').toString(), 'https://dmarin.com/gocek');
    });

    test('email → mailto: şeması', () {
      expect(contactUri('email', 'info@dmarin.com').toString(), 'mailto:info@dmarin.com');
    });

    test('vhf → açılamaz (null)', () {
      expect(contactUri('vhf', '73'), isNull);
    });

    test('reservation_link → web gibi açılır (https eklenir)', () {
      expect(contactUri('reservation_link', 'book.dmarin.com').toString(),
          'https://book.dmarin.com');
    });

    test('emergency → tel: şeması (telefon gibi)', () {
      expect(contactUri('emergency', '112').toString(), 'tel:112');
    });

    test('boş değer → null', () {
      expect(contactUri('phone', '   '), isNull);
    });
  });
}
