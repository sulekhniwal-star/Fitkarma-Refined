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
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/biomorphic_shield_screen.dart';
import '../../features/ayurveda/presentation/ayurveda_hub_screen.dart';
import '../../features/ayurveda/presentation/prakriti_quiz_screen.dart';
import '../security/security_providers.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../shared/widgets/main_shell.dart';

final appRouter = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final securityState = ref.read(securityProvider).value;
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
        builder: (context, state) => const SplashScreen(),
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
                    path: 'detail/:id',
                    builder: (context, state) => _PlaceholderScreen(name: 'Food Detail: ${state.pathParameters['id']}'),
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
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => _PlaceholderScreen(name: 'Workout Detail: ${state.pathParameters['id']}'),
                    routes: [
                      GoRoute(
                        path: 'active',
                        builder: (context, state) => _PlaceholderScreen(name: 'Active Workout: ${state.pathParameters['id']}'),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'gps',
                    builder: (context, state) => const _PlaceholderScreen(name: 'GPS Workout'),
                  ),
                  GoRoute(
                    path: 'custom',
                    builder: (context, state) => const _PlaceholderScreen(name: 'Custom Workout'),
                  ),
                ],
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
      
      // Additional feature modules
      GoRoute(path: '/blood-pressure', builder: (context, state) => const _PlaceholderScreen(name: 'BloodPressureScreen')),
      GoRoute(path: '/glucose', builder: (context, state) => const _PlaceholderScreen(name: 'GlucoseScreen')),
      GoRoute(path: '/spo2', builder: (context, state) => const _PlaceholderScreen(name: 'SpO2Screen')),
      GoRoute(path: '/lab-reports', builder: (context, state) => const _PlaceholderScreen(name: 'LabReportsScreen')),
      GoRoute(path: '/abha', builder: (context, state) => const _PlaceholderScreen(name: 'AbhaScreen')),
      GoRoute(path: '/appointments', builder: (context, state) => const _PlaceholderScreen(name: 'AppointmentsScreen')),
      GoRoute(path: '/fasting', builder: (context, state) => const _PlaceholderScreen(name: 'FastingTrackerScreen')),
      GoRoute(path: '/meditations', builder: (context, state) => const _PlaceholderScreen(name: 'MeditationScreen')),
      GoRoute(path: '/mood', builder: (context, state) => const _PlaceholderScreen(name: 'MoodTrackerScreen')),
      GoRoute(path: '/journal', builder: (context, state) => const _PlaceholderScreen(name: 'JournalScreen')),
      GoRoute(path: '/festival', builder: (context, state) => const _PlaceholderScreen(name: 'FestivalScreen')),
      GoRoute(path: '/wedding', builder: (context, state) => const _PlaceholderScreen(name: 'WeddingPlannerScreen')),
    ],
  );
});

// Temporary placeholder for unimplemented screens
class _PlaceholderScreen extends StatelessWidget {
  final String name;
  const _PlaceholderScreen({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text('Coming Soon: $name')),
    );
  }
}
