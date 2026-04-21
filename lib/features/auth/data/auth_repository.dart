import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/appwrite_client.dart';

/// Repository responsible for handling all authentication-related operations with Appwrite.
class AuthRepository {
  final Account _account;
  final FlutterSecureStorage _storage;

  AuthRepository({
    Account? account,
    FlutterSecureStorage? storage,
  })  : _account = account ?? AppwriteClient.account,
        _storage = storage ?? const FlutterSecureStorage();

  /// Logs in with email and password and stores the session JWT.
  Future<void> login(String email, String password) async {
    await _account.createEmailPasswordSession(
      email: email,
      password: password,
    );
    
    // Generate and store JWT for potentially authenticated background requests
    final jwt = await _account.createJWT();
    await _storage.write(key: 'session_jwt', value: jwt.jwt);
  }

  /// Registers a new user and then logs them in.
  Future<void> register(String email, String password, String name) async {
    await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
    await login(email, password);
  }

  /// Initiates Google OAuth2 login flow.
  Future<void> loginWithGoogle() async {
    await _account.createOAuth2Session(provider: OAuthProvider.google);
  }

  /// Deletes the current session and clears secure storage.
  Future<void> logout() async {
    await _account.deleteSession(sessionId: 'current');
    await _storage.delete(key: 'session_jwt');
  }

  /// Fetches the current authenticated user's details.
  Future<models.User> getUser() async {
    return await _account.get();
  }

  /// Checks if a valid user session exists.
  Future<bool> isLoggedIn() async {
    try {
      await getUser();
      return true;
    } on AppwriteException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Refreshes the current session.
  Future<void> refreshSession() async {
    await _account.updateSession(sessionId: 'current');
  }

  /// Sends a password reset email.
  Future<void> sendPasswordReset(String email) async {
    await _account.createRecovery(
      email: email,
      url: 'https://fitkarma.app/reset-password',
    );
  }
}

