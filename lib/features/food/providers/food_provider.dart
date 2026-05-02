import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../repositories/food_repository.dart';

part 'food_provider.g.dart';

@riverpod
FoodRepository foodRepository(Ref ref) {
  return FoodRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appwriteTablesDBProvider),
  );
}

@riverpod
class FoodLogNotifier extends _$FoodLogNotifier {
  @override
  Stream<List<dynamic>> build(DateTime date) {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;

    if (user == null) return Stream.value([]);

    return ref.watch(appDatabaseProvider).watchTodayFoodLogs(user.$id, date);
  }

  Future<void> deleteFood(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.foodLogs)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Future<double> todayCalories(Ref ref) async {
  return 0.0;
}

@riverpod
Future<List<dynamic>> foodSearch(Ref ref, String query) async {
  if (query.trim().isEmpty) return [];

  final repo = ref.read(foodRepositoryProvider);
  return repo.searchLocal(query);
}
