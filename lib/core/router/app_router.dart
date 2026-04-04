import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/home/home_screen.dart';
import 'package:fitkarma/features/food/food_screen.dart';
import 'package:fitkarma/features/food/presentation/community_food_submit_screen.dart';
import 'package:fitkarma/features/food/presentation/food_log_screen.dart';
import 'package:fitkarma/features/workout/workout_screen.dart';
import 'package:fitkarma/features/karma/karma_screen.dart';
import 'package:fitkarma/features/steps/steps_screen.dart';
import 'package:fitkarma/features/profile/profile_screen.dart';
import 'package:fitkarma/features/bp/presentation/bp_log_screen.dart';
import 'package:fitkarma/features/bp/presentation/bp_history_screen.dart';
import 'package:fitkarma/features/glucose/presentation/glucose_log_screen.dart';
import 'package:fitkarma/features/glucose/presentation/glucose_history_screen.dart';
import 'package:fitkarma/features/spo2/presentation/spo2_log_screen.dart';
import 'package:fitkarma/features/spo2/presentation/spo2_history_screen.dart';
import 'package:fitkarma/features/appointments/presentation/appointment_screen.dart';
import 'package:fitkarma/features/appointments/presentation/appointments_list_screen.dart';
import 'package:fitkarma/features/appointments/presentation/prescription_screen.dart';
import 'package:fitkarma/features/lab_reports/presentation/lab_report_scan_screen.dart';
import 'package:fitkarma/features/abha/presentation/link_abha_screen.dart';
import 'package:fitkarma/features/spo2/presentation/spo2_log_screen.dart';
import 'package:fitkarma/features/spo2/presentation/spo2_history_screen.dart';
import 'package:fitkarma/features/wearables/wearables_screen.dart'
    deferred as wearables;
import 'package:fitkarma/features/social/social_feed_screen.dart'
    deferred as social;
import 'package:fitkarma/features/gps/gps_workout_screen.dart'
    deferred as gps_workout;
import 'package:fitkarma/features/mental/mental_health_screen.dart'
    deferred as mental_health;
import 'package:fitkarma/features/meditation/meditation_screen.dart'
    deferred as meditation;
import 'package:fitkarma/features/settings/settings_screen.dart';
import 'package:fitkarma/features/onboarding/presentation/onboarding_screen1.dart';
import 'package:fitkarma/features/onboarding/presentation/onboarding_screen2.dart';
import 'package:fitkarma/features/onboarding/presentation/onboarding_screen3.dart';
import 'package:fitkarma/features/onboarding/presentation/onboarding_screen4.dart';
import 'package:fitkarma/features/onboarding/presentation/onboarding_screen5.dart';
import 'package:fitkarma/features/onboarding/presentation/onboarding_screen6.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// DEFERRED LOADING HELPER
// ═══════════════════════════════════════════════════════════════════════════════

/// Loads a deferred library then builds [child].
class DeferredWidget extends StatefulWidget {
  final Future<void> Function() loader;
  final Widget Function() builder;

  const DeferredWidget({
    super.key,
    required this.loader,
    required this.builder,
  });

  @override
  State<DeferredWidget> createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<DeferredWidget> {
  Widget? _loaded;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      await widget.loader();
      if (mounted) {
        setState(() => _loaded = widget.builder());
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(child: Text('Failed to load module: $_error'));
    }
    return _loaded ?? const Center(child: CircularProgressIndicator());
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// APP SHELL — 5-tab BottomNav
// ═══════════════════════════════════════════════════════════════════════════════

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'होम',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: 'Food',
            tooltip: 'खाना',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Workout',
            tooltip: 'कसरत',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_walk_outlined),
            selectedIcon: Icon(Icons.directions_walk),
            label: 'Steps',
            tooltip: 'कदम',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Me',
            tooltip: 'मैं',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ROUTER
// ═══════════════════════════════════════════════════════════════════════════════

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // ─── Onboarding routes ──────────────────────────────────────────────────────
    GoRoute(
      path: '/onboarding/1',
      builder: (context, state) => const OnboardingScreen1(),
    ),
    GoRoute(
      path: '/onboarding/2',
      builder: (context, state) => const OnboardingScreen2(),
    ),
    GoRoute(
      path: '/onboarding/3',
      builder: (context, state) => const OnboardingScreen3(),
    ),
    GoRoute(
      path: '/onboarding/4',
      builder: (context, state) => const OnboardingScreen4(),
    ),
    GoRoute(
      path: '/onboarding/5',
      builder: (context, state) => const OnboardingScreen5(),
    ),
    GoRoute(
      path: '/onboarding/6',
      builder: (context, state) => const OnboardingScreen6(),
    ),

    // ─── Auth routes ────────────────────────────────────────────────────────────
    GoRoute(
      path: '/login',
      builder: (context, state) => const _PlaceholderScreen('Login'),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const _PlaceholderScreen('Register'),
    ),

    // ─── Shell route (5 tabs) ──────────────────────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        // Home tab
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
        ]),
        // Food tab
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/food',
            builder: (context, state) => const FoodScreen(),
          ),
          GoRoute(
            path: '/food/log',
            builder: (context, state) => const FoodLogScreen(),
          ),
          GoRoute(
            path: '/food/submit',
            builder: (context, state) => const CommunityFoodSubmitScreen(),
          ),
        ]),
        // Workout tab
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/workout',
            builder: (context, state) => const WorkoutHomeScreen(),
          ),
        ]),
        // Steps tab
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/steps',
            builder: (context, state) => const StepsScreen(),
          ),
        ]),
        // Me tab
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
      ],
    ),

    // ─── Full-screen routes (push over shell) ─────────────────────────────

    // Wearables (deferred)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/wearables',
      builder: (context, state) => DeferredWidget(
        loader: wearables.loadLibrary,
        builder: () => wearables.WearablesScreen(),
      ),
    ),

    // Community / Social feed (deferred)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/social',
      builder: (context, state) => DeferredWidget(
        loader: social.loadLibrary,
        builder: () => social.SocialFeedScreen(),
      ),
    ),

    // GPS workout map (deferred)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/gps-workout',
      builder: (context, state) => DeferredWidget(
        loader: gps_workout.loadLibrary,
        builder: () => gps_workout.GpsWorkoutScreen(),
      ),
    ),

    // Mental health (deferred)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/mental-health',
      builder: (context, state) => DeferredWidget(
        loader: mental_health.loadLibrary,
        builder: () => mental_health.MentalHealthScreen(),
      ),
    ),

    // Meditation audio player (deferred)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/meditation',
      builder: (context, state) => DeferredWidget(
        loader: meditation.loadLibrary,
        builder: () => meditation.MeditationScreen(),
      ),
    ),

    // Health reports
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/health-reports',
      builder: (context, state) => const _PlaceholderScreen('Health Reports'),
    ),

    // Lab reports
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/lab-reports',
      builder: (context, state) => const _PlaceholderScreen('Lab Reports'),
    ),

    // Karma hub
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/karma',
      builder: (context, state) => const KarmaHubScreen(),
    ),

    // Settings
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    // Blood Pressure
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/bp/log',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return BPLogScreen(userId: userId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/bp/history',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return BpHistoryScreen(userId: userId);
      },
    ),

    // Glucose
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/glucose/log',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return GlucoseLogScreen(userId: userId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/glucose/history',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return GlucoseHistoryScreen(userId: userId);
      },
    ),

    // SpO2
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/spo2/log',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return Spo2LogScreen(userId: userId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/spo2/history',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return Spo2HistoryScreen(userId: userId);
      },
    ),

    // Appointments
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/appointments/add',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return AppointmentScreen(userId: userId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/appointments/list',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return AppointmentsListScreen(userId: userId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/appointments/prescription/:id',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        final appointmentId = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return PrescriptionScreen(userId: userId, appointmentId: appointmentId);
      },
    ),

    // Lab Reports
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/lab-report/scan',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return LabReportScanScreen(userId: userId);
      },
    ),

    // ABHA
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/abha/link',
      builder: (context, state) {
        final userId = state.extra as String? ?? '';
        return LinkAbhaScreen(userId: userId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/abha/prescriptions/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? '';
        return const _PlaceholderScreen('ABHA Prescriptions');
      },
    ),
  ],
);

// ═══════════════════════════════════════════════════════════════════════════════
// PLACEHOLDER (for routes without a screen yet)
// ═══════════════════════════════════════════════════════════════════════════════

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
