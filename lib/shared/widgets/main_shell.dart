import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_nav_bar.dart';
import 'side_drawer.dart';
import 'quick_log_fab.dart';

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
          QuickLogAction.water: () {},
          QuickLogAction.mood: () => context.push('/mood'),
          QuickLogAction.workout: () => context.push('/home/workout/gps'),
          QuickLogAction.bp: () => context.push('/blood-pressure'),
          QuickLogAction.glucose: () => context.push('/glucose'),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
