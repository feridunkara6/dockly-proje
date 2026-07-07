/**
 * Kimliği doğrulanmış çağıranın temsil biçimi (docs/23 §3.2 claim seti).
 * PII taşımaz; her katman yetki kararını bu nesneden okur.
 */
export interface Principal {
  userId: string;
  role: RoleCode;
  isGuest: boolean;
  /** Oturum ailesi — logout tek aileyi düşürür (docs/23 §3.4). */
  familyId: string;
  /** Token kimliği — acil iptal (blacklist) anahtarı (docs/24 §7.2). */
  jti: string;
}

export type RoleCode = 'user' | 'moderator' | 'admin' | 'super_admin';

const ROLE_ORDER: Record<RoleCode, number> = {
  user: 0,
  moderator: 1,
  admin: 2,
  super_admin: 3,
};

export function roleAtLeast(actual: RoleCode, required: RoleCode): boolean {
  return ROLE_ORDER[actual] >= ROLE_ORDER[required];
}
