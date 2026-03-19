import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
    this.margin,
  });

  /// Standard variant for a large card
  factory ShimmerLoader.card({double height = 160}) => ShimmerLoader(
        width: double.infinity,
        height: height,
      );

  /// Standard variant for a line of text
  factory ShimmerLoader.text({double width = 200, double height = 16}) =>
      ShimmerLoader(
        width: width,
        height: height,
        borderRadius: 4,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Use divider color as base, with subtle highlights
    final Color baseColor = theme.dividerColor;
    final Color highlightColor = isDarkMode 
        ? Colors.white.withOpacity(0.05) 
        : Colors.white.withOpacity(0.5);

    return Container(
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        period: const Duration(milliseconds: 1500),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white, // Required for shimmer to work
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
