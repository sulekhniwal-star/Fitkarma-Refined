import 'package:flutter/material.dart';

class HomeWidgetPreview extends StatelessWidget {
  final double scale;
  final Widget child;
  final String platform;

  const HomeWidgetPreview({
    super.key,
    this.scale = 0.3,
    required this.child,
    this.platform = 'android',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: platform == 'ios' ? 155 : 180,
            height: platform == 'ios' ? 155 : 180,
            child: child,
          ),
        ),
      ),
    );
  }
}

class HomeWidgetGrid extends StatelessWidget {
  final List<Widget> androidWidgets;
  final List<Widget> iosWidgets;

  const HomeWidgetGrid({
    super.key,
    required this.androidWidgets,
    required this.iosWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Android',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: Row(
            children: androidWidgets.map((w) => Expanded(child: w)).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'iOS',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: Row(
            children: iosWidgets.map((w) => Expanded(child: w)).toList(),
          ),
        ),
      ],
    );
  }
}