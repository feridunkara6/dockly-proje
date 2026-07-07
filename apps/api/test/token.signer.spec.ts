import { EnvService } from '../src/config/env.service';
import { TokenSigner } from '../src/infrastructure/jwt/token.signer';
import { Principal } from '../src/core/auth/principal';
import { generateTestKeys } from './helpers/auth-test-kit';

const PRINCIPAL: Principal = {
  userId: '0198a000-0000-7000-8000-000000000001',
  role: 'user',
  isGuest: false,
  familyId: '0198a000-0000-7000-8000-0000000000f1',
  jti: '0198a000-0000-7000-8000-0000000000a1',
};

describe('TokenSigner (RS256, docs/23 §3.2 + SEC-10/11)', () => {
  let signer: TokenSigner;

  beforeAll(() => {
    const keys = generateTestKeys();
    process.env.NODE_ENV = 'test';
    process.env.DATABASE_URL = 'postgresql://t:t@localhost:5432/t';
    process.env.REDIS_URL = 'redis://localhost:6379';
    process.env.FIREBASE_PROJECT_ID = 'dockly-test';
    process.env.JWT_PRIVATE_KEY_PEM = keys.privatePem;
    process.env.JWT_PUBLIC_KEY_PEM = keys.publicPem;
    signer = new TokenSigner(new EnvService());
  });

  it('imzalar ve doğrular; claim seti principal ile birebir', async () => {
    const token = await signer.signAccess(PRINCIPAL);
    const decoded = await signer.verifyAccess(token);
    expect(decoded).toEqual(PRINCIPAL);
  });

  it('gövdesi kurcalanan token reddedilir', async () => {
    const token = await signer.signAccess(PRINCIPAL);
    const [h, p, s] = token.split('.');
    const tamperedPayload = Buffer.from(
      JSON.stringify({
        ...JSON.parse(Buffer.from(p, 'base64url').toString()),
        role: 'super_admin',
      }),
    ).toString('base64url');
    await expect(signer.verifyAccess(`${h}.${tamperedPayload}.${s}`)).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
  });

  it('farklı anahtarla imzalanmış token reddedilir', async () => {
    const otherKeys = generateTestKeys();
    process.env.JWT_PRIVATE_KEY_PEM = otherKeys.privatePem;
    process.env.JWT_PUBLIC_KEY_PEM = otherKeys.publicPem;
    const otherSigner = new TokenSigner(new EnvService());
    const foreignToken = await otherSigner.signAccess(PRINCIPAL);
    await expect(signer.verifyAccess(foreignToken)).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
  });

  it('düz metin/bozuk girdi invalid-token döner (edge)', async () => {
    await expect(signer.verifyAccess('bozuk.token.degeri')).rejects.toMatchObject({
      problemType: 'invalid-token',
    });
    await expect(signer.verifyAccess('')).rejects.toMatchObject({ problemType: 'invalid-token' });
  });
});
