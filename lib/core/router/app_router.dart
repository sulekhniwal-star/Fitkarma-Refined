import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_screen.dart';
import '../../features/food/food_screen.dart';
import '../../features/workout/workout_screen.dart';
import '../../features/steps/steps_screen.dart';
import '../../features/profile/profile_screen.dart';
import 'app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        // ── Home ────────────────────────────────────────────
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
        ]),
        // ── Food ────────────────────────────────────────────
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/food',
            builder: (context, state) => const FoodScreen(),
          ),
        ]),
        // ── Workout ─────────────────────────────────────────
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/workout',
            builder: (context, state) => const WorkoutScreen(),
          ),
        ]),
        // ── Steps ───────────────────────────────────────────
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/steps',
            builder: (context, state) => const StepsScreen(),
          ),
        ]),
        // ── Profile / Me ────────────────────────────────────
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
      ],
    ),
    // ── Deferred / Deep-link routes ─────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/wearables',
      builder: (context, state) => FutureBuilder(
        future: _loadWearables(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _DeferredLoading();
          }
          return (snapshot.data as Widget Function())();
        },
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/social',
      builder: (context, state) => FutureBuilder(
        future: _loadSocial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _DeferredLoading();
          }
          return (snapshot.data as Widget Function())();
        },
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/gps-workout',
      builder: (context, state) => FutureBuilder(
        future: _loadGpsWorkout(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _DeferredLoading();
          }
          return (snapshot.data as Widget Function())();
        },
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/mental-health',
      builder: (context, state) => FutureBuilder(
        future: _loadMentalHealth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _DeferredLoading();
          }
          return (snapshot.data as Widget Function())();
        },
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/meditation',
      builder: (context, state) => FutureBuilder(
        future: _loadMeditation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _DeferredLoading();
          }
          return (snapshot.data as Widget Function())();
        },
      ),
    ),
  ],
);

// ═══════════════════════════════════════════════════════════════
// Deferred module loaders — library loaded on first navigation
// ═══════════════════════════════════════════════════════════════

Future<Widget Function()> _loadWearables() async {
  final module = await Future.delayed(
    const Duration(milliseconds: 100),
    () => null,
  );
  return () => const WearablesScreen();
}

Future<Widget Function()> _loadSocial() async {
  return () => const SocialScreen();
}

Future<Widget Function()> _loadGpsWorkout() async {
  return () => const GpsWorkoutScreen();
}

Future<Widget Function()> _loadMentalHealth() async {
  return () => const MentalHealthScreen();
}

Future<Widget Function()> _loadMeditation() async {
  return () => const MeditationScreen();
}

// Placeholder imports — replace with deferred imports when
// dart:mirrors or `import deferred as` is wired per module.
class WearablesScreen extends StatelessWidget {
  const WearablesScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Wearables')));
}

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Social Feed')));
}

class GpsWorkoutScreen extends StatelessWidget {
  const GpsWorkoutScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('GPS Workout')));
}

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Mental Health')));
}

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Meditation')));
}

class _DeferredLoading extends StatelessWidget {
  const _DeferredLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
