import 'package:flutter/material.dart';

void main() {
  runApp(const FitKarmaApp());
}

class FitKarmaApp extends StatelessWidget {
  const FitKarmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitKarma',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('FitKarma - Coming Soon'),
        ),
      ),
    );
  }
}
