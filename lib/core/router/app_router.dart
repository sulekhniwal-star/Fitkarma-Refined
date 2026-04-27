import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/home/screens/dashboard_screen.dart';
import '../../features/karma/screens/karma_hub_screen.dart';
import 'biometric_guard.dart';

import '../../features/food/screens/food_home_screen.dart';
import '../../features/food/screens/food_log_screen.dart';
import '../../features/food/screens/food_detail_screen.dart';
import '../../features/food/screens/lab_scan_screen.dart';

import '../../features/workout/screens/workout_home_screen.dart';
import '../../features/workout/screens/workout_detail_screen.dart';
import '../../features/workout/screens/active_workout_screen.dart';
import '../../features/workout/screens/gps_workout_screen.dart';
import '../../features/workout/screens/custom_workout_builder_screen.dart';
import '../../features/steps/screens/steps_screen.dart';
import '../../features/health/screens/bp_screen.dart';
import '../../features/health/screens/glucose_screen.dart';
import '../../features/health/screens/spo2_screen.dart';
import '../../features/health/screens/body_metrics_screen.dart';
import '../../features/fasting/screens/fasting_timer_screen.dart';
import '../../features/reports/screens/lab_reports_screen.dart';
import '../../features/reports/screens/abha_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final onAuth = state.matchedLocation.startsWith('/auth') ||
                     state.matchedLocation == '/splash';

      if (!isLoggedIn && !onAuth) return '/auth/login';
      if (isLoggedIn && onAuth)  return '/home/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/splash',          builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/auth/login',      builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/auth/register',   builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/onboarding',      builder: (_, __) => const OnboardingScreen()),
      
      // Dashboard & Main Features
      GoRoute(
        path: '/home/dashboard',  
        builder: (_, __) => const DashboardScreen(),
      ),
      
      GoRoute(
        path: '/home/food',
        builder: (_, __) => const FoodHomeScreen(),
        routes: [
          GoRoute(
            path: 'log/:mealType',
            builder: (_, state) => FoodLogScreen(
              mealType: state.pathParameters['mealType'] ?? 'breakfast',
            ),
          ),
          GoRoute(
            path: 'detail/:id',
            builder: (_, state) => FoodDetailScreen(
              foodId: state.pathParameters['id'] ?? 'dal_rice',
            ),
          ),
          GoRoute(path: 'lab-scan', builder: (_, __) => const LabScanScreen()),
        ],
      ),
      
      GoRoute(
        path: '/home/workout',
        builder: (_, __) => const WorkoutHomeScreen(),
        routes: [
          GoRoute(path: 'gps',    builder: (_, __) => const GPSWorkoutScreen()),
          GoRoute(path: 'custom', builder: (_, __) => const CustomWorkoutBuilderScreen()),
          GoRoute(
            path: ':id',
            builder: (_, state) => WorkoutDetailScreen(
              workoutId: state.pathParameters['id'] ?? 'yoga_flow',
            ),
            routes: [
              GoRoute(
                path: 'active',
                builder: (_, state) => ActiveWorkoutScreen(
                  workoutId: state.pathParameters['id'] ?? 'yoga_flow',
                ),
              ),
            ],
          ),
        ],
      ),
      
      GoRoute(path: '/home/steps',      builder: (_, __) => const StepsScreen()),
      GoRoute(path: '/profile',         builder: (_, __) => const _PlaceholderScreen(name: 'Profile')),
      
      // Vitals & Health
      GoRoute(path: '/blood-pressure',  builder: (_, __) => const BPScreen()),
      GoRoute(path: '/glucose',         builder: (_, __) => const GlucoseScreen()),
      GoRoute(path: '/spo2',            builder: (_, __) => const SpO2Screen()),
      GoRoute(path: '/body-metrics',    builder: (_, __) => const BodyMetricsScreen()),
      GoRoute(path: '/fasting',         builder: (_, __) => const FastingTimerScreen()),
      GoRoute(path: '/sleep',           builder: (_, __) => const _PlaceholderScreen(name: 'Sleep')),
      GoRoute(path: '/period-tracker',  builder: (_, __) => const BiometricGuard(child: _PlaceholderScreen(name: 'Period Tracker'))),
      
      // Intelligence & Insights
      GoRoute(path: '/karma',           builder: (_, __) => const KarmaHubScreen()),
      GoRoute(path: '/journal',         builder: (_, __) => const BiometricGuard(child: _PlaceholderScreen(name: 'Journal'))),
      GoRoute(path: '/mood',            builder: (_, __) => const _PlaceholderScreen(name: 'Mood Tracker')),
      GoRoute(path: '/mental-health',   builder: (_, __) => const _PlaceholderScreen(name: 'Mental Health')),
      GoRoute(path: '/ayurveda',        builder: (_, __) => const _PlaceholderScreen(name: 'Ayurveda Profile')),
      GoRoute(path: '/habits',          builder: (_, __) => const _PlaceholderScreen(name: 'Habits')),
      
      // Specialized & Infrastructure
      GoRoute(path: '/lab-reports',     builder: (_, __) => const LabReportsScreen()),
      GoRoute(path: '/abha',            builder: (_, __) => const ABHAScreen()),
      GoRoute(path: '/settings',        builder: (_, __) => const _PlaceholderScreen(name: 'Settings')),
      GoRoute(path: '/emergency',       builder: (_, __) => const _PlaceholderScreen(name: 'Emergency Card')),
      
      GoRoute(
        path: '/festival-calendar', 
        builder: (_, __) => const _PlaceholderScreen(name: 'Festival Calendar'),
        routes: [
          GoRoute(path: ':festivalKey/diet', builder: (_, state) => _PlaceholderScreen(name: 'Diet for ${state.pathParameters['festivalKey']}')),
        ],
      ),
      
      GoRoute(
        path: '/wedding-planner', 
        builder: (_, __) => const _PlaceholderScreen(name: 'Wedding Planner'),
        routes: [
          GoRoute(path: 'setup', builder: (_, __) => const _PlaceholderScreen(name: 'Setup Plan')),
          GoRoute(path: 'event/:eventKey', builder: (_, state) => _PlaceholderScreen(name: 'Event ${state.pathParameters['eventKey']}')),
          GoRoute(path: 'recovery', builder: (_, __) => const _PlaceholderScreen(name: 'Post-Wedding Recovery')),
        ],
      ),
      
      GoRoute(path: '/wearables',       builder: (_, __) => const _PlaceholderScreen(name: 'Wearables')),
      GoRoute(path: '/reports',         builder: (_, __) => const _PlaceholderScreen(name: 'Health Reports')),
      GoRoute(path: '/subscription',    builder: (_, __) => const _PlaceholderScreen(name: 'Subscription')),
      GoRoute(path: '/home-widgets',    builder: (_, __) => const _PlaceholderScreen(name: 'Home Widgets')),
    ],
  );
});

class _PlaceholderScreen extends StatelessWidget {
  final String name;
  const _PlaceholderScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text('$name Screen Placeholder')),
    );
  }
}
