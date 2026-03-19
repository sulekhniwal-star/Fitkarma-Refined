import 'package:flutter/material.dart';

class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Feed')),
      body: const Center(child: Text('Social Feed module loaded deferred.')),
    );
  }
}
