import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'shared/theme/app_theme.dart';
import 'shared/theme/app_colors.dart';
import 'features/auth/data/auth_aw_service.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/auth/presentation/onboarding_screen_1.dart';
import 'features/auth/presentation/onboarding_screen_2.dart';
import 'features/auth/presentation/onboarding_screen_3.dart';
import 'features/auth/presentation/onboarding_screen_4.dart';
import 'features/auth/presentation/onboarding_screen_5.dart';
import 'features/auth/presentation/onboarding_screen_6.dart';
import 'features/settings/presentation/settings_screen.dart';
import 'features/karma/presentation/karma_hub_screen.dart';
import 'features/karma/presentation/karma_store_screen.dart';
import 'features/karma/presentation/leaderboard_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'core/security/biometric_service.dart';

// --- Deferred Imports ---
import 'features/social/presentation/social_feed_screen.dart'
    deferred as social;
import 'features/workout/presentation/gps_workout_screen.dart'
    deferred as gps_workout;
import 'features/mental_health/presentation/mental_health_screen.dart'
    deferred as mental_health;
import 'features/meditation/presentation/meditation_screen.dart'
    deferred as meditation;
import 'features/wearables/presentation/wearables_screen.dart'
    deferred as wearables;
import 'features/steps/presentation/steps_screen.dart';
import 'features/lab_reports/presentation/lab_report_scan_screen.dart';

// --- Placeholder Screens ---
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: Center(child: Text('Screen: $title')),
    );
  }
}

// --- Root Detection Provider ---
final isRootedProvider = FutureProvider<bool>((ref) async {
  try {
    return await FlutterJailbreakDetection.jailbroken;
  } catch (e) {
    return false;
  }
});

/// Splash screen that checks for valid session and redirects
class _SplashScreen extends ConsumerStatefulWidget {
  const _SplashScreen();

  @override
  ConsumerState<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSessionAndRedirect();
  }

  Future<void> _checkSessionAndRedirect() async {
    final authService = ref.read(_authServiceProvider);
    final hasSession = await authService.hasValidSession();

    if (!mounted) return;

    if (hasSession) {
      context.go('/home/dashboard');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}

// --- Navigation Shell ---
class RootShell extends ConsumerWidget {
  final Widget child;
  const RootShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final isRooted = ref
        .watch(isRootedProvider)
        .maybeWhen(data: (val) => val, orElse: () => false);

    int getIndex() {
      if (location.startsWith('/home/dashboard')) return 0;
      if (location.startsWith('/home/food')) return 1;
      if (location.startsWith('/home/workout')) return 2;
      if (location.startsWith('/home/steps')) return 3;
      if (location.startsWith('/profile') || location.startsWith('/karma')) {
        return 4;
      }
      return 0;
    }

    void onIndexSelected(int index) {
      switch (index) {
        case 0:
          context.go('/home/dashboard');
          break;
        case 1:
          context.go('/home/food');
          break;
        case 2:
          context.go('/home/workout');
          break;
        case 3:
          context.go('/home/steps');
          break;
        case 4:
          context.go('/profile');
          break;
      }
    }

    return Scaffold(
      body: Column(
        children: [
          if (isRooted) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.error,
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(
                    Icons.security_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Security Alert: Device appears rooted/jailbroken. Encrypted health data may be at diminished risk.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getIndex(),
        onTap: onIndexSelected,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildNavItem(Icons.home_outlined, Icons.home_rounded, 'Home', 'होम'),
          _buildNavItem(
            Icons.restaurant_outlined,
            Icons.restaurant_rounded,
            'Food',
            'भोजन',
          ),
          _buildNavItem(
            Icons.fitness_center_outlined,
            Icons.fitness_center_rounded,
            'Workout',
            'कसरत',
          ),
          _buildNavItem(
            Icons.directions_walk_outlined,
            Icons.directions_walk_rounded,
            'Steps',
            'कदम',
          ),
          _buildNavItem(
            Icons.person_outline_rounded,
            Icons.person_rounded,
            'Me',
            'मेरा प्रोफाइल',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String en,
    String hi,
  ) {
    return BottomNavigationBarItem(
      icon: _NavLabel(icon: icon, en: en, hi: hi, isActive: false),
      activeIcon: _NavLabel(icon: activeIcon, en: en, hi: hi, isActive: true),
      label: '',
    );
  }
}

class _NavLabel extends StatelessWidget {
  final IconData icon;
  final String en;
  final String hi;
  final bool isActive;

  const _NavLabel({
    required this.icon,
    required this.en,
    required this.hi,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          en,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          hi,
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

// --- Deferred Loading Wrapper ---
class DeferredLoader extends StatefulWidget {
  final Future<void> Function() loader;
  final Widget Function() builder;

  const DeferredLoader({
    super.key,
    required this.loader,
    required this.builder,
  });

  @override
  State<DeferredLoader> createState() => _DeferredLoaderState();
}

class _DeferredLoaderState extends State<DeferredLoader> {
  Future<void>? _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = widget.loader();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error loading module: ${snapshot.error}'),
              ),
            );
          }
          return widget.builder();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// --- Router Definition ---
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Auth service provider for session checking
final _authServiceProvider = Provider<AuthAwService>((ref) {
  return AuthAwService();
});

/// Initial location provider - checks for valid session on app start
final _initialLocationProvider = FutureProvider<String>((ref) async {
  final authService = ref.watch(_authServiceProvider);
  final hasSession = await authService.hasValidSession();

  if (hasSession) {
    return '/home/dashboard';
  }
  return '/login';
});

final _router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) {
    // Skip redirect if already on splash, login, register, or onboarding
    final path = state.uri.path;
    if (path == '/' ||
        path == '/login' ||
        path == '/register' ||
        path.startsWith('/onboarding')) {
      return null;
    }

    // For all other routes, we'll check auth in the splash screen
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const _SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
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

    // --- Tabbed Shell ---
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => RootShell(child: child),
      routes: [
        GoRoute(
          path: '/home/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/home/steps',
          builder: (context, state) => const StepsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/home/food',
          builder: (context, state) =>
              const PlaceholderScreen(title: 'Food Home'),
          routes: [
            GoRoute(
              path: 'log/:mealType',
              builder: (context, state) => PlaceholderScreen(
                title: 'Log ${state.pathParameters['mealType']}',
              ),
            ),
            GoRoute(
              path: 'search',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Food Search'),
            ),
            GoRoute(
              path: 'scan',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Barcode Scanner'),
            ),
            GoRoute(
              path: 'photo',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Photo Scanner'),
            ),
            GoRoute(
              path: 'lab-scan',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Lab Report OCR'),
            ),
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) => PlaceholderScreen(
                title: 'Food Detail ${state.pathParameters['id']}',
              ),
            ),
            GoRoute(
              path: 'recipes',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Recipe Browser'),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (context, state) =>
                      const PlaceholderScreen(title: 'Recipe Builder'),
                ),
              ],
            ),
            GoRoute(
              path: 'planner',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Meal Planner'),
            ),
          ],
        ),
        GoRoute(
          path: '/home/workout',
          builder: (context, state) =>
              const PlaceholderScreen(title: 'Workout Home'),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => PlaceholderScreen(
                title: 'Workout Detail ${state.pathParameters['id']}',
              ),
            ),
            GoRoute(
              path: ':id/active',
              builder: (context, state) => PlaceholderScreen(
                title: 'Active Workout ${state.pathParameters['id']}',
              ),
            ),
            GoRoute(
              path: 'gps',
              builder: (context, state) => DeferredLoader(
                loader: gps_workout.loadLibrary,
                builder: () => gps_workout.GpsWorkoutScreen(),
              ),
            ),
            GoRoute(
              path: 'custom',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Custom Workout Builder'),
            ),
            GoRoute(
              path: 'calendar',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Workout Calendar'),
            ),
          ],
        ),
        GoRoute(
          path: '/home/steps',
          builder: (context, state) =>
              const PlaceholderScreen(title: 'Steps Home'),
        ),
        GoRoute(
          path: '/home/social',
          builder: (context, state) => DeferredLoader(
            loader: social.loadLibrary,
            builder: () => social.SocialFeedScreen(),
          ),
          routes: [
            GoRoute(
              path: 'groups',
              builder: (context, state) =>
                  const PlaceholderScreen(title: 'Community Groups'),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => PlaceholderScreen(
                    title: 'Group Detail ${state.pathParameters['id']}',
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'dm/:userId',
              builder: (context, state) => PlaceholderScreen(
                title: 'Direct Message ${state.pathParameters['userId']}',
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) =>
              const PlaceholderScreen(title: 'Profile'),
          routes: [
            GoRoute(
              path: 'wearables',
              builder: (context, state) => DeferredLoader(
                loader: wearables.loadLibrary,
                builder: () => wearables.WearablesScreen(),
              ),
            ),
          ],
        ),
      ],
    ),

    // --- Standalone Features ---
    GoRoute(
      path: '/karma',
      builder: (context, state) => const KarmaHubScreen(),
      routes: [
        GoRoute(
          path: 'store',
          builder: (context, state) => const KarmaStoreScreen(),
        ),
        GoRoute(
          path: 'leaderboard',
          builder: (context, state) => const LeaderboardScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/sleep',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Sleep Tracker'),
    ),
    GoRoute(
      path: '/mood',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Mood Tracker'),
    ),
    GoRoute(
      path: '/habits',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Habit Tracker'),
    ),
    GoRoute(
      path: '/period',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Period Tracker'),
    ),
    GoRoute(
      path: '/medications',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Medications'),
    ),
    GoRoute(
      path: '/body-metrics',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Body Measurements'),
    ),
    GoRoute(
      path: '/ayurveda',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Ayurveda Hub'),
    ),
    GoRoute(
      path: '/family',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Family Profiles'),
    ),
    GoRoute(
      path: '/emergency',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Emergency Card'),
    ),
    GoRoute(
      path: '/blood-pressure',
      builder: (context, state) => const PlaceholderScreen(title: 'BP Tracker'),
    ),
    GoRoute(
      path: '/glucose',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Glucose Tracker'),
    ),
    GoRoute(
      path: '/spo2',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'SpO2 Tracker'),
    ),
    GoRoute(
      path: '/lab-reports',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Lab Reports'),
    ),
    GoRoute(
      path: '/lab-reports/scan',
      builder: (context, state) => const LabReportScanScreen(),
    ),
    GoRoute(
      path: '/abha',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'ABHA Account'),
    ),
    GoRoute(
      path: '/chronic-disease',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Chronic Disease Hub'),
    ),
    GoRoute(
      path: '/fasting',
      builder: (context, state) =>
          const PlaceholderScreen(title: 'Fasting Tracker'),
    ),
    GoRoute(
      path: '/meditation',
      builder: (context, state) => DeferredLoader(
        loader: meditation.loadLibrary,
        builder: () => meditation.MeditationScreen(),
      ),
    ),
    GoRoute(
      path: '/journal',
      builder: (context, state) => const PlaceholderScreen(title: 'Journal'),
    ),
    GoRoute(
      path: '/mental-health',
      builder: (context, state) => DeferredLoader(
        loader: mental_health.loadLibrary,
        builder: () => mental_health.MentalHealthScreen(),
      ),
    ),
  ],
);

class FitKarmaApp extends ConsumerStatefulWidget {
  const FitKarmaApp({super.key});

  @override
  ConsumerState<FitKarmaApp> createState() => _FitKarmaAppState();
}

class _FitKarmaAppState extends ConsumerState<FitKarmaApp>
    with WidgetsBindingObserver {
  bool _isFirstLaunch = true;
  bool _isAuthenticated = false;
  bool _biometricEnabled = false;
  final BiometricService _biometricService = biometricServiceProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkBiometricSettings();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkBiometricSettings() async {
    _biometricEnabled = await _biometricService.isBiometricLockEnabled();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check biometric on app resume (but not on first launch)
    if (state == AppLifecycleState.resumed && !_isFirstLaunch) {
      if (_biometricEnabled && !_isAuthenticated) {
        _showBiometricLock();
      }
    } else if (state == AppLifecycleState.paused) {
      // Reset authentication when app goes to background
      _isFirstLaunch = false;
    }
  }

  Future<void> _showBiometricLock() async {
    if (!mounted) return;

    final isAvailable = await _biometricService.isBiometricAvailable();
    if (!isAvailable) return;

    // Show biometric dialog
    final authenticated = await _biometricService.authenticate(
      reason: 'Authenticate to unlock Fitkarma',
    );

    if (mounted) {
      setState(() {
        _isAuthenticated = authenticated;
      });

      if (!authenticated) {
        // Show locked screen
        _showLockedScreen();
      }
    }
  }

  void _showLockedScreen() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('App Locked'),
        content: const Text('Please authenticate to continue'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _showBiometricLock();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FitKarma',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
