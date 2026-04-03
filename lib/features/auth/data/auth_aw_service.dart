import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/errors/app_exception.dart';

const _sessionKey = 'fitkarma_session';
const _userIdKey = 'fitkarma_user_id';
const _secretKey = 'fitkarma_secret';

final _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
);

class AuthService {
  late final Account _account;
  late final Client _client;

  AuthService() {
    _client = Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId);
    _account = Account(_client);
  }

  Account get account => _account;

  Future<models.User?> getCurrentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }

  Future<models.User> login({
    required String email,
    required String password,
  }) async {
    final session = await _account.createEmailPasswordSession(
      email: email,
      password: password,
    );
    await _saveSession(session);
    final user = await getCurrentUser();
    return user!;
  }

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

  Future<void> logout() async {
    try {
      final sessions = await _account.listSessions();
      for (final session in sessions.sessions) {
        await _account.deleteSession(sessionId: session.$id);
      }
    } catch (_) {}
    await _clearSession();
  }

  Future<models.User> loginWithGoogle() async {
    await _account.createOAuth2Session(provider: 'google' as dynamic);
    final user = await getCurrentUser();
    if (user == null) {
      throw const AuthException(code: 'oauth_failed', message: 'Failed to get user');
    }
    return user;
  }

  Future<models.User> loginWithApple() async {
    await _account.createOAuth2Session(provider: 'apple' as dynamic);
    final user = await getCurrentUser();
    if (user == null) {
      throw const AuthException(code: 'oauth_failed', message: 'Failed to get user');
    }
    return user;
  }

  Future<bool> hasStoredSession() async {
    try {
      final sessionSecret = await _secureStorage.read(key: _secretKey);
      return sessionSecret != null && sessionSecret.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _saveSession(models.Session session) async {
    await _secureStorage.write(key: _secretKey, value: session.secret);
    final user = await getCurrentUser();
    if (user != null) {
      await _secureStorage.write(key: _userIdKey, value: user.$id);
    }
  }

  Future<void> _clearSession() async {
    await _secureStorage.delete(key: _sessionKey);
    await _secureStorage.delete(key: _userIdKey);
    await _secureStorage.delete(key: _secretKey);
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final currentUserProvider = FutureProvider.autoDispose<models.User?>((ref) async {
  final auth = ref.watch(authServiceProvider);
  final hasSession = await auth.hasStoredSession();
  if (!hasSession) return null;
  return auth.getCurrentUser();
});

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final auth = ref.watch(authServiceProvider);
  return auth.hasStoredSession();
});