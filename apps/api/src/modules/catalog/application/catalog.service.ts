import { Inject, Injectable } from '@nestjs/common';
import { pickLabel } from '../../../common/i18n/locale';
import { CATALOG_REPOSITORY, CatalogRepository } from '../domain/catalog.repository';
import {
  AmenityItem,
  BoatTypeItem,
  EngineTypeItem,
  LocationTypeItem,
  ServiceItem,
} from '../domain/lookup.types';

/** Sözlük uçları — satırları istenen locale'e göre etiketler (docs/23 §7). */
@Injectable()
export class CatalogService {
  constructor(@Inject(CATALOG_REPOSITORY) private readonly repo: CatalogRepository) {}

  async locationTypes(locale: string): Promise<LocationTypeItem[]> {
    const rows = await this.repo.listLocationTypes();
    return rows.map((r) => ({
      code: r.code,
      label: pickLabel(r.translations, locale, r.code),
      iconKey: r.iconKey,
      colorHex: r.colorHex,
      supportsReservation: r.supportsReservation,
    }));
  }

  async amenities(locale: string): Promise<AmenityItem[]> {
    const rows = await this.repo.listAmenities();
    return rows.map((r) => ({
      code: r.code,
      label: pickLabel(r.translations, locale, r.code),
      iconKey: r.iconKey,
      category: r.category,
    }));
  }

  async services(locale: string): Promise<ServiceItem[]> {
    const rows = await this.repo.listServices();
    return rows.map((r) => ({
      code: r.code,
      label: pickLabel(r.translations, locale, r.code),
      iconKey: r.iconKey,
    }));
  }

  async boatTypes(locale: string): Promise<BoatTypeItem[]> {
    const rows = await this.repo.listBoatTypes();
    return rows.map((r) => ({
      code: r.code,
      label: pickLabel(r.translations, locale, r.code),
      iconKey: r.iconKey,
    }));
  }

  async engineTypes(): Promise<EngineTypeItem[]> {
    const rows = await this.repo.listEngineTypes();
    return rows.map((r) => ({ code: r.code, label: r.code }));
  }
}
