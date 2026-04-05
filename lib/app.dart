import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/auth/presentation/forgot_password_screen.dart';
import 'features/onboarding/presentation/onboarding_screens.dart';
import 'shared/theme/app_theme.dart';
import 'shared/widgets/main_scaffold.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/food/presentation/food_log_screen.dart';
import 'features/food/presentation/food_search_screen.dart';
import 'features/food/presentation/food_detail_screen.dart';
import 'features/steps/presentation/steps_screen.dart';
import 'features/workout/presentation/workout_log_screen.dart';
import 'features/workout/presentation/workout_list_screen.dart';
import 'features/workout/presentation/workout_detail_screen.dart';
import 'features/workout/presentation/personal_records_screen.dart';
import 'core/storage/app_database.dart';

class FitKarmaApp extends ConsumerWidget {
  const FitKarmaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    final router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final user = authState.asData?.value;
        final isAuthPath = state.matchedLocation.startsWith('/login') || state.matchedLocation.startsWith('/register');
        final isOnboardingPath = state.matchedLocation.startsWith('/onboarding');

        // 1. Not logged in -> Go to Login
        if (user == null) {
          return isAuthPath ? null : '/login';
        }

        // 2. Logged in but not onboarded -> Go to Onboarding
        // Assuming we have a flag for completion. For now, check if still in onboarding.
        if (user.name == 'New User' && !isOnboardingPath) {
           return '/onboarding/1';
        }

        // 3. Logged in and on Auth path -> Go to Home
        if (isAuthPath) {
          return '/';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/onboarding/:step',
          builder: (context, state) {
            final step = int.tryParse(state.pathParameters['step'] ?? '1') ?? 1;
            return OnboardingScreen(step: step);
          },
        ),
        ShellRoute(
          builder: (context, state, child) => MainScaffold(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              path: '/food',
              builder: (context, state) => const FoodLogScreen(),
              routes: [
                GoRoute(
                  path: 'search',
                  builder: (context, state) {
                    final mealType = state.extra as String?;
                    return FoodSearchScreen(mealType: mealType);
                  },
                ),
                GoRoute(
                  path: 'detail',
                  builder: (context, state) {
                    final extra = state.extra as Map<String, dynamic>;
                    return FoodDetailScreen(
                      item: extra['item'] as FoodItem,
                      mealType: extra['mealType'] as String?,
                    );
                  },
                ),
                GoRoute(
                  path: 'recipes',
                  builder: (context, state) => const _PlaceholderScreen(title: 'Recipes'),
                ),
              ],
            ),
            GoRoute(
              path: '/workout',
              builder: (context, state) => const WorkoutListScreen(),
              routes: [
                GoRoute(
                  path: 'log',
                  builder: (context, state) => const WorkoutLogScreen(),
                ),
                GoRoute(
                  path: 'prs',
                  builder: (context, state) => const PersonalRecordsScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return WorkoutDetailScreen(id: id);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/steps',
              builder: (context, state) => const StepsScreen(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const _PlaceholderScreen(title: 'Profile · प्रोफाइल'),
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const _PlaceholderScreen(title: 'Settings'),
                ),
                GoRoute(
                  path: 'emergency',
                  builder: (context, state) => const _PlaceholderScreen(title: 'Emergency Card'),
                ),
              ],
            ),
          ],
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

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
