import { Injectable, OnModuleDestroy } from '@nestjs/common';
import Redis from 'ioredis';
import { EnvService } from '../../config/env.service';

/**
 * Tek Redis bağlantısı (docs/24 §8 — cache/rate-limit/kuyruk altyapısının temeli).
 * lazyConnect: readiness kontrolü bağlantıyı açıkça kurar; boot Redis'e takılmaz.
 */
@Injectable()
export class RedisService implements OnModuleDestroy {
  readonly client: Redis;

  constructor(env: EnvService) {
    this.client = new Redis(env.get('REDIS_URL'), {
      lazyConnect: true,
      maxRetriesPerRequest: 2,
      enableOfflineQueue: false,
    });
  }

  /** lazyConnect: ilk kullanımda bağlantıyı açıkça kurar. */
  async ensureConnected(): Promise<void> {
    if (this.client.status === 'wait' || this.client.status === 'end') {
      await this.client.connect();
    }
  }

  async ping(): Promise<boolean> {
    await this.ensureConnected();
    return (await this.client.ping()) === 'PONG';
  }

  async onModuleDestroy(): Promise<void> {
    if (this.client.status !== 'end') {
      await this.client.quit();
    }
  }
}
