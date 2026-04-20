import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';
import 'dart:ui';

/// Actions available in the Quick Log Speed Dial.
enum QuickLogAction { food, water, mood, workout, bp, glucose }

/// A speed-dial Floating Action Button for quick health logging.
/// 
/// Expands to show multiple sub-actions with a staggered animation and 
/// an interactive overlay scrim.
class QuickLogFAB extends StatefulWidget {
  final Map<QuickLogAction, VoidCallback> onActions;

  const QuickLogFAB({super.key, required this.onActions});

  @override
  State<QuickLogFAB> createState() => _QuickLogFABState();
}

class _QuickLogFABState extends State<QuickLogFAB>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  final List<_QuickLogButtonData> _buttons = [
    _QuickLogButtonData(
      action: QuickLogAction.food,
      label: 'Food 🍽',
      icon: Icons.restaurant_rounded,
    ),
    _QuickLogButtonData(
      action: QuickLogAction.water,
      label: 'Water 💧',
      icon: Icons.water_drop_rounded,
    ),
    _QuickLogButtonData(
      action: QuickLogAction.mood,
      label: 'Mood 😊',
      icon: Icons.sentiment_satisfied_alt_rounded,
    ),
    _QuickLogButtonData(
      action: QuickLogAction.workout,
      label: 'Workout 💪',
      icon: Icons.fitness_center_rounded,
    ),
    _QuickLogButtonData(
      action: QuickLogAction.bp,
      label: 'BP 🩺',
      icon: Icons.monitor_heart_rounded,
    ),
    _QuickLogButtonData(
      action: QuickLogAction.glucose,
      label: 'Glucose 🩸',
      icon: Icons.bloodtype_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        // Scrim Overlay
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ),
          ),

        // Sub-buttons
        ...List.generate(_buttons.length, (index) {
          final button = _buttons[index];
          return _buildStepChild(index, button);
        }),

        // Main FAB
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (_isExpanded)
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: AppTheme.primary,
            elevation: 4,
            shape: const CircleBorder(),
            child: AnimatedRotation(
              turns: _isExpanded ? 0.125 : 0, // 45 degrees for X
              duration: const Duration(milliseconds: 250),
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepChild(int index, _QuickLogButtonData data) {
    // Fixed distance from bottom for each button
    final double bottomMargin = 72.0 + (index * 56.0);

    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        final double value = _expandAnimation.value;
        // Stagger logic
        final double stagger = (index / _buttons.length) * 0.5;
        final double animValue = (value - stagger).clamp(0.0, 1.0) / (1.0 - stagger);

        return Positioned(
          right: 8,
          bottom: bottomMargin * animValue,
          child: Opacity(
            opacity: animValue,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (animValue > 0.8)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.surface0.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          data.label,
                          style: AppTheme.labelMd(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: FloatingActionButton(
                    heroTag: 'quick_log_${data.action.name}',
                    onPressed: () {
                      _toggle();
                      widget.onActions[data.action]?.call();
                    },
                    backgroundColor: AppTheme.bg2,
                    mini: true,
                    elevation: 2,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: AppTheme.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(data.icon, color: AppTheme.primary, size: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuickLogButtonData {
  final QuickLogAction action;
  final String label;
  final IconData icon;

  const _QuickLogButtonData({
    required this.action,
    required this.label,
    required this.icon,
  });
}

