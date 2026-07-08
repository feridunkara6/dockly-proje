import { Injectable, Logger } from '@nestjs/common';
import { RedisService } from './redis.service';
import { AppProblem } from '../../common/problem/problem';

const KEY_PREFIX = 'jti:block:';

/**
 * Acil access-token iptali (docs/24 §7.2): hesabı kapanan/askıya alınan kullanıcının
 * hâlâ geçerli görünen 15 dk'lık token'ları anında düşürülür.
 */
@Injectable()
export class JtiBlacklistService {
  private readonly logger = new Logger(JtiBlacklistService.name);

  constructor(private readonly redis: RedisService) {}

  /**
   * Yazma BEST-EFFORT: Redis'e yazılamazsa loglanır ama akış durmaz. Kalıcı güvenlik
   * garantisi refresh ailelerinin DB'de iptalidir (session.service terminateUser);
   * bu liste yalnızca ≤15 dk'lık access token penceresi için hızlı yoldur.
   */
  async block(jti: string, ttlSec: number): Promise<void> {
    try {
      await this.redis.ensureConnected();
      await this.redis.client.set(KEY_PREFIX + jti, '1', 'EX', Math.max(ttlSec, 1));
    } catch (err) {
      this.logger.warn(
        { err: String(err) },
        'jti blacklist yazılamadı (DB refresh iptali kalıcı garanti sağlar)',
      );
    }
  }

  /**
   * Okuma FAIL-CLOSED (docs/12 §0.3): Redis kontrol edilemezse iptal durumu bilinemez;
   * güvenli taraf isteği reddetmektir (503 → istemci yeniden dener, oturumu kapatmaz).
   * Yalnız kimliği doğrulanmış uçları etkiler; public keşif uçları jti kontrolü yapmaz,
   * Redis kesintisinde de açık kalır.
   */
  async isBlocked(jti: string): Promise<boolean> {
    try {
      await this.redis.ensureConnected();
      return (await this.redis.client.exists(KEY_PREFIX + jti)) === 1;
    } catch (err) {
      this.logger.error({ err: String(err) }, 'jti blacklist okunamadı — fail-closed (503)');
      throw new AppProblem(
        'service-unavailable',
        'Kimlik doğrulama servisi geçici olarak kullanılamıyor, lütfen tekrar deneyin.',
      );
    }
  }
}
