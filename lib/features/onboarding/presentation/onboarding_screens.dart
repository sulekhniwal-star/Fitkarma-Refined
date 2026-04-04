import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/onboarding_progress.dart';
import '../../../shared/theme/app_colors.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  final int step;
  const OnboardingScreen({super.key, this.step = 1});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.step - 1);
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
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
      );
    }
  }

  void _prevPage() {
    final state = ref.read(onboardingControllerProvider);
    if (state.currentStep > 1) {
      ref.read(onboardingControllerProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
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
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const BilingualText(
            english: "Personal Details",
            hindi: "व्यक्तिगत जानकारी",
            englishStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Text(
            "Let's start with your basics to personalise your Ayurvedic journey.",
            style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
          ),
          const SizedBox(height: 40),
          TextField(
            onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updateName(val),
            decoration: const InputDecoration(
              labelText: 'Display Name',
              hintText: 'e.g. Rahul Sharma',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: 32),
          const Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              _GenderCard(
                label: "Male",
                icon: Icons.male_rounded,
                selected: state.gender == "Male",
                onTap: () => ref.read(onboardingControllerProvider.notifier).updateGender("Male"),
              ),
              const SizedBox(width: 12),
              _GenderCard(
                label: "Female",
                icon: Icons.female_rounded,
                selected: state.gender == "Female",
                onTap: () => ref.read(onboardingControllerProvider.notifier).updateGender("Female"),
              ),
              const SizedBox(width: 12),
              _GenderCard(
                label: "Other",
                icon: Icons.transgender_rounded,
                selected: state.gender == "Other",
                onTap: () => ref.read(onboardingControllerProvider.notifier).updateGender("Other"),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text("Date of Birth", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: state.dob ?? DateTime(2000),
                firstDate: DateTime(1940),
                lastDate: DateTime.now(),
              );
              if (date != null) ref.read(onboardingControllerProvider.notifier).updateDob(date);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(16),
                color: isDark ? AppColors.surfaceVariantDark : Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 20, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text(
                    state.dob == null ? "Select Date" : "${state.dob!.day}/${state.dob!.month}/${state.dob!.year}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          PrimaryButton(
            text: "Continue", 
            onPressed: state.name.trim().length >= 2 && state.gender != null && state.dob != null ? onNext : null
          ),
          const SizedBox(height: 8),
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
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onBack, 
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(height: 20),
          const BilingualText(
            english: "Body Metrics",
            hindi: "शारीरिक माप",
            englishStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)', hintText: 'e.g. 175'),
                  onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(height: double.tryParse(val)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)', hintText: 'e.g. 70'),
                  onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(weight: double.tryParse(val)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
          const Text("Fitness Goal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ["Weight Loss", "Muscle Gain", "Improve Endurance", "General Wellness"].map((goal) {
              final isSelected = state.fitnessGoal == goal;
              return ChoiceChip(
                label: Text(goal),
                selected: isSelected,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                onSelected: (val) => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(goal: goal),
              );
            }).toList(),
          ),
          const SizedBox(height: 36),
          const Text("Activity Level", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Column(
            children: ["Sedentary", "Lightly Active", "Moderately Active", "Very Active", "Extra Active"].map((level) {
              final isSelected = state.activityLevel == level;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () => ref.read(onboardingControllerProvider.notifier).updatePhysicalMetrics(activity: level),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? AppColors.primary.withOpacity(0.1) : (isDark ? AppColors.surfaceVariantDark : Colors.white),
                      border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_off, 
                          color: isSelected ? AppColors.primary : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(level, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Spacer(),
          PrimaryButton(
            text: "Next →", 
            onPressed: state.height != null && state.weight != null && state.fitnessGoal != null && state.activityLevel != null ? onNext : null
          ),
          const SizedBox(height: 8),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final conditions = ["Diabetes", "Hypertension", "PCOD/PCOS", "Hypothyroidism", "Asthma", "Heart Condition", "None"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
          const SizedBox(height: 20),
          const BilingualText(
            english: "Medical History",
            hindi: "चिकित्सा इतिहास",
            englishStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Text(
            "This helps us adjust calories and exercise intensity safely.",
            style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: conditions.map((condition) {
                    final isSelected = state.chronicConditions.contains(condition);
                    return FilterChip(
                      label: Text(condition),
                      selected: isSelected,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(text: "Continue", onPressed: state.chronicConditions.isNotEmpty ? onNext : null),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Step4DoshaQuiz extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Step4DoshaQuiz({required this.onNext, required this.onBack});

  @override
  ConsumerState<_Step4DoshaQuiz> createState() => _Step4DoshaQuizState();
}

class _Step4DoshaQuizState extends ConsumerState<_Step4DoshaQuiz> {
  int _currentQuestionIndex = 0;
  final Map<String, int> _scores = {'vata': 0, 'pitta': 0, 'kapha': 0};

  final List<Map<String, dynamic>> _questions = [
    {
      'q': 'Physical Frame',
      'options': [
        {'text': 'Slim, bony, hard to gain weight', 'dosha': 'vata'},
        {'text': 'Medium, athletic, easy to gain/lose', 'dosha': 'pitta'},
        {'text': 'Large, heavy, easy to gain weight', 'dosha': 'kapha'},
      ]
    },
    {
      'q': 'Skin Texture',
      'options': [
        {'text': 'Dry, rough, thin or cold', 'dosha': 'vata'},
        {'text': 'Oily, soft, warm, reddish', 'dosha': 'pitta'},
        {'text': 'Thick, moist, smooth, cool', 'dosha': 'kapha'},
      ]
    },
    {
      'q': 'Digestion & Appetite',
      'options': [
        {'text': 'Irregular appetite, gas/constipation', 'dosha': 'vata'},
        {'text': 'Intense hunger, strong digestion', 'dosha': 'pitta'},
        {'text': 'Slow digestion, constant appetite', 'dosha': 'kapha'},
      ]
    },
    {
      'q': 'Sleep Pattern',
      'options': [
        {'text': 'Light, interrupted, less than 6 hrs', 'dosha': 'vata'},
        {'text': 'Sound, 6–8 hrs, wakes refreshed', 'dosha': 'pitta'},
        {'text': 'Heavy, deep, 8+ hrs, hard to wake', 'dosha': 'kapha'},
      ]
    },
    {
      'q': 'Mental Activity',
      'options': [
        {'text': 'Active, restless, many ideas', 'dosha': 'vata'},
        {'text': 'Focused, goal-oriented, sharp', 'dosha': 'pitta'},
        {'text': 'Calm, steady, stable, patient', 'dosha': 'kapha'},
      ]
    }
    // Summary simplified for brevity, in real app add all 12
  ];

  void _answer(String dosha) {
    setState(() {
      _scores[dosha] = (_scores[dosha] ?? 0) + 1;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        ref.read(onboardingControllerProvider.notifier).updateDosha(_scores);
        widget.onNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: widget.onBack, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
          const SizedBox(height: 20),
          const BilingualText(
            english: "Dosha Quiz",
            hindi: "दोष प्रश्नोत्तरी",
            englishStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: AppColors.divider,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 48),
          Text(
            "Question ${_currentQuestionIndex + 1}/${_questions.length}",
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          Text(
            question['q'],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: question['options'].length,
              itemBuilder: (context, index) {
                final opt = question['options'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    onTap: () => _answer(opt['dosha']),
                    tileColor: isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariant,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Text(opt['text']),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: widget.onNext,
            child: const Center(child: Text("Skip Quiz for now")),
          ),
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
    final state = ref.watch(onboardingControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languages = [
      {'name': 'English', 'code': 'en'},
      {'name': 'Hindi', 'code': 'hi'},
      {'name': 'Marathi', 'code': 'mr'},
      {'name': 'Tamil', 'code': 'ta'},
      {'name': 'Telugu', 'code': 'te'},
      {'name': 'Bengali', 'code': 'bn'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
          const SizedBox(height: 20),
          const BilingualText(
            english: "Preferences",
            hindi: "प्राथमिकताएं",
            englishStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 32),
          const Text("Content Language", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: languages.map((lang) {
              final isSelected = state.preferredLanguage == lang['code'];
              return ChoiceChip(
                label: Text(lang['name']!),
                selected: isSelected,
                onSelected: (val) => ref.read(onboardingControllerProvider.notifier).updateLanguage(lang['code']!),
              );
            }).toList(),
          ),
          const SizedBox(height: 48),
          const Text("Health Access", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDark ? AppColors.surfaceVariantDark : Colors.white,
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                const Icon(Icons.health_and_safety_rounded, color: Colors.green, size: 32),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Google Health Connect", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Sync steps, sleep, and heart rate automatically.", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                Switch(
                  value: state.healthPermissionsGranted, 
                  onChanged: (val) => ref.read(onboardingControllerProvider.notifier).updatePermissions(val),
                ),
              ],
            ),
          ),
          const Spacer(),
          PrimaryButton(text: "Almost There!", onPressed: onNext),
          const SizedBox(height: 8),
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
    final state = ref.watch(onboardingControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
          const SizedBox(height: 20),
          const BilingualText(
            english: "Ecosystem Link",
            hindi: "इकोसिस्टम लिंक",
            englishStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 32),
          _LinkCard(
            title: "ABHA Health ID",
            subtitle: "Link your Ayushman Bharat ID (+100 XP)",
            icon: Icons.badge_outlined,
            onTap: () {}, // Future: ABHA flow
          ),
          const SizedBox(height: 16),
          _LinkCard(
            title: "Connect Wearable",
            subtitle: "Fitbit, Garmin, or Apple Watch (+100 XP)",
            icon: Icons.watch_rounded,
            onTap: () {}, // Future: Wearable flow
          ),
          const Spacer(),
          const Center(
            child: Column(
              children: [
                Icon(Icons.stars_rounded, color: AppColors.accent, size: 48),
                SizedBox(height: 12),
                Text(
                  "Earn 50 XP after finishing!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: "Finalise Journey", 
            isLoading: state.isSaving,
            onPressed: () async {
              await ref.read(onboardingControllerProvider.notifier).completeOnboarding();
              if (context.mounted) context.go('/');
            }
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderCard({required this.label, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withOpacity(0.1) : (isDark ? AppColors.surfaceVariantDark : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? AppColors.primary : AppColors.divider, width: 2),
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? AppColors.primary : Colors.grey, size: 32),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: selected ? AppColors.primary : Colors.grey, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _LinkCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? AppColors.surfaceVariantDark : Colors.white,
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.secondarySurface, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: AppColors.secondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

