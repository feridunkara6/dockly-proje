import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../infrastructure/prisma/prisma.service';
import {
  AmenityRow,
  CatalogRepository,
  CodeRow,
  LocationTypeRow,
  NamedIconRow,
} from '../domain/catalog.repository';

const ACTIVE = { isActive: true } as const;
const BY_SORT = { sortOrder: 'asc' } as const;

@Injectable()
export class PrismaCatalogRepository implements CatalogRepository {
  constructor(private readonly prisma: PrismaService) {}

  async listLocationTypes(): Promise<LocationTypeRow[]> {
    const rows = await this.prisma.locationType.findMany({
      where: ACTIVE,
      orderBy: BY_SORT,
      include: { i18n: { select: { locale: true, name: true } } },
    });
    return rows.map((r) => ({
      code: r.code,
      iconKey: r.iconKey,
      colorHex: r.colorHex,
      supportsReservation: r.supportsReservation,
      translations: r.i18n,
    }));
  }

  async listAmenities(): Promise<AmenityRow[]> {
    const rows = await this.prisma.amenity.findMany({
      where: ACTIVE,
      orderBy: BY_SORT,
      include: { i18n: { select: { locale: true, name: true } } },
    });
    return rows.map((r) => ({
      code: r.code,
      iconKey: r.iconKey,
      category: r.category,
      translations: r.i18n,
    }));
  }

  async listServices(): Promise<NamedIconRow[]> {
    const rows = await this.prisma.service.findMany({
      where: ACTIVE,
      orderBy: BY_SORT,
      include: { i18n: { select: { locale: true, name: true } } },
    });
    return rows.map((r) => ({ code: r.code, iconKey: r.iconKey, translations: r.i18n }));
  }

  async listBoatTypes(): Promise<NamedIconRow[]> {
    const rows = await this.prisma.boatType.findMany({
      where: ACTIVE,
      orderBy: BY_SORT,
      include: { i18n: { select: { locale: true, name: true } } },
    });
    return rows.map((r) => ({ code: r.code, iconKey: r.iconKey, translations: r.i18n }));
  }

  async listEngineTypes(): Promise<CodeRow[]> {
    const rows = await this.prisma.engineType.findMany({ where: ACTIVE, orderBy: BY_SORT });
    return rows.map((r) => ({ code: r.code }));
  }
}
