import { Inject, Injectable } from '@nestjs/common';
import { LOCATIONS_REPOSITORY, LocationsRepository } from '../domain/locations.repository';
import { PIN_CAP, parseBbox, quantizeBbox } from '../domain/bbox';
import { CLUSTER_CAP, MIN_PIN_ZOOM, clusterCellSizeDeg, parseZoom } from '../domain/cluster';
import { NM_TO_M, parseNearbyQuery } from '../domain/nearby';
import { LocationDetail, LocationSummary, MapResult } from '../domain/location.types';
import { pickLabel } from '../../../common/i18n/locale';
import { AppProblem } from '../../../common/problem/problem';

/** i18n satırından name/description seçer: istenen → 'en' → temel (null atlanır). */
function pickI18nField(
  rows: { locale: string; name: string | null; description: string | null }[],
  locale: string,
  field: 'name' | 'description',
  fallback: string | null,
): string | null {
  return (
    rows.find((r) => r.locale === locale)?.[field] ??
    rows.find((r) => r.locale === 'en')?.[field] ??
    fallback
  );
}

/** Harita/lokasyon sorguları — doğrulama + tavan/truncation orkestrasyonu. */
@Injectable()
export class LocationsService {
  constructor(
    @Inject(LOCATIONS_REPOSITORY) private readonly repo: LocationsRepository,
  ) {}

  /**
   * Harita bbox sorgusu (docs/23 §9.5). Ham bbox doğrulanır, %1 grid'e kuantalanır.
   * zoom < 12 → cluster modu (balonlar); aksi halde (zoom ≥ 12 veya yok) → pin modu.
   */
  async map(
    rawBbox: string | undefined,
    rawZoom: string | undefined,
    types: string[] | undefined,
  ): Promise<MapResult> {
    const bbox = parseBbox(rawBbox);
    const zoom = parseZoom(rawZoom);
    const quantized = quantizeBbox(bbox);

    if (zoom !== undefined && zoom < MIN_PIN_ZOOM) {
      const cellDeg = clusterCellSizeDeg(zoom);
      const found = await this.repo.findClusters(quantized, types, cellDeg, CLUSTER_CAP + 1);
      const clusters = found.length > CLUSTER_CAP ? found.slice(0, CLUSTER_CAP) : found;
      return { clusters, locations: [], truncated: false };
    }

    const rows = await this.repo.findPinsInBbox(quantized, types, PIN_CAP + 1);
    const truncated = rows.length > PIN_CAP;
    return { clusters: [], locations: truncated ? rows.slice(0, PIN_CAP) : rows, truncated };
  }

  /**
   * Yakınımdaki lokasyonlar (docs/23 §9.6). Query doğrulanır; radiusNm metreye
   * çevrilir; sonuç mesafeye göre artan sıralı döner.
   */
  async nearby(
    raw: { lat?: string; lon?: string; radiusNm?: string; limit?: string },
    types: string[] | undefined,
  ): Promise<{ data: LocationSummary[] }> {
    const q = parseNearbyQuery(raw);
    const data = await this.repo.findNearby({
      lat: q.lat,
      lon: q.lon,
      radiusMeters: q.radiusNm * NM_TO_M,
      types,
      limit: q.limit,
    });
    return { data };
  }

  /**
   * Liman detayı (docs/23 §11.3, S-09). id veya slug ile; bulunamazsa 404.
   * name/description + olanak/hizmet etiketleri locale'e göre çözülür; `typeDetails`
   * (alt-tip birleşimi) ve `rating.dimensions` (yorum-türevli) dahil.
   * `media.cover`/`userContext` ilgili alt sistemlerle gelecek (şimdilik null).
   */
  async detail(idOrSlug: string, locale: string): Promise<LocationDetail> {
    const d = await this.repo.findDetail(idOrSlug);
    if (!d) throw new AppProblem('not-found');

    return {
      id: d.id,
      slug: d.slug,
      type: d.type,
      status: d.status,
      name: pickI18nField(d.i18n, locale, 'name', d.baseName) ?? d.baseName,
      description: pickI18nField(d.i18n, locale, 'description', d.baseDescription),
      position: { lat: d.lat, lon: d.lon },
      geo: { countryCode: d.countryCode, adminArea: d.adminArea, waterBody: d.waterBody },
      dimensions: d.dimensions,
      priceTier: d.priceTier,
      is24h: d.is24h,
      verifiedAt: d.verifiedAt,
      rating: { avg: d.ratingAvg, count: d.ratingCount, dimensions: d.ratingDimensions },
      amenities: d.amenities.map((a) => ({
        code: a.code,
        label: pickLabel(a.translations, locale, a.code),
        category: a.category,
      })),
      services: d.services.map((s) => ({
        code: s.code,
        label: pickLabel(s.translations, locale, s.code),
      })),
      contacts: d.contacts,
      hours: d.hours,
      seasons: d.seasons,
      typeDetails: d.typeDetails,
      media: { cover: null, count: d.photoCount },
      userContext: null,
      counts: { reviews: d.reviewCount, photos: d.photoCount },
    };
  }
}
