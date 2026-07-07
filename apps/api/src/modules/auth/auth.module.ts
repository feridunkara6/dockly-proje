import { Module } from '@nestjs/common';
import { AuthController } from './presentation/auth.controller';
import { SessionService } from './application/session.service';
import { SESSION_REPOSITORY } from './domain/session.repository';
import { USER_ACCOUNT_REPOSITORY } from './domain/user-account.repository';
import { PrismaSessionRepository } from './persistence/prisma-session.repository';
import { PrismaUserAccountRepository } from './persistence/prisma-user-account.repository';
import { TokenSigner } from '../../infrastructure/jwt/token.signer';
import {
  FIREBASE_TOKEN_VERIFIER,
  GoogleJwksFirebaseVerifier,
} from '../../infrastructure/firebase/firebase-token.verifier';
import { RateLimiterService } from '../../infrastructure/redis/rate-limiter.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { RolesGuard } from '../../common/guards/roles.guard';

@Module({
  controllers: [AuthController],
  providers: [
    SessionService,
    TokenSigner,
    RateLimiterService,
    JwtAuthGuard,
    RolesGuard,
    { provide: FIREBASE_TOKEN_VERIFIER, useClass: GoogleJwksFirebaseVerifier },
    { provide: SESSION_REPOSITORY, useClass: PrismaSessionRepository },
    { provide: USER_ACCOUNT_REPOSITORY, useClass: PrismaUserAccountRepository },
  ],
  exports: [TokenSigner, JwtAuthGuard, RolesGuard, RateLimiterService],
})
export class AuthModule {}
