import { CanActivate, ExecutionContext, Injectable, SetMetadata } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AppProblem } from '../problem/problem';
import { RoleCode, roleAtLeast } from '../../core/auth/principal';
import { AuthedRequest } from './jwt-auth.guard';

export const MIN_ROLE_KEY = 'dockly:minRole';

/** Route için asgari rol (hiyerarşik — docs/23 §4.1). JwtAuthGuard'dan SONRA çalışır. */
export const MinRole = (role: RoleCode): MethodDecorator & ClassDecorator =>
  SetMetadata(MIN_ROLE_KEY, role);

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const required = this.reflector.getAllAndOverride<RoleCode | undefined>(MIN_ROLE_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (!required) return true;
    const { principal } = context.switchToHttp().getRequest<AuthedRequest>();
    if (!principal) throw new AppProblem('invalid-token');
    if (!roleAtLeast(principal.role, required)) throw new AppProblem('forbidden');
    return true;
  }
}
