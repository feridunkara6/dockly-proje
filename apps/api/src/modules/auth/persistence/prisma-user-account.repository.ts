import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../infrastructure/prisma/prisma.service';
import { FirebaseIdentity } from '../../../infrastructure/firebase/firebase-token.verifier';
import { UserAccountRepository } from '../domain/user-account.repository';
import { UserAccount } from '../domain/auth.types';
import { RoleCode } from '../../../core/auth/principal';
import { AppProblem } from '../../../common/problem/problem';

@Injectable()
export class PrismaUserAccountRepository implements UserAccountRepository {
  constructor(private readonly prisma: PrismaService) {}

  async upsertFromIdentity(id: string, identity: FirebaseIdentity): Promise<UserAccount> {
    const now = new Date();
    const isGuestLogin = identity.provider === 'anonymous';

    const existing = await this.prisma.user.findUnique({
      where: { firebaseUid: identity.uid },
      include: { role: true },
    });

    if (existing) {
      if (existing.status === 'suspended' || existing.deletedAt !== null) {
        throw new AppProblem('forbidden', 'Hesap kullanıma kapalı.');
      }
      const updated = await this.prisma.user.update({
        where: { id: existing.id },
        data: {
          lastSignInAt: now,
          // Misafir → kayıtlı yükseltme: firebase_uid sabit, satır aynı (docs/23 §3.3).
          isGuest: existing.isGuest && !isGuestLogin ? false : existing.isGuest,
          email: identity.email ?? existing.email,
          emailVerifiedAt:
            identity.emailVerified && existing.emailVerifiedAt === null
              ? now
              : existing.emailVerifiedAt,
          phone: identity.phone ?? existing.phone,
          // Firebase phone sağlayıcısı numarayı doğrulamış demektir (docs/29 SEC-17 temeli).
          phoneVerifiedAt:
            identity.phone && existing.phoneVerifiedAt === null ? now : existing.phoneVerifiedAt,
        },
        include: { role: true },
      });
      return this.toAccount(updated.id, updated.firebaseUid, updated.role.code, updated);
    }

    const created = await this.prisma.user.create({
      data: {
        id,
        firebaseUid: identity.uid,
        email: identity.email,
        emailVerifiedAt: identity.emailVerified ? now : null,
        phone: identity.phone,
        phoneVerifiedAt: identity.phone ? now : null,
        isGuest: isGuestLogin,
        lastSignInAt: now,
      },
      include: { role: true },
    });
    return this.toAccount(created.id, created.firebaseUid, created.role.code, created);
  }

  async findActiveById(id: string): Promise<UserAccount | null> {
    const row = await this.prisma.user.findFirst({
      where: { id, status: 'active', deletedAt: null },
      include: { role: true },
    });
    if (!row) return null;
    return this.toAccount(row.id, row.firebaseUid, row.role.code, row);
  }

  private toAccount(
    id: string,
    firebaseUid: string,
    roleCode: string,
    row: { isGuest: boolean; locale: string; status: string },
  ): UserAccount {
    return {
      id,
      firebaseUid,
      role: roleCode as RoleCode,
      isGuest: row.isGuest,
      locale: row.locale,
      status: row.status as UserAccount['status'],
    };
  }
}
