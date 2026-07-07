import { CatalogService } from '../src/modules/catalog/application/catalog.service';
import {
  AmenityRow,
  CatalogRepository,
  CodeRow,
  LocationTypeRow,
  NamedIconRow,
} from '../src/modules/catalog/domain/catalog.repository';

class FakeCatalogRepo implements CatalogRepository {
  async listLocationTypes(): Promise<LocationTypeRow[]> {
    return [
      {
        code: 'private_marina',
        iconKey: 'private_marina',
        colorHex: '#0C7BDC',
        supportsReservation: true,
        translations: [
          { locale: 'tr', name: 'Özel Marina' },
          { locale: 'en', name: 'Private Marina' },
        ],
      },
    ];
  }
  async listAmenities(): Promise<AmenityRow[]> {
    return [
      {
        code: 'electricity',
        iconKey: 'electricity',
        category: 'utility',
        translations: [
          { locale: 'tr', name: 'Elektrik' },
          { locale: 'en', name: 'Electricity' },
        ],
      },
    ];
  }
  async listServices(): Promise<NamedIconRow[]> {
    return [{ code: 'mooring_assist', iconKey: null, translations: [{ locale: 'tr', name: 'Palamar' }] }];
  }
  async listBoatTypes(): Promise<NamedIconRow[]> {
    return [{ code: 'sailboat', iconKey: 'sailboat', translations: [] }];
  }
  async listEngineTypes(): Promise<CodeRow[]> {
    return [{ code: 'inboard_diesel' }, { code: 'electric' }];
  }
}

describe('CatalogService (i18n etiketleme)', () => {
  const service = new CatalogService(new FakeCatalogRepo());

  it('location types: locale=tr → TR etiket + meta korunur', async () => {
    const items = await service.locationTypes('tr');
    expect(items[0]).toEqual({
      code: 'private_marina',
      label: 'Özel Marina',
      iconKey: 'private_marina',
      colorHex: '#0C7BDC',
      supportsReservation: true,
    });
  });

  it('amenities: locale=en → EN etiket', async () => {
    const items = await service.amenities('en');
    expect(items[0].label).toBe('Electricity');
    expect(items[0].category).toBe('utility');
  });

  it('boat types çevirisi yoksa label = code', async () => {
    const items = await service.boatTypes('tr');
    expect(items[0].label).toBe('sailboat');
  });

  it('engine types: i18n yok, label = code', async () => {
    const items = await service.engineTypes();
    expect(items).toEqual([
      { code: 'inboard_diesel', label: 'inboard_diesel' },
      { code: 'electric', label: 'electric' },
    ]);
  });

  it('services: desteklenmeyen locale → en yoksa ilk çeviri (Palamar)', async () => {
    const items = await service.services('de');
    expect(items[0].label).toBe('Palamar');
  });
});
