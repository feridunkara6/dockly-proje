import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/core/l10n/app_locale.dart';
import 'package:dockly_mobile/core/l10n/l10n_strings.dart';
import 'package:dockly_mobile/core/origin_provider.dart';
import 'package:dockly_mobile/features/auth/presentation/account_gate.dart';
import 'package:dockly_mobile/features/occupancy/application/occupancy_controller.dart';
import 'package:dockly_mobile/features/occupancy/presentation/occupancy_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/auth_fakes.dart';

/// Sahte doluluk ağ geçidi — bildirilen düzey ve konumu kaydeder.
class FakeOccupancyGateway implements OccupancyGateway {
  final List<({String idOrSlug, String level, GeoPoint position})> calls =
      <({String idOrSlug, String level, GeoPoint position})>[];

  @override
  Future<OccupancySummary> report(
      String idOrSlug, String level, GeoPoint position) async {
    calls.add((idOrSlug: idOrSlug, level: level, position: position));
    return OccupancySummary(
      level: level,
      reportedAt: DateTime.utc(2026, 7, 15, 12),
      reportCount: 1,
    );
  }
}

/// Akvaryum Koyu (Adaboğazı) konumu — mesafe testlerinin sabit hedefi.
const GeoPoint akvaryum = GeoPoint(lat: 37.004972, lon: 27.385389);

/// ~1 NM uzaklıkta GPS (koy çevresi — bildirime İZİN verilir).
const GeoPoint gpsYakin = GeoPoint(lat: 37.02, lon: 27.39);

/// ~40 NM uzaklıkta GPS (başka bölge — bildirim REDDEDİLİR).
const GeoPoint gpsUzak = GeoPoint(lat: 36.55, lon: 28.05);

Widget _app(Widget child, {List<Override> overrides = const <Override>[]}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  test('occupancyAgo: az önce / dk / saat biçimleri', () {
    final L10n t = l10nOf(AppLocale.tr);
    final DateTime now = DateTime(2026, 7, 15, 12, 0);
    expect(occupancyAgo(t, DateTime(2026, 7, 15, 11, 59, 40), now), 'az önce');
    expect(occupancyAgo(t, DateTime(2026, 7, 15, 11, 15), now), '45 dk önce');
    expect(occupancyAgo(t, DateTime(2026, 7, 15, 9, 30), now), '2 sa önce');
  });

  test('l10n: doluluk alanları 4 dilde dolu ve ayrık', () {
    for (final AppLocale l in AppLocale.values) {
      final L10n t = l10nOf(l);
      expect(t.occChipFmt, contains('{0}'));
      expect(t.occChipFmt, contains('{1}'));
      expect(t.occupancyLabel('empty'), isNotEmpty);
      expect(t.occupancyLabel('moderate'), isNotEmpty);
      expect(t.occupancyLabel('full'), isNotEmpty);
      expect(t.occNeedLocation, isNotEmpty);
      expect(t.occTooFar, isNotEmpty);
    }
    expect(
      AppLocale.values.map((AppLocale l) => l10nOf(l).occReportCta).toSet().length,
      4,
    );
    expect(l10nOf(AppLocale.tr).occupancyLabel('full'), 'Dolu');
    expect(l10nOf(AppLocale.en).occupancyLabel('empty'), 'Quiet');
  });

  testWidgets('çip: özet varsa düzey + zaman + bildirim sayısı gösterir',
      (WidgetTester tester) async {
    final OccupancySummary summary = OccupancySummary(
      level: 'full',
      reportedAt: DateTime(2026, 7, 15, 10, 0),
      reportCount: 3,
    );
    await tester.pumpWidget(_app(OccupancyChip(
      idOrSlug: 'loc-1',
      initial: summary,
      now: () => DateTime(2026, 7, 15, 12, 0),
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('Doluluk: Dolu'), findsOneWidget);
    expect(find.textContaining('2 sa önce'), findsOneWidget);
    expect(find.textContaining('3 bildirim'), findsOneWidget);
  });

  testWidgets('çip: kompakt modda yalnız düzey; özet yoksa hiç çizilmez',
      (WidgetTester tester) async {
    final OccupancySummary summary = OccupancySummary(
      level: 'moderate',
      reportedAt: DateTime(2026, 7, 15, 10, 0),
      reportCount: 2,
    );
    await tester.pumpWidget(_app(Column(children: <Widget>[
      OccupancyChip(idOrSlug: 'loc-1', initial: summary, compact: true),
      const OccupancyChip(idOrSlug: 'loc-2', initial: null),
    ])));
    await tester.pumpAndSettle();

    expect(find.text('Orta'), findsOneWidget); // kompakt: yalnız etiket
    expect(find.textContaining('önce'), findsNothing); // zaman kompaktta yok
    expect(find.textContaining('Doluluk:'), findsNothing);
  });

  testWidgets('KONUM ŞARTI: konum paylaşılmadan bildirim akışı açılmaz',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(
      const OccupancyRow(idOrSlug: 'akvaryum', position: akvaryum),
      overrides: <Override>[signedInAuthOverride()],
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Doluluk bildir'));
    await tester.pumpAndSettle();

    expect(find.textContaining('konumunu paylaşmalısın'), findsOneWidget);
    expect(find.text('Koy şu an ne durumda?'), findsNothing);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets('YAKINLIK ŞARTI: uzak koy için bildirim reddedilir (5 NM kuralı)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(
      const OccupancyRow(idOrSlug: 'akvaryum', position: akvaryum),
      overrides: <Override>[
        signedInAuthOverride(),
        devicePositionProvider.overrideWith((ref) => gpsUzak),
      ],
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Doluluk bildir'));
    await tester.pumpAndSettle();

    expect(find.textContaining('yakınında olduğun koylar'), findsOneWidget);
    expect(find.text('Koy şu an ne durumda?'), findsNothing);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets('ÜYELİK KAPISI: konum uygun ama hesap yok → "Hesap gerekli"',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(
      const OccupancyRow(idOrSlug: 'akvaryum', position: akvaryum),
      overrides: <Override>[
        devicePositionProvider.overrideWith((ref) => gpsYakin),
      ],
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Doluluk bildir'));
    await tester.pumpAndSettle();

    expect(find.byType(AccountRequiredSheetBody), findsOneWidget);
    expect(find.text('Doluluk bildirmek için ücretsiz bir hesap gerekir.'),
        findsOneWidget);
  });

  testWidgets('tam akış: yakın konum + hesap → düzey seç → GPS ile bildirilir',
      (WidgetTester tester) async {
    final FakeOccupancyGateway gateway = FakeOccupancyGateway();
    await tester.pumpWidget(_app(
      Column(children: <Widget>[
        const OccupancyChip(idOrSlug: 'akvaryum-koyu', initial: null),
        const OccupancyRow(idOrSlug: 'akvaryum-koyu', position: akvaryum),
      ]),
      overrides: <Override>[
        signedInAuthOverride(),
        devicePositionProvider.overrideWith((ref) => gpsYakin),
        occupancyGatewayProvider.overrideWithValue(gateway),
      ],
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Doluluk bildir'));
    await tester.pumpAndSettle(); // alt sayfa

    expect(find.text('Koy şu an ne durumda?'), findsOneWidget);
    await tester.tap(find.text('Orta'));
    await tester.pumpAndSettle();

    expect(gateway.calls, hasLength(1));
    expect(gateway.calls.single.idOrSlug, 'akvaryum-koyu');
    expect(gateway.calls.single.level, 'moderate');
    expect(gateway.calls.single.position.lat, gpsYakin.lat); // GERÇEK GPS gitti
    expect(find.text('Bildirimin alındı — teşekkürler kaptan.'), findsOneWidget);
    // Yerel geçersiz kılma: çip HTTP önbelleğini beklemeden görünür.
    expect(find.textContaining('Doluluk: Orta'), findsOneWidget);

    // SnackBar zamanlayıcısını akıt (CI dersi: bekleyen Timer kalmasın).
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
