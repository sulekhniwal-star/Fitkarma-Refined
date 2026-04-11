import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/health/data/health_repository.dart';
import 'water_intake_dialog.dart';
import 'quick_log_fab.dart';

class MainScaffold extends ConsumerStatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // Navigation logic
          final routes = ['/home', '/food', '/workout', '/steps', '/me'];
          context.go(routes[index]);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home · मुख्य',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_outlined),
            activeIcon: Icon(Icons.restaurant),
            label: 'Food · भोजन',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: 'Workout · व्यायाम',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk_outlined),
            activeIcon: Icon(Icons.directions_walk),
            label: 'Steps · कदम',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Me · मैं',
          ),
        ],
      ),
      floatingActionButton: QuickLogFAB(
        onFood: () => context.push('/food/search'),
        onWorkout: () => context.push('/workout/log'),
        onBp: () => context.push('/health/bp'),
        onGlucose: () => context.push('/health/glucose'),
        onWater: _showWaterDialog,
        onMood: () => context.push('/lifestyle/mood'),
      ),
    );
  }

  void _showWaterDialog() {
    showDialog(
      context: context,
      builder: (context) => WaterIntakeDialog(
        onSave: (glasses) async {
          await ref.read(healthRepositoryProvider).saveWaterIntake(glasses);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Logged $glasses glasses of water! 💧')),
            );
          }
        },
      ),
    );
  }
}
