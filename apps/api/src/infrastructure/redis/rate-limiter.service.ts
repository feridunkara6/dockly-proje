import { Injectable, Logger } from '@nestjs/common';
import { RedisService } from './redis.service';

export interface RateDecision {
  allowed: boolean;
  retryAfterSec: number;
}

/**
 * Sabit pencereli sayaç (docs/30 §1). Redis erişilemezse FAIL-OPEN DEĞİL:
 * bellek-içi (in-process) yedek sayaca düşülür — brute-force koruması Redis kesintisinde
 * de sürer (auth uçları fail-closed, docs/12 §0.3). Yedek sayaç instance başınadır; çok
 * instance'lı dağıtımda efektif limit ~N×max olur ama sınırsız DEĞİLDİR (fail-open'dan
 * kesin olarak daha güvenli).
 */
@Injectable()
export class RateLimiterService {
  private readonly logger = new Logger(RateLimiterService.name);
  /** Redis kesintisi için bellek-içi yedek: `rl:...:<windowStart>` → sayaç. */
  private readonly fallback = new Map<string, number>();

  constructor(private readonly redis: RedisService) {}

  async consume(bucket: string, id: string, max: number, windowSec: number): Promise<RateDecision> {
    const nowSec = Math.floor(Date.now() / 1000);
    const windowStart = Math.floor(nowSec / windowSec);
    const key = `rl:${bucket}:${id}:${windowStart}`;
    try {
      await this.redis.ensureConnected();
      const count = await this.redis.client.incr(key);
      if (count === 1) {
        await this.redis.client.expire(key, windowSec);
      }
      return this.decide(count, max, windowSec, nowSec);
    } catch (err) {
      this.logger.warn(
        { bucket, err: String(err) },
        'Rate limiter Redis hatası — bellek-içi yedeğe düşüldü (fail-closed)',
      );
      return this.consumeFallback(key, windowStart, max, windowSec, nowSec);
    }
  }

  private consumeFallback(
    key: string,
    windowStart: number,
    max: number,
    windowSec: number,
    nowSec: number,
  ): RateDecision {
    this.pruneFallback(windowStart);
    const count = (this.fallback.get(key) ?? 0) + 1;
    this.fallback.set(key, count);
    return this.decide(count, max, windowSec, nowSec);
  }

  private decide(count: number, max: number, windowSec: number, nowSec: number): RateDecision {
    if (count > max) {
      return { allowed: false, retryAfterSec: windowSec - (nowSec % windowSec) };
    }
    return { allowed: true, retryAfterSec: 0 };
  }

  /** Geçmiş pencere anahtarlarını temizler (bellek sızıntısını önler). */
  private pruneFallback(currentWindowStart: number): void {
    for (const k of this.fallback.keys()) {
      const ws = Number(k.slice(k.lastIndexOf(':') + 1));
      if (Number.isFinite(ws) && ws < currentWindowStart) {
        this.fallback.delete(k);
      }
    }
  }
}
