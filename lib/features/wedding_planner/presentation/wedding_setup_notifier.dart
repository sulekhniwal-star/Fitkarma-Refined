import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../domain/wedding_setup_state.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import 'package:drift/drift.dart';
import '../../auth/domain/auth_providers.dart';
import '../../auth/data/users_repository.dart';

class WeddingSetupNotifier extends Notifier<WeddingSetupState> {
  final _uuid = const Uuid();

  @override
  WeddingSetupState build() => const WeddingSetupState();

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void prevStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setRole(WeddingRole role) {
    state = state.copyWith(role: role);
  }

  void setRelativeType(String type) {
    state = state.copyWith(relativeType: type);
  }

  void setDateRange(DateTimeRange range) {
    state = state.copyWith(dateRange: range);
  }

  void toggleEvent(String event) {
    final current = List<String>.from(state.selectedEvents);
    if (current.contains(event)) {
      current.remove(event);
    } else {
      current.add(event);
    }
    state = state.copyWith(selectedEvents: current);
  }

  void setPrepWeeks(String weeks) {
    state = state.copyWith(prepWeeks: weeks);
  }

  void setPrimaryGoal(String goal) {
    state = state.copyWith(primaryGoal: goal);
  }

  Future<void> completeSetup() async {
    state = state.copyWith(isSubmitting: true);
    try {
      final db = DriftService.db;
      final authState = ref.read(authStateProvider);
      final userId = authState.value?.id ?? 'anonymous';

      // 1. Save to WeddingEvents table
      for (final eventKey in state.selectedEvents) {
        await db.into(db.weddingEvents).insert(
          WeddingEventsCompanion.insert(
            id: _uuid.v4(),
            userId: userId,
            eventKey: eventKey,
            eventName: _getEventName(eventKey),
            date: state.dateRange?.start ?? DateTime.now(),
            idempotencyKey: _uuid.v4(),
            syncStatus: const Value('pending'),
          ),
        );
      }

      // 2. Update user record
      await ref.read(usersRepositoryProvider).updateWeddingData(
            userId: userId,
            role: state.role?.name ?? 'guest',
            relativeType: state.relativeType,
            startDate: state.dateRange?.start,
            endDate: state.dateRange?.end,
            events: state.selectedEvents,
            prepWeeks: state.prepWeeks,
            primaryGoal: state.primaryGoal,
          );

      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  String _getEventName(String key) {
    switch (key) {
      case 'haldi': return 'Haldi';
      case 'mehendi': return 'Mehendi';
      case 'sangeet': return 'Sangeet';
      case 'baraat': return 'Baraat';
      case 'vivah': return 'Vivah (Wedding)';
      case 'reception': return 'Reception';
      default: return key;
    }
  }
}

final weddingSetupProvider = NotifierProvider<WeddingSetupNotifier, WeddingSetupState>(() {
  return WeddingSetupNotifier();
});
