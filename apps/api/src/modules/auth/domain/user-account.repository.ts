import { FirebaseIdentity } from '../../../infrastructure/firebase/firebase-token.verifier';
import { UserAccount } from './auth.types';

/**
 * Kimlik köprüsünün users erişimi: upsert + misafir yükseltme (docs/23 §3.3).
 * firebase_uid sabit kimlik anahtarıdır; misafir→kayıtlı geçişte satır AYNI kalır.
 */
export interface UserAccountRepository {
  upsertFromIdentity(id: string, identity: FirebaseIdentity): Promise<UserAccount>;
  /** Refresh rotasyonu için: aktif (silinmemiş/askıya alınmamış) hesabı okur. */
  findActiveById(id: string): Promise<UserAccount | null>;
}

export const USER_ACCOUNT_REPOSITORY = Symbol('USER_ACCOUNT_REPOSITORY');
