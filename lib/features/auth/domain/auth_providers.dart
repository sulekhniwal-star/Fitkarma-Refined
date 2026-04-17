import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// Simplified domain model for the authenticated user.
class AppUser {
  final String id;
  final String email;
  final String name;

  const AppUser({required this.id, required this.email, required this.name});

  factory AppUser.fromAppwrite(models.User user) {
    return AppUser(
      id: user.$id,
      email: user.email,
      name: user.name,
    );
  }
}

/// Provider for the AuthRepository instance.
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

/// Notifier that manages the application's authentication state.
class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final repository = ref.watch(authRepositoryProvider);
    final loggedIn = await repository.isLoggedIn();
    
    if (loggedIn) {
      final user = await repository.getUser();
      return AppUser.fromAppwrite(user);
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.login(email, password);
      final user = await repository.getUser();
      return AppUser.fromAppwrite(user);
    });
  }

  Future<void> register(String email, String password, String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.register(email, password, name);
      final user = await repository.getUser();
      return AppUser.fromAppwrite(user);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).logout();
      return null;
    });
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).loginWithGoogle();
      // OAuth flow handles the final redirection/session, 
      // but we should check again.
      final user = await ref.read(authRepositoryProvider).getUser();
      return AppUser.fromAppwrite(user);
    });
  }
}

/// Global provider for the authentication state.
final authStateProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

