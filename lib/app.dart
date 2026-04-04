import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/storage/drift_service.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/onboarding/presentation/onboarding_screens.dart';
import 'shared/theme/app_theme.dart';

class FitKarmaApp extends ConsumerWidget {
  const FitKarmaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    final router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final user = authState.asData?.value;
        final isAuthPath = state.matchedLocation == '/login' || state.matchedLocation == '/register';
        final isOnboardingPath = state.matchedLocation == '/onboarding';

        // 1. Not logged in -> Go to Login/Register
        if (user == null) {
          return isAuthPath ? null : '/login';
        }

        // 2. Logged in and on Auth path -> Go to Home
        if (isAuthPath) {
          return '/';
        }

        // 3. Logged in but profile incomplete -> Go to Onboarding
        // (This will be expanded when we have a profile check)
        
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('FitKarma Dashboard')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome to FitKarma Dashboard'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.push('/onboarding'),
                    child: const Text('Go to Onboarding'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => ref.read(authRepositoryProvider).logout(),
                    child: const Text('Logout', style: TextStyle(color: Colors.red)),
                  ),
                ],
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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
