import { RoleCode } from '../../../core/auth/principal';

/** Oturum açma/yenileme sonucunda istemciye dönen paket (docs/23 §3.1). */
export interface SessionBundle {
  accessToken: string;
  /** Access token ömrü (saniye). */
  expiresIn: number;
  refreshToken: string;
  user: SessionUser;
}

export interface SessionUser {
  id: string;
  role: RoleCode;
  isGuest: boolean;
  locale: string;
}

/** users tablosunun auth bağlamında gereken dar görünümü. */
export interface UserAccount {
  id: string;
  firebaseUid: string;
  role: RoleCode;
  isGuest: boolean;
  locale: string;
  status: 'active' | 'suspended' | 'deleted';
}

/** user_sessions satırının domain görünümü (ADR-001). */
export interface SessionRecord {
  id: string;
  userId: string;
  familyId: string;
  expiresAt: Date;
  revokedAt: Date | null;
}

export interface RequestMeta {
  ip?: string;
  userAgent?: string;
}
