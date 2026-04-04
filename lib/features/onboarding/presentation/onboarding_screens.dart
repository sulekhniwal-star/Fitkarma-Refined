import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/onboarding_progress.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final state = ref.read(onboardingControllerProvider);
    if (state.currentStep < 6) {
      ref.read(onboardingControllerProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    final state = ref.read(onboardingControllerProvider);
    if (state.currentStep > 1) {
      ref.read(onboardingControllerProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnboardingProgress(currentStep: state.currentStep),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _Step1PersonalInfo(onNext: _nextPage, onBack: _prevPage),
                  _Step2PhysicalMetrics(onNext: _nextPage, onBack: _prevPage),
                  _Step3ChronicConditions(onNext: _nextPage, onBack: _prevPage),
                  _Step4DoshaQuiz(onNext: _nextPage, onBack: _prevPage),
                  _Step5LanguagePermissions(onNext: _nextPage, onBack: _prevPage),
                  _Step6AbhaWearable(onNext: _nextPage, onBack: _prevPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step1PersonalInfo extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step1PersonalInfo({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(onboardingControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BilingualText(
            english: "Personal Info",
            hindi: "व्यक्तिगत जानकारी",
            englishStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          TextField(
            onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updateName(val),
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 24),
          Text("Gender", style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              _ChoiceChip(
                label: "Male",
                selected: state.gender == "Male",
                onSelected: (val) => ref.read(onboardingControllerProvider.notifier).updatePersonalInfo(gender: "Male"),
              ),
              const SizedBox(width: 12),
              _ChoiceChip(
                label: "Female",
                selected: state.gender == "Female",
                onSelected: (val) => ref.read(onboardingControllerProvider.notifier).updatePersonalInfo(gender: "Female"),
              ),
              const SizedBox(width: 12),
              _ChoiceChip(
                label: "Other",
                selected: state.gender == "Other",
                onSelected: (val) => ref.read(onboardingControllerProvider.notifier).updatePersonalInfo(gender: "Other"),
              ),
            ],
          ),
          const Spacer(),
          PrimaryButton(text: "Next →", onPressed: state.name.isNotEmpty && state.gender != null ? onNext : null),
        ],
      ),
    );
  }
}

class _Step2PhysicalMetrics extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step2PhysicalMetrics({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(onboardingControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          const SizedBox(height: 16),
          const BilingualText(
            english: "Body & Goals",
            hindi: "शरीर और लक्ष्य",
            englishStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(height: double.tryParse(val)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(weight: double.tryParse(val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text("Fitness Goal", style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ["Weight Loss", "Muscle Gain", "Endurance", "General Fitness"].map((goal) {
              return ChoiceChip(
                label: Text(goal),
                selected: state.fitnessGoal == goal,
                onSelected: (val) => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(goal: goal),
              );
            }).toList(),
          ),
          const Spacer(),
          PrimaryButton(text: "Next →", onPressed: state.height != null && state.weight != null && state.fitnessGoal != null ? onNext : null),
        ],
      ),
    );
  }
}

class _Step3ChronicConditions extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step3ChronicConditions({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final conditions = ["Diabetes", "Hypertension", "PCOD/PCOS", "Hypothyroidism", "Asthma", "None"];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          const SizedBox(height: 16),
          const BilingualText(
            english: "Health Conditions",
            hindi: "स्वास्थ्य स्थितियां",
            englishStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text("Select any conditions to personalize your exercise and diet plan."),
          const SizedBox(height: 32),
          Wrap(
            spacing: 8,
            children: conditions.map((condition) {
              final isSelected = state.chronicConditions.contains(condition);
              return FilterChip(
                label: Text(condition),
                selected: isSelected,
                onSelected: (val) {
                  final newConditions = List<String>.from(state.chronicConditions);
                  if (val) {
                    if (condition == "None") {
                      newConditions.clear();
                      newConditions.add("None");
                    } else {
                      newConditions.remove("None");
                      newConditions.add(condition);
                    }
                  } else {
                    newConditions.remove(condition);
                  }
                  ref.read(onboardingControllerProvider.notifier).updateConditions(newConditions);
                },
              );
            }).toList(),
          ),
          const Spacer(),
          PrimaryButton(text: "Next →", onPressed: state.chronicConditions.isNotEmpty ? onNext : null),
        ],
      ),
    );
  }
}

class _Step4DoshaQuiz extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step4DoshaQuiz({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Basic placeholder for now, logic will be expanded
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          const SizedBox(height: 16),
          const BilingualText(
            english: "Dosha Quiz",
            hindi: "दोष प्रश्नोत्तरी",
            englishStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          const Center(child: Text("Dosha Quiz Engine Placeholder")),
          const Spacer(),
          PrimaryButton(text: "Skip Dosha", onPressed: onNext),
        ],
      ),
    );
  }
}

class _Step5LanguagePermissions extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step5LanguagePermissions({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          const SizedBox(height: 16),
          const BilingualText(
            english: "Language & Consent",
            hindi: "भाषा और सहमति",
            englishStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          const Text("Select Language"),
          // Grid of languages placeholder
          const Spacer(),
          PrimaryButton(text: "Confirm & Next", onPressed: onNext),
        ],
      ),
    );
  }
}

class _Step6AbhaWearable extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step6AbhaWearable({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          const SizedBox(height: 16),
          const BilingualText(
            english: "Health Link",
            hindi: "हेल्थ लिंक",
            englishStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          const Text("Connect Wearable (Mandatory)"),
          // Connect button placeholder
          const Spacer(),
          PrimaryButton(text: "Complete Onboarding", onPressed: () => context.go('/')),
        ],
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool) onSelected;

  const _ChoiceChip({required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
    );
  }
}
