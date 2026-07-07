import { AsyncLocalStorage } from 'node:async_hooks';

/**
 * İstek bağlamı — AsyncLocalStorage ile taşınır (docs/24 §4: request-scope DI yasak).
 * requestId her log satırına ve Problem yanıtlarına otomatik iliştirilir (docs/23 §18).
 */
export interface RequestContext {
  requestId: string;
}

export const requestContextStorage = new AsyncLocalStorage<RequestContext>();

export function currentRequestId(): string | undefined {
  return requestContextStorage.getStore()?.requestId;
}
