import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fitkarma/core/database/app_database.dart';
import 'package:fitkarma/core/providers/core_providers.dart';
import 'package:fitkarma/features/auth/providers/auth_provider.dart';
import 'package:fitkarma/features/food/repositories/food_repository.dart';

part 'food_provider.g.dart';

@riverpod
FoodRepository foodRepository(FoodRepositoryRef ref) {
  return FoodRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appwriteTablesDBProvider),
  );
}

@riverpod
class FoodLogNotifier extends _$FoodLogNotifier {
  @override
  Stream<List<FoodLog>> build(DateTime date) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.asData?.value;
    
    if (user == null) return Stream.value([]);
    
    return ref.watch(appDatabaseProvider).watchTodayFoodLogs(user.$id, date);
  }

  Future<void> deleteFood(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.foodLogs)..where((t) => t.id.equals(id))).go();
  }

  Future<void> logFood(FoodLogsCompanion log) async {
    final db = ref.read(appDatabaseProvider);
    await db.into(db.foodLogs).insert(log);
    
    // 3. Trigger remote push (repository handles status updates)
    // In a real app, this might be handled by a dedicated SyncService
    try {
      await ref.read(foodRepositoryProvider).pushToRemote(log.id.value);
    } catch (e) {
      // Background sync will retry
    }
  }
}

@riverpod
double todayCalories(TodayCaloriesRef ref) {
  final now = DateTime.now();
  final logsAsync = ref.watch(foodLogNotifierProvider(DateTime(now.year, now.month, now.day)));
  
  return logsAsync.when(
    data: (logs) => logs.fold(0.0, (sum, item) => sum + item.calories),
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
}

@riverpod
Future<List<FoodLog>> foodSearch(FoodSearchRef ref, String query) async {
  if (query.trim().isEmpty) return [];
  
  final repo = ref.read(foodRepositoryProvider);
  return repo.searchLocal(query);
}
