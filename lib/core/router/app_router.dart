import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';

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
      GoRoute(path: '/splash',          builder: (_, __) => const _PlaceholderScreen(name: 'Splash')),
      GoRoute(path: '/auth/login',      builder: (_, __) => const _PlaceholderScreen(name: 'Login')),
      GoRoute(path: '/auth/register',   builder: (_, __) => const _PlaceholderScreen(name: 'Register')),
      GoRoute(path: '/onboarding',      builder: (_, __) => const _PlaceholderScreen(name: 'Onboarding')),
      GoRoute(path: '/home/dashboard',  builder: (_, __) => const _PlaceholderScreen(name: 'Dashboard')),
      GoRoute(path: '/home/food',       builder: (_, __) => const _PlaceholderScreen(name: 'Food Home')),
      GoRoute(path: '/home/workout',    builder: (_, __) => const _PlaceholderScreen(name: 'Workout Home')),
      GoRoute(path: '/home/steps',      builder: (_, __) => const _PlaceholderScreen(name: 'Steps')),
      GoRoute(path: '/profile',         builder: (_, __) => const _PlaceholderScreen(name: 'Profile')),
      GoRoute(path: '/blood-pressure',  builder: (_, __) => const _PlaceholderScreen(name: 'Blood Pressure')),
      GoRoute(path: '/glucose',         builder: (_, __) => const _PlaceholderScreen(name: 'Glucose')),
      GoRoute(path: '/sleep',           builder: (_, __) => const _PlaceholderScreen(name: 'Sleep')),
      GoRoute(path: '/karma',           builder: (_, __) => const _PlaceholderScreen(name: 'Karma Hub')),
      GoRoute(path: '/journal',         builder: (_, __) => const _PlaceholderScreen(name: 'Journal')),
      GoRoute(path: '/lab-reports',     builder: (_, __) => const _PlaceholderScreen(name: 'Lab Reports')),
      GoRoute(path: '/abha',            builder: (_, __) => const _PlaceholderScreen(name: 'ABHA')),
      GoRoute(path: '/settings',        builder: (_, __) => const _PlaceholderScreen(name: 'Settings')),
      GoRoute(path: '/emergency',       builder: (_, __) => const _PlaceholderScreen(name: 'Emergency Card')),
      GoRoute(path: '/festival-calendar', builder: (_, __) => const _PlaceholderScreen(name: 'Festival Calendar')),
      GoRoute(path: '/wedding-planner', builder: (_, __) => const _PlaceholderScreen(name: 'Wedding Planner')),
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
