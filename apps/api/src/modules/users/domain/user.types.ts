import { RoleCode } from '../../../core/auth/principal';

/** GET /v1/users/me yanıt modeli (docs/23 §10 #4). */
export interface UserMe {
  id: string;
  email: string | null;
  phone: string | null;
  role: RoleCode;
  isGuest: boolean;
  locale: string;
  countryCode: string;
  createdAt: string;
  profile: {
    displayName: string;
    fullName: string | null;
    bio: string | null;
    experienceYears: number | null;
  };
  settings: {
    theme: 'system' | 'light' | 'dark';
    units: 'metric' | 'imperial';
    marketingConsent: boolean;
  };
}

/** PATCH /v1/users/me girişi — JSON Merge Patch alt kümesi; alan beyaz listesi (SEC). */
export interface UpdateMeInput {
  locale?: 'tr' | 'en';
  profile?: {
    displayName?: string;
    fullName?: string | null;
    bio?: string | null;
    experienceYears?: number | null;
  };
  settings?: {
    theme?: 'system' | 'light' | 'dark';
    units?: 'metric' | 'imperial';
    marketingConsent?: boolean;
  };
}
