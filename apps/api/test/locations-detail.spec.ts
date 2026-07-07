import { LocationsService } from '../src/modules/locations/application/locations.service';
import { AppProblem } from '../src/common/problem/problem';
import {
  DetailData,
  LocationsRepository,
} from '../src/modules/locations/domain/locations.repository';

const SAMPLE: DetailData = {
  id: 'loc-1',
  slug: 'd-marin',
  type: 'private_marina',
  status: 'published',
  baseName: 'D-Marin',
  baseDescription: 'base desc',
  i18n: [
    { locale: 'tr', name: 'D-Marin Göcek', description: 'TR açıklama' },
    { locale: 'en', name: 'D-Marin Gocek', description: 'EN desc' },
  ],
  lat: 36.75,
  lon: 28.95,
  countryCode: 'TR',
  adminArea: { id: 'aa', name: 'Fethiye', province: 'Muğla' },
  waterBody: { id: 'wb', name: 'Göcek Körfezi', type: 'gulf' },
  dimensions: { maxBoatLengthM: 40, maxDraftM: 5, depthMinM: 3, depthMaxM: 12, capacity: 380 },
  priceTier: 'paid',
  is24h: true,
  verifiedAt: '2026-08-01T00:00:00.000Z',
  ratingAvg: 4.6,
  ratingCount: 50,
  reviewCount: 50,
  photoCount: 24,
  amenities: [
    {
      code: 'electricity',
      category: 'utility',
      translations: [
        { locale: 'tr', name: 'Elektrik' },
        { locale: 'en', name: 'Electricity' },
      ],
    },
  ],
  services: [{ code: 'mooring_assist', translations: [{ locale: 'tr', name: 'Palamar' }] }],
  contacts: [{ type: 'phone', value: '+90', isPrimary: true }],
  hours: [{ dayOfWeek: 1, opensAt: '08:00', closesAt: '22:00' }],
  seasons: [{ opensOn: '05-01', closesOn: '10-31' }],
};

class FakeRepo implements LocationsRepository {
  findPinsInBbox(): Promise<never[]> {
    return Promise.resolve([]);
  }
  findNearby(): Promise<never[]> {
    return Promise.resolve([]);
  }
  findClusters(): Promise<never[]> {
    return Promise.resolve([]);
  }
  findDetail(idOrSlug: string): Promise<DetailData | null> {
    return Promise.resolve(idOrSlug === 'd-marin' ? SAMPLE : null);
  }
}

describe('LocationsService.detail (docs/23 §11.3)', () => {
  const service = new LocationsService(new FakeRepo());

  it('tr locale: TR isim + etiketler + province', async () => {
    const d = await service.detail('d-marin', 'tr');
    expect(d.name).toBe('D-Marin Göcek');
    expect(d.description).toBe('TR açıklama');
    expect(d.amenities[0].label).toBe('Elektrik');
    expect(d.services[0].label).toBe('Palamar');
    expect(d.geo.adminArea?.province).toBe('Muğla');
    expect(d.geo.waterBody?.type).toBe('gulf');
    expect(d.hours[0]).toEqual({ dayOfWeek: 1, opensAt: '08:00', closesAt: '22:00' });
    expect(d.seasons[0]).toEqual({ opensOn: '05-01', closesOn: '10-31' });
  });

  it('en locale: EN isim + etiket', async () => {
    const d = await service.detail('d-marin', 'en');
    expect(d.name).toBe('D-Marin Gocek');
    expect(d.amenities[0].label).toBe('Electricity');
  });

  it('ertelenen alanlar null/boş (typeDetails, media.cover, userContext, rating.dimensions)', async () => {
    const d = await service.detail('d-marin', 'tr');
    expect(d.typeDetails).toBeNull();
    expect(d.media.cover).toBeNull();
    expect(d.media.count).toBe(24);
    expect(d.userContext).toBeNull();
    expect(d.rating).toEqual({ avg: 4.6, count: 50, dimensions: [] });
    expect(d.counts).toEqual({ reviews: 50, photos: 24 });
  });

  it('bulunamayan id/slug → not-found (AppProblem)', async () => {
    await expect(service.detail('yok', 'tr')).rejects.toBeInstanceOf(AppProblem);
  });
});
