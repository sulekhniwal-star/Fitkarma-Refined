import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/services/health_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../health/repositories/health_repository.dart';
import 'package:collection/collection.dart';

part 'steps_provider.g.dart';

@riverpod
class Steps extends _$Steps {
  @override
  Stream<int> build() async* {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) {
      yield 0;
      return;
    }

    // Periodic refresh every 10 minutes
    yield* Stream.periodic(
            const Duration(minutes: 10), (_) => _fetchSteps(user.$id))
        .asyncMap((event) => event)
        .startWith(await _fetchSteps(user.$id));
  }

  Future<int> _fetchSteps(String userId) async {
    final count = await ref.read(healthServiceProvider).todaySteps();
    // Save to local DB for history
    final db = ref.read(appDatabaseProvider);
    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);

    final id = const Uuid().v4();
    final companion = StepCountsCompanion.insert(
      id: id,
      userId: userId,
      count: Value(count),
      date: dateOnly,
    );

    await db.saveSteps(companion);

    try {
      await ref.read(healthRepositoryProvider).pushStepsToRemote(id);
    } catch (_) {}

    return count;
  }
}

@riverpod
Stream<List<dynamic>> stepHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchStepHistory(user.$id, days);
}

@riverpod
Future<double> adaptiveGoal(Ref ref) async {
  final history = await ref.watch(stepHistoryProvider(7).future);

  if (history.isEmpty) return 6000.0; // Default goal

  final average = history.map((e) => e.count as int).average;
  // Suggest goal 10% higher than average, min 5000, max 15000
  return (average * 1.1).clamp(5000.0, 15000.0);
}

extension StreamStartWith<T> on Stream<T> {
  Stream<T> startWith(T value) async* {
    yield value;
    yield* this;
  }
}
