import { SessionRecord, RequestMeta } from './auth.types';

export interface CreateSessionInput extends RequestMeta {
  id: string;
  userId: string;
  familyId: string;
  tokenHash: string;
  expiresAt: Date;
  rotatedFromId?: string;
}

/** Refresh token deposu sözleşmesi (ADR-001; implementasyon: persistence). */
export interface SessionRepository {
  create(input: CreateSessionInput): Promise<void>;
  /** Hash ile satırı bulur — iptal/rotasyon durumuna bakılmaksızın (reuse tespiti için). */
  findByTokenHash(tokenHash: string): Promise<SessionRecord | null>;
  revoke(id: string): Promise<void>;
  /** Reuse tespitinde tüm aile düşürülür ve olay işaretlenir (docs/23 §3.2). */
  revokeFamily(familyId: string, reuseDetected: boolean): Promise<void>;
  revokeAllForUser(userId: string): Promise<void>;
}

export const SESSION_REPOSITORY = Symbol('SESSION_REPOSITORY');
