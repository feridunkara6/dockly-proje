import { Translation } from './lookup.types';

/** Lookup satırı + çevirileri (etiket çözümü uygulama katmanında). */
export interface LocationTypeRow {
  code: string;
  iconKey: string | null;
  colorHex: string | null;
  supportsReservation: boolean;
  translations: Translation[];
}

export interface AmenityRow {
  code: string;
  iconKey: string | null;
  category: string | null;
  translations: Translation[];
}

export interface NamedIconRow {
  code: string;
  iconKey: string | null;
  translations: Translation[];
}

export interface CodeRow {
  code: string;
}

/** Aktif lookup satırlarını sortOrder sırasıyla okur (docs/22 §4). */
export interface CatalogRepository {
  listLocationTypes(): Promise<LocationTypeRow[]>;
  listAmenities(): Promise<AmenityRow[]>;
  listServices(): Promise<NamedIconRow[]>;
  listBoatTypes(): Promise<NamedIconRow[]>;
  listEngineTypes(): Promise<CodeRow[]>;
}

export const CATALOG_REPOSITORY = Symbol('CATALOG_REPOSITORY');
