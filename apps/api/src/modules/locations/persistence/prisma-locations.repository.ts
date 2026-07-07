import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../../../infrastructure/prisma/prisma.service';
import { LocationsRepository } from '../domain/locations.repository';
import { Bbox, LocationPin } from '../domain/location.types';

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
}
