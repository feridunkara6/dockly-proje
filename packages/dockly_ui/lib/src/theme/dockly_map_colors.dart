import 'package:flutter/material.dart';

/// Harita `location_type` başına kanonik pin renkleri (docs/09 §1.4, foundation §7).
///
/// KURAL: Bu renkler yalnız harita semantiğine rezervedir; amenity/rozet vb. başka
/// hiçbir yerde yeniden kullanılamaz (docs/09 §1.4). Uygulama kodunda ham hex yasak
/// olduğundan (docs/09 §0) pin renkleri buradan tüketilir.
///
/// Mapbox annotation API'si renk olarak ARGB `int` beklediğinden değerler int olarak
/// tutulur; `forType` ayrıca Flutter `Color` döndürür (lejant/rozet kullanımı için).
abstract final class DocklyMapColors {
  /// Bilinmeyen/yeni tip için güvenli varsayılan (marka birincil).
  static const int _fallbackArgb = 0xFF0C7BDC;

  static const Map<String, int> _argbByType = <String, int>{
    'private_marina': 0xFF0C7BDC, // Özel Marina
    'municipal_marina': 0xFF3B82F6, // Belediye Marinası
    'municipal_pier': 0xFF6366F1, // Belediye İskelesi
    'guest_mooring': 0xFF2EC4B6, // Misafir Bağlama Noktası
    'restaurant_pier': 0xFFF97316, // Restoran İskelesi
    'fuel_pier': 0xFFEAB308, // Yakıt İskelesi
    'boat_club': 0xFF8B5CF6, // Tekne Kulübü
    'mooring_point': 0xFF64748B, // Bağlama Noktası
    'buoy': 0xFFEF4444, // Şamandıra
  };

  /// Küme (cluster) rozeti rengi (docs/09 §1.4: baskın tip; v1'de marka birincil).
  static const int clusterArgb = 0xFF0C7BDC;

  /// Küme baloncuğu ÜLKE renkleri — balonlar ülkeye göre ayrılır ve renklenir:
  /// Türkiye marka mavisi, Yunanistan Ege turkuazı. Bilinmeyen/eski veri →
  /// marka birincil (geriye uyumlu). Yeni ülke eklenince buraya satır eklenir.
  static const Map<String, int> _clusterArgbByCountry = <String, int>{
    'TR': 0xFF0C7BDC, // marka birincil
    'GR': 0xFF2EC4B6, // Ege turkuazı (accent)
  };

  /// Baloncuk degradesinin koyu ucu (ülke başına).
  static const Map<String, int> _clusterDeepArgbByCountry = <String, int>{
    'TR': 0xFF0A2540, // marka derin lacivert
    'GR': 0xFF0B5D54, // derin turkuaz
  };

  /// Mapbox (native) küme rengi — annotation API tek renk ister (ARGB int).
  static int clusterArgbForCountry(String countryCode) =>
      _clusterArgbByCountry[countryCode] ?? clusterArgb;

  /// Küme degradesi açık ucu (web baloncukları).
  static Color clusterColorForCountry(String countryCode) =>
      Color(_clusterArgbByCountry[countryCode] ?? clusterArgb);

  /// Küme degradesi koyu ucu (web baloncukları).
  static Color clusterDeepColorForCountry(String countryCode) =>
      Color(_clusterDeepArgbByCountry[countryCode] ?? 0xFF0A2540);

  /// Pin dolgu ikonu ve halkası (docs/09 §1.4: ikon/halka #FFFFFF).
  static const int strokeArgb = 0xFFFFFFFF;

  /// Mapbox annotation için ARGB int. Bilinmeyen tip → marka birincil (fallback).
  static int argbForType(String type) => _argbByType[type] ?? _fallbackArgb;

  /// Flutter `Color` (lejant, rozet, widget kullanımı için).
  static Color forType(String type) => Color(argbForType(type));

  /// Kanonik tip kodları kümesi (test/lejant için).
  static Iterable<String> get knownTypes => _argbByType.keys;
}
