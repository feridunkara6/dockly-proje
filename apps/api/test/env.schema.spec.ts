import { validateEnv } from '../src/config/env.schema';

const VALID: NodeJS.ProcessEnv = {
  NODE_ENV: 'test',
  DATABASE_URL: 'postgresql://user:pass@localhost:5432/db',
  REDIS_URL: 'redis://localhost:6379',
};

describe('validateEnv (fail-fast, docs/24 §16)', () => {
  it('geçerli ortamı tipli döndürür ve varsayılanları uygular', () => {
    const env = validateEnv(VALID);
    expect(env.PORT).toBe(3000);
    expect(env.LOG_LEVEL).toBe('info');
    expect(env.SHUTDOWN_TIMEOUT_MS).toBe(10_000);
  });

  it('DATABASE_URL eksikse anlaşılır hatayla düşer', () => {
    const { DATABASE_URL: _omitted, ...rest } = VALID;
    expect(() => validateEnv(rest)).toThrow(/DATABASE_URL/);
  });

  it('postgresql:// olmayan DATABASE_URL reddedilir', () => {
    expect(() => validateEnv({ ...VALID, DATABASE_URL: 'mysql://x:y@h/db' })).toThrow(
      /DATABASE_URL/,
    );
  });

  it('geçersiz PORT reddedilir (edge: 0 ve 65536)', () => {
    expect(() => validateEnv({ ...VALID, PORT: '0' })).toThrow(/PORT/);
    expect(() => validateEnv({ ...VALID, PORT: '65536' })).toThrow(/PORT/);
  });

  it('bilinmeyen NODE_ENV reddedilir', () => {
    expect(() => validateEnv({ ...VALID, NODE_ENV: 'qa' })).toThrow(/NODE_ENV/);
  });
});
