import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Me', style: AppTextStyles.titleLarge)),
      body: const Center(child: Text('Profile')),
    );
  }
}
