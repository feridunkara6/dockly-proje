import 'package:dockly_api/dockly_api.dart' show Contact;
import 'package:dockly_mobile/features/reservation/domain/reservation_option.dart';
import 'package:flutter_test/flutter_test.dart';

Contact _c(String type, String value, {bool primary = false}) =>
    Contact(type: type, value: value, isPrimary: primary);

void main() {
  test('öncelik sırası: telefon > whatsapp > e-posta > web', () {
    final List<ReservationOption> opts = resolveReservationOptions(<Contact>[
      _c('website', 'marina.com'),
      _c('email', 'a@b.com'),
      _c('whatsapp', '+905551112233'),
      _c('phone', '+902521234567'),
    ]);
    expect(
      opts.map((ReservationOption o) => o.channel).toList(),
      <ReservationChannel>[
        ReservationChannel.phone,
        ReservationChannel.whatsapp,
        ReservationChannel.email,
        ReservationChannel.website,
      ],
    );
    expect(opts.first.uri.toString(), startsWith('tel:'));
  });

  test('WhatsApp uri hazır mesaj + tekne boyu içerir; 0 → 90 ile tamamlanır', () {
    final List<ReservationOption> opts =
        resolveReservationOptions(<Contact>[_c('whatsapp', '05551112233')], boatLengthM: 12);
    final ReservationOption wa =
        opts.firstWhere((ReservationOption o) => o.channel == ReservationChannel.whatsapp);
    expect(wa.uri.host, 'wa.me');
    expect(wa.uri.path, contains('90'));
    // Tek-çözme (decodeFull) — sorgu içindeki %20'ler boşluğa döner; ham Türkçe
    // metinde çift-çözmeye gerek yok.
    expect(Uri.decodeFull(wa.uri.query), contains('12 metre teknem'));
  });

  test('tekne yoksa mesaj "teknem için" der, "metre" içermez', () {
    final String msg = buildReservationMessage();
    expect(msg, contains('teknem için'));
    expect(msg.contains('metre'), isFalse);
  });

  test('e-posta uri mailto + body içerir', () {
    final List<ReservationOption> opts =
        resolveReservationOptions(<Contact>[_c('email', 'info@marina.com')], boatLengthM: 10);
    expect(opts.single.uri.scheme, 'mailto');
    expect(opts.single.uri.toString(), contains('body='));
  });

  test('rezervasyon-başlatmaya uygun iletişim yoksa boş liste (VHF/Instagram atlanır)', () {
    final List<ReservationOption> opts =
        resolveReservationOptions(<Contact>[_c('vhf', '73'), _c('instagram', 'marina')]);
    expect(opts, isEmpty);
  });

  test('birincil (isPrimary) telefon tercih edilir', () {
    final List<ReservationOption> opts = resolveReservationOptions(<Contact>[
      _c('phone', '111'),
      _c('phone', '+902520000000', primary: true),
    ]);
    expect(opts.first.uri.toString(), contains('902520000000'));
  });
}
