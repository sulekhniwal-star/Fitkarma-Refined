import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home', style: AppTextStyles.titleLarge)),
      body: const Center(child: Text('Home Dashboard')),
    );
  }
}
