import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        // Scrim Overlay
        if (_isExpanded)
          Positioned.fill(
              child: GestureDetector(
            onTap: _toggle,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          )),

        // Sub-buttons
        ...List.generate(_buttons.length, (index) {
          final button = _buttons[index];
          return _buildStepChild(index, button, isDark);
        }),

        // Main FAB
        FloatingActionButton(
          onPressed: _toggle,
          backgroundColor: primaryColor,
          elevation: 4,
          shape: const CircleBorder(),
          child: AnimatedRotation(
            turns: _isExpanded ? 0.125 : 0, // 45 degrees for X
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildStepChild(int index, _QuickLogButtonData data, bool isDark) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final surfaceColor = isDark ? AppColorsDark.surface : AppColors.surface;

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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      data.label,
                      style: AppTextStyles.labelLarge(isDark: isDark),
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
                    backgroundColor: surfaceColor,
                    mini: true,
                    elevation: 2,
                    shape: const CircleBorder(),
                    child: Icon(data.icon, color: primaryColor, size: 20),
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
