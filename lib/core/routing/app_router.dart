import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/domain/auth_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/onboarding/presentation/onboarding_flow_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/food/presentation/food_home_screen.dart';
import '../../features/food/presentation/food_log_screen.dart';
import '../../features/food/presentation/wedding_meal_log_screen.dart';
import '../../features/food/presentation/lab_report_scan_screen.dart';
import '../../features/karma/presentation/karma_hub_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/auth/presentation/biomorphic_shield_screen.dart';
import '../../features/ayurveda/presentation/ayurveda_hub_screen.dart';
import '../../features/ayurveda/presentation/prakriti_quiz_screen.dart';
import '../security/security_providers.dart';
import '../../shared/widgets/main_shell.dart';

final appRouter = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final isAuthenticated = authState.value != null;

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final securityState = ref.read(securityNotifierProvider).valueOrNull;
      final isAuthenticated = authState.value != null;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';
      final isGoingToOnboarding = state.matchedLocation.startsWith('/onboarding');
      final isGoingToShield = state.matchedLocation == '/shield';
      final isSplash = state.matchedLocation == '/';

      // 1. Handle Biomorphic Security Lock
      if (securityState?.level == SecurityLevel.locked && !isGoingToShield) {
        return '/shield';
      }

      // 2. Prevent infinite loop if already at shield but unlocked
      if (securityState?.level == SecurityLevel.unlocked && isGoingToShield) {
        return '/home/dashboard';
      }

      // 3. Standard Auth Guard
      if (!isAuthenticated && !isGoingToLogin && !isGoingToRegister && !isGoingToOnboarding && !isSplash) {
        return '/login';
      }

      if (isAuthenticated && (isGoingToLogin || isGoingToRegister)) {
        return '/home/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const _PlaceholderScreen(name: 'SplashScreen'),
      ),
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
        builder: (context, state) => const OnboardingFlowScreen(),
      ),
      
      // Stateful shell for persistent tab state
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/food',
                builder: (context, state) => const FoodHomeScreen(),
                routes: [
                  GoRoute(
                    path: 'log/:mealType',
                    builder: (context, state) => FoodLogScreen(
                      mealType: state.pathParameters['mealType'] ?? 'meal',
                    ),
                  ),
                  GoRoute(
                    path: 'lab-scan',
                    builder: (context, state) => const LabReportScanScreen(),
                  ),
                  GoRoute(
                    path: 'log/wedding',
                    builder: (context, state) => const WeddingMealLogScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/workout',
                builder: (context, state) => const _PlaceholderScreen(name: 'WorkoutHomeScreen'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/steps',
                builder: (context, state) => const _PlaceholderScreen(name: 'StepsHomeScreen'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Other routes outside the main shell
      GoRoute(path: '/karma', builder: (context, state) => const KarmaHubScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/shield', builder: (context, state) => const BiomorphicShieldScreen()),
      GoRoute(path: '/ayurveda', builder: (context, state) => const AyurvedaHubScreen()),
      GoRoute(path: '/ayurveda/quiz', builder: (context, state) => const PrakritiQuizScreen()),
    ],
  );
});

// Temporary placeholder for unimplemented screens
class _PlaceholderScreen extends StatelessWidget {
  final String name;
  const _PlaceholderScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text('Coming Soon: $name')),
    );
  }
}
