import { Module } from '@nestjs/common';
import { LocationsController } from './presentation/locations.controller';
import { LocationsService } from './application/locations.service';
import { LOCATIONS_REPOSITORY } from './domain/locations.repository';
import { PrismaLocationsRepository } from './persistence/prisma-locations.repository';

@Module({
  controllers: [LocationsController],
  providers: [
    LocationsService,
    { provide: LOCATIONS_REPOSITORY, useClass: PrismaLocationsRepository },
  ],
})
export class LocationsModule {}
