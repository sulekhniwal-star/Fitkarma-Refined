import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/providers.dart';
import 'shared/theme/app_theme.dart';

/// The root widget of the FitKarma application.
/// 
/// Configures navigation via GoRouter, applies the design system themes, 
/// and initializes support for 23 Indian locales.
class FitKarmaApp extends ConsumerWidget {
  const FitKarmaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouter);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'FitKarma',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      
      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      
      // Localization Configuration
      // Supports English + 22 scheduled Indian languages
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
