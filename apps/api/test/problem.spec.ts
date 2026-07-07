import { AppProblem } from '../src/common/problem/problem';

describe('AppProblem (RFC 9457 kataloğu, docs/23 §5)', () => {
  it('katalogdaki status ile eşleşir', () => {
    expect(new AppProblem('guest-not-allowed').status).toBe(403);
    expect(new AppProblem('duplicate-review').status).toBe(409);
    expect(new AppProblem('validation-error').status).toBe(422);
    expect(new AppProblem('rate-limited').status).toBe(429);
    expect(new AppProblem('internal').status).toBe(500);
  });

  it('toBody type URI, instance ve requestId üretir', () => {
    const body = new AppProblem('not-found', 'Lokasyon yok').toBody('/v1/locations/x', 'req-1');
    expect(body).toMatchObject({
      type: 'https://api.dockly.app/problems/not-found',
      status: 404,
      detail: 'Lokasyon yok',
      instance: '/v1/locations/x',
      requestId: 'req-1',
    });
  });

  it('alan hataları errors[] olarak taşınır, boşsa alan hiç yazılmaz', () => {
    const withErrors = new AppProblem('validation-error', undefined, [
      { field: 'checkOutOn', code: 'date_order', message: 'Çıkış girişten sonra olmalı' },
    ]).toBody();
    expect(withErrors.errors).toHaveLength(1);
    const without = new AppProblem('validation-error').toBody();
    expect(without.errors).toBeUndefined();
  });
});
