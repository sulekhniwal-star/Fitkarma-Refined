// lib/features/food/presentation/food_log_screen.dart
// Food logging screen with search, quick actions, and meal tracking

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/food/data/food_providers.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/food/presentation/manual_entry_sheet.dart';
import 'package:fitkarma/features/food/presentation/barcode_scanner_screen.dart';
import 'package:fitkarma/features/food/presentation/scan_label_screen.dart';
import 'package:fitkarma/features/food/presentation/upload_plate_screen.dart';
import 'package:fitkarma/features/food/presentation/voice_search_screen.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Food log screen - main entry point for logging meals
class FoodLogScreen extends ConsumerStatefulWidget {
  const FoodLogScreen({super.key});

  @override
  ConsumerState<FoodLogScreen> createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends ConsumerState<FoodLogScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodState = ref.watch(foodLogProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Log Food'),
        backgroundColor: AppColors.surface,
        actions: [
          // Copy yesterday's meals button
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy yesterday\'s meals',
            onPressed: () => _copyYesterdayMeals(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Bilingual search bar
          _buildSearchBar(),

          // Meal type selector
          _buildMealTypeSelector(foodState),

          // Quick action chips
          _buildQuickActions(context),

          // Frequent Indian Portions
          if (foodState.frequentItems.isNotEmpty)
            _buildFrequentItems(foodState),

          // Recent Logs
          Expanded(child: _buildRecentLogs(foodState)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search foods... / खाद्य पदार्थ खोजें...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(foodLogProvider.notifier).loadTodayLogs();
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (value) {
          // TODO: Implement search
        },
      ),
    );
  }

  Widget _buildMealTypeSelector(FoodLogState state) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: MealType.values.map((mealType) {
          final isSelected = state.selectedMealType == mealType;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(mealType.emoji),
                  const SizedBox(width: 4),
                  Text(mealType.displayName),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(foodLogProvider.notifier).setMealType(mealType);
                }
              },
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              backgroundColor: AppColors.surface,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickActionChip(
                  icon: Icons.qr_code_scanner,
                  label: 'Barcode',
                  onTap: () => _openBarcodeScanner(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionChip(
                  icon: Icons.document_scanner,
                  label: 'Scan Label',
                  onTap: () => _openScanLabel(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QuickActionChip(
                  icon: Icons.photo_library,
                  label: 'Upload Plate',
                  onTap: () => _openUploadPlate(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _QuickActionChip(
                  icon: Icons.mic,
                  label: 'Voice',
                  onTap: () => _openVoiceSearch(context),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  void _openBarcodeScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );
  }

  void _openScanLabel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanLabelScreen()),
    );
  }

  void _openUploadPlate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadPlateScreen()),
    );
  }

  void _openVoiceSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VoiceSearchScreen()),
    );
  }

  Widget _buildFrequentItems(FoodLogState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Frequent Indian Portions',
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.frequentItems.length,
            itemBuilder: (context, index) {
              final log = state.frequentItems[index];
              return _FrequentItemCard(
                name: log.foodName,
                calories: log.calories,
                onTap: () {
                  // Quick log this item
                  ref
                      .read(foodLogProvider.notifier)
                      .logFood(
                        foodName: log.foodName,
                        foodItemId: log.foodItemId,
                        quantityG: log.quantityG,
                        calories: log.calories,
                        proteinG: log.proteinG,
                        carbsG: log.carbsG,
                        fatG: log.fatG,
                        fiberG: log.fiberG,
                      );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRecentLogs(FoodLogState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.todayLogs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No meals logged today',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to add your first meal',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Meals',
                style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              // Daily summary
              Text(
                '${state.dailyNutrition['calories']?.toStringAsFixed(0) ?? 0} kcal',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.todayLogs.length,
            itemBuilder: (context, index) {
              final log = state.todayLogs[index];
              return _FoodLogCard(
                log: log,
                onDelete: () {
                  ref.read(foodLogProvider.notifier).deleteLog(log.id);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showManualEntry(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ManualEntrySheet(),
    );
  }

  void _copyYesterdayMeals(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Copy Yesterday\'s Meals'),
        content: const Text(
          'This will add all of yesterday\'s meals to today\'s log. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Copy'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(foodLogProvider.notifier).copyYesterdayMeals();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('+5 XP earned! 🎉'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }
}

/// Quick action chip widget
class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Frequent item card
class _FrequentItemCard extends StatelessWidget {
  final String name;
  final double calories;
  final VoidCallback onTap;

  const _FrequentItemCard({
    required this.name,
    required this.calories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${calories.toStringAsFixed(0)} kcal',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Food log card
class _FoodLogCard extends StatelessWidget {
  final FoodLog log;
  final VoidCallback onDelete;

  const _FoodLogCard({required this.log, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log.foodName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${log.quantityG.toStringAsFixed(0)}g • ${log.mealType}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _MacroBadge(label: 'P', value: log.proteinG),
                      const SizedBox(width: 4),
                      _MacroBadge(label: 'C', value: log.carbsG),
                      const SizedBox(width: 4),
                      _MacroBadge(label: 'F', value: log.fatG),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${log.calories.toStringAsFixed(0)}',
                  style: AppTextStyles.statMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'kcal',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.error,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// Macro nutrient badge
class _MacroBadge extends StatelessWidget {
  final String label;
  final double value;

  const _MacroBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${value.toStringAsFixed(1)}g',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
