import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { LoggerModule } from 'nestjs-pino';
import { AppConfigModule } from './config/config.module';
import { EnvService } from './config/env.service';
import { RequestContextMiddleware } from './common/context/request-context.middleware';
import { currentRequestId } from './common/context/request-context';
import { PrismaModule } from './infrastructure/prisma/prisma.module';
import { RedisModule } from './infrastructure/redis/redis.module';
import { HealthModule } from './modules/health/health.module';
import { AuthModule } from './modules/auth/auth.module';
import { UsersModule } from './modules/users/users.module';
import { BoatsModule } from './modules/boats/boats.module';
import { CatalogModule } from './modules/catalog/catalog.module';

/** PII redaksiyon listesi (docs/24 §12, docs/29 SEC-04). */
const REDACT_PATHS = [
  'req.headers.authorization',
  'req.headers.cookie',
  'req.body.contactPhone',
  'req.body.phone',
  'req.body.email',
];

@Module({
  imports: [
    AppConfigModule,
    LoggerModule.forRootAsync({
      inject: [EnvService],
      useFactory: (env: EnvService) => ({
        pinoHttp: {
          level: env.get('LOG_LEVEL'),
          redact: { paths: REDACT_PATHS, censor: '[redacted]' },
          mixin: () => ({ requestId: currentRequestId() }),
          autoLogging: {
            ignore: (req) => req.url === '/healthz' || req.url === '/readyz',
          },
          transport:
            env.get('NODE_ENV') === 'development' ? { target: 'pino-pretty' } : undefined,
        },
      }),
    }),
    PrismaModule,
    RedisModule,
    HealthModule,
    AuthModule,
    UsersModule,
    BoatsModule,
    CatalogModule,
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): void {
    consumer.apply(RequestContextMiddleware).forRoutes('*');
  }
}
