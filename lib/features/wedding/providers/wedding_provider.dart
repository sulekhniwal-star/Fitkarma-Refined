import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'wedding_provider.g.dart';

@riverpod
class WeddingPlanNotifier extends _$WeddingPlanNotifier {
  @override
  void build() {}

  Future<void> createPlan({
    required String role,
    required DateTime firstEventDate,
    required DateTime lastEventDate,
    required List<Map<String, dynamic>> events,
    required int prepWeeks,
    required String goal,
    String? relation,
  }) async {
    final authState = ref.read(authNotifierProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();

    final companion = WeddingPlansCompanion.insert(
      id: id,
      userId: user.$id,
      role: role,
      relation: Value(relation),
      firstEventTs: firstEventDate,
      lastEventTs: lastEventDate,
      eventsJson: jsonEncode(events),
      prepWeeks: prepWeeks,
      primaryGoal: goal,
      currentPhase: 'prep',
      createdAt: DateTime.now(),
    );

    await db.into(db.weddingPlans).insert(companion);
  }

  Future<void> updatePhase(String planId, String phase) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.weddingPlans)..where((t) => t.id.equals(planId))).write(
      WeddingPlansCompanion(currentPhase: Value(phase)),
    );
  }

  Future<void> deletePlan(String planId) async {
    final db = ref.read(appDatabaseProvider);
    await (db.delete(db.weddingPlans)..where((t) => t.id.equals(planId))).go();
  }
}

@riverpod
Stream<WeddingPlan?> activeWeddingPlan(ActiveWeddingPlanRef ref) {
  final authState = ref.watch(authNotifierProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchActiveWeddingPlan(user.$id);
}

@riverpod
String weddingPhase(WeddingPhaseRef ref) {
  final planAsync = ref.watch(activeWeddingPlanProvider);
  
  return planAsync.when(
    data: (plan) {
      if (plan == null) return 'none';
      
      final now = DateTime.now();
      if (now.isBefore(plan.firstEventTs)) {
        final daysToWedding = plan.firstEventTs.difference(now).inDays;
        if (daysToWedding <= 7) return 'wedding_week';
        return 'prep';
      } else if (now.isAfter(plan.lastEventTs)) {
        return 'post_wedding';
      } else {
        return 'active_wedding';
      }
    },
    loading: () => 'loading',
    error: (_, __) => 'error',
  );
}

@riverpod
Map<String, dynamic> weddingEventDiet(WeddingEventDietRef ref, String eventKey) {
  // Logic for specific wedding events
  switch (eventKey.toLowerCase()) {
    case 'haldi':
      return {
        'recommendation': 'Hydrate well! Turmeric can be dehydrating. Opt for light, liquid-based snacks.',
        'avoid': 'Heavy fried food, excessive sweets.',
        'bonus': '+10 Karma for choosing coconut water over soda.'
      };
    case 'mehendi':
      return {
        'recommendation': 'Finger foods only! You won\'t be able to use your hands. Mini wraps or skewers are best.',
        'avoid': 'Curries or anything that requires cutlery.',
        'bonus': 'Stay energized with dry fruit mix.'
      };
    case 'sangeet':
      return {
        'recommendation': 'High carb, moderate protein for dancing energy. Eat 2 hours before the performance.',
        'avoid': 'Dairy (may cause bloating).',
        'bonus': 'Extra stamina points for complex carbs.'
      };
    default:
      return {
        'recommendation': 'Focus on portion control and mindful eating.',
        'avoid': 'Oily snacks.',
        'bonus': 'Stay consistent!'
      };
  }
}
