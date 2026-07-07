import { Body, Controller, Delete, Get, HttpCode, Patch, Req, UseGuards } from '@nestjs/common';
import { z } from 'zod';
import { UsersService } from '../application/users.service';
import { AuthedRequest, JwtAuthGuard } from '../../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../../common/decorators/current-user.decorator';
import { currentRequestId } from '../../../common/context/request-context';
import { Principal } from '../../../core/auth/principal';
import { UserMe } from '../domain/user.types';

/**
 * PATCH beyaz listesi (docs/24 §7.3 mass-assignment önlemi): yalnız bu alanlar.
 * strict(): bilinmeyen alan 422 — role/status/email gibi alanlar istemciden ASLA.
 */
const patchMeSchema = z
  .object({
    locale: z.enum(['tr', 'en']).optional(),
    profile: z
      .object({
        displayName: z.string().trim().min(2).max(50).optional(),
        fullName: z.string().trim().min(2).max(100).nullable().optional(),
        bio: z.string().trim().max(500).nullable().optional(),
        experienceYears: z.number().int().min(0).max(80).nullable().optional(),
      })
      .strict()
      .optional(),
    settings: z
      .object({
        theme: z.enum(['system', 'light', 'dark']).optional(),
        units: z.enum(['metric', 'imperial']).optional(),
        marketingConsent: z.boolean().optional(),
      })
      .strict()
      .optional(),
  })
  .strict();

@Controller('users/me')
@UseGuards(JwtAuthGuard)
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async getMe(@CurrentUser() principal: Principal): Promise<UserMe> {
    return this.usersService.getMe(principal);
  }

  @Patch()
  async updateMe(@CurrentUser() principal: Principal, @Body() body: unknown): Promise<UserMe> {
    const patch = patchMeSchema.parse(body);
    return this.usersService.updateMe(principal, patch);
  }

  @Delete()
  @HttpCode(204)
  async deleteMe(@CurrentUser() principal: Principal, @Req() req: AuthedRequest): Promise<void> {
    await this.usersService.deleteMe(principal, {
      ip: req.ip,
      requestId: currentRequestId(),
    });
  }
}
