import { CanActivate, ExecutionContext, Injectable, SetMetadata } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AppProblem } from '../problem/problem';
import { AuthedRequest } from './jwt-auth.guard';

export const REQUIRE_ACCOUNT_KEY = 'dockly:requireAccount';

/**
 * Route/controller yalnız kayıtlı (misafir olmayan) kullanıcıya açıktır (docs/12 §2.3,
 * docs/01-prd §5.3 "kayıt duvarı"). Misafir (anonim Firebase) oturum, keşif uçlarını
 * kullanabilir ama yazma/hesap uçlarına erişemez. JwtAuthGuard'dan SONRA çalışır.
 */
export const RequireAccount = (): MethodDecorator & ClassDecorator =>
  SetMetadata(REQUIRE_ACCOUNT_KEY, true);

@Injectable()
export class AccountGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const required = this.reflector.getAllAndOverride<boolean | undefined>(REQUIRE_ACCOUNT_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (!required) return true;
    const { principal } = context.switchToHttp().getRequest<AuthedRequest>();
    if (!principal) throw new AppProblem('invalid-token');
    if (principal.isGuest) {
      throw new AppProblem(
        'guest-not-allowed',
        'Bu işlem için hesabınızla giriş yapmalısınız.',
      );
    }
    return true;
  }
}
