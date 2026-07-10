import 'package:dockly_api/dockly_api.dart' show Contact;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'reservation_option.dart';

/// "Rezervasyon Talebi" butonunun arkasındaki soyut strateji.
///
/// v1.0: [ContactLaunchStrategy] — rezervasyonu BAŞLATIR (mevcut iletişim
/// yöntemlerini açar). v2.0: aynı arayüz online-rezervasyon stratejisiyle
/// override edilecek; buton ve kullanıcı deneyimi DEĞİŞMEYECEK, yalnızca
/// arkadaki iş akışı otomatikleşecek (docs — v1.0 rezervasyon modeli).
abstract interface class ReservationStrategy {
  List<ReservationOption> options(List<Contact> contacts, {double? boatLengthM});
}

/// v1.0 stratejisi: iletişim yöntemlerini öncelik sırasıyla açılabilir hale getirir.
class ContactLaunchStrategy implements ReservationStrategy {
  const ContactLaunchStrategy();

  @override
  List<ReservationOption> options(List<Contact> contacts, {double? boatLengthM}) =>
      resolveReservationOptions(contacts, boatLengthM: boatLengthM);
}

/// Aktif rezervasyon stratejisi — testte/ileride override edilebilir. v2'de
/// online-rezervasyon stratejisiyle değiştirilecek (UX aynı kalır).
final Provider<ReservationStrategy> reservationStrategyProvider =
    Provider<ReservationStrategy>((ref) => const ContactLaunchStrategy());
