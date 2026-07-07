import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../../../infrastructure/prisma/prisma.service';
import { DetailData, LocationsRepository } from '../domain/locations.repository';
import { NM_TO_M } from '../domain/nearby';
import { Bbox, Cluster, LocationPin, LocationSummary, NearbyParams } from '../domain/location.types';

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

function pad2(n: number): string {
  return n < 10 ? `0${n}` : `${n}`;
}

/** @db.Time → "HH:MM" (UTC saklanır); null ise null. */
function fmtTime(t: Date | null): string | null {
  return t ? `${pad2(t.getUTCHours())}:${pad2(t.getUTCMinutes())}` : null;
}

/** month/day → "MM-DD"; ikisinden biri yoksa null. */
function fmtMonthDay(month: number | null, day: number | null): string | null {
  return month != null && day != null ? `${pad2(month)}-${pad2(day)}` : null;
}

function dec(v: unknown): number | null {
  return v === null || v === undefined ? null : Number(v);
}

/** Ham satır (PostGIS projeksiyonu). */
interface PinRow {
  id: string;
  name: string;
  type: string;
  lat: number;
  lon: number;
  ratingAvg: Prisma.Decimal | number | null;
  priceTier: string;
}

interface NearbyRow extends PinRow {
  slug: string;
  ratingCount: number | bigint;
  city: string | null;
  waterBodyName: string | null;
  distanceNm: number;
  amenityCodes: string[] | null;
}

interface ClusterRow {
  nodeLon: number;
  nodeLat: number;
  lon: number;
  lat: number;
  count: number | bigint;
}

@Injectable()
export class PrismaLocationsRepository implements LocationsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findPinsInBbox(
    bbox: Bbox,
    types: string[] | undefined,
    limit: number,
  ): Promise<LocationPin[]> {
    const typeFilter =
      types && types.length > 0
        ? Prisma.sql`AND lt.code = ANY(${types}::text[])`
        : Prisma.empty;

    // `&&` = geography GIST index'i (ix_locations_position) kullanan bbox örtüşmesi;
    // nokta geometrileri için örtüşme = "kutu içinde" (tam sonuç). ADR-005 ham SQL.
    const rows = await this.prisma.$queryRaw<PinRow[]>(Prisma.sql`
      SELECT
        l.id::text                     AS id,
        l.name                         AS name,
        lt.code                        AS type,
        ST_Y(l.position::geometry)     AS lat,
        ST_X(l.position::geometry)     AS lon,
        l.rating_avg                   AS "ratingAvg",
        l.price_tier::text             AS "priceTier"
      FROM locations l
      JOIN location_types lt ON lt.id = l.location_type_id
      WHERE l.status = 'published'
        AND l.deleted_at IS NULL
        AND l.position && ST_MakeEnvelope(${bbox.minLon}, ${bbox.minLat}, ${bbox.maxLon}, ${bbox.maxLat}, 4326)::geography
        ${typeFilter}
      ORDER BY l.rating_count DESC
      LIMIT ${limit}
    `);

    return rows.map((r) => ({
      id: r.id,
      name: r.name,
      type: r.type,
      position: { lat: Number(r.lat), lon: Number(r.lon) },
      ratingAvg: r.ratingAvg === null ? null : Number(r.ratingAvg),
      priceTier: r.priceTier,
    }));
  }

  async findNearby(params: NearbyParams): Promise<LocationSummary[]> {
    const typeFilter =
      params.types && params.types.length > 0
        ? Prisma.sql`AND lt.code = ANY(${params.types}::text[])`
        : Prisma.empty;

    // ST_DWithin(geography) = GIST index'li yarıçap filtresi (metre). Mesafe
    // deniz miline çevrilir. amenityCodes en fazla 6 (sort_order sırası). coverMedia
    // medya alt sistemi gelene dek NULL (bu fazda lokasyon medyası yok). ADR-005.
    const rows = await this.prisma.$queryRaw<NearbyRow[]>(Prisma.sql`
      SELECT
        l.id::text                       AS id,
        l.name                           AS name,
        lt.code                          AS type,
        ST_Y(l.position::geometry)       AS lat,
        ST_X(l.position::geometry)       AS lon,
        l.slug                           AS slug,
        l.rating_avg                     AS "ratingAvg",
        l.rating_count                   AS "ratingCount",
        l.price_tier::text               AS "priceTier",
        aa.name                          AS city,
        wb.name                          AS "waterBodyName",
        ST_Distance(l.position, ref.g) / ${NM_TO_M} AS "distanceNm",
        (
          SELECT array_agg(code ORDER BY so NULLS LAST)
          FROM (
            SELECT a.code AS code, a.sort_order AS so
            FROM location_amenities la
            JOIN amenities a ON a.id = la.amenity_id
            WHERE la.location_id = l.id AND a.is_active = true
            ORDER BY a.sort_order NULLS LAST
            LIMIT 6
          ) top6
        )                                AS "amenityCodes"
      FROM locations l
      JOIN location_types lt ON lt.id = l.location_type_id
      LEFT JOIN admin_areas aa ON aa.id = l.admin_area_id
      LEFT JOIN water_bodies wb ON wb.id = l.water_body_id
      CROSS JOIN (SELECT ST_SetSRID(ST_MakePoint(${params.lon}, ${params.lat}), 4326)::geography AS g) ref
      WHERE l.status = 'published'
        AND l.deleted_at IS NULL
        AND ST_DWithin(l.position, ref.g, ${params.radiusMeters})
        ${typeFilter}
      ORDER BY ST_Distance(l.position, ref.g) ASC
      LIMIT ${params.limit}
    `);

    return rows.map((r) => ({
      id: r.id,
      name: r.name,
      type: r.type,
      position: { lat: Number(r.lat), lon: Number(r.lon) },
      slug: r.slug,
      coverMedia: null,
      ratingAvg: r.ratingAvg === null ? null : Number(r.ratingAvg),
      ratingCount: Number(r.ratingCount),
      priceTier: r.priceTier,
      city: r.city ?? null,
      waterBodyName: r.waterBodyName ?? null,
      distanceNm: Math.round(Number(r.distanceNm) * 100) / 100,
      amenityCodes: r.amenityCodes ?? [],
    }));
  }

  async findClusters(
    bbox: Bbox,
    types: string[] | undefined,
    cellDeg: number,
    limit: number,
  ): Promise<Cluster[]> {
    const typeFilter =
      types && types.length > 0
        ? Prisma.sql`AND lt.code = ANY(${types}::text[])`
        : Prisma.empty;

    // ST_SnapToGrid ile noktalar hücre düğümüne kilitlenir, düğüme göre GROUP BY;
    // konum = noktaların ağırlık merkezi (ST_Centroid). En kalabalık balonlar önce.
    const rows = await this.prisma.$queryRaw<ClusterRow[]>(Prisma.sql`
      SELECT
        ST_X(cell)                       AS "nodeLon",
        ST_Y(cell)                       AS "nodeLat",
        ST_X(ST_Centroid(ST_Collect(g))) AS "lon",
        ST_Y(ST_Centroid(ST_Collect(g))) AS "lat",
        COUNT(*)::int                    AS "count"
      FROM (
        SELECT
          ST_SnapToGrid(l.position::geometry, 0, 0, ${cellDeg}, ${cellDeg}) AS cell,
          l.position::geometry AS g
        FROM locations l
        JOIN location_types lt ON lt.id = l.location_type_id
        WHERE l.status = 'published'
          AND l.deleted_at IS NULL
          AND l.position && ST_MakeEnvelope(${bbox.minLon}, ${bbox.minLat}, ${bbox.maxLon}, ${bbox.maxLat}, 4326)::geography
          ${typeFilter}
      ) s
      GROUP BY cell
      ORDER BY COUNT(*) DESC
      LIMIT ${limit}
    `);

    const half = cellDeg / 2;
    return rows.map((r) => ({
      position: { lat: Number(r.lat), lon: Number(r.lon) },
      count: Number(r.count),
      bbox: [
        Number(r.nodeLon) - half,
        Number(r.nodeLat) - half,
        Number(r.nodeLon) + half,
        Number(r.nodeLat) + half,
      ] as [number, number, number, number],
    }));
  }

  async findDetail(idOrSlug: string): Promise<DetailData | null> {
    const where = UUID_RE.test(idOrSlug) ? { id: idOrSlug } : { slug: idOrSlug };
    const loc = await this.prisma.location.findFirst({
      where: { ...where, status: 'published', deletedAt: null },
      include: {
        locationType: true,
        i18n: true,
        adminArea: { include: { parent: true } },
        waterBody: true,
        amenities: { include: { amenity: { include: { i18n: true } } } },
        services: { include: { service: { include: { i18n: true } } } },
        contacts: true,
        operatingHours: true,
        openingSeasons: true,
      },
    });
    if (!loc) return null;

    const pos = await this.prisma.$queryRaw<{ lat: number; lon: number }[]>(Prisma.sql`
      SELECT ST_Y(position::geometry) AS lat, ST_X(position::geometry) AS lon
      FROM locations WHERE id = ${loc.id}::uuid
    `);
    const lat = Number(pos[0]?.lat);
    const lon = Number(pos[0]?.lon);

    const bySort = <T extends { sortOrder: number | null }>(a: T, b: T): number =>
      (a.sortOrder ?? 9999) - (b.sortOrder ?? 9999);

    return {
      id: loc.id,
      slug: loc.slug,
      type: loc.locationType.code,
      status: loc.status,
      baseName: loc.name,
      baseDescription: loc.description,
      i18n: loc.i18n.map((t) => ({ locale: t.locale, name: t.name, description: t.description })),
      lat,
      lon,
      countryCode: loc.countryCode,
      adminArea: loc.adminArea
        ? { id: loc.adminArea.id, name: loc.adminArea.name, province: loc.adminArea.parent?.name ?? null }
        : null,
      waterBody: loc.waterBody
        ? { id: loc.waterBody.id, name: loc.waterBody.name, type: loc.waterBody.type }
        : null,
      dimensions: {
        maxBoatLengthM: dec(loc.maxBoatLengthM),
        maxDraftM: dec(loc.maxDraftM),
        depthMinM: dec(loc.depthMinM),
        depthMaxM: dec(loc.depthMaxM),
        capacity: loc.capacity ?? null,
      },
      priceTier: loc.priceTier,
      is24h: loc.is24h,
      verifiedAt: loc.verifiedAt ? loc.verifiedAt.toISOString() : null,
      ratingAvg: dec(loc.ratingAvg),
      ratingCount: loc.ratingCount,
      reviewCount: loc.reviewCount,
      photoCount: loc.photoCount,
      amenities: [...loc.amenities]
        .sort((a, b) => bySort(a.amenity, b.amenity))
        .map((la) => ({
          code: la.amenity.code,
          category: la.amenity.category,
          translations: la.amenity.i18n.map((i) => ({ locale: i.locale, name: i.name })),
        })),
      services: [...loc.services]
        .sort((a, b) => bySort(a.service, b.service))
        .map((ls) => ({
          code: ls.service.code,
          translations: ls.service.i18n.map((i) => ({ locale: i.locale, name: i.name })),
        })),
      contacts: [...loc.contacts]
        .sort((a, b) => Number(b.isPrimary) - Number(a.isPrimary))
        .map((c) => ({ type: c.contactType, value: c.value, isPrimary: c.isPrimary })),
      hours: [...loc.operatingHours]
        .sort((a, b) => a.dayOfWeek - b.dayOfWeek)
        .map((h) => ({
          dayOfWeek: h.dayOfWeek,
          opensAt: h.isClosed ? null : fmtTime(h.opensAt),
          closesAt: h.isClosed ? null : fmtTime(h.closesAt),
        })),
      seasons: loc.openingSeasons.map((s) => ({
        opensOn: fmtMonthDay(s.opensOnMonth, s.opensOnDay),
        closesOn: fmtMonthDay(s.closesOnMonth, s.closesOnDay),
      })),
    };
  }
}
