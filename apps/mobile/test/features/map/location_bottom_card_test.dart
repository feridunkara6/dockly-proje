import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/map/presentation/location_bottom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/map_fakes.dart';

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
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(closed, isTrue);
  });
}
