import 'package:flutter/material.dart';

class WearablesScreen extends StatelessWidget {
  const WearablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wearable Devices')),
      body: const Center(child: Text('Wearables module loaded deferred.')),
    );
  }
}
