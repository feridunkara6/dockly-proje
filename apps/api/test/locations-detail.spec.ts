import { LocationsService } from '../src/modules/locations/application/locations.service';
import { AppProblem } from '../src/common/problem/problem';
import { DetailData, LocationsRepository } from '../src/modules/locations/domain/locations.repository';

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
  cover: null,
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
  typeDetails: {
    kind: 'marina',
    berthCount: 380,
    vhfChannel: '72',
    hasBlueFlag: true,
    travelLiftCapacityTons: 100,
    craneCapacityTons: null,
    winterStorage: true,
  },
  ratingDimensions: [
    { code: 'shelter', avg: 4.9 },
    { code: 'staff', avg: 4.7 },
  ],
};

/** Alt-tip detayı olmayan lokasyon (ör. şamandıra) — typeDetails null yolu. */
const BARE: DetailData = { ...SAMPLE, slug: 'bare', typeDetails: null, ratingDimensions: [] };

/** Dış (CC/Commons) lisanslı kapak görseli olan lokasyon — atıf geçişi. */
const WITHCOVER: DetailData = {
  ...SAMPLE,
  slug: 'covered',
  cover: {
    url: 'https://upload.wikimedia.org/wikipedia/commons/x.jpg',
    blurhash: null,
    credit: 'Foto: Jane Doe',
    license: 'CC BY-SA 4.0',
    sourceUrl: 'https://commons.wikimedia.org/wiki/File:X.jpg',
  },
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
    if (idOrSlug === 'd-marin') return Promise.resolve(SAMPLE);
    if (idOrSlug === 'bare') return Promise.resolve(BARE);
    if (idOrSlug === 'covered') return Promise.resolve(WITHCOVER);
    return Promise.resolve(null);
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

  it('typeDetails (marina) + rating.dimensions geçirilir', async () => {
    const d = await service.detail('d-marin', 'tr');
    expect(d.typeDetails).toEqual({
      kind: 'marina',
      berthCount: 380,
      vhfChannel: '72',
      hasBlueFlag: true,
      travelLiftCapacityTons: 100,
      craneCapacityTons: null,
      winterStorage: true,
    });
    expect(d.rating).toEqual({
      avg: 4.6,
      count: 50,
      dimensions: [
        { code: 'shelter', avg: 4.9 },
        { code: 'staff', avg: 4.7 },
      ],
    });
  });

  it('alt-tip detayı yoksa typeDetails null, rating.dimensions boş', async () => {
    const d = await service.detail('bare', 'tr');
    expect(d.typeDetails).toBeNull();
    expect(d.rating.dimensions).toEqual([]);
  });

  it('kapak görseli yoksa media.cover null (userContext de null)', async () => {
    const d = await service.detail('d-marin', 'tr');
    expect(d.media).toEqual({ cover: null, count: 24 });
    expect(d.userContext).toBeNull();
    expect(d.counts).toEqual({ reviews: 50, photos: 24 });
  });

  it('dış lisanslı kapak görseli, atıf alanlarıyla (credit/license/source) geçirilir', async () => {
    const d = await service.detail('covered', 'tr');
    expect(d.media.cover).toEqual({
      url: 'https://upload.wikimedia.org/wikipedia/commons/x.jpg',
      blurhash: null,
      credit: 'Foto: Jane Doe',
      license: 'CC BY-SA 4.0',
      sourceUrl: 'https://commons.wikimedia.org/wiki/File:X.jpg',
    });
    expect(d.media.count).toBe(24);
  });

  it('bulunamayan id/slug → not-found (AppProblem)', async () => {
    await expect(service.detail('yok', 'tr')).rejects.toBeInstanceOf(AppProblem);
  });
});
