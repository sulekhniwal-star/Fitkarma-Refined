import 'package:flutter/material.dart';

class GpsWorkoutScreen extends StatelessWidget {
  const GpsWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Workout')),
      body: const Center(child: Text('GPS Workout Map')),
    );
  }
}
