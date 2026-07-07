import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { BoatsController } from './presentation/boats.controller';
import { BoatsService } from './application/boats.service';
import { BOAT_REPOSITORY } from './domain/boat.repository';
import { PrismaBoatRepository } from './persistence/prisma-boat.repository';

@Module({
  imports: [AuthModule],
  controllers: [BoatsController],
  providers: [BoatsService, { provide: BOAT_REPOSITORY, useClass: PrismaBoatRepository }],
})
export class BoatsModule {}
