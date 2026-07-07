import { Body, Controller, Delete, HttpCode, Post, Req, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { z } from 'zod';
import { SessionService } from '../application/session.service';
import { RateLimiterService } from '../../../infrastructure/redis/rate-limiter.service';
import { EnvService } from '../../../config/env.service';
import { AppProblem } from '../../../common/problem/problem';
import { JwtAuthGuard } from '../../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../../common/decorators/current-user.decorator';
import { Principal } from '../../../core/auth/principal';
import { RequestMeta, SessionBundle } from '../domain/auth.types';

const createSessionSchema = z.object({ firebaseIdToken: z.string().min(20).max(4096) });
const refreshSchema = z.object({ refreshToken: z.string().min(20).max(256) });

const RATE_BUCKET = 'auth';
const RATE_WINDOW_SEC = 60;

/** docs/23 §3.4 — /v1/auth/sessions* uçları. Anonim uçlar IP bazlı rate limitlidir (docs/30 §1). */
@Controller('auth/sessions')
export class AuthController {
  private readonly maxPerMin: number;

  constructor(
    private readonly sessionService: SessionService,
    private readonly rateLimiter: RateLimiterService,
    env: EnvService,
  ) {
    this.maxPerMin = env.get('AUTH_RATE_LIMIT_PER_MIN');
  }

  @Post()
  @HttpCode(200)
  async createSession(@Body() body: unknown, @Req() req: Request): Promise<SessionBundle> {
    await this.enforceRate(req);
    const dto = createSessionSchema.parse(body);
    return this.sessionService.createSession(dto.firebaseIdToken, this.meta(req));
  }

  @Post('refresh')
  @HttpCode(200)
  async refresh(@Body() body: unknown, @Req() req: Request): Promise<SessionBundle> {
    await this.enforceRate(req);
    const dto = refreshSchema.parse(body);
    return this.sessionService.refreshSession(dto.refreshToken, this.meta(req));
  }

  @Delete()
  @HttpCode(204)
  async logout(@Body() body: unknown): Promise<void> {
    const dto = refreshSchema.parse(body);
    await this.sessionService.logout(dto.refreshToken);
  }

  @Delete('all')
  @HttpCode(204)
  @UseGuards(JwtAuthGuard)
  async logoutAll(@CurrentUser() principal: Principal): Promise<void> {
    await this.sessionService.logoutAll(principal.userId);
  }

  private async enforceRate(req: Request): Promise<void> {
    const decision = await this.rateLimiter.consume(
      RATE_BUCKET,
      req.ip ?? 'unknown',
      this.maxPerMin,
      RATE_WINDOW_SEC,
    );
    if (!decision.allowed) {
      throw new AppProblem('rate-limited', undefined, undefined, {
        'Retry-After': String(decision.retryAfterSec),
      });
    }
  }

  private meta(req: Request): RequestMeta {
    return { ip: req.ip, userAgent: req.header('user-agent')?.slice(0, 512) };
  }
}
