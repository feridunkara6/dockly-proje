import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_mobile/core/l10n/app_locale.dart';
import 'package:dockly_mobile/core/l10n/l10n_strings.dart';
import 'package:dockly_mobile/features/auth/presentation/account_gate.dart';
import 'package:dockly_mobile/features/occupancy/application/occupancy_controller.dart';
import 'package:dockly_mobile/features/occupancy/presentation/occupancy_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/auth_fakes.dart';

/// Sahte doluluk ağ geçidi — bildirilen düzeyleri kaydeder, sabit özet döner.
class FakeOccupancyGateway implements OccupancyGateway {
  final List<({String idOrSlug, String level})> calls =
      <({String idOrSlug, String level})>[];

  @override
  Future<OccupancySummary> report(String idOrSlug, String level) async {
    calls.add((idOrSlug: idOrSlug, level: level));
    return OccupancySummary(
      level: level,
      reportedAt: DateTime.utc(2026, 7, 15, 12),
      reportCount: 1,
    );
  }
}

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
    }
    expect(
      AppLocale.values.map((AppLocale l) => l10nOf(l).occReportCta).toSet().length,
      4,
    );
    expect(l10nOf(AppLocale.tr).occupancyLabel('full'), 'Dolu');
    expect(l10nOf(AppLocale.en).occupancyLabel('empty'), 'Quiet');
  });

  testWidgets('özet varsa çip görünür: düzey + zaman + bildirim sayısı',
      (WidgetTester tester) async {
    final OccupancySummary summary = OccupancySummary(
      level: 'full',
      reportedAt: DateTime(2026, 7, 15, 10, 0),
      reportCount: 3,
    );
    await tester.pumpWidget(_app(OccupancyRow(
      idOrSlug: 'loc-1',
      initial: summary,
      now: () => DateTime(2026, 7, 15, 12, 0),
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('Doluluk: Dolu'), findsOneWidget);
    expect(find.textContaining('2 sa önce'), findsOneWidget);
    expect(find.textContaining('3 bildirim'), findsOneWidget);
    expect(find.text('Doluluk bildir'), findsOneWidget);
  });

  testWidgets('özet yoksa yalnız bildirme eylemi görünür (tahmin yok)',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(const OccupancyRow(idOrSlug: 'loc-1', initial: null)));
    await tester.pumpAndSettle();
    expect(find.text('Doluluk bildir'), findsOneWidget);
    expect(find.textContaining('Doluluk:'), findsNothing);
  });

  testWidgets('ÜYELİK KAPISI: hesapsız dokunuşta "Hesap gerekli" sayfası açılır',
      (WidgetTester tester) async {
    await tester.pumpWidget(_app(const OccupancyRow(idOrSlug: 'loc-1', initial: null)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Doluluk bildir'));
    await tester.pumpAndSettle();

    expect(find.byType(AccountRequiredSheetBody), findsOneWidget);
    expect(find.text('Doluluk bildirmek için ücretsiz bir hesap gerekir.'),
        findsOneWidget);
  });

  testWidgets('hesaplı akış: düzey seç → gateway çağrılır → onay + çip tazelenir',
      (WidgetTester tester) async {
    final FakeOccupancyGateway gateway = FakeOccupancyGateway();
    await tester.pumpWidget(_app(
      const OccupancyRow(idOrSlug: 'akvaryum-koyu', initial: null),
      overrides: <Override>[
        signedInAuthOverride(),
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
    expect(find.text('Bildirimin alındı — teşekkürler kaptan.'), findsOneWidget);
    // Yerel geçersiz kılma: çip HTTP önbelleğini beklemeden görünür.
    expect(find.textContaining('Doluluk: Orta'), findsOneWidget);

    // SnackBar zamanlayıcısını akıt (CI dersi: bekleyen Timer kalmasın).
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
