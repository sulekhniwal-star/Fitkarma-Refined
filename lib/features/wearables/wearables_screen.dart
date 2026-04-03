import 'package:flutter/material.dart';

class WearablesScreen extends StatelessWidget {
  const WearablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wearables')),
      body: const Center(child: Text('Wearable Device Sync')),
    );
  }
}
