import { Module } from '@nestjs/common';
import { CatalogController } from './presentation/catalog.controller';
import { CatalogService } from './application/catalog.service';
import { CATALOG_REPOSITORY } from './domain/catalog.repository';
import { PrismaCatalogRepository } from './persistence/prisma-catalog.repository';

@Module({
  controllers: [CatalogController],
  providers: [CatalogService, { provide: CATALOG_REPOSITORY, useClass: PrismaCatalogRepository }],
})
export class CatalogModule {}
