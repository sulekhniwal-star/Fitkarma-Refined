import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_nav_bar.dart';
import 'side_drawer.dart';
import 'quick_log_fab.dart';
import 'bilingual_label.dart';
import '../../core/config/app_theme.dart';
import '../../features/nutrition/data/water_repository.dart';
import '../../features/auth/domain/auth_providers.dart';
import '../../features/dashboard/domain/dashboard_providers.dart';

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true, // Required for the notched FAB
      drawer: const SideDrawer(),
      body: navigationShell,
      bottomNavigationBar: FitKarmaBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
      floatingActionButton: QuickLogFAB(
        onActions: {
          QuickLogAction.food: () => context.push('/home/food/log/meal'),
          QuickLogAction.water: () => _showWaterDialog(context, ref),
          QuickLogAction.mood: () => context.push('/mood'),
          QuickLogAction.workout: () => context.push('/home/workout/gps'),
          QuickLogAction.bp: () => context.push('/blood-pressure'),
          QuickLogAction.glucose: () => context.push('/glucose'),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showWaterDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        decoration: BoxDecoration(
          color: AppTheme.surface0,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BilingualLabel(english: 'Log Water', hindi: 'पानी दर्ज करें'),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWaterOption(context, ref, '250ml', 250, Icons.local_drink_outlined),
                _buildWaterOption(context, ref, '500ml', 500, Icons.water_drop_outlined),
                _buildWaterOption(context, ref, '1L', 1000, Icons.opacity_rounded),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterOption(
    BuildContext context,
    WidgetRef ref,
    String label,
    int ml,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () async {
        final userId = ref.read(authStateProvider).value?.id;
        if (userId != null) {
          await ref.read(waterRepositoryProvider).logWater(
                userId: userId,
                amountMl: ml,
              );
          ref.invalidate(todayWaterProvider);
          if (context.mounted) Navigator.pop(context);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added $label of water 💧'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppTheme.primary,
              ),
            );
          }
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.bg2,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTheme.labelMd(context).copyWith(color: AppTheme.textPrimary),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

