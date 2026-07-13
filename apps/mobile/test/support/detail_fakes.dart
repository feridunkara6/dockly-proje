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

  @override
  Future<LocationDetail> fetch(String idOrSlug) {
    final AppFailure? err = error;
    if (err != null) return Future<LocationDetail>.error(err);
    return Future<LocationDetail>.value(result);
  }
}


/// Örnek demirleme koyu detayı — rezervasyonun OLMADIĞI tip (ürün kararı testi).
const LocationDetail sampleAnchorageDetail = LocationDetail(
  id: 'loc-koy',
  slug: 'gokkaya-koyu-kekova',
  type: 'mooring_point',
  status: 'published',
  name: 'Gökkaya Koyu',
  description: 'Kekova\'nın en büyük koyu; 7-8 m çamura demirlenir.',
  position: GeoPoint(lat: 36.210667, lon: 29.891167),
  geo: GeoInfo(
    countryCode: 'TR',
    adminArea: AdminAreaRef(id: 'a2', name: 'Demre', province: 'Antalya'),
    waterBody: null,
  ),
  dimensions: Dimensions(
    maxBoatLengthM: null,
    maxDraftM: null,
    depthMinM: 7,
    depthMaxM: 8,
    capacity: null,
  ),
  priceTier: 'free',
  is24h: false,
  verifiedAt: null,
  rating: Rating(avg: null, count: 0, dimensions: <RatingDimension>[]),
  amenities: <AmenityLabeled>[],
  services: <ServiceLabeled>[],
  contacts: <Contact>[],
  hours: <Hour>[],
  seasons: <Season>[],
  typeDetails: AnchorageTypeDetails(
    holdingType: 'mud',
    protectionN: null,
    protectionS: null,
    protectionE: null,
    protectionW: null,
    swellExposure: null,
    isFree: true,
  ),
  media: MediaInfo(cover: null, count: 0),
  counts: Counts(reviews: 0, photos: 0),
);
