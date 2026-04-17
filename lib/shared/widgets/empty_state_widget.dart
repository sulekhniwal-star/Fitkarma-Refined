import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

enum EmptyStateType {
  food,
  workout,
  steps,
  sleep,
  mood,
  lab,
  habits,
  journal,
  water,
  medication,
  doctor,
  family,
  search,
}

class FitKarmaEmptyState extends StatelessWidget {
  final EmptyStateType type;
  final String? title;
  final String? subtitle;
  final String? hindiTitle;
  final VoidCallback? onAction;
  final String? actionLabel;

  const FitKarmaEmptyState({
    super.key,
    required this.type,
    this.title,
    this.subtitle,
    this.hindiTitle,
    this.onAction,
    this.actionLabel,
  });

  String get _assetPath {
    switch (type) {
      case EmptyStateType.food:
        return 'assets/images/empty_states/food_log.png';
      case EmptyStateType.workout:
        return 'assets/images/empty_states/workout.png';
      case EmptyStateType.steps:
        return 'assets/images/empty_states/steps.png';
      case EmptyStateType.sleep:
        return 'assets/images/empty_states/sleep.png';
      case EmptyStateType.mood:
        return 'assets/images/empty_states/mood.png';
      case EmptyStateType.lab:
        return 'assets/images/empty_states/lab_reports.png';
      case EmptyStateType.habits:
        return 'assets/images/empty_states/habits.png';
      case EmptyStateType.journal:
        return 'assets/images/empty_states/journal.png';
      case EmptyStateType.water:
        return 'assets/images/empty_states/water.png';
      case EmptyStateType.medication:
        return 'assets/images/empty_states/medication.png';
      case EmptyStateType.doctor:
        return 'assets/images/empty_states/doctor_appointments.png';
      case EmptyStateType.family:
        return 'assets/images/empty_states/family_hub.png';
      case EmptyStateType.search:
        return 'assets/images/empty_states/search.png';
    }
  }

  String get _defaultTitle {
    switch (type) {
      case EmptyStateType.food:
        return 'No meals logged today';
      case EmptyStateType.workout:
        return 'No workouts yet';
      case EmptyStateType.steps:
        return 'Waiting for steps...';
      case EmptyStateType.sleep:
        return 'No sleep data available';
      case EmptyStateType.mood:
        return 'How are you feeling?';
      case EmptyStateType.lab:
        return 'No lab reports found';
      case EmptyStateType.habits:
        return 'Build healthy habits';
      case EmptyStateType.journal:
        return 'Capture your thoughts';
      case EmptyStateType.water:
        return 'Stay hydrated!';
      case EmptyStateType.medication:
        return 'No medications added';
      case EmptyStateType.doctor:
        return 'No upcoming appointments';
      case EmptyStateType.family:
        return 'Your health circle';
      case EmptyStateType.search:
        return 'No results found';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _assetPath,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            if (hindiTitle != null) ...[
              Text(
                hindiTitle!,
                style: AppTextStyles.bodySmall(isDark).copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
            ],
            Text(
              title ?? _defaultTitle,
              style: AppTextStyles.h3(isDark),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: AppTextStyles.bodySmall(isDark),
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
