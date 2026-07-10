import 'package:dockly_api/dockly_api.dart' show Contact;
import 'package:dockly_mobile/features/reservation/presentation/reservation_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) =>
    ProviderScope(child: MaterialApp(home: Scaffold(body: child)));

Contact _c(String type, String value) =>
    Contact(type: type, value: value, isPrimary: false);

void main() {
  testWidgets('iletişim varsa öncelikli aksiyonlar görünür', (WidgetTester tester) async {
    await tester.pumpWidget(_host(ReservationSheetBody(
      locationName: 'D-Marin Göcek',
      contacts: <Contact>[_c('phone', '+902520000000'), _c('whatsapp', '05551112233')],
    )));
    await tester.pump();
    expect(find.text('D-Marin Göcek'), findsOneWidget);
    expect(find.text('Ara'), findsOneWidget);
    expect(find.text("WhatsApp'tan yaz"), findsOneWidget);
  });

  testWidgets('iletişim yoksa bilgilendirme gösterir, aksiyon yok', (WidgetTester tester) async {
    await tester.pumpWidget(_host(const ReservationSheetBody(
      locationName: 'İsimsiz Koy',
      contacts: <Contact>[],
    )));
    await tester.pump();
    expect(find.textContaining('iletişim bilgisi yok'), findsOneWidget);
    expect(find.text('Ara'), findsNothing);
  });
}
