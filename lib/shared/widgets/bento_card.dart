import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'glass_card.dart';

enum BentoSize { small, medium, large, wide, tall }

class BentoCard extends ConsumerWidget {
  final Widget child;
  final BentoSize size;
  final VoidCallback? onTap;

  const BentoCard({
    super.key,
    required this.child,
    this.size = BentoSize.medium,
    this.onTap,
  });

  double _getAspectRatio() {
    switch (size) {
      case BentoSize.small: return 1.0;
      case BentoSize.medium: return 1.2;
      case BentoSize.large: return 0.8;
      case BentoSize.wide: return 2.1;
      case BentoSize.tall: return 0.5;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: _getAspectRatio(),
        child: GlassCard(
          padding: EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
