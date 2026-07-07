/** Lokalize sözlük öğeleri (docs/23 §10 #8). İstemci `code`'a göre davranır, `label`'ı basar. */
export interface LocationTypeItem {
  code: string;
  label: string;
  iconKey: string | null;
  colorHex: string | null;
  supportsReservation: boolean;
}

export interface AmenityItem {
  code: string;
  label: string;
  iconKey: string | null;
  category: string | null;
}

export interface ServiceItem {
  code: string;
  label: string;
  iconKey: string | null;
}

export interface BoatTypeItem {
  code: string;
  label: string;
  iconKey: string | null;
}

export interface EngineTypeItem {
  code: string;
  /** engine_types i18n taşımaz; label = code (istemci gerekirse eşler). */
  label: string;
}

/** Çeviri satırının dar görünümü. */
export interface Translation {
  locale: string;
  name: string;
}
