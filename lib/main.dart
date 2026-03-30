import 'package:flutter/material.dart';

void main() {
  runApp(const FitkarmaApp());
}

class FitkarmaApp extends StatelessWidget {
  const FitkarmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitkarma',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Fitkarma'),
        ),
      ),
    );
  }
}
