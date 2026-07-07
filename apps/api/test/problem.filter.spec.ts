import { ArgumentsHost, HttpException, HttpStatus, Logger } from '@nestjs/common';
import { z } from 'zod';
import { GlobalProblemFilter } from '../src/common/problem/problem.filter';
import { AppProblem, ProblemBody } from '../src/common/problem/problem';

interface Captured {
  status?: number;
  contentType?: string;
  body?: ProblemBody;
}

function hostWith(url = '/v1/test'): { host: ArgumentsHost; out: Captured } {
  const out: Captured = {};
  const res = {
    status(code: number) {
      out.status = code;
      return this;
    },
    type(ct: string) {
      out.contentType = ct;
      return this;
    },
    json(body: ProblemBody) {
      out.body = body;
      return this;
    },
  };
  const host = {
    switchToHttp: () => ({
      getResponse: () => res,
      getRequest: () => ({ originalUrl: url }),
    }),
  } as unknown as ArgumentsHost;
  return { host, out };
}

describe('GlobalProblemFilter (RFC 9457 tek çıkış kapısı, docs/24 §14)', () => {
  const filter = new GlobalProblemFilter();

  beforeAll(() => {
    Logger.overrideLogger(false);
  });

  it('AppProblem kataloglu type ve status ile döner', () => {
    const { host, out } = hostWith('/v1/reviews');
    filter.catch(new AppProblem('duplicate-review'), host);
    expect(out.status).toBe(409);
    expect(out.contentType).toBe('application/problem+json');
    expect(out.body?.type).toBe('https://api.dockly.app/problems/duplicate-review');
    expect(out.body?.instance).toBe('/v1/reviews');
  });

  it('ZodError 422 validation-error + errors[] alan listesine dönüşür', () => {
    const schema = z.object({ checkInOn: z.string().min(10) });
    const parsed = schema.safeParse({ checkInOn: 'x' });
    if (parsed.success) throw new Error('test kurgusu hatalı');
    const { host, out } = hostWith();
    filter.catch(parsed.error, host);
    expect(out.status).toBe(422);
    expect(out.body?.errors?.[0]?.field).toBe('checkInOn');
  });

  it('HttpException kendi status kodunu korur (503 readiness senaryosu)', () => {
    const { host, out } = hostWith('/readyz');
    filter.catch(new HttpException('Hazır değil', HttpStatus.SERVICE_UNAVAILABLE), host);
    expect(out.status).toBe(503);
    expect(out.body?.type).toBe('about:blank');
  });

  it('404 HttpException kataloglu not-found type alır', () => {
    const { host, out } = hostWith();
    filter.catch(new HttpException('Yok', HttpStatus.NOT_FOUND), host);
    expect(out.status).toBe(404);
    expect(out.body?.type).toBe('https://api.dockly.app/problems/not-found');
  });

  it('bilinmeyen hata 500 internal olarak maskelenir, detay sızdırmaz', () => {
    const { host, out } = hostWith();
    filter.catch(new Error('gizli iç detay: db şifresi'), host);
    expect(out.status).toBe(500);
    expect(out.body?.type).toBe('https://api.dockly.app/problems/internal');
    expect(JSON.stringify(out.body)).not.toContain('gizli iç detay');
  });

  it('sorgu parametresi instance yolundan temizlenir', () => {
    const { host, out } = hostWith('/v1/locations?bbox=1,2,3,4');
    filter.catch(new AppProblem('not-found'), host);
    expect(out.body?.instance).toBe('/v1/locations');
  });
});
