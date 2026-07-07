import { Injectable, Logger } from '@nestjs/common';
import { RedisService } from './redis.service';

export interface RateDecision {
  allowed: boolean;
  retryAfterSec: number;
}

/**
 * Sabit pencereli sayaç (docs/30 §1). Redis erişilemezse FAIL-OPEN:
 * istek geçer + uyarı loglanır (docs/29 kabul edilen risk, SEC-13 alarmı ops tarafında).
 */
@Injectable()
export class RateLimiterService {
  private readonly logger = new Logger(RateLimiterService.name);

  constructor(private readonly redis: RedisService) {}

  async consume(bucket: string, id: string, max: number, windowSec: number): Promise<RateDecision> {
    const windowStart = Math.floor(Date.now() / 1000 / windowSec);
    const key = `rl:${bucket}:${id}:${windowStart}`;
    try {
      await this.redis.ensureConnected();
      const count = await this.redis.client.incr(key);
      if (count === 1) {
        await this.redis.client.expire(key, windowSec);
      }
      if (count > max) {
        const retryAfterSec = windowSec - (Math.floor(Date.now() / 1000) % windowSec);
        return { allowed: false, retryAfterSec };
      }
      return { allowed: true, retryAfterSec: 0 };
    } catch (err) {
      this.logger.warn({ bucket, err: String(err) }, 'Rate limiter fail-open');
      return { allowed: true, retryAfterSec: 0 };
    }
  }
}
