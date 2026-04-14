import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'wedding_setup_notifier.dart';
import '../domain/wedding_setup_state.dart';
import '../../festival/presentation/festival_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_label.dart';

class WeddingSetupScreen extends ConsumerWidget {
  const WeddingSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weddingSetupProvider);
    final notifier = ref.read(weddingSetupProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: state.currentStep <= 1
              ? () => context.pop()
              : () => notifier.prevStep(),
        ),
        title: BilingualLabel(
          englishText: 'Wedding Planner',
          hindiText: 'विवाह योजनाकार',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          hindiStyle: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _ProgressPills(currentStep: state.currentStep, totalSteps: 6),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero)
                      .animate(animation),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey<int>(state.currentStep),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: _buildStepContent(state, notifier),
                ),
              ),
            ),
          ),
          _BottomNavigation(state: state, notifier: notifier),
        ],
      ),
    );
  }

  Widget _buildStepContent(WeddingSetupState state, WeddingSetupNotifier notifier) {
    switch (state.currentStep) {
      case 1:
        return _Step1Role(state: state, notifier: notifier);
      case 2:
        return _Step2Dates(state: state, notifier: notifier);
      case 3:
        return _Step3Events(state: state, notifier: notifier);
      case 4:
        return _Step4Prep(state: state, notifier: notifier);
      case 5:
        return _Step5Goals(state: state, notifier: notifier);
      case 6:
        return _Step6Summary(state: state, notifier: notifier);
      default:
        return const Center(child: Text('Step not found'));
    }
  }
}

// ─── Progress Pills ──────────────────────────────────────────────────────────

class _ProgressPills extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const _ProgressPills({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: List.generate(totalSteps, (i) {
          final isDone = i < currentStep - 1;
          final isActive = i == currentStep - 1;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isDone
                    ? AppColors.primary
                    : isActive
                        ? AppColors.weddingGoldStart
                        : AppColors.divider,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Step 1: Role Selection ───────────────────────────────────────────────────

class _Step1Role extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step1Role({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Who are you in this wedding?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'इस शादी में आपकी भूमिका क्या है?',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 28),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 120 / 155,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _IllustratedRoleCard(
                label: 'Bride',
                hindiLabel: 'दुल्हन',
                imagePath: 'assets/images/wedding/bride.png',
                isActive: state.role == WeddingRole.bride,
                onTap: () => notifier.setRole(WeddingRole.bride),
              ),
              _IllustratedRoleCard(
                label: 'Groom',
                hindiLabel: 'दूल्हा',
                imagePath: 'assets/images/wedding/groom.png',
                isActive: state.role == WeddingRole.groom,
                onTap: () => notifier.setRole(WeddingRole.groom),
              ),
              _IllustratedRoleCard(
                label: 'Guest',
                hindiLabel: 'मेहमान',
                imagePath: 'assets/images/wedding/guest.png',
                isActive: state.role == WeddingRole.guest,
                onTap: () => notifier.setRole(WeddingRole.guest),
              ),
              _IllustratedRoleCard(
                label: 'Relative',
                hindiLabel: 'रिश्तेदार',
                imagePath: 'assets/images/wedding/relative.png',
                isActive: state.role == WeddingRole.relative,
                onTap: () => notifier.setRole(WeddingRole.relative),
              ),
            ],
          ),
          if (state.role == WeddingRole.relative) ...[
            const SizedBox(height: 28),
            const Text(
              'What is your relation?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
            ),
            const Text(
              'रिश्ता क्या है?',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                'Father of Bride', 'Mother of Bride',
                'Father of Groom', 'Mother of Groom',
                'Sibling', 'Close Family',
              ].map((r) {
                final isSelected = state.relativeType == r;
                return GestureDetector(
                  onTap: () => notifier.setRelativeType(r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primarySurface : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.divider,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Text(
                      r,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _IllustratedRoleCard extends StatelessWidget {
  final String label;
  final String hindiLabel;
  final String imagePath;
  final bool isActive;
  final VoidCallback onTap;

  const _IllustratedRoleCard({
    required this.label,
    required this.hindiLabel,
    required this.imagePath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.divider,
            width: isActive ? 2.0 : 1.0,
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 12,
                spreadRadius: 2,
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 4),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 56, color: AppColors.textMuted),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                      color: isActive ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hindiLabel,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  if (isActive) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 12),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Step 2: Dates ────────────────────────────────────────────────────────────

class _Step2Dates extends ConsumerWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step2Dates({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check for festival overlaps with the selected date range
    final festivalOverlap = ref.watch(upcomingFestivalsProvider).when(
          data: (festivals) {
            if (state.dateRange == null) return null;
            try {
              return festivals.firstWhere(
                (f) => f.startDate.isBefore(state.dateRange!.end) &&
                    f.endDate.isAfter(state.dateRange!.start),
              );
            } catch (_) {
              return null;
            }
          },
          loading: () => null,
          error: (_, __) => null,
        );

    final duration = state.dateRange?.duration.inDays ?? 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'When is the wedding?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const Text('शादी कब है?', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () async {
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 730)),
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.weddingGoldStart,
                      onPrimary: Colors.white,
                      surface: AppColors.surface,
                    ),
                  ),
                  child: child!,
                ),
              );
              if (range != null) {
                if (range.duration.inDays > 14) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wedding period cannot exceed 14 days.')),
                  );
                } else {
                  notifier.setDateRange(range);
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: state.dateRange != null ? AppColors.weddingGoldStart : AppColors.divider,
                  width: state.dateRange != null ? 1.5 : 1,
                ),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.calendar_month_rounded, color: AppColors.weddingGoldStart, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: state.dateRange == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Select Wedding Dates', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textPrimary)),
                              SizedBox(height: 2),
                              Text('Tap to pick a date range (up to 14 days)', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_fmt(state.dateRange!.start)} – ${_fmt(state.dateRange!.end)}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$duration day${duration == 1 ? '' : 's'} of festivities',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                ],
              ),
            ),
          ),
          if (festivalOverlap != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppColors.accent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '🎉 Dates overlap with ${festivalOverlap.nameEn}! Plan for festive meals, delays, and lighter event schedules during the festival.',
                      style: const TextStyle(color: Color(0xFF5D4037), fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  static String _fmt(DateTime d) =>
      '${d.day} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.month - 1]}';
}

// ─── Step 3: Events ───────────────────────────────────────────────────────────

class _Step3Events extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step3Events({required this.state, required this.notifier});

  static const _events = [
    {'key': 'haldi',     'en': 'Haldi',    'hi': 'हल्दी',    'icon': '🥣', 'color': 0xFFFFF9C4},
    {'key': 'mehendi',   'en': 'Mehendi',  'hi': 'मेहँदी',   'icon': '🎨', 'color': 0xFFE8F5E9},
    {'key': 'sangeet',   'en': 'Sangeet',  'hi': 'संगीत',    'icon': '💃', 'color': 0xFFE3F2FD},
    {'key': 'baraat',    'en': 'Baraat',   'hi': 'बारात',    'icon': '🎺', 'color': 0xFFEDE7F6},
    {'key': 'vivah',     'en': 'Vivah',    'hi': 'विवाह',    'icon': '💍', 'color': 0xFFFCE4EC},
    {'key': 'reception', 'en': 'Reception','hi': 'रिसेप्शन', 'icon': '🥂', 'color': 0xFFE0F7FA},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Which events are happening?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const Text(
          'कौन से आयोजन होंगे? (सभी चुनें)',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.4,
            ),
            itemCount: _events.length,
            itemBuilder: (context, i) {
              final e = _events[i];
              final isSelected = state.selectedEvents.contains(e['key']);
              return GestureDetector(
                onTap: () => notifier.toggleEvent(e['key'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primarySurface
                        : Color(e['color'] as int),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(e['icon'] as String, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e['en'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              e['hi'] as String,
                              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Step 4: Prep Time ────────────────────────────────────────────────────────

class _Step4Prep extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step4Prep({required this.state, required this.notifier});

  static const _options = [
    {'label': '1 Week', 'sub': 'Quick start', 'weeks': '1'},
    {'label': '2 Weeks', 'sub': 'Rapid plan', 'weeks': '2'},
    {'label': '4 Weeks', 'sub': 'Recommended', 'weeks': '4'},
    {'label': '8 Weeks', 'sub': 'Full plan', 'weeks': '8'},
    {'label': 'Already wedding week', 'sub': 'Event-day guide only', 'weeks': '0'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How long to prepare?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const Text(
          'तैयारी के लिए कितना समय है?',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        Expanded(
          child: ListView.separated(
            itemCount: _options.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final o = _options[i];
              final isSelected = state.prepWeeks == o['weeks'];
              return GestureDetector(
                onTap: () => notifier.setPrepWeeks(o['weeks'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primarySurface : AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.divider,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o['label'] as String,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              o['sub'] as String,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22)
                      else
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.divider, width: 2),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Step 5: Goals ────────────────────────────────────────────────────────────

class _Step5Goals extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step5Goals({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final isBrideOrGroom =
        state.role == WeddingRole.bride || state.role == WeddingRole.groom;

    final goals = isBrideOrGroom
        ? [
            {'key': 'tone_up', 'icon': '💪', 'en': 'Look My Best', 'hi': 'सबसे अच्छा दिखना', 'sub': 'Tone up, glow & feel confident'},
            {'key': 'energised', 'icon': '⚡', 'en': 'Feel Energised', 'hi': 'ऊर्जावान रहना', 'sub': 'Stamina through long event days'},
            {'key': 'manage_stress', 'icon': '🧘', 'en': 'Manage Stress', 'hi': 'तनाव कम करना', 'sub': 'Calm mind through the celebration'},
            {'key': 'manage_indulgence', 'icon': '🍽', 'en': 'Stay on Track', 'hi': 'संयमित रहना', 'sub': 'Mindful eating at festivities'},
          ]
        : [
            {'key': 'manage_indulgence', 'icon': '🍽', 'en': 'Manage Indulgence', 'hi': 'भोजन संयम', 'sub': 'Enjoy feasts without overdoing it'},
            {'key': 'energised', 'icon': '🏃', 'en': 'Stay Active', 'hi': 'सक्रिय रहना', 'sub': 'Keep your energy up across events'},
            {'key': 'manage_stress', 'icon': '📅', 'en': 'Maintain Routine', 'hi': 'दिनचर्या बनाए रखें', 'sub': 'Stick to your regular habits'},
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s your primary goal?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const Text(
          'आपका मुख्य लक्ष्य क्या है?',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            itemCount: goals.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final g = goals[i];
              final isSelected = state.primaryGoal == g['key'];
              return GestureDetector(
                onTap: () => notifier.setPrimaryGoal(g['key'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primarySurface : AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.divider,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(g['icon'] as String, style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              g['en'] as String,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            Text(g['hi'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            const SizedBox(height: 2),
                            Text(g['sub'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22)
                      else
                        Container(
                          width: 22, height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.divider, width: 2),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Step 6: Summary ─────────────────────────────────────────────────────────

class _Step6Summary extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step6Summary({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final roleLabel = {
      WeddingRole.bride: '👰 Bride',
      WeddingRole.groom: '🤵 Groom',
      WeddingRole.guest: '🎉 Guest',
      WeddingRole.relative: '👨‍👩‍👧 Relative',
    }[state.role] ?? 'Not set';

    final goalLabel = {
      'tone_up': '💪 Look My Best',
      'energised': '⚡ Feel Energised',
      'manage_stress': '🧘 Manage Stress',
      'manage_indulgence': '🍽 Manage Indulgence',
    }[state.primaryGoal] ?? state.primaryGoal ?? '—';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Wedding Plan is Ready! 🎊',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const Text('आपकी शादी की योजना तैयार है!', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          // Summary card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
            ),
            child: Column(
              children: [
                _SummaryRow(icon: '👤', label: 'Role', value: roleLabel),
                if (state.relativeType != null)
                  _SummaryRow(icon: '🔗', label: 'Relation', value: state.relativeType!),
                _SummaryRow(
                  icon: '📅',
                  label: 'Dates',
                  value: state.dateRange != null
                      ? '${_fmt(state.dateRange!.start)} – ${_fmt(state.dateRange!.end)}'
                      : '—',
                ),
                _SummaryRow(icon: '🎊', label: 'Events', value: state.selectedEvents.length.toString()),
                _SummaryRow(icon: '⏰', label: 'Prep Time', value: _prepLabel(state.prepWeeks)),
                _SummaryRow(icon: '🎯', label: 'Goal', value: goalLabel),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // What's included
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.weddingGoldGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '📋 Your personalised plan includes:',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 12),
                _PlanFeature('Pre-wedding diet & fitness schedule'),
                _PlanFeature('Event-by-event meal guides'),
                _PlanFeature('Bloat-free wedding day nutrition'),
                _PlanFeature('Post-wedding 3-day recovery plan'),
                _PlanFeature('Rule-based daily plan updates'),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  static String _fmt(DateTime d) =>
      '${d.day} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][d.month - 1]}';

  static String _prepLabel(String? w) {
    switch (w) {
      case '0': return 'Already wedding week';
      case '1': return '1 week';
      case '2': return '2 weeks';
      case '4': return '4 weeks';
      case '8': return '8 weeks';
      default: return '—';
    }
  }
}

class _SummaryRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const _SummaryRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _PlanFeature extends StatelessWidget {
  final String text;
  const _PlanFeature(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13))),
        ],
      ),
    );
  }
}

// ─── Bottom Navigation ────────────────────────────────────────────────────────

class _BottomNavigation extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _BottomNavigation({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final isLastStep = state.currentStep == 6;
    final canProceed = _validateStep(state);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: canProceed && !state.isSubmitting
                ? () {
                    if (isLastStep) {
                      notifier.completeSetup().then((_) => context.go('/wedding-planner'));
                    } else {
                      notifier.nextStep();
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isLastStep ? AppColors.weddingGoldStart : AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              disabledBackgroundColor: AppColors.divider,
            ),
            child: state.isSubmitting
                ? const SizedBox(
                    width: 22, height: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLastStep ? '🚀  Start My Wedding Plan' : 'Next →',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  bool _validateStep(WeddingSetupState state) {
    switch (state.currentStep) {
      case 1:
        return state.role != null &&
            (state.role != WeddingRole.relative || state.relativeType != null);
      case 2:
        return state.dateRange != null;
      case 3:
        return state.selectedEvents.isNotEmpty;
      case 4:
        return state.prepWeeks != null;
      case 5:
        return state.primaryGoal != null;
      case 6:
        return true;
      default:
        return false;
    }
  }
}
