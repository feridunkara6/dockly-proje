import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:dockly_mobile/features/map/presentation/location_bottom_card.dart';
import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/map_fakes.dart';

/// İkonlar artık SVG tabanlı [DocklyIcon]; ikon verisiyle bulunur.
Finder _docklyIcon(DocklyIconData d) =>
    find.byWidgetPredicate((Widget w) => w is DocklyIcon && w.data == d);

void main() {
  testWidgets('kart: tip etiketi + ad + puan + fiyat rozeti gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: LocationBottomCard(pin: testPin, onClose: () {}))),
    );
    expect(find.byKey(LocationBottomCard.cardKey), findsOneWidget);
    expect(find.text('Özel Marina'), findsOneWidget); // private_marina etiketi
    expect(find.text('D-Marin Göcek'), findsOneWidget);
    expect(find.text('4.8'), findsOneWidget);
    expect(find.text('Ücretli'), findsOneWidget); // paid rozeti
  });

  testWidgets('puanı olmayan pin → "Puan yok"', (WidgetTester tester) async {
    const noRating = LocationPin(
      id: 'x',
      name: 'İsimsiz Koy',
      type: 'mooring_point',
      position: GeoPoint(lat: 36.0, lon: 28.0),
      ratingAvg: null,
      priceTier: 'unknown',
    );
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: LocationBottomCard(pin: noRating, onClose: () {}))),
    );
    expect(find.text('Puan yok'), findsOneWidget);
    expect(find.text('Bağlama Noktası'), findsOneWidget);
    // unknown fiyat → rozet gösterilmez
    expect(find.text('Ücretli'), findsNothing);
    expect(find.text('Ücretsiz'), findsNothing);
  });

  testWidgets('kapat düğmesi onClose çağırır', (WidgetTester tester) async {
    bool closed = false;
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: LocationBottomCard(pin: testPin, onClose: () => closed = true))),
    );
    await tester.tap(_docklyIcon(DocklyIcons.close));
    await tester.pump();
    expect(closed, isTrue);
  });

  testWidgets('onOpenDetail verilince "Detay" butonu görünür ve çağırır', (WidgetTester tester) async {
    bool opened = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LocationBottomCard(
            pin: testPin,
            onClose: () {},
            onOpenDetail: () => opened = true,
          ),
        ),
      ),
    );
    expect(find.text('Detay'), findsOneWidget);
    await tester.tap(find.text('Detay'));
    await tester.pump();
    expect(opened, isTrue);
  });

  testWidgets('onOpenDetail yoksa "Detay" butonu gösterilmez', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: LocationBottomCard(pin: testPin, onClose: () {}))),
    );
    expect(find.text('Detay'), findsNothing);
  });

  testWidgets('fit verilince uyum rozeti gösterilir; unknown/verilmezse gösterilmez',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LocationBottomCard(pin: testPin, onClose: () {}, fit: BoatFit.fits),
        ),
      ),
    );
    expect(find.text('Teknen sığar'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LocationBottomCard(pin: testPin, onClose: () {}, fit: BoatFit.unknown),
        ),
      ),
    );
    expect(find.text('Teknen sığar'), findsNothing);
    expect(find.text('Uygunluk bilinmiyor'), findsNothing);
  });
}
