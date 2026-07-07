import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';
import { TokenSigner } from '../../infrastructure/jwt/token.signer';
import { JtiBlacklistService } from '../../infrastructure/redis/jti-blacklist.service';
import { AppProblem } from '../problem/problem';
import { Principal } from '../../core/auth/principal';

/** Request'e iliştirilen principal alanı. */
export interface AuthedRequest extends Request {
  principal?: Principal;
}

/**
 * Bearer access token doğrulaması (docs/24 §7.1) — lokal public key + jti karaliste
 * kontrolü (acil iptal, docs/24 §7.2). Korunan controller'lara @UseGuards ile uygulanır.
 */
@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(
    private readonly signer: TokenSigner,
    private readonly blacklist: JtiBlacklistService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest<AuthedRequest>();
    const header = req.header('authorization');
    if (!header?.startsWith('Bearer ')) {
      throw new AppProblem('invalid-token', 'Authorization başlığı eksik.');
    }
    const principal = await this.signer.verifyAccess(header.slice('Bearer '.length));
    if (await this.blacklist.isBlocked(principal.jti)) {
      throw new AppProblem('invalid-token', 'Oturum kapatıldı.');
    }
    req.principal = principal;
    return true;
  }
}
