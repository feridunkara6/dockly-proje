import 'package:dockly_api/dockly_api.dart' show GeoPoint;
import 'package:dockly_mobile/features/route/domain/sea_route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('haversineNm (kuşuçuşu deniz mili)', () {
    test('aynı nokta → 0', () {
      expect(
        haversineNm(const GeoPoint(lat: 36.75, lon: 28.93), const GeoPoint(lat: 36.75, lon: 28.93)),
        moreOrLessEquals(0, epsilon: 0.001),
      );
    });

    test('1° enlem ≈ 60 deniz mili', () {
      expect(
        haversineNm(const GeoPoint(lat: 0, lon: 0), const GeoPoint(lat: 1, lon: 0)),
        moreOrLessEquals(60.04, epsilon: 0.1),
      );
    });

    test('ekvatorda 1° boylam ≈ 60 deniz mili', () {
      expect(
        haversineNm(const GeoPoint(lat: 0, lon: 0), const GeoPoint(lat: 0, lon: 1)),
        moreOrLessEquals(60.04, epsilon: 0.1),
      );
    });

    test('Göcek → Fethiye ≈ 11.66 deniz mili', () {
      expect(
        haversineNm(const GeoPoint(lat: 36.75, lon: 28.93), const GeoPoint(lat: 36.62, lon: 29.11)),
        moreOrLessEquals(11.66, epsilon: 0.2),
      );
    });
  });

  group('initialBearingDeg (kerteriz 0..360)', () {
    test('kuzey → 0', () {
      expect(
        initialBearingDeg(const GeoPoint(lat: 0, lon: 0), const GeoPoint(lat: 1, lon: 0)),
        moreOrLessEquals(0, epsilon: 0.01),
      );
    });

    test('doğu → 90', () {
      expect(
        initialBearingDeg(const GeoPoint(lat: 0, lon: 0), const GeoPoint(lat: 0, lon: 1)),
        moreOrLessEquals(90, epsilon: 0.01),
      );
    });

    test('güney → 180', () {
      expect(
        initialBearingDeg(const GeoPoint(lat: 0, lon: 0), const GeoPoint(lat: -1, lon: 0)),
        moreOrLessEquals(180, epsilon: 0.01),
      );
    });

    test('batı → 270', () {
      expect(
        initialBearingDeg(const GeoPoint(lat: 0, lon: 0), const GeoPoint(lat: 0, lon: -1)),
        moreOrLessEquals(270, epsilon: 0.01),
      );
    });
  });

  group('compass16Tr (Türkçe pusula)', () {
    test('0 → Kuzey', () => expect(compass16Tr(0), 'Kuzey'));
    test('90 → Doğu', () => expect(compass16Tr(90), 'Doğu'));
    test('180 → Güney', () => expect(compass16Tr(180), 'Güney'));
    test('270 → Batı', () => expect(compass16Tr(270), 'Batı'));
    test('45 → Kuzeydoğu', () => expect(compass16Tr(45), 'Kuzeydoğu'));
    test('225 → Güneybatı', () => expect(compass16Tr(225), 'Güneybatı'));
    test('359 → Kuzey (sarma)', () => expect(compass16Tr(359), 'Kuzey'));
  });

  group('etaHours', () {
    test('60 NM @ 8 kn = 7.5 saat', () {
      expect(etaHours(60), moreOrLessEquals(7.5, epsilon: 0.001));
    });
    test('hız 0 → sonsuz', () {
      expect(etaHours(10, speedKn: 0), double.infinity);
    });
  });

  group('computeSeaRoute', () {
    test('Göcek → Fethiye: mesafe + kerteriz + pusula (GD)', () {
      final SeaRoutePreview p = computeSeaRoute(
        const GeoPoint(lat: 36.75, lon: 28.93),
        const GeoPoint(lat: 36.62, lon: 29.11),
      );
      expect(p.distanceNm, moreOrLessEquals(11.66, epsilon: 0.2));
      expect(p.bearingDeg, moreOrLessEquals(131.95, epsilon: 0.5));
      expect(p.compass, 'Güneydoğu');
      expect(p.etaHoursAtCruise, moreOrLessEquals(11.66 / 8, epsilon: 0.05));
    });
  });
}
