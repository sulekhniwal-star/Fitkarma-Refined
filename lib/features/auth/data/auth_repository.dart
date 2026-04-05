import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/appwrite_service.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Account _account;

  AuthRepository(this._account);

  /// Gets currently logged in user info.
  Future<models.User> getCurrentUser() async {
    return await _account.get();
  }

  /// Logs in a user with email and password.
  Future<models.Session> login({
    required String email,
    required String password,
  }) async {
    return await _account.createEmailPasswordSession(
      email: email,
      password: password,
    );
  }

  /// Registers a new user.
  Future<models.User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final user = await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
    return user;
  }

  /// Logs out the current session.
  Future<void> logout() async {
    await _account.deleteSession(sessionId: 'current');
  }

  /// Request password recovery email.
  Future<void> recoverPassword(String email) async {
    // Note: redirectUrl should be handled properly in production
    await _account.createRecovery(
      email: email,
      url: 'https://fitkarma.com/reset-password', 
    );
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(appwriteAccountProvider));
}

/// A provider that exposes the current Appwrite User, or null if logged out.
@riverpod
Future<models.User?> currentUser(Ref ref) async {
  final repo = ref.watch(authRepositoryProvider);
  try {
    return await repo.getCurrentUser();
  } catch (e) {
    // Not logged in or network error
    return null;
  }
}

/// A provider that manages the authentication state (authenticated/unauthenticated/initial).
@riverpod
Stream<models.User?> authStateChanges(Ref ref) async* {
  final repo = ref.watch(authRepositoryProvider);
  // Initial check
  models.User? user;
  try {
    user = await repo.getCurrentUser();
  } catch (_) {
    user = null;
  }
  yield user;
  
  // Future: Use Appwrite Realtime to listen for session changes if needed
  // For now, we rely on manual login/logout to trigger ref.invalidate
}
