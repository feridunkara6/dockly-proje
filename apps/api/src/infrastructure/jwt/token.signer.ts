import { Injectable } from '@nestjs/common';
import { SignJWT, jwtVerify, importPKCS8, importSPKI, KeyLike, errors } from 'jose';
import { EnvService } from '../../config/env.service';
import { Principal, RoleCode } from '../../core/auth/principal';
import { AppProblem } from '../../common/problem/problem';

const ALG = 'RS256';
const ISSUER = 'https://auth.dockly.app';
const AUDIENCE = 'api.dockly.app';
/** Saat kayması toleransı (docs/23 §4 denetim notu SEC-11). */
const CLOCK_TOLERANCE_SEC = 60;

/**
 * Dockly access token imzalama/doğrulama (docs/23 §3.2, docs/24 §7.1).
 * Doğrulama algoritmayı RS256'ya SABİTLER (alg karışıklığı saldırısına kapalı — SEC-10).
 */
@Injectable()
export class TokenSigner {
  private privateKey!: KeyLike;
  private publicKey!: KeyLike;
  private readonly kid: string;
  private readonly ttlSec: number;
  private ready: Promise<void>;

  constructor(env: EnvService) {
    this.kid = env.get('JWT_KID');
    this.ttlSec = env.get('ACCESS_TOKEN_TTL_SEC');
    this.ready = this.importKeys(env.get('JWT_PRIVATE_KEY_PEM'), env.get('JWT_PUBLIC_KEY_PEM'));
  }

  private async importKeys(privatePem: string, publicPem: string): Promise<void> {
    this.privateKey = await importPKCS8(privatePem, ALG);
    this.publicKey = await importSPKI(publicPem, ALG);
  }

  get accessTtlSec(): number {
    return this.ttlSec;
  }

  async signAccess(principal: Principal): Promise<string> {
    await this.ready;
    return new SignJWT({
      role: principal.role,
      guest: principal.isGuest,
      fam: principal.familyId,
      ver: 1,
    })
      .setProtectedHeader({ alg: ALG, kid: this.kid })
      .setSubject(principal.userId)
      .setJti(principal.jti)
      .setIssuer(ISSUER)
      .setAudience(AUDIENCE)
      .setIssuedAt()
      .setExpirationTime(Math.floor(Date.now() / 1000) + this.ttlSec)
      .sign(this.privateKey);
  }

  async verifyAccess(token: string): Promise<Principal> {
    await this.ready;
    try {
      const { payload } = await jwtVerify(token, this.publicKey, {
        algorithms: [ALG],
        issuer: ISSUER,
        audience: AUDIENCE,
        clockTolerance: CLOCK_TOLERANCE_SEC,
      });
      if (
        typeof payload.sub !== 'string' ||
        typeof payload.role !== 'string' ||
        typeof payload.fam !== 'string' ||
        typeof payload.jti !== 'string'
      ) {
        throw new AppProblem('invalid-token');
      }
      return {
        userId: payload.sub,
        role: payload.role as RoleCode,
        isGuest: payload.guest === true,
        familyId: payload.fam,
        jti: payload.jti,
      };
    } catch (err) {
      if (err instanceof AppProblem) throw err;
      if (err instanceof errors.JWTExpired) throw new AppProblem('token-expired');
      throw new AppProblem('invalid-token');
    }
  }
}
