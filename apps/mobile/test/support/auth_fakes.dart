import 'package:dockly_api/dockly_api.dart';
import 'package:dockly_core/dockly_core.dart';
import 'package:dockly_mobile/features/auth/data/auth_repository.dart';
import 'package:dockly_mobile/features/auth/domain/auth_gateway.dart';

const SessionUser testUser = SessionUser(id: 'u1', role: 'user', isGuest: false, locale: 'tr');
const SessionUser testGuest = SessionUser(id: 'g1', role: 'user', isGuest: true, locale: 'tr');

/// Testte AuthRepository yerine geçen sahte (yalnız testte mock kuralı, docs/15).
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.restoreResult, this.signInResult = testUser, this.signInError});

  SessionUser? restoreResult;
  SessionUser signInResult;
  AppFailure? signInError;

  final List<AuthProviderKind> signInCalls = <AuthProviderKind>[];
  bool loggedOut = false;

  @override
  Future<SessionUser> signIn(AuthProviderKind kind) async {
    signInCalls.add(kind);
    final error = signInError;
    if (error != null) throw error;
    return signInResult;
  }

  @override
  Future<SessionUser?> restore() async => restoreResult;

  @override
  Future<void> logout() async {
    loggedOut = true;
  }
}
