import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/features/detail/presentation/cover_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CC atıflı kapak: fotoğrafçı + lisans görselin üstünde görünür',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CoverPhoto(
            cover: CoverMedia(
              url: 'https://upload.wikimedia.org/wikipedia/commons/x.jpg',
              blurhash: null,
              credit: 'Foto: Jane Doe',
              license: 'CC BY-SA 4.0',
            ),
          ),
        ),
      ),
    );

    // Atıf (fotoğrafçı + lisans) tek satırda görünür — CC zorunluluğu.
    expect(find.textContaining('Jane Doe'), findsOneWidget);
    expect(find.textContaining('CC BY-SA 4.0'), findsOneWidget);
  });

  testWidgets('atıf yoksa kredi şeridi hiç çıkmaz', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CoverPhoto(
            cover: CoverMedia(url: 'https://example.com/y.jpg', blurhash: null),
          ),
        ),
      ),
    );

    expect(find.byType(CoverPhoto), findsOneWidget);
    expect(find.textContaining('·'), findsNothing);
  });
}
