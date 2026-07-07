import { Request, Response } from 'express';
import { RequestContextMiddleware } from '../src/common/context/request-context.middleware';
import { currentRequestId } from '../src/common/context/request-context';

function fakeReqRes(incomingId?: string): {
  req: Request;
  res: Response;
  headers: Record<string, string>;
} {
  const headers: Record<string, string> = {};
  const req = {
    header: (name: string) => (name.toLowerCase() === 'x-request-id' ? incomingId : undefined),
  } as unknown as Request;
  const res = {
    setHeader: (k: string, v: string) => {
      headers[k.toLowerCase()] = v;
    },
  } as unknown as Response;
  return { req, res, headers };
}

describe('RequestContextMiddleware (docs/24 §12)', () => {
  const middleware = new RequestContextMiddleware();

  it("id üretir, yanıt header'ına yazar ve ALS içinde erişilir kılar", () => {
    const { req, res, headers } = fakeReqRes();
    let seen: string | undefined;
    middleware.use(req, res, () => {
      seen = currentRequestId();
    });
    expect(seen).toBeDefined();
    expect(headers['x-request-id']).toBe(seen);
  });

  it('güvenli formatta gelen X-Request-Id korunur (korelasyon)', () => {
    const { req, res } = fakeReqRes('client-abc-12345');
    let seen: string | undefined;
    middleware.use(req, res, () => {
      seen = currentRequestId();
    });
    expect(seen).toBe('client-abc-12345');
  });

  it('şüpheli format (log injection) reddedilir, yenisi üretilir', () => {
    const { req, res } = fakeReqRes('evil\nid');
    let seen: string | undefined;
    middleware.use(req, res, () => {
      seen = currentRequestId();
    });
    expect(seen).not.toContain('\n');
    expect(seen).toMatch(/^[0-9a-f-]{36}$/);
  });

  it('bağlam istek dışında sızmaz', () => {
    expect(currentRequestId()).toBeUndefined();
  });
});
