import { ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { MIN_ROLE_KEY, RolesGuard } from '../src/common/guards/roles.guard';
import { Principal, RoleCode, roleAtLeast } from '../src/core/auth/principal';

function contextWith(principal: Principal | undefined, minRole?: RoleCode): ExecutionContext {
  const handler = (): void => undefined;
  if (minRole) {
    Reflect.defineMetadata(MIN_ROLE_KEY, minRole, handler);
  }
  return {
    getHandler: () => handler,
    getClass: () => class {},
    switchToHttp: () => ({ getRequest: () => ({ principal }) }),
  } as unknown as ExecutionContext;
}

function principalWith(role: RoleCode): Principal {
  return { userId: 'u', role, isGuest: false, familyId: 'f', jti: 'j' };
}

describe('RolesGuard + rol hiyerarşisi (docs/23 §4.1)', () => {
  const guard = new RolesGuard(new Reflector());

  it('rol şartı yoksa geçirir', () => {
    expect(guard.canActivate(contextWith(principalWith('user')))).toBe(true);
  });

  it('hiyerarşi: admin, moderator gerektiren yeri geçer; user geçemez', () => {
    expect(guard.canActivate(contextWith(principalWith('admin'), 'moderator'))).toBe(true);
    expect(() => guard.canActivate(contextWith(principalWith('user'), 'moderator'))).toThrow();
  });

  it('principal yoksa (guard sırası hatası) invalid-token fırlatır', () => {
    expect(() => guard.canActivate(contextWith(undefined, 'user'))).toThrow();
  });

  it('roleAtLeast sıralaması doğru (edge: eşitlik)', () => {
    expect(roleAtLeast('moderator', 'moderator')).toBe(true);
    expect(roleAtLeast('super_admin', 'admin')).toBe(true);
    expect(roleAtLeast('user', 'super_admin')).toBe(false);
  });
});
