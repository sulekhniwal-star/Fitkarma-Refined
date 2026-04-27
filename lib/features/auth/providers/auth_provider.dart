
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart' as models;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<models.User?> build() async {
    final account = ref.watch(appwriteAccountProvider);
    try {
      return await account.get();
    } catch (_) {
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final account = ref.read(appwriteAccountProvider);
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      final user = await account.get();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final account = ref.read(appwriteAccountProvider);
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      
      // Automatically login after registration
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      
      final user = await account.get();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final account = ref.read(appwriteAccountProvider);
      // createOAuth2Session returns a Future that completes when the redirect starts
      // In a real app, you might need to handle the redirect/result
      await account.createOAuth2Session(provider: OAuthProvider.google);
      
      // Note: In mobile, this will open a browser. The state update usually 
      // happens when the app is resumed and build() is re-evaluated.
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      final account = ref.read(appwriteAccountProvider);
      await account.deleteSession(sessionId: 'current');
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
