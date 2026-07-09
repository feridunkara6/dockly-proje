import 'package:dockly_mobile/features/boat/domain/my_boat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('computeBoatFit (docs/01-prd §6.5 tekne uyumu)', () {
    test('tekne tanımsız → unknown', () {
      expect(
        computeBoatFit(boat: null, maxBoatLengthM: 40, maxDraftM: 5),
        BoatFit.unknown,
      );
    });

    test('lokasyon limiti bilinmiyor → unknown', () {
      expect(
        computeBoatFit(boat: const MyBoat(lengthM: 12), maxBoatLengthM: null, maxDraftM: null),
        BoatFit.unknown,
      );
    });

    test('boy limiti aşılıyor → tooBig', () {
      expect(
        computeBoatFit(boat: const MyBoat(lengthM: 50), maxBoatLengthM: 40, maxDraftM: null),
        BoatFit.tooBig,
      );
    });

    test('su çekimi limiti aşılıyor → tooBig', () {
      expect(
        computeBoatFit(
          boat: const MyBoat(lengthM: 10, draftM: 3),
          maxBoatLengthM: 40,
          maxDraftM: 2,
        ),
        BoatFit.tooBig,
      );
    });

    test('boy ve su çekimi sığıyor → fits', () {
      expect(
        computeBoatFit(
          boat: const MyBoat(lengthM: 12, draftM: 1.5),
          maxBoatLengthM: 40,
          maxDraftM: 5,
        ),
        BoatFit.fits,
      );
    });

    test('boy sığıyor, su çekimi bilinmiyor → fits (bilinen limit aşılmıyor)', () {
      expect(
        computeBoatFit(boat: const MyBoat(lengthM: 12), maxBoatLengthM: 40, maxDraftM: 5),
        BoatFit.fits,
      );
    });
  });
}
