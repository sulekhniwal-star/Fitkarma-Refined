import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/storage/app_database.dart';

class PRCelebrationNotifier extends Notifier<PersonalRecord?> {
  @override
  PersonalRecord? build() => null;

  void show(PersonalRecord pr) => state = pr;
  void dismiss() => state = null;
}

final pRCelebrationProvider =
    NotifierProvider<PRCelebrationNotifier, PersonalRecord?>(
  PRCelebrationNotifier.new,
);

class PRCelebrationOverlay extends ConsumerWidget {
  const PRCelebrationOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pr = ref.watch(pRCelebrationProvider);
    if (pr == null) return const SizedBox.shrink();

    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, AppColors.primary.withOpacity(0.05)],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("🏆", style: TextStyle(fontSize: 60)),
              const SizedBox(height: 16),
              const Text(
                "NEW PERSONAL RECORD!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.primary),
              ),
              const Text(
                "नया व्यक्तिगत रिकॉर्ड!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Text(
                pr.exerciseName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "${pr.value}",
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.orangeAccent),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    pr.unit,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => ref.read(pRCelebrationProvider.notifier).dismiss(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("AWESOME! · बहुत बढ़िया", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
