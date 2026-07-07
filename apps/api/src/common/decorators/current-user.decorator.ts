import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { AppProblem } from '../problem/problem';
import { Principal } from '../../core/auth/principal';
import { AuthedRequest } from '../guards/jwt-auth.guard';

/** Controller parametresi olarak doğrulanmış Principal (JwtAuthGuard şartı). */
export const CurrentUser = createParamDecorator((_data: unknown, ctx: ExecutionContext): Principal => {
  const { principal } = ctx.switchToHttp().getRequest<AuthedRequest>();
  if (!principal) throw new AppProblem('invalid-token');
  return principal;
});
