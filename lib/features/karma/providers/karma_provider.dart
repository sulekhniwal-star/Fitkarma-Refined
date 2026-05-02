import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'karma_provider.g.dart';

enum LeaderboardType {
  friends,
  city,
  national,
  seasonal,
}

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
Future<List<Map<String, dynamic>>> leaderboard(Ref ref, LeaderboardType type) async {
  // TODO: Implement remote call to Appwrite Function to get real-time leaderboard
  // For now, we return mock data based on the type
  await Future.delayed(const Duration(seconds: 1));
  
  final prefix = type.name.toUpperCase();
  
  return [
    {'name': 'You', 'xp': 1250, 'rank': 4, 'type': prefix},
    {'name': 'Aarav', 'xp': 2100, 'rank': 1, 'type': prefix},
    {'name': 'Ishani', 'xp': 1850, 'rank': 2, 'type': prefix},
    {'name': 'Vihaan', 'xp': 1500, 'rank': 3, 'type': prefix},
  ];
}
