import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout', style: AppTextStyles.titleLarge)),
      body: const Center(child: Text('Workout Tracker')),
    );
  }
}
