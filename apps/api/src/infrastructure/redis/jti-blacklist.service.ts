import { Injectable, Logger } from '@nestjs/common';
import { RedisService } from './redis.service';

const KEY_PREFIX = 'jti:block:';

/**
 * Acil access-token iptali (docs/24 §7.2): hesabı kapanan/askıya alınan kullanıcının
 * hâlâ geçerli görünen 15 dk'lık token'ları anında düşürülür.
 * Redis erişilemezse FAIL-OPEN + uyarı (docs/29 kabul edilen risk — pencere ≤ access TTL).
 */
@Injectable()
export class JtiBlacklistService {
  private readonly logger = new Logger(JtiBlacklistService.name);

  constructor(private readonly redis: RedisService) {}

  async block(jti: string, ttlSec: number): Promise<void> {
    try {
      await this.redis.ensureConnected();
      await this.redis.client.set(KEY_PREFIX + jti, '1', 'EX', Math.max(ttlSec, 1));
    } catch (err) {
      this.logger.warn({ err: String(err) }, 'jti blacklist yazılamadı (fail-open)');
    }
  }

  async isBlocked(jti: string): Promise<boolean> {
    try {
      await this.redis.ensureConnected();
      return (await this.redis.client.exists(KEY_PREFIX + jti)) === 1;
    } catch (err) {
      this.logger.warn({ err: String(err) }, 'jti blacklist okunamadı (fail-open)');
      return false;
    }
  }
}
