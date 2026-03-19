import 'dart:io';

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/network/appwrite_client.dart';

/// Appwrite Authentication Service
/// Handles email/password authentication, OAuth2 (Google, Apple), and session management
class AuthAwService {
  static const String _jwtKey = 'appwrite_session_jwt';
  static const String _userIdKey = 'appwrite_user_id';

  final FlutterSecureStorage _secureStorage;

  AuthAwService({FlutterSecureStorage? secureStorage})
    : _secureStorage =
          secureStorage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.first_unlock,
            ),
          );

  /// Get the Appwrite Account instance
  appwrite.Account get _account => AppwriteClient.account;

  /// Login with email and password
  /// Stores the JWT token in secure storage after successful login
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      // In Appwrite SDK v22, use createSession for email/password
      final session = await (_account.createSession as dynamic)(
        email: email,
        password: password,
      );

      // Store the JWT token securely
      await _storeSession(session.jwt, session.userId);

      // Get the current user
      final user = await _account.get();

      debugPrint('Login successful: ${user.name} (${user.email})');
      return user;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Login failed: ${e.message}');
      rethrow;
    }
  }

  /// Register a new user with email and password
  Future<dynamic> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create new user account
      final user = await _account.create(
        userId: appwrite.ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      debugPrint('Registration successful: ${user.name} (${user.email})');

      // Optionally auto-login after registration
      // await login(email: email, password: password);

      return user;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Registration failed: ${e.message}');
      rethrow;
    }
  }

  /// Logout the current user
  /// Clears the stored session from secure storage
  Future<void> logout() async {
    try {
      // Delete current session from Appwrite
      await _account.deleteSession(sessionId: 'current');

      // Clear stored credentials
      await _clearSession();

      debugPrint('Logout successful');
    } on appwrite.AppwriteException catch (e) {
      // Even if Appwrite logout fails, clear local storage
      await _clearSession();

      // Only log if it's not a "no session" error
      final message = e.message ?? '';
      if (e.type != 'general_unauthorized' &&
          e.code != 401 &&
          !message.contains('Session not found')) {
        debugPrint('Logout warning: $message');
      }
    }
  }

  /// Get the currently logged-in user
  /// Returns null if no valid session exists
  Future<dynamic> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user;
    } on appwrite.AppwriteException catch (e) {
      // No valid session exists
      if (e.type == 'general_unauthorized' || e.code == 401) {
        // Clear any stale session data
        await _clearSession();
        return null;
      }
      debugPrint('Get current user failed: ${e.message}');
      return null;
    }
  }

  /// Check if a valid session exists on app start
  /// Returns true if a valid session is stored
  Future<bool> hasValidSession() async {
    try {
      // First check if we have stored credentials
      final storedUserId = await _secureStorage.read(key: _userIdKey);
      if (storedUserId == null) {
        return false;
      }

      // Try to get current user to verify session is still valid
      final user = await getCurrentUser();
      return user != null;
    } catch (e) {
      debugPrint('Session check failed: $e');
      return false;
    }
  }

  /// Login with Google OAuth2
  /// Opens OAuth2 provider in browser/app and returns to app after authentication
  Future<dynamic> loginWithGoogle() async {
    try {
      // Create OAuth2 session with Google
      // Use dynamic to bypass type checking for provider parameter
      final session = await (_account.createOAuth2Session as dynamic)(
        provider: 'google',
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );

      // Store the JWT token
      // Note: For OAuth2, we need to get the JWT after session creation
      final jwt = await _account.createJWT();
      await _storeSession(jwt.jwt, session.userId);

      // Get the current user
      final user = await _account.get();

      debugPrint('Google OAuth login successful: ${user.name} (${user.email})');
      return user;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Google OAuth failed: ${e.message}');
      rethrow;
    }
  }

  /// Login with Apple Sign-In (iOS only)
  /// Opens OAuth2 provider in browser/app and returns to app after authentication
  Future<dynamic> loginWithApple() async {
    if (!Platform.isIOS) {
      throw UnsupportedError('Apple Sign-In is only available on iOS');
    }

    try {
      // Create OAuth2 session with Apple - use dynamic to bypass type checking
      final session = await (_account.createOAuth2Session as dynamic)(
        provider: 'apple',
        scopes: ['name', 'email'],
      );

      // Store the JWT token
      final jwt = await _account.createJWT();
      await _storeSession(jwt.jwt, session.userId);

      // Get the current user
      final user = await _account.get();

      debugPrint('Apple Sign-In successful: ${user.name} (${user.email})');
      return user;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Apple Sign-In failed: ${e.message}');
      rethrow;
    }
  }

  /// Get stored JWT token
  Future<String?> getStoredJwt() async {
    return await _secureStorage.read(key: _jwtKey);
  }

  /// Get stored user ID
  Future<String?> getStoredUserId() async {
    return await _secureStorage.read(key: _userIdKey);
  }

  /// Store session in secure storage
  Future<void> _storeSession(String jwt, String userId) async {
    await _secureStorage.write(key: _jwtKey, value: jwt);
    await _secureStorage.write(key: _userIdKey, value: userId);
    debugPrint('Session stored securely');
  }

  /// Clear session from secure storage
  Future<void> _clearSession() async {
    await _secureStorage.delete(key: _jwtKey);
    await _secureStorage.delete(key: _userIdKey);
    debugPrint('Session cleared from secure storage');
  }

  /// Update JWT token (for refreshing expired tokens)
  Future<void> refreshJwt() async {
    try {
      final jwt = await _account.createJWT();
      final userId = await getStoredUserId();
      if (userId != null) {
        await _storeSession(jwt.jwt, userId);
        debugPrint('JWT refreshed successfully');
      }
    } on appwrite.AppwriteException catch (e) {
      debugPrint('JWT refresh failed: ${e.message}');
      // If refresh fails, clear session
      await _clearSession();
      rethrow;
    }
  }

  /// Send password reset email
  Future<void> sendPasswordReset(String email) async {
    try {
      await _account.createRecovery(
        email: email,
        url: 'https://fitkarma.app/reset-password',
      );
      debugPrint('Password reset email sent to: $email');
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Password reset failed: ${e.message}');
      rethrow;
    }
  }

  /// Confirm password reset with the code from email
  Future<void> confirmPasswordReset({
    required String userId,
    required String secret,
    required String newPassword,
  }) async {
    try {
      await _account.updateRecovery(
        userId: userId,
        secret: secret,
        password: newPassword,
      );
      debugPrint('Password reset confirmed');
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Password reset confirmation failed: ${e.message}');
      rethrow;
    }
  }

  /// Update user name
  Future<dynamic> updateName(String name) async {
    try {
      final user = await _account.updateName(name: name);
      debugPrint('Name updated to: $name');
      return user;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Name update failed: ${e.message}');
      rethrow;
    }
  }

  /// Update user email
  Future<dynamic> updateEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _account.updateEmail(email: email, password: password);
      debugPrint('Email updated to: $email');
      return user;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Email update failed: ${e.message}');
      rethrow;
    }
  }

  /// Update user password
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _account.updatePassword(
        password: newPassword,
        oldPassword: oldPassword,
      );
      debugPrint('Password updated successfully');
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Password update failed: ${e.message}');
      rethrow;
    }
  }
}
