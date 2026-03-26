import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/period/data/period_providers.dart';
import 'package:fitkarma/features/period/data/period_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class PeriodTrackingScreen extends ConsumerStatefulWidget {
  const PeriodTrackingScreen({super.key});

  @override
  ConsumerState<PeriodTrackingScreen> createState() =>
      _PeriodTrackingScreenState();
}

class _PeriodTrackingScreenState extends ConsumerState<PeriodTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: Get userId from auth
    const String userId = 'demo_user';

    final cycleInfoAsync = ref.watch(periodCycleInfoProvider(userId));

    // Get workout suggestions with a default phase
    CyclePhase currentPhase = CyclePhase.unknown;
    cycleInfoAsync.whenData((info) {
      currentPhase = info.currentPhase;
    });

    final workoutSuggestions = ref.watch(
      workoutSuggestionsProvider(currentPhase),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Period Tracking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to period settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cycle Phase Card
            _buildCyclePhaseCard(cycleInfoAsync),
            const SizedBox(height: 16),

            // Predictions Card
            _buildPredictionsCard(cycleInfoAsync),
            const SizedBox(height: 16),

            // Log Period Button
            _buildLogPeriodButton(context),
            const SizedBox(height: 16),

            // Symptom Tracking
            _buildSymptomTrackingSection(context),
            const SizedBox(height: 16),

            // Workout Suggestions
            _buildWorkoutSuggestionsSection(workoutSuggestions),
            const SizedBox(height: 16),

            // PCOD/PCOS Mode Toggle
            _buildPcodModeToggle(context, cycleInfoAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildCyclePhaseCard(AsyncValue<PeriodCycleInfo> cycleInfoAsync) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Phase', style: AppTextStyles.h4),
            const SizedBox(height: 8),
            cycleInfoAsync.when(
              data: (info) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPhaseIndicator(info.currentPhase),
                  const SizedBox(height: 8),
                  Text(
                    _getPhaseDescription(info.currentPhase),
                    style: AppTextStyles.bodyMedium,
                  ),
                  if (info.isPcodPcosMode) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 16,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'PCOD/PCOS Mode Active',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error loading data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(CyclePhase phase) {
    final colors = {
      CyclePhase.menstrual: AppColors.error,
      CyclePhase.follicular: AppColors.success,
      CyclePhase.ovulation: AppColors.primary,
      CyclePhase.luteal: AppColors.warning,
      CyclePhase.unknown: AppColors.textMuted,
    };

    final labels = {
      CyclePhase.menstrual: 'Menstrual Phase',
      CyclePhase.follicular: 'Follicular Phase',
      CyclePhase.ovulation: 'Ovulation',
      CyclePhase.luteal: 'Luteal Phase',
      CyclePhase.unknown: 'Not Tracking',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors[phase]?.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getPhaseIcon(phase), color: colors[phase], size: 20),
          const SizedBox(width: 8),
          Text(
            labels[phase] ?? 'Unknown',
            style: AppTextStyles.bodyLarge.copyWith(
              color: colors[phase],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPhaseIcon(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return Icons.water_drop;
      case CyclePhase.follicular:
        return Icons.wb_sunny;
      case CyclePhase.ovulation:
        return Icons.brightness_7;
      case CyclePhase.luteal:
        return Icons.nights_stay;
      case CyclePhase.unknown:
        return Icons.help_outline;
    }
  }

  String _getPhaseDescription(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return 'Day 1-5: Your period phase. Rest and hydrate.';
      case CyclePhase.follicular:
        return 'Day 6-13: Energy rising. Great time for intense workouts!';
      case CyclePhase.ovulation:
        return 'Day 14-16: Fertile window. Stay hydrated.';
      case CyclePhase.luteal:
        return 'Day 17-28: Premenstrual phase. Gentle activities recommended.';
      case CyclePhase.unknown:
        return 'Start tracking to get personalized insights.';
    }
  }

  Widget _buildPredictionsCard(AsyncValue<PeriodCycleInfo> cycleInfoAsync) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Predictions', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            cycleInfoAsync.when(
              data: (info) => Column(
                children: [
                  _buildPredictionRow(
                    icon: Icons.event,
                    label: 'Next Period',
                    value: info.nextPeriodDate != null
                        ? '${info.nextPeriodDate!.day}/${info.nextPeriodDate!.month}'
                        : 'Not enough data',
                    daysUntil: info.daysUntilNextPeriod,
                  ),
                  const Divider(),
                  _buildPredictionRow(
                    icon: Icons.favorite,
                    label: 'Ovulation',
                    value: info.ovulationDate != null
                        ? '${info.ovulationDate!.day}/${info.ovulationDate!.month}'
                        : 'Not enough data',
                    isOvulation: true,
                  ),
                  const Divider(),
                  _buildPredictionRow(
                    icon: Icons.loop,
                    label: 'Avg Cycle Length',
                    value: info.averageCycleLength != null
                        ? '${info.averageCycleLength} days'
                        : 'Not enough data',
                  ),
                  const Divider(),
                  _buildPredictionRow(
                    icon: Icons.water_drop,
                    label: 'Avg Period Length',
                    value: info.averagePeriodLength != null
                        ? '${info.averagePeriodLength} days'
                        : 'Not enough data',
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Text('Error loading predictions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionRow({
    required IconData icon,
    required String label,
    required String value,
    int? daysUntil,
    bool isOvulation = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: isOvulation ? AppColors.primary : AppColors.textMuted,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodyMedium),
                Text(value, style: AppTextStyles.caption),
              ],
            ),
          ),
          if (daysUntil != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isOvulation
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : AppColors.error.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isOvulation ? ' Fertile ' : ' $daysUntil days ',
                style: AppTextStyles.caption.copyWith(
                  color: isOvulation ? AppColors.primary : AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogPeriodButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showLogPeriodDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Log Period Day'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  void _showLogPeriodDialog(BuildContext context) {
    String selectedFlow = 'medium';
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Log Period Day', style: AppTextStyles.h4),
              const SizedBox(height: 16),

              // Date picker
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Date'),
                subtitle: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setModalState(() => selectedDate = date);
                  }
                },
              ),

              // Flow intensity
              const Text('Flow Intensity'),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildFlowChip(
                    'light',
                    'Light',
                    setModalState,
                    selectedFlow,
                    (v) => selectedFlow = v,
                  ),
                  _buildFlowChip(
                    'medium',
                    'Medium',
                    setModalState,
                    selectedFlow,
                    (v) => selectedFlow = v,
                  ),
                  _buildFlowChip(
                    'heavy',
                    'Heavy',
                    setModalState,
                    selectedFlow,
                    (v) => selectedFlow = v,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Save period log
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Period logged!')),
                    );
                  },
                  child: const Text('Save'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlowChip(
    String value,
    String label,
    StateSetter setState,
    String selected,
    Function(String) onSelected,
  ) {
    final isSelected = value == selected;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (s) {
          if (s) onSelected(value);
          setState(() {});
        },
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildSymptomTrackingSection(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Symptoms Today', style: AppTextStyles.h4),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showSymptomsDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSymptomChip('Cramps', '😫'),
                _buildSymptomChip('Bloating', '🫃'),
                _buildSymptomChip('Mood Swings', '😤'),
                _buildSymptomChip('Headache', '🤕'),
                _buildSymptomChip('Fatigue', '😴'),
                _buildSymptomChip('Spotting', '💧'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomChip(String label, String emoji) {
    return FilterChip(
      avatar: Text(emoji),
      label: Text(label),
      selected: false,
      onSelected: (selected) {
        // Toggle symptom
      },
    );
  }

  void _showSymptomsDialog(BuildContext context) {
    final selectedSymptoms = <String>{};

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Track Symptoms', style: AppTextStyles.h4),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSymptomToggle(
                    'Cramps',
                    '😫',
                    selectedSymptoms,
                    setModalState,
                  ),
                  _buildSymptomToggle(
                    'Bloating',
                    '🫃',
                    selectedSymptoms,
                    setModalState,
                  ),
                  _buildSymptomToggle(
                    'Mood Swings',
                    '😤',
                    selectedSymptoms,
                    setModalState,
                  ),
                  _buildSymptomToggle(
                    'Headache',
                    '🤕',
                    selectedSymptoms,
                    setModalState,
                  ),
                  _buildSymptomToggle(
                    'Fatigue',
                    '😴',
                    selectedSymptoms,
                    setModalState,
                  ),
                  _buildSymptomToggle(
                    'Spotting',
                    '💧',
                    selectedSymptoms,
                    setModalState,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Saved symptoms: ${selectedSymptoms.join(", ")}',
                        ),
                      ),
                    );
                  },
                  child: const Text('Save Symptoms'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomToggle(
    String label,
    String emoji,
    Set<String> selected,
    StateSetter setModalState,
  ) {
    final isSelected = selected.contains(label);
    return FilterChip(
      avatar: Text(emoji),
      label: Text(label),
      selected: isSelected,
      onSelected: (s) {
        setModalState(() {
          if (s) {
            selected.add(label);
          } else {
            selected.remove(label);
          }
        });
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.3),
    );
  }

  Widget _buildWorkoutSuggestionsSection(List<WorkoutSuggestion> suggestions) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workout Suggestions', style: AppTextStyles.h4),
            const SizedBox(height: 8),
            Text(
              'Based on your current cycle phase',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 16),
            ...suggestions.map(
              (suggestion) => _buildSuggestionCard(suggestion),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(WorkoutSuggestion suggestion) {
    final intensityColors = {
      'low': AppColors.success,
      'medium': AppColors.warning,
      'high': AppColors.error,
      'any': AppColors.textMuted,
    };

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: intensityColors[suggestion.intensity]?.withValues(
            alpha: 0.2,
          ),
          child: Icon(
            Icons.fitness_center,
            color: intensityColors[suggestion.intensity],
          ),
        ),
        title: Text(suggestion.title),
        subtitle: Text(suggestion.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(suggestion.duration, style: AppTextStyles.caption),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: intensityColors[suggestion.intensity]?.withValues(
                  alpha: 0.2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                suggestion.intensity,
                style: AppTextStyles.caption.copyWith(
                  color: intensityColors[suggestion.intensity],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPcodModeToggle(
    BuildContext context,
    AsyncValue<PeriodCycleInfo> cycleInfoAsync,
  ) {
    bool isPcodMode = false;
    cycleInfoAsync.whenData((info) {
      isPcodMode = info.isPcodPcosMode;
    });

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.medical_services, color: AppColors.primary),
                const SizedBox(width: 8),
                Text('PCOD/PCOS Management', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enable PCOD/PCOS mode for adjusted cycle predictions and specialized recommendations.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('PCOD/PCOS Mode'),
              subtitle: Text(
                isPcodMode
                    ? 'Adjusted predictions for longer cycles (35-40 days)'
                    : 'Standard 28-day cycle predictions',
              ),
              value: isPcodMode,
              onChanged: (value) {
                // TODO: Toggle PCOD mode via service
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value
                          ? 'PCOD/PCOS mode enabled'
                          : 'PCOD/PCOS mode disabled',
                    ),
                  ),
                );
              },
              activeThumbColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
