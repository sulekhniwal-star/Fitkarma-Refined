import 'package:flutter/material.dart';

enum WeddingRole { bride, groom, guest, relative }

class WeddingSetupState {
  final int currentStep;
  final WeddingRole? role;
  final String? relativeType;
  final DateTimeRange? dateRange;
  final List<String> selectedEvents;
  final String? prepWeeks;
  final String? primaryGoal;
  final bool isSubmitting;

  const WeddingSetupState({
    this.currentStep = 1,
    this.role,
    this.relativeType,
    this.dateRange,
    this.selectedEvents = const [],
    this.prepWeeks,
    this.primaryGoal,
    this.isSubmitting = false,
  });

  WeddingSetupState copyWith({
    int? currentStep,
    WeddingRole? role,
    String? relativeType,
    DateTimeRange? dateRange,
    List<String>? selectedEvents,
    String? prepWeeks,
    String? primaryGoal,
    bool? isSubmitting,
  }) {
    return WeddingSetupState(
      currentStep: currentStep ?? this.currentStep,
      role: role ?? this.role,
      relativeType: relativeType ?? this.relativeType,
      dateRange: dateRange ?? this.dateRange,
      selectedEvents: selectedEvents ?? this.selectedEvents,
      prepWeeks: prepWeeks ?? this.prepWeeks,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
