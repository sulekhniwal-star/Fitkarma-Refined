import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food', style: AppTextStyles.titleLarge)),
      body: const Center(child: Text('Food Tracker')),
    );
  }
}
