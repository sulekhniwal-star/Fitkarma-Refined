import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/auth_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/food/presentation/food_home_screen.dart';
import '../../features/food/presentation/food_log_screen.dart';
import '../../features/food/presentation/lab_report_scan_screen.dart';
import '../../features/sleep/presentation/sleep_tracker_screen.dart';
import '../../features/mood/presentation/mood_tracker_screen.dart';
import '../../features/habits/presentation/habit_tracker_screen.dart';
import '../../features/blood_pressure/presentation/bp_tracker_screen.dart';
import '../../features/glucose/presentation/glucose_tracker_screen.dart';
import '../../features/nutrition/presentation/nutrition_goal_screen.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../features/festival/presentation/festival_calendar_screen.dart';
import '../../features/festival/presentation/festival_diet_plan_screen.dart';
import '../../features/fasting_tracker/presentation/fasting_tracker_screen.dart';
import '../../features/period/presentation/period_tracker_screen.dart';
import '../../features/karma/presentation/karma_hub_screen.dart';
import '../../features/wedding_planner/presentation/wedding_planner_home_screen.dart';
import '../../features/wedding_planner/presentation/wedding_event_day_screen.dart';
import '../../features/wedding_planner/presentation/wedding_recovery_screen.dart';
import '../../features/wedding_planner/presentation/wedding_setup_screen.dart';
import '../../features/auth/data/users_repository.dart';
import '../../features/lab_reports/presentation/lab_reports_home_screen.dart';
import '../../features/abha/presentation/abha_screen.dart';
import '../../features/wearables/presentation/wearable_connections_screen.dart';
import '../../features/ayurveda/presentation/ayurveda_hub_screen.dart';
import '../../features/appointments/presentation/doctor_appointments_screen.dart';
import '../../features/reports/presentation/health_reports_screen.dart';
import '../../features/emergency/presentation/emergency_card_screen.dart';
import '../../features/social/presentation/social_feed_screen.dart';
import '../../features/social/presentation/community_groups_screen.dart';
import '../../features/social/presentation/referral_screen.dart';
import '../storage/app_database.dart';

final driftDbProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('driftDbProvider must be overridden in ProviderScope');
});

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

final appRouter = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final isAuthenticated = authState.value != null;

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';
      final isGoingToOnboarding = state.matchedLocation.startsWith('/onboarding');
      final isSplash = state.matchedLocation == '/';

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
        path: '/onboarding/:step',
        builder: (context, state) => _PlaceholderScreen(name: 'Onboarding Step ${state.pathParameters['step']}'),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
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
                path: 'search',
                builder: (context, state) => const _PlaceholderScreen(name: 'FoodSearchScreen'),
              ),
              GoRoute(
                path: 'scan',
                builder: (context, state) => const _PlaceholderScreen(name: 'BarcodeScanScreen'),
              ),
              GoRoute(
                path: 'photo',
                builder: (context, state) => const _PlaceholderScreen(name: 'PhotoScanScreen'),
              ),
              GoRoute(
                path: 'lab-scan',
                builder: (context, state) => const LabReportScanScreen(),
              ),
              GoRoute(
                path: 'detail/:id',
                builder: (context, state) => _PlaceholderScreen(name: 'FoodDetail: ${state.pathParameters['id']}'),
              ),
              GoRoute(
                path: 'recipes',
                builder: (context, state) => const _PlaceholderScreen(name: 'RecipeBrowserScreen'),
              ),
              GoRoute(
                path: 'recipes/new',
                builder: (context, state) => const _PlaceholderScreen(name: 'RecipeBuilderScreen'),
              ),
              GoRoute(
                path: 'planner',
                builder: (context, state) => const _PlaceholderScreen(name: 'MealPlannerScreen'),
              ),
            ],
          ),
          GoRoute(
            path: '/home/workout',
            builder: (context, state) => const _PlaceholderScreen(name: 'WorkoutHomeScreen'),
            routes: [
              GoRoute(
                path: 'gps',
                builder: (context, state) => const _PlaceholderScreen(name: 'GpsWorkoutScreen'),
              ),
              GoRoute(
                path: 'custom',
                builder: (context, state) => const _PlaceholderScreen(name: 'CustomWorkoutBuilderScreen'),
              ),
              GoRoute(
                path: 'calendar',
                builder: (context, state) => const _PlaceholderScreen(name: 'WorkoutCalendarScreen'),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => _PlaceholderScreen(name: 'WorkoutDetail: ${state.pathParameters['id']}'),
                routes: [
                  GoRoute(
                    path: 'active',
                    builder: (context, state) => const _PlaceholderScreen(name: 'ActiveWorkoutScreen'),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/home/steps',
            builder: (context, state) => const _PlaceholderScreen(name: 'StepsHomeScreen'),
          ),
          GoRoute(
            path: '/home/social',
            builder: (context, state) => const _PlaceholderScreen(name: 'SocialFeedScreen'),
            routes: [
              GoRoute(
                path: 'groups',
                builder: (context, state) => const _PlaceholderScreen(name: 'CommunityGroupsScreen'),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => _PlaceholderScreen(name: 'GroupDetail: ${state.pathParameters['id']}'),
                  ),
                ],
              ),
              GoRoute(
                path: 'dm/:userId',
                builder: (context, state) => _PlaceholderScreen(name: 'DirectMessage: ${state.pathParameters['userId']}'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: '/karma', builder: (context, state) => const KarmaHubScreen()),
      GoRoute(path: '/social', builder: (context, state) => const SocialFeedScreen()),
      GoRoute(path: '/profile', builder: (context, state) => const _PlaceholderScreen(name: 'ProfileScreen')),
      GoRoute(path: '/sleep', builder: (context, state) => const SleepTrackerScreen()),
      GoRoute(path: '/mood', builder: (context, state) => const MoodTrackerScreen()),
      GoRoute(path: '/habits', builder: (context, state) => const HabitTrackerScreen()),
      GoRoute(path: '/period', builder: (context, state) => const PeriodTrackerScreen()),
      GoRoute(path: '/medications', builder: (context, state) => const _PlaceholderScreen(name: 'MedicationsScreen')),
      GoRoute(path: '/body-metrics', builder: (context, state) => const _PlaceholderScreen(name: 'BodyMetricsScreen')),
      GoRoute(path: '/ayurveda', builder: (context, state) => const AyurvedaHubScreen()),
      GoRoute(path: '/community', builder: (context, state) => const CommunityGroupsScreen()),
      GoRoute(path: '/family', builder: (context, state) => const _PlaceholderScreen(name: 'FamilyProfilesScreen')),
      GoRoute(path: '/emergency', builder: (context, state) => const EmergencyCardScreen()),
      GoRoute(path: '/blood-pressure', builder: (context, state) => const BPTrackerScreen()),
      GoRoute(path: '/glucose', builder: (context, state) => const GlucoseTrackerScreen()),
      GoRoute(path: '/spo2', builder: (context, state) => const _PlaceholderScreen(name: 'Spo2Screen')),
      GoRoute(path: '/lab-reports', builder: (context, state) => const LabReportsHomeScreen()),
      GoRoute(path: '/abha', builder: (context, state) => const ABHAScreen()),
      GoRoute(path: '/chronic-disease', builder: (context, state) => const _PlaceholderScreen(name: 'ChronicDiseaseHubScreen')),
      GoRoute(path: '/fasting', builder: (context, state) => const FastingTrackerScreen()),
      GoRoute(path: '/meditation', builder: (context, state) => const _PlaceholderScreen(name: 'MeditationScreen')),
      GoRoute(path: '/journal', builder: (context, state) => const _PlaceholderScreen(name: 'JournalScreen')),
      GoRoute(path: '/mental-health', builder: (context, state) => const _PlaceholderScreen(name: 'MentalHealthHubScreen')),
      GoRoute(path: '/wearables', builder: (context, state) => const WearableConnectionsScreen()),
      GoRoute(path: '/home-widgets', builder: (context, state) => const _PlaceholderScreen(name: 'HomeWidgetConfigScreen')),
      GoRoute(path: '/reports', builder: (context, state) => const HealthReportsScreen()),
      GoRoute(path: '/personal-records', builder: (context, state) => const _PlaceholderScreen(name: 'PersonalRecordsScreen')),
      GoRoute(path: '/nutrition-goals', builder: (context, state) => const NutritionGoalScreen()),
      GoRoute(path: '/doctor-appointments', builder: (context, state) => const DoctorAppointmentsScreen()),
      GoRoute(path: '/referral', builder: (context, state) => const ReferralScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const _PlaceholderScreen(name: 'SettingsScreen')),
      GoRoute(path: '/subscription', builder: (context, state) => const _PlaceholderScreen(name: 'SubscriptionPlansScreen')),
      GoRoute(
        path: '/festival-calendar',
        builder: (context, state) => const FestivalCalendarScreen(),
        routes: [
          GoRoute(
            path: ':festivalKey/diet',
            builder: (context, state) => FestivalDietPlanScreen(
              festivalKey: state.pathParameters['festivalKey'] ?? '',
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/wedding-planner',
        builder: (context, state) => const WeddingPlannerHomeScreen(),
        routes: [
          GoRoute(path: 'setup', builder: (context, state) => const WeddingSetupScreen()),
          GoRoute(path: 'recovery', builder: (context, state) => const WeddingRecoveryScreen()),
          GoRoute(
            path: 'event/:eventKey',
            builder: (context, state) => WeddingEventDayScreen(
              eventKey: state.pathParameters['eventKey'] ?? '',
            ),
          ),
        ],
      ),
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
      body: Center(child: Text('Coming Soon: $name')),
    );
  }
}

class _MainShell extends ConsumerWidget {
  final Widget child;
  const _MainShell({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    
    final int index;
    if (location.startsWith('/home/dashboard')) {
      index = 0;
    } else if (location.startsWith('/home/food')) {
      index = 1;
    } else if (location.startsWith('/home/workout')) {
      index = 2;
    } else if (location.startsWith('/home/steps')) {
      index = 3;
    } else if (location.startsWith('/profile')) {
      index = 4;
    } else {
      index = 0;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: FitKarmaBottomNav(
        currentIndex: index,
        onTap: (i) {
          final routes = [
            '/home/dashboard',
            '/home/food',
            '/home/workout',
            '/home/steps',
            '/profile',
          ];
          context.go(routes[i]);
        },
      ),
    );
  }
}
