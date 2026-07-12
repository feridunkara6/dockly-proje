import 'package:dockly_ui/dockly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocklyMapColors — kanonik harita renkleri (docs/09 §1.4)', () {
    test('9 location_type için kanonik ARGB değerleri', () {
      expect(DocklyMapColors.argbForType('private_marina'), 0xFF0C7BDC);
      expect(DocklyMapColors.argbForType('municipal_marina'), 0xFF3B82F6);
      expect(DocklyMapColors.argbForType('municipal_pier'), 0xFF6366F1);
      expect(DocklyMapColors.argbForType('guest_mooring'), 0xFF2EC4B6);
      expect(DocklyMapColors.argbForType('restaurant_pier'), 0xFFF97316);
      expect(DocklyMapColors.argbForType('fuel_pier'), 0xFFEAB308);
      expect(DocklyMapColors.argbForType('boat_club'), 0xFF8B5CF6);
      expect(DocklyMapColors.argbForType('mooring_point'), 0xFF64748B);
      expect(DocklyMapColors.argbForType('buoy'), 0xFFEF4444);
    });

    test('bilinmeyen/yeni tip → marka birincil fallback (çökme yok)', () {
      expect(DocklyMapColors.argbForType('uzay_limani'), 0xFF0C7BDC);
      expect(DocklyMapColors.argbForType(''), 0xFF0C7BDC);
    });

    test('forType Color döndürür ve argbForType ile tutarlı', () {
      expect(DocklyMapColors.forType('buoy'), const Color(0xFFEF4444));
    });

    test('9 kanonik tip tanımlı', () {
      expect(DocklyMapColors.knownTypes.length, 9);
    });

    test('küme ülke renkleri (pastel + vurgu): TR mavi, GR turkuaz; bilinmeyen → nötr/marka', () {
      // Vurgu (halka + sayı): canlı ton.
      expect(DocklyMapColors.clusterAccentArgbForCountry('TR'), 0xFF0C7BDC);
      expect(DocklyMapColors.clusterAccentArgbForCountry('GR'), 0xFF0E8577);
      expect(DocklyMapColors.clusterAccentArgbForCountry(''), DocklyMapColors.clusterArgb);
      expect(DocklyMapColors.clusterAccentArgbForCountry('XX'), DocklyMapColors.clusterArgb);
      // Dolgu: açık pastel — koyu değil (kibar baloncuk kararı).
      expect(DocklyMapColors.clusterFillColorForCountry('TR'), const Color(0xFFE3F2FF));
      expect(DocklyMapColors.clusterFillColorForCountry('GR'), const Color(0xFFDEF6F2));
      expect(DocklyMapColors.clusterFillColorForCountry('XX'), const Color(0xFFEDF2F8));
      expect(
        DocklyMapColors.clusterAccentColorForCountry('TR'),
        const Color(0xFF0C7BDC),
      );
    });
  });
}
