import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

/// A widget that provides a shimmer loading effect.
/// 
/// Used as a placeholder while data is being fetched. Uses the app divider 
/// and surface colors to match the design system.
class ShimmerLoader extends StatelessWidget {
  final Widget? child;

  const ShimmerLoader({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColorsDark.divider : AppColors.divider;
    final highlightColor = isDark ? AppColorsDark.surface : AppColors.surface;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child ??
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
