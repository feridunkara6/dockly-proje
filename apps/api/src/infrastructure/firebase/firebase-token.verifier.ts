import { Injectable } from '@nestjs/common';
import { createRemoteJWKSet, jwtVerify } from 'jose';
import { EnvService } from '../../config/env.service';
import { AppProblem } from '../../common/problem/problem';

/** Firebase ID token'ından türetilen kimlik (docs/23 §3.1). */
export interface FirebaseIdentity {
  uid: string;
  email?: string;
  emailVerified: boolean;
  phone?: string;
  /** 'anonymous' = misafir modu (docs/23 §3.3). */
  provider: string;
}

export interface FirebaseTokenVerifier {
  verify(idToken: string): Promise<FirebaseIdentity>;
}

/** DI token'ı — testlerde sahte doğrulayıcı ile değiştirilir (yalnız testte mock kuralı). */
export const FIREBASE_TOKEN_VERIFIER = Symbol('FIREBASE_TOKEN_VERIFIER');

const FIREBASE_JWKS_URL =
  'https://www.googleapis.com/robot/v1/metadata/jwk/securetoken@system.gserviceaccount.com';

interface FirebaseClaims {
  email?: string;
  email_verified?: boolean;
  phone_number?: string;
  firebase?: { sign_in_provider?: string };
}

/**
 * Google JWKS ile Firebase ID token doğrulaması (docs/24 §7.1):
 * imza + aud=projectId + iss pinning. firebase-admin bağımlılığı bilinçli olarak
 * alınmadı (MVP sadelik; FCM ihtiyacı Faz 5'te ayrıca değerlendirilir).
 */
@Injectable()
export class GoogleJwksFirebaseVerifier implements FirebaseTokenVerifier {
  private readonly jwks = createRemoteJWKSet(new URL(FIREBASE_JWKS_URL));
  private readonly projectId: string;

  constructor(env: EnvService) {
    this.projectId = env.get('FIREBASE_PROJECT_ID');
  }

  async verify(idToken: string): Promise<FirebaseIdentity> {
    try {
      const { payload } = await jwtVerify(idToken, this.jwks, {
        algorithms: ['RS256'],
        audience: this.projectId,
        issuer: `https://securetoken.google.com/${this.projectId}`,
      });
      if (typeof payload.sub !== 'string' || payload.sub.length === 0) {
        throw new AppProblem('invalid-token');
      }
      const claims = payload as FirebaseClaims;
      return {
        uid: payload.sub,
        email: claims.email,
        emailVerified: claims.email_verified === true,
        phone: claims.phone_number,
        provider: claims.firebase?.sign_in_provider ?? 'unknown',
      };
    } catch (err) {
      if (err instanceof AppProblem) throw err;
      throw new AppProblem('invalid-token', 'Firebase kimliği doğrulanamadı.');
    }
  }
}
