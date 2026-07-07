import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { UsersController } from './presentation/users.controller';
import { UsersService } from './application/users.service';
import { USER_REPOSITORY } from './domain/user.repository';
import { PrismaUserRepository } from './persistence/prisma-user.repository';

@Module({
  imports: [AuthModule],
  controllers: [UsersController],
  providers: [UsersService, { provide: USER_REPOSITORY, useClass: PrismaUserRepository }],
})
export class UsersModule {}
