import { ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AccountGuard, REQUIRE_ACCOUNT_KEY } from '../src/common/guards/account.guard';
import { AppProblem } from '../src/common/problem/problem';
import { Principal } from '../src/core/auth/principal';

function contextWith(principal: Principal | undefined, requireAccount?: boolean): ExecutionContext {
  const handler = (): void => undefined;
  if (requireAccount) {
    Reflect.defineMetadata(REQUIRE_ACCOUNT_KEY, true, handler);
  }
  return {
    getHandler: () => handler,
    getClass: () => class {},
    switchToHttp: () => ({ getRequest: () => ({ principal }) }),
  } as unknown as ExecutionContext;
}

function principalWith(isGuest: boolean): Principal {
  return { userId: 'u', role: 'user', isGuest, familyId: 'f', jti: 'j' };
}

describe('AccountGuard — misafir kısıtı (docs/12 §2.3)', () => {
  const guard = new AccountGuard(new Reflector());

  it('şart yoksa (RequireAccount metadata yok) herkesi geçirir — misafir dahil', () => {
    expect(guard.canActivate(contextWith(principalWith(true)))).toBe(true);
    expect(guard.canActivate(contextWith(principalWith(false)))).toBe(true);
  });

  it('RequireAccount varsa kayıtlı kullanıcı geçer', () => {
    expect(guard.canActivate(contextWith(principalWith(false), true))).toBe(true);
  });

  it('RequireAccount varsa misafir 403 guest-not-allowed fırlatır', () => {
    let thrown: unknown;
    try {
      guard.canActivate(contextWith(principalWith(true), true));
    } catch (e) {
      thrown = e;
    }
    expect(thrown).toBeInstanceOf(AppProblem);
    expect((thrown as AppProblem).problemType).toBe('guest-not-allowed');
    expect((thrown as AppProblem).status).toBe(403);
  });

  it('principal yoksa (guard sırası hatası) invalid-token fırlatır', () => {
    let thrown: unknown;
    try {
      guard.canActivate(contextWith(undefined, true));
    } catch (e) {
      thrown = e;
    }
    expect(thrown).toBeInstanceOf(AppProblem);
    expect((thrown as AppProblem).problemType).toBe('invalid-token');
  });
});
