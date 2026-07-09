import {
  DEFAULT_REVIEWS_LIMIT,
  MAX_REVIEWS_LIMIT,
  parseReviewsLimit,
} from '../src/modules/locations/domain/reviews';

describe('parseReviewsLimit (yorum-listesi limiti)', () => {
  it('yok/boş → varsayılan', () => {
    expect(parseReviewsLimit(undefined)).toBe(DEFAULT_REVIEWS_LIMIT);
    expect(parseReviewsLimit('')).toBe(DEFAULT_REVIEWS_LIMIT);
    expect(parseReviewsLimit('   ')).toBe(DEFAULT_REVIEWS_LIMIT);
  });

  it('geçersiz/aralık-dışı → varsayılana kelepçelenir', () => {
    expect(parseReviewsLimit('0')).toBe(DEFAULT_REVIEWS_LIMIT);
    expect(parseReviewsLimit('abc')).toBe(DEFAULT_REVIEWS_LIMIT);
    expect(parseReviewsLimit('2.5')).toBe(DEFAULT_REVIEWS_LIMIT);
    expect(parseReviewsLimit(String(MAX_REVIEWS_LIMIT + 1))).toBe(DEFAULT_REVIEWS_LIMIT);
  });

  it('geçerli limit korunur', () => {
    expect(parseReviewsLimit('5')).toBe(5);
    expect(parseReviewsLimit(String(MAX_REVIEWS_LIMIT))).toBe(MAX_REVIEWS_LIMIT);
  });
});
