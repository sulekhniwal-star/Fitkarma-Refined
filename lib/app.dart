import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/providers.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'core/security/security_providers.dart';

/// The root widget of the FitKarma application.
///
/// Configures navigation via GoRouter, applies the design system themes,
/// and initializes support for 23 Indian locales.
class FitKarmaApp extends ConsumerStatefulWidget {
  const FitKarmaApp({super.key});

  @override
  ConsumerState<FitKarmaApp> createState() => _FitKarmaAppState();
}

class _FitKarmaAppState extends ConsumerState<FitKarmaApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Notify SecurityNotifier of lifecycle changes to handle auto-lock
    final securityNotifier = ref.read(securityProvider.notifier);

    if (state == AppLifecycleState.resumed) {
      securityNotifier.handleAppResumed();
    } else if (state == AppLifecycleState.paused) {
      securityNotifier.handleAppPaused();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouter);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'FitKarma',
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      // Theme Configuration
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,

      // Localization Configuration
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('hi'), // Hindi
        Locale('as'), // Assamese
        Locale('bn'), // Bengali
        Locale('brx'), // Bodo
        Locale('doi'), // Dogri
        Locale('gu'), // Gujarati
        Locale('kn'), // Kannada
        Locale('ks'), // Kashmiri
        Locale('kok'), // Konkani
        Locale('mai'), // Maithili
        Locale('ml'), // Malayalam
        Locale('mni'), // Manipuri
        Locale('mr'), // Marathi
        Locale('ne'), // Nepali
        Locale('or'), // Odia
        Locale('pa'), // Punjabi
        Locale('sa'), // Sanskrit
        Locale('sat'), // Santali
        Locale('sd'), // Sindhi
        Locale('ta'), // Tamil
        Locale('te'), // Telugu
        Locale('ur'), // Urdu
      ],
    );
  }
}

