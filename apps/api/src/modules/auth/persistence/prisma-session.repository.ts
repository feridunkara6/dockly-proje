import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../infrastructure/prisma/prisma.service';
import { CreateSessionInput, SessionRepository } from '../domain/session.repository';
import { SessionRecord } from '../domain/auth.types';

@Injectable()
export class PrismaSessionRepository implements SessionRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(input: CreateSessionInput): Promise<void> {
    await this.prisma.userSession.create({
      data: {
        id: input.id,
        userId: input.userId,
        familyId: input.familyId,
        tokenHash: input.tokenHash,
        expiresAt: input.expiresAt,
        rotatedFromId: input.rotatedFromId,
        ip: input.ip,
        userAgent: input.userAgent,
      },
    });
  }

  async findByTokenHash(tokenHash: string): Promise<SessionRecord | null> {
    const row = await this.prisma.userSession.findUnique({ where: { tokenHash } });
    if (!row) return null;
    return {
      id: row.id,
      userId: row.userId,
      familyId: row.familyId,
      expiresAt: row.expiresAt,
      revokedAt: row.revokedAt,
    };
  }

  async revoke(id: string): Promise<void> {
    await this.prisma.userSession.update({ where: { id }, data: { revokedAt: new Date() } });
  }

  async revokeFamily(familyId: string, reuseDetected: boolean): Promise<void> {
    const now = new Date();
    await this.prisma.userSession.updateMany({
      where: { familyId, revokedAt: null },
      data: { revokedAt: now, ...(reuseDetected ? { reuseDetectedAt: now } : {}) },
    });
  }

  async revokeAllForUser(userId: string): Promise<void> {
    await this.prisma.userSession.updateMany({
      where: { userId, revokedAt: null },
      data: { revokedAt: new Date() },
    });
  }

  async countActiveFamilies(userId: string): Promise<number> {
    const families = await this.prisma.userSession.groupBy({
      by: ['familyId'],
      where: { userId, revokedAt: null },
    });
    return families.length;
  }

  async findOldestActiveFamilyId(userId: string): Promise<string | null> {
    const oldest = await this.prisma.userSession.findFirst({
      where: { userId, revokedAt: null },
      orderBy: { issuedAt: 'asc' },
      select: { familyId: true },
    });
    return oldest?.familyId ?? null;
  }

  async listActiveSessionIds(userId: string): Promise<string[]> {
    const rows = await this.prisma.userSession.findMany({
      where: { userId, revokedAt: null },
      select: { id: true },
    });
    return rows.map((r) => r.id);
  }
}
