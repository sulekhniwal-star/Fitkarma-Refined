import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'karma_provider.g.dart';

class KarmaService {
  final Functions _functions;

  KarmaService(this._functions);

  Future<void> awardXP(String userId, String eventType) async {
    try {
      await _functions.createExecution(
        functionId: 'xp-calculator',
        body: '{"userId": "$userId", "eventType": "$eventType"}',
      );
    } catch (e) {
      // Log error but don't break the user flow
    }
  }
}

@riverpod
KarmaService karmaService(Ref ref) {
  return KarmaService(ref.watch(appwriteFunctionsProvider));
}

@riverpod
class XpFloatNotifier extends _$XpFloatNotifier {
  @override
  List<int> build() => [];

  void showXp(int points) {
    state = [...state, points];
    Future.delayed(const Duration(seconds: 2), () {
      if (state.isNotEmpty) {
        state = state.skip(1).toList();
      }
    });
  }
}

@riverpod
Stream<dynamic> userKarma(Ref ref) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchUserProfile(user.$id);
}

@riverpod
Future<List<Map<String, Object>>> leaderboard(Ref ref, String type) async {
  // Mocking leaderboard data for now as it usually requires a custom function or large query
  await Future.delayed(const Duration(seconds: 1));
  return [
    {'name': 'You', 'xp': 1250, 'rank': 4},
    {'name': 'Aarav', 'xp': 2100, 'rank': 1},
    {'name': 'Ishani', 'xp': 1850, 'rank': 2},
    {'name': 'Vihaan', 'xp': 1500, 'rank': 3},
  ];
}
