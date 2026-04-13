import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'wedding_setup_notifier.dart';
import '../domain/wedding_setup_state.dart';
import '../../festival/presentation/festival_providers.dart';
import '../../../core/storage/app_database.dart';
import '../../../shared/widgets/bilingual_label.dart';

class WeddingSetupScreen extends ConsumerWidget {
  const WeddingSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weddingSetupProvider);
    final notifier = ref.read(weddingSetupProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Planner Setup'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => notifier.prevStep(),
        ),
      ),
      body: Column(
        children: [
          _ProgressIndicator(currentStep: state.currentStep, totalSteps: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildStepContent(state, notifier),
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

class _ProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const _ProgressIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isCompleted = index < currentStep - 1;
          final isActive = index == currentStep - 1;
          return Expanded(
            child: Container(
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isCompleted || isActive ? Colors.orange : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Step1Role extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step1Role({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your role in the wedding?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 120 / 140,
            children: [
              _RoleCard(
                label: 'Bride',
                icon: '👰',
                isActive: state.role == WeddingRole.bride,
                onTap: () => notifier.setRole(WeddingRole.bride),
              ),
              _RoleCard(
                label: 'Groom',
                icon: '🤵',
                isActive: state.role == WeddingRole.groom,
                onTap: () => notifier.setRole(WeddingRole.groom),
              ),
              _RoleCard(
                label: 'Guest',
                icon: '🎫',
                isActive: state.role == WeddingRole.guest,
                onTap: () => notifier.setRole(WeddingRole.guest),
              ),
              _RoleCard(
                label: 'Relative',
                icon: '🏠',
                isActive: state.role == WeddingRole.relative,
                onTap: () => notifier.setRole(WeddingRole.relative),
              ),
            ],
          ),
        ),
        if (state.role == WeddingRole.relative) ...[
          const SizedBox(height: 24),
          const Text('Select Relation:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['Parent', 'Sibling', 'Cousin', 'Uncle/Aunt', 'In-Law', 'Close Friend']
                .map((r) => ChoiceChip(
                      label: Text(r),
                      selected: state.relativeType == r,
                      onSelected: (val) => notifier.setRelativeType(r),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String label;
  final String icon;
  final bool isActive;
  final VoidCallback onTap;
  const _RoleCard({required this.label, required this.icon, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isActive ? Colors.orange : Colors.grey.shade200, width: 2),
          boxShadow: [
            if (isActive) BoxShadow(color: Colors.orange.withOpacity(0.1), blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(label, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _Step2Dates extends ConsumerWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step2Dates({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final festivalOverlap = ref.watch(upcomingFestivalsProvider).when(
          data: (festivals) {
            if (state.dateRange == null) return null;
            return festivals.firstWhere(
              (f) =>
                  (f.startDate.isBefore(state.dateRange!.end) && f.endDate.isAfter(state.dateRange!.start)),
              orElse: () => null as dynamic,
            );
          },
          loading: () => null,
          error: (_, __) => null,
        );

    final duration = state.dateRange?.duration.inDays ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'When is the wedding?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(state.dateRange == null
                    ? 'Pick Date Range'
                    : '${state.dateRange!.start.day}/${state.dateRange!.start.month} - ${state.dateRange!.end.day}/${state.dateRange!.end.month}'),
                subtitle: Text(state.dateRange == null ? 'Up to 14 days' : '$duration Days Duration'),
                trailing: const Icon(Icons.calendar_today, color: Colors.orange),
                onTap: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 730)),
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
              ),
            ],
          ),
        ),
        if (festivalOverlap != null) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Dates overlap with ${festivalOverlap.nameEn}! Be mindful of festive delays and heavy meals.',
                    style: const TextStyle(color: Colors.brown, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _Step3Events extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step3Events({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final events = [
      {'key': 'haldi', 'en': 'Haldi', 'hi': 'हल्दी', 'icon': '🥣'},
      {'key': 'mehendi', 'en': 'Mehendi', 'hi': 'मेहँदी', 'icon': '🎨'},
      {'key': 'sangeet', 'en': 'Sangeet', 'hi': 'संगीत', 'icon': '💃'},
      {'key': 'baraat', 'en': 'Baraat', 'hi': 'बारात', 'icon': '🎺'},
      {'key': 'vivah', 'en': 'Vivah', 'hi': 'विवाह', 'icon': '💍'},
      {'key': 'reception', 'en': 'Reception', 'hi': 'रिसेप्शन', 'icon': '🥂'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the events you are attending',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final e = events[index];
              final isSelected = state.selectedEvents.contains(e['key']);
              return GestureDetector(
                onTap: () => notifier.toggleEvent(e['key']!),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.orange.withOpacity(0.05) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isSelected ? Colors.orange : Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Text(e['icon']!, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(e['en']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(e['hi']!, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                      if (isSelected) const Icon(Icons.check_circle, color: Colors.orange, size: 18),
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

class _Step4Prep extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step4Prep({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final options = ['1w', '2w', '4w', '8w', 'Already wedding week'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How long do you have for prep?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((o) {
            final isSelected = state.prepWeeks == o;
            return ChoiceChip(
              label: Text(o),
              selected: isSelected,
              onSelected: (val) => notifier.setPrepWeeks(o),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _Step5Goals extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step5Goals({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final isMainRole = state.role == WeddingRole.bride || state.role == WeddingRole.groom;
    final goals = isMainRole
        ? ['Weight Loss', 'Glowing Skin', 'Posture Correction', 'Strength & Stamina', 'Stress Relief']
        : ['Fit in Outfit', 'Dance Performance Prep', 'Stay Energetic', 'Detox for Events'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your primary goal?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final g = goals[index];
              final isSelected = state.primaryGoal == g;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: RadioListTile<String>(
                  title: Text(g),
                  value: g,
                  groupValue: state.primaryGoal,
                  onChanged: (val) => notifier.setPrimaryGoal(val!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: isSelected ? Colors.orange : Colors.grey.shade200),
                  ),
                  activeColor: Colors.orange,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Step6Summary extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _Step6Summary({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Wedding Plan Summary',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _SummaryRow(label: 'Role', value: state.role?.name.toUpperCase() ?? ''),
                if (state.relativeType != null) _SummaryRow(label: 'Relation', value: state.relativeType!),
                _SummaryRow(
                  label: 'Dates',
                  value: state.dateRange != null
                      ? '${state.dateRange!.start.day}/${state.dateRange!.start.month} - ${state.dateRange!.end.day}/${state.dateRange!.end.month}'
                      : '-',
                ),
                _SummaryRow(label: 'Events', value: state.selectedEvents.length.toString()),
                _SummaryRow(label: 'Prep Duration', value: state.prepWeeks ?? ''),
                _SummaryRow(label: 'Goal', value: state.primaryGoal ?? ''),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final WeddingSetupState state;
  final WeddingSetupNotifier notifier;
  const _BottomNavigation({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
    final isLastStep = state.currentStep == 6;
    final canProceed = _validateStep(state);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: canProceed
                ? () {
                    if (isLastStep) {
                      notifier.completeSetup().then((_) => context.go('/home/dashboard'));
                    } else {
                      notifier.nextStep();
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: state.isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(isLastStep ? 'Start My Wedding Plan' : 'Next'),
          ),
        ),
      ),
    );
  }

  bool _validateStep(WeddingSetupState state) {
    switch (state.currentStep) {
      case 1:
        return state.role != null && (state.role != WeddingRole.relative || state.relativeType != null);
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
