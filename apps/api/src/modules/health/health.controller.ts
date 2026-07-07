import { Controller, Get, ServiceUnavailableException } from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RedisService } from '../../infrastructure/redis/redis.service';

const CHECK_TIMEOUT_MS = 2_000;

interface ReadinessReport {
  status: 'ok';
  checks: { database: 'ok'; redis: 'ok' };
}

/**
 * docs/24 §13: /healthz = liveness (process ayakta mı), /readyz = readiness (DB+Redis).
 * S3 bilinçli olarak readiness DIŞI — S3 kesintisi trafiği düşürmemeli.
 */
@Controller()
export class HealthController {
  constructor(
    private readonly prisma: PrismaService,
    private readonly redis: RedisService,
  ) {}

  @Get('healthz')
  liveness(): { status: 'ok' } {
    return { status: 'ok' };
  }

  @Get('readyz')
  async readiness(): Promise<ReadinessReport> {
    const [db, cache] = await Promise.allSettled([
      this.withTimeout(this.prisma.$queryRaw`SELECT 1`, 'database'),
      this.withTimeout(this.redis.ping(), 'redis'),
    ]);
    const failures: string[] = [];
    if (db.status === 'rejected') failures.push('database');
    if (cache.status === 'rejected') failures.push('redis');
    if (failures.length > 0) {
      throw new ServiceUnavailableException(`Hazır değil: ${failures.join(', ')}`);
    }
    return { status: 'ok', checks: { database: 'ok', redis: 'ok' } };
  }

  private async withTimeout<T>(work: Promise<T>, name: string): Promise<T> {
    let timer: NodeJS.Timeout | undefined;
    const timeout = new Promise<never>((_, reject) => {
      timer = setTimeout(() => reject(new Error(`${name} zaman aşımı`)), CHECK_TIMEOUT_MS);
    });
    try {
      return await Promise.race([work, timeout]);
    } finally {
      clearTimeout(timer);
    }
  }
}
