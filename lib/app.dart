import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitKarmaApp extends StatelessWidget {
  const FitKarmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial router setup — will be expanded later
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Text(
                'Namaste FitKarma 🙏',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
            ),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'FitKarma',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}
