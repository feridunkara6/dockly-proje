import { Inject, Injectable } from '@nestjs/common';
import { LOCATIONS_REPOSITORY, LocationsRepository } from '../domain/locations.repository';
import { PIN_CAP, parseBbox, quantizeBbox } from '../domain/bbox';
import { PinResult } from '../domain/location.types';

/** Harita/lokasyon sorguları — doğrulama + tavan/truncation orkestrasyonu. */
@Injectable()
export class LocationsService {
  constructor(
    @Inject(LOCATIONS_REPOSITORY) private readonly repo: LocationsRepository,
  ) {}

  /**
   * bbox pin sorgusu (docs/23 §9.5, zoom ≥ 12). Ham bbox doğrulanır, %1 grid'e
   * kuantalanır; tavanı (500) tespit için +1 satır çekilir. Cluster modu
   * (zoom < 12) sonraki alt-fazda.
   */
  async pinsInBbox(rawBbox: string | undefined, types: string[] | undefined): Promise<PinResult> {
    const bbox = parseBbox(rawBbox);
    const quantized = quantizeBbox(bbox);
    const rows = await this.repo.findPinsInBbox(quantized, types, PIN_CAP + 1);
    const truncated = rows.length > PIN_CAP;
    return { locations: truncated ? rows.slice(0, PIN_CAP) : rows, truncated };
  }
}
