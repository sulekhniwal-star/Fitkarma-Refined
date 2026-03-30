import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class QuickLogFab extends StatefulWidget {
  final VoidCallback? onFoodLog;
  final VoidCallback? onWorkoutLog;
  final VoidCallback? onStepLog;
  final VoidCallback? onSleepLog;
  final VoidCallback? onMoodLog;
  final VoidCallback? onWaterLog;

  const QuickLogFab({
    super.key,
    this.onFoodLog,
    this.onWorkoutLog,
    this.onStepLog,
    this.onSleepLog,
    this.onMoodLog,
    this.onWaterLog,
  });

  @override
  State<QuickLogFab> createState() => _QuickLogFabState();
}

class _QuickLogFabState extends State<QuickLogFab>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      _isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildItem(Icons.restaurant_rounded, 'Food', widget.onFoodLog, 5),
        _buildItem(Icons.fitness_center_rounded, 'Workout', widget.onWorkoutLog, 4),
        _buildItem(Icons.directions_walk_rounded, 'Steps', widget.onStepLog, 3),
        _buildItem(Icons.bedtime_rounded, 'Sleep', widget.onSleepLog, 2),
        _buildItem(Icons.mood_rounded, 'Mood', widget.onMoodLog, 1),
        _buildItem(Icons.water_drop_rounded, 'Water', widget.onWaterLog, 0),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: _toggle,
          backgroundColor: AppColors.caloriesOrange,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animation,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
      IconData icon, String label, VoidCallback? onTap, int index) {
    return ScaleTransition(
      scale: _animation,
      child: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightShadow,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              FloatingActionButton.small(
                heroTag: 'fab_$label',
                onPressed: () {
                  _toggle();
                  onTap?.call();
                },
                backgroundColor: AppColors.caloriesOrange.withValues(alpha: 0.9),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
