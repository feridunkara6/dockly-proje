import 'dart:async';

import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/detail/domain/location_detail_gateway.dart';

/// Örnek marina detayı (test sabiti).
const LocationDetail sampleMarinaDetail = LocationDetail(
  id: 'loc-1',
  slug: 'd-marin-gocek',
  type: 'private_marina',
  status: 'published',
  name: 'D-Marin Göcek',
  description: 'Göcek körfezinde tam donanımlı özel marina.',
  position: GeoPoint(lat: 36.75, lon: 28.93),
  geo: GeoInfo(
    countryCode: 'TR',
    adminArea: AdminAreaRef(id: 'a1', name: 'Fethiye', province: 'Muğla'),
    waterBody: null,
  ),
  dimensions: Dimensions(
    maxBoatLengthM: 40,
    maxDraftM: 5,
    depthMinM: 3,
    depthMaxM: 8,
    capacity: 380,
  ),
  priceTier: 'paid',
  is24h: true,
  verifiedAt: '2026-07-01',
  rating: Rating(avg: 4.8, count: 12, dimensions: <RatingDimension>[]),
  amenities: <AmenityLabeled>[
    AmenityLabeled(code: 'water', label: 'Su', category: null),
    AmenityLabeled(code: 'electricity', label: 'Elektrik', category: null),
  ],
  services: <ServiceLabeled>[ServiceLabeled(code: 'crane', label: 'Vinç')],
  contacts: <Contact>[Contact(type: 'phone', value: '+902526451234', isPrimary: true)],
  hours: <Hour>[],
  seasons: <Season>[],
  typeDetails: MarinaTypeDetails(
    berthCount: 380,
    vhfChannel: '73',
    hasBlueFlag: true,
    travelLiftCapacityTons: 100,
    craneCapacityTons: null,
    winterStorage: true,
  ),
  media: MediaInfo(cover: null, count: 0),
  counts: Counts(reviews: 12, photos: 0),
);

/// Testte `LocationDetailGateway` yerine geçen sahte.
class FakeLocationDetailGateway implements LocationDetailGateway {
  FakeLocationDetailGateway({this.result = sampleMarinaDetail, this.error});

  LocationDetail result;
  AppFailure? error;

  /// Ayarlanırsa yanıt bu completer ile elle tamamlanır (yükleme durumu testi).
  Completer<LocationDetail>? pending;

  @override
  Future<LocationDetail> fetch(String idOrSlug) {
    final Completer<LocationDetail>? controlled = pending;
    if (controlled != null) return controlled.future;
    final AppFailure? err = error;
    if (err != null) return Future<LocationDetail>.error(err);
    return Future<LocationDetail>.value(result);
  }
}
