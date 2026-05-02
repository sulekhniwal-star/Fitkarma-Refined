import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/database/app_database.dart';
import '../../auth/providers/auth_provider.dart';
import '../repositories/food_repository.dart';

part 'food_provider.g.dart';

@riverpod
FoodRepository foodRepository(Ref ref) {
  return FoodRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appwriteTablesDBProvider),
    ref.watch(dioProvider),
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

  Future<void> logFood(FoodLogsCompanion companion) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);

    // Ensure ID and userId are set
    final id = companion.id.present ? companion.id.value : const Uuid().v4();
    final finalCompanion = companion.copyWith(
      id: Value(id),
      userId: Value(user.$id),
      syncStatus: const Value('pending'),
    );

    await db.into(db.foodLogs).insert(finalCompanion);

    // Optimistic push
    _pushToRemote(id);
  }

  Future<void> _pushToRemote(String localId) async {
    try {
      await ref.read(foodRepositoryProvider).pushToRemote(localId);
    } catch (e) {
      // SyncWorker will pick it up later during periodic sync
    }
  }

  Future<void> deleteFood(String id) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.foodLogs)..where((t) => t.id.equals(id))).go();
    // TODO: Add remote delete if synced
  }
}

@riverpod
Future<double> todayCalories(Ref ref) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  
  final logs = await ref.watch(foodLogProvider(today).future);
  return logs.fold<double>(0.0, (sum, log) => sum + (log as dynamic).calories);
}

@riverpod
Future<List<dynamic>> foodSearch(Ref ref, String query) async {
  if (query.trim().isEmpty) return [];

  final repo = ref.read(foodRepositoryProvider);

  // Search local and remote in parallel
  final results = await Future.wait([
    repo.searchLocal(query),
    repo.searchRemote(query),
  ]);

  // Merge results
  final local = results[0];
  final remote = results[1];

  // Use a map to deduplicate by name/remoteId if necessary
  final merged = [...local, ...remote];
  return merged;
}
