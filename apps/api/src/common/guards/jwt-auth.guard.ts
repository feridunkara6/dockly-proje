import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';
import { TokenSigner } from '../../infrastructure/jwt/token.signer';
import { AppProblem } from '../problem/problem';
import { Principal } from '../../core/auth/principal';

/** Request'e iliştirilen principal alanı. */
export interface AuthedRequest extends Request {
  principal?: Principal;
}

/**
 * Bearer access token doğrulaması (docs/24 §7.1) — lokal public key, ağ çağrısı yok.
 * Korunan controller'lara @UseGuards(JwtAuthGuard) ile uygulanır.
 */
@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(private readonly signer: TokenSigner) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest<AuthedRequest>();
    const header = req.header('authorization');
    if (!header?.startsWith('Bearer ')) {
      throw new AppProblem('invalid-token', 'Authorization başlığı eksik.');
    }
    req.principal = await this.signer.verifyAccess(header.slice('Bearer '.length));
    return true;
  }
}
