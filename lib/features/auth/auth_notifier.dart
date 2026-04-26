import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<dynamic> build() async {
    return null; // null means not logged in
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    // Implementation in Section 2.9
    state = const AsyncValue.data(null);
  }

  Future<void> logout() async {
    state = const AsyncValue.data(null);
  }
}
