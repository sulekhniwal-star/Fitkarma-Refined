// lib/features/auth/application/auth_service.dart
import 'package:appwrite/enums.dart' show OAuthProvider;
import 'package:appwrite/models.dart' as models;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/auth_repository.dart';
import '../../../core/di/providers.dart';

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  @override
  void build() {}

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  /// Logs in with email and password.
  Future<models.Session> login(String email, String password) async {
    final session = await _repo.login(email: email, password: password);
    // Invalidate auth state to trigger UI updates
    ref.invalidate(authStateChangesProvider);
    ref.invalidate(currentUserProvider);
    return session;
  }

  /// Registers a new user and automatically logs them in.
  Future<models.User> register(String email, String password, String name) async {
    final user = await _repo.register(email: email, password: password, name: name);
    // After registration, log in
    await login(email, password);
    return user;
  }

  /// Initiates Google OAuth2 login via Appwrite.
  Future<void> loginWithGoogle() async {
    final account = ref.read(accountProvider);
    await account.createOAuth2Session(provider: OAuthProvider.google);
    ref.invalidate(authStateChangesProvider);
  }

  /// Initiates Apple OAuth2 login via Appwrite.
  Future<void> loginWithApple() async {
    final account = ref.read(accountProvider);
    try {
      await account.createOAuth2Session(provider: OAuthProvider.apple);
      ref.invalidate(authStateChangesProvider);
    } catch (e) {
      // Handle or rethrow
      rethrow;
    }
  }

  /// Logs out the current session.
  Future<void> logout() async {
    await _repo.logout();
    ref.invalidate(authStateChangesProvider);
    ref.invalidate(currentUserProvider);
  }

  /// Sends a password reset email.
  Future<void> resetPassword(String email) async {
    await _repo.recoverPassword(email);
  }
}
