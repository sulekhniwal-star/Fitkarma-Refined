import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

/// Speed-dial orange FAB with 6 sub-actions.
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
  late final AnimationController _controller;
  late final Animation<double> _animation;

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
    setState(() => _isOpen = !_isOpen);
    if (_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sub-actions (animated)
        ..._buildActions(),
        const SizedBox(height: 8),
        // Main FAB
        FloatingActionButton(
          backgroundColor: AppColors.accent,
          onPressed: _toggle,
          child: AnimatedRotation(
            turns: _isOpen ? 0.125 : 0,
            duration: const Duration(milliseconds: 250),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    final items = [
      _FabAction(Icons.restaurant, 'Food', widget.onFoodLog, AppColors.primary),
      _FabAction(Icons.fitness_center, 'Workout', widget.onWorkoutLog,
          const Color(0xFFE74C3C)),
      _FabAction(Icons.directions_walk, 'Steps', widget.onStepLog,
          const Color(0xFF3498DB)),
      _FabAction(Icons.bedtime, 'Sleep', widget.onSleepLog,
          const Color(0xFF9B59B6)),
      _FabAction(Icons.mood, 'Mood', widget.onMoodLog,
          const Color(0xFFF39C12)),
      _FabAction(Icons.water_drop, 'Water', widget.onWaterLog,
          const Color(0xFF00BCD4)),
    ];

    return items.map((item) {
      return SizeTransition(
        sizeFactor: _animation,
        child: FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SubAction(
              icon: item.icon,
              label: item.label,
              color: item.color,
              onTap: () {
                _toggle();
                item.onTap?.call();
              },
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _FabAction {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color color;

  _FabAction(this.icon, this.label, this.onTap, this.color);
}

class _SubAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SubAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: Text(label, style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 8),
        FloatingActionButton.small(
          backgroundColor: color,
          heroTag: label,
          onPressed: onTap,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}
