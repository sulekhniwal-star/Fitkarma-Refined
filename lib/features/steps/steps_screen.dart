import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

class StepsScreen extends StatelessWidget {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Steps', style: AppTextStyles.titleLarge)),
      body: const Center(child: Text('Step Counter')),
    );
  }
}
