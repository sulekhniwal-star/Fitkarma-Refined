import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final glucoseLoggingProvider = NotifierProvider<GlucoseLoggingNotifier, GlucoseLoggingState>(GlucoseLoggingNotifier.new);

class GlucoseLoggingState {
  final int glucose;
  final String mealType;
  final int? linkedFoodLogId;
  final bool isLoading;
  final String? error;
  final bool logged;

  GlucoseLoggingState({
    this.glucose = 100,
    this.mealType = 'fasting',
    this.linkedFoodLogId,
    this.isLoading = false,
    this.error,
    this.logged = false,
  });

  GlucoseLoggingState copyWith({
    int? glucose,
    String? mealType,
    int? linkedFoodLogId,
    bool? isLoading,
    String? error,
    bool? logged,
  }) {
    return GlucoseLoggingState(
      glucose: glucose ?? this.glucose,
      mealType: mealType ?? this.mealType,
      linkedFoodLogId: linkedFoodLogId ?? this.linkedFoodLogId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      logged: logged ?? this.logged,
    );
  }

  GlucoseClassification get classification {
    if (mealType == 'fasting') {
      return DecryptedGlucoseLog.classifyFasting(glucose);
    } else if (mealType == 'post_meal') {
      return DecryptedGlucoseLog.classifyPostMeal2h(glucose);
    }
    return DecryptedGlucoseLog.classifyRandom(glucose);
  }
}

class GlucoseLoggingNotifier extends Notifier<GlucoseLoggingState> {
  @override
  GlucoseLoggingState build() => GlucoseLoggingState();

  void setGlucose(int v) => state = state.copyWith(glucose: v);
  void setMealType(String v) => state = state.copyWith(mealType: v);
  void setLinkedFoodLog(int? v) => state = state.copyWith(linkedFoodLogId: v);

  Future<void> saveLog(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(appDatabaseProvider);
      await db.glucoseLogsDao.insertLogWithKarma(
        userId: userId,
        glucoseMgdl: state.glucose,
        mealType: state.mealType,
        foodLogId: state.linkedFoodLogId,
      );
      state = state.copyWith(isLoading: false, logged: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() => state = GlucoseLoggingState();
}

class GlucoseLogScreen extends ConsumerStatefulWidget {
  final String userId;

  const GlucoseLogScreen({super.key, required this.userId});

  @override
  ConsumerState<GlucoseLogScreen> createState() => _GlucoseLogScreenState();
}

class _GlucoseLogScreenState extends ConsumerState<GlucoseLogScreen> {
  late TextEditingController _glucoseController;

  @override
  void initState() {
    super.initState();
    _glucoseController = TextEditingController(text: '100');
  }

  @override
  void dispose() {
    _glucoseController.dispose();
    super.dispose();
  }

  static const _mealTypes = [
    ('Fasting', 'fasting'),
    ('Post-meal (2h)', 'post_meal'),
    ('Random', 'random'),
    ('Bedtime', 'bedtime'),
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(glucoseLoggingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMealTypeSelector(state),
              const SizedBox(height: 24),
              _buildClassificationCard(state),
              const SizedBox(height: 24),
              _buildGlucoseInput(state),
              const SizedBox(height: 32),
              _buildSaveButton(state),
              if (state.error != null) ...[
                const SizedBox(height: 16),
                Text(state.error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealTypeSelector(GlucoseLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reading Type',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _mealTypes.map((type) {
            final isSelected = state.mealType == type.$2;
            return ChoiceChip(
              label: Text(type.$1),
              selected: isSelected,
              onSelected: (_) {
                ref.read(glucoseLoggingProvider.notifier).setMealType(type.$2);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildClassificationCard(GlucoseLoggingState state) {
    Color bgColor;
    String label;
    IconData icon;

    switch (state.classification) {
      case GlucoseClassification.low:
        bgColor = Colors.blue.shade600;
        label = 'Low';
        icon = Icons.arrow_downward;
        break;
      case GlucoseClassification.normal:
        bgColor = Colors.green.shade700.withValues(alpha: 0.2);
        label = 'Normal';
        icon = Icons.check_circle_outline;
        break;
      case GlucoseClassification.prediabetes:
        bgColor = Colors.yellow.shade700;
        label = 'Pre-diabetes';
        icon = Icons.info_outline;
        break;
      case GlucoseClassification.diabetes:
        bgColor = Colors.red.shade700;
        label = 'Diabetes Range';
        icon = Icons.warning_amber_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: state.classification == GlucoseClassification.normal 
              ? Colors.green.shade700 : Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: state.classification == GlucoseClassification.normal 
                        ? Colors.green.shade900 : Colors.white,
                  ),
                ),
                if (state.classification == GlucoseClassification.low) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'Consume fast-acting carbohydrate',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlucoseInput(GlucoseLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Blood Glucose',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _glucoseController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '100',
            suffixText: 'mg/dL',
            filled: true,
            fillColor: AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          onChanged: (v) {
            final val = int.tryParse(v) ?? 0;
            ref.read(glucoseLoggingProvider.notifier).setGlucose(val);
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(GlucoseLoggingState state) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : () async {
        final notifier = ref.read(glucoseLoggingProvider.notifier);
        await notifier.saveLog(widget.userId);
        if (mounted && ref.read(glucoseLoggingProvider).logged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Glucose logged! +5 XP'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: state.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}