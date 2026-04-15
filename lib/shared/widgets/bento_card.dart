import 'package:flutter/material.dart';

enum BentoSize { full, half, third, twoThird, quarter }

class BentoCard extends StatelessWidget {
  final Widget child;
  final BentoSize size;
  final double aspectRatio;
  final VoidCallback? onTap;

  const BentoCard({
    super.key,
    required this.child,
    this.size = BentoSize.full,
    this.aspectRatio = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 16.0;
    final availableWidth = screenWidth - (padding * 2);
    
    // Auto-promotion logic from TODO §17
    final resolvedSize = _resolveSize(screenWidth);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: child,
    );
  }

  BentoSize _resolveSize(double screenWidth) {
    // Basic implementation of the Promotion logic
    if (screenWidth < 360) {
      if (size == BentoSize.quarter) return BentoSize.third;
      if (size == BentoSize.third) return BentoSize.half;
    }
    return size;
  }
}
