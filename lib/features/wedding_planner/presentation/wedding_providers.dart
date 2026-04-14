import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/domain/auth_providers.dart';
import '../domain/wedding_plan_rule.dart';
import 'package:drift/drift.dart' as drift;

// ─── Profile data ─────────────────────────────────────────────────────────────

class WeddingProfileData {
  final String role;
  final String? relationType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? prepWeeks;
  final List<String> events;
  final String? goal;

  const WeddingProfileData({
    required this.role,
    this.relationType,
    this.startDate,
    this.endDate,
    this.prepWeeks,
    required this.events,
    this.goal,
  });

  bool get hasWeddingSetup =>
      startDate != null && endDate != null && role != 'none' && role.isNotEmpty;
}

final weddingProfileProvider = FutureProvider<WeddingProfileData?>((ref) async {
  final db = DriftService.db;
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.id ?? 'anonymous';

  final query = db.select(db.users)
    ..where((u) => u.id.equals(userId));
  final user = await query.getSingleOrNull();

  if (user == null) return null;

  return WeddingProfileData(
    role: user.weddingRole ?? 'none',
    relationType: user.weddingRelationType,
    startDate: user.weddingStartDate,
    endDate: user.weddingEndDate,
    prepWeeks: user.weddingPrepWeeks,
    events: user.weddingEvents != null
        ? List<String>.from(
            (user.weddingEvents!.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '').split(','))
                .where((e) => e.trim().isNotEmpty),
          )
        : [],
    goal: user.weddingPrimaryGoal,
  );
});

// ─── Events ──────────────────────────────────────────────────────────────────

final weddingEventsProvider = FutureProvider<List<WeddingEvent>>((ref) async {
  final db = DriftService.db;
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.id ?? 'anonymous';

  return (db.select(db.weddingEvents)
        ..where((t) => t.userId.equals(userId))
        ..orderBy([(t) => drift.OrderingTerm.asc(t.date)]))
      .get();
});

// ─── Phase ───────────────────────────────────────────────────────────────────

final weddingPhaseProvider = FutureProvider<WeddingPhase>((ref) async {
  final profile = await ref.watch(weddingProfileProvider.future);
  return WeddingPlanEngine.computePhase(
    startDate: profile?.startDate,
    endDate: profile?.endDate,
  );
});

// ─── Today's Plan (rule-engine driven) ───────────────────────────────────────

final weddingTodaysPlanProvider = FutureProvider<WeddingDayPlan?>((ref) async {
  final profile = await ref.watch(weddingProfileProvider.future);
  final phase = await ref.watch(weddingPhaseProvider.future);

  if (profile == null || !profile.hasWeddingSetup) return null;

  final planRole = _parseRole(profile.role);

  // NOTE: RemoteConfig overrides would be fetched from DriftService.db
  // remoteConfigCache and passed here. For now, pass null to use local rules.
  return WeddingPlanEngine.evaluate(
    phase: phase,
    role: planRole,
    goal: profile.goal,
    remoteOverrides: null,
  );
});

// ─── Event-specific plan provider ─────────────────────────────────────────────

final weddingEventPlanProvider = FutureProvider.family<WeddingDayPlan?, String>((ref, eventKey) async {
  final profile = await ref.watch(weddingProfileProvider.future);
  final phase = await ref.watch(weddingPhaseProvider.future);

  if (profile == null || !profile.hasWeddingSetup) return null;

  final planRole = _parseRole(profile.role);

  return WeddingPlanEngine.evaluate(
    phase: phase,
    role: planRole,
    goal: profile.goal,
    remoteOverrides: null,
    eventKey: eventKey,
  );
});

// ─── Next event provider ──────────────────────────────────────────────────────

final weddingNextEventProvider = FutureProvider<WeddingEvent?>((ref) async {
  final events = await ref.watch(weddingEventsProvider.future);
  final now = DateTime.now();
  final upcoming = events.where((e) => e.date.isAfter(now)).toList();
  return upcoming.isNotEmpty ? upcoming.first : null;
});

// ─── Helper to get all upcoming events with days remaining ──────────────────

final weddingUpcomingEventsWithCountdownProvider = FutureProvider<List<_EventWithCountdown>>((ref) async {
  final events = await ref.watch(weddingEventsProvider.future);
  final now = DateTime.now();
  
  return events
      .where((e) => e.date.isAfter(now))
      .map((e) => _EventWithCountdown(
            event: e,
            daysRemaining: e.date.difference(now).inDays,
          ))
      .toList()
    ..sort((a, b) => a.daysRemaining.compareTo(b.daysRemaining));
});

class _EventWithCountdown {
  final WeddingEvent event;
  final int daysRemaining;
  _EventWithCountdown({required this.event, required this.daysRemaining});
}

WeddingPlanRole _parseRole(String role) {
  switch (role) {
    case 'bride': return WeddingPlanRole.bride;
    case 'groom': return WeddingPlanRole.groom;
    case 'guest': return WeddingPlanRole.guest;
    case 'relative': return WeddingPlanRole.relative;
    default: return WeddingPlanRole.none;
  }
}
