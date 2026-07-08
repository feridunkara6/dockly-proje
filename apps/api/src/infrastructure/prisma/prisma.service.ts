import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { Prisma, PrismaClient } from '@prisma/client';

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

  /**
   * RLS bağlamı (ADR-003, docs/12 §0): sahiplik-kolonlu tablolara dokunan her
   * kullanıcı-kapsamlı işlem bunun içinden koşar. `set_config(..., true)` bağlamı
   * YALNIZ bu transaction'a yazar (connection pool'a sızmaz). Bağlam kurulunca RLS
   * politikaları `user_id = app_current_user_id()` ile satır izolasyonu uygular;
   * uygulama-katmanı WHERE'i yanlışlıkla atlarsa DB seviyesinde ikinci fren devrede.
   * Altyapı/anonim yollar (auth köprüsü, public okuma) bu sarmalayıcıyı KULLANMAZ;
   * bağlam bildirilmediğinde politikanın `IS NULL` kolu onları çalışır bırakır.
   */
  async withUserContext<T>(
    userId: string,
    work: (tx: Prisma.TransactionClient) => Promise<T>,
  ): Promise<T> {
    return this.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.user_id', ${userId}, true)`;
      return work(tx);
    });
  }
}
