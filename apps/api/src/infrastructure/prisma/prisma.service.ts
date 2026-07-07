import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

/**
 * Tek PrismaClient örneği (docs/24 §5).
 * KURAL: Bu servis yalnız infrastructure ve modüllerin persistence katmanından
 * import edilir (eslint no-restricted-imports ile zorlanır).
 */
@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  async onModuleInit(): Promise<void> {
    await this.$connect();
  }

  async onModuleDestroy(): Promise<void> {
    await this.$disconnect();
  }
}
