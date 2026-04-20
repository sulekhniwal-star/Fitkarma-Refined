import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth & Core
import '../../features/auth/domain/auth_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/biomorphic_shield_screen.dart';
import '../../features/onboarding/presentation/onboarding_flow_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/dashboard/presentation/activity_hub_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../shared/widgets/main_shell.dart';
import '../security/security_providers.dart';

// Feature Modules - Health
import '../../features/blood_pressure/presentation/bp_tracker_screen.dart';
import '../../features/glucose/presentation/glucose_tracker_screen.dart';
import '../../features/fasting_tracker/presentation/fasting_tracker_screen.dart';
import '../../features/period/presentation/period_tracker_screen.dart';

// Feature Modules - Lifestyle
import '../../features/food/presentation/food_home_screen.dart';
import '../../features/food/presentation/food_log_screen.dart';
import '../../features/food/presentation/wedding_meal_log_screen.dart';
import '../../features/food/presentation/lab_report_scan_screen.dart';
import '../../features/steps/presentation/steps_home_screen.dart';
import '../../features/workout/presentation/workout_home_screen.dart';
import '../../features/sleep/presentation/sleep_tracker_screen.dart';
import '../../features/mood/presentation/mood_tracker_screen.dart';
import '../../features/habits/presentation/habit_tracker_screen.dart';

// Feature Modules - Knowledge & Community
import '../../features/ayurveda/presentation/ayurveda_hub_screen.dart';
import '../../features/ayurveda/presentation/prakriti_quiz_screen.dart';
import '../../features/karma/presentation/karma_hub_screen.dart';
import '../../features/social/presentation/social_feed_screen.dart';
import '../../features/social/presentation/community_groups_screen.dart';
import '../../features/social/presentation/referral_screen.dart';

// Feature Modules - Systems
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/abha/presentation/abha_screen.dart';
import '../../features/appointments/presentation/doctor_appointments_screen.dart';
import '../../features/lab_reports/presentation/lab_reports_home_screen.dart';
import '../../features/emergency/presentation/emergency_card_screen.dart';
import '../../features/subscription/presentation/subscription_plans_screen.dart';
import '../../features/wearables/presentation/wearable_connections_screen.dart';
import '../../features/festival/presentation/festival_calendar_screen.dart';
import '../../features/wedding_planner/presentation/wedding_planner_home_screen.dart';

final appRouter = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final userProfile = ref.read(userProfileProvider).value;
      final securityState = ref.read(securityProvider).value;
      
      final isAuthenticated = authState.value != null;
      final isOnboardingComplete = userProfile?.onboardingCompleted ?? false;

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

      // 4. Onboarding Guard
      if (isAuthenticated && !isOnboardingComplete && !isGoingToOnboarding && !isSplash) {
        return '/onboarding';
      }

      if (isAuthenticated && (isGoingToLogin || isGoingToRegister || (isOnboardingComplete && isGoingToOnboarding))) {
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
          // Branch 0: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          // Branch 1: Food
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
          // Branch 2: Activity
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/activity',
                builder: (context, state) => const ActivityHubScreen(),
                routes: [
                  GoRoute(
                    path: 'steps',
                    builder: (context, state) => const StepsHomeScreen(),
                  ),
                  GoRoute(
                    path: 'workout',
                    builder: (context, state) => const WorkoutHomeScreen(),
                    routes: [
                      GoRoute(
                        path: 'gps',
                        builder: (context, state) => _PlaceholderScreen(name: 'GPS Workout'),
                      ),
                      GoRoute(
                        path: ':id',
                        builder: (context, state) => _PlaceholderScreen(name: 'Workout Detail: ${state.pathParameters['id']}'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Branch 3: Profile
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
      
      // Health Trackers
      GoRoute(path: '/blood-pressure', builder: (context, state) => const BPTrackerScreen()),
      GoRoute(path: '/glucose', builder: (context, state) => const GlucoseTrackerScreen()),
      GoRoute(path: '/fasting', builder: (context, state) => const FastingTrackerScreen()),
      GoRoute(path: '/period', builder: (context, state) => const PeriodTrackerScreen()),
      GoRoute(path: '/sleep', builder: (context, state) => const SleepTrackerScreen()),
      GoRoute(path: '/mood', builder: (context, state) => const MoodTrackerScreen()),
      GoRoute(path: '/habits', builder: (context, state) => const HabitTrackerScreen()),
      
      // Tools & Knowledge
      GoRoute(path: '/lab-reports', builder: (context, state) => const LabReportsHomeScreen()),
      GoRoute(path: '/abha', builder: (context, state) => const ABHAScreen()),
      GoRoute(path: '/appointments', builder: (context, state) => const DoctorAppointmentsScreen()),
      GoRoute(path: '/emergency', builder: (context, state) => const EmergencyCardScreen()),
      GoRoute(path: '/festival', builder: (context, state) => const FestivalCalendarScreen()),
      GoRoute(path: '/wedding', builder: (context, state) => const WeddingPlannerHomeScreen()),
      
      // Social & Account
      GoRoute(path: '/social', builder: (context, state) => const SocialFeedScreen()),
      GoRoute(path: '/social/groups', builder: (context, state) => const CommunityGroupsScreen()),
      GoRoute(path: '/referral', builder: (context, state) => const ReferralScreen()),
      GoRoute(path: '/subscription', builder: (context, state) => const SubscriptionPlansScreen()),
      GoRoute(path: '/wearables', builder: (context, state) => const WearableConnectionsScreen()),
      
      // Secondary Workout/Steps top-level paths (for QuickLog or deep links)
      GoRoute(path: '/home/steps', builder: (context, state) => const StepsHomeScreen()),
      GoRoute(path: '/home/workout', builder: (context, state) => const WorkoutHomeScreen()),
      GoRoute(path: '/home/workout/gps', builder: (context, state) => _PlaceholderScreen(name: 'GPS Workout')),
    ],
  );
});

// Temporary placeholder for unimplemented sub-screens
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
