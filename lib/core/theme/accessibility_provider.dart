import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

// Theme mode enum
enum AppThemeMode { system, light, dark, highContrast }

// Accessibility settings state
class AccessibilitySettings {
  final AppThemeMode themeMode;
  final bool enableSemantics;
  final bool enableDyslexiaFont;
  final double fontScale;
  final double contrastLevel; // 1.0 to 2.0

  const AccessibilitySettings({
    this.themeMode = AppThemeMode.system,
    this.enableSemantics = true,
    this.enableDyslexiaFont = false,
    this.fontScale = 1.0,
    this.contrastLevel = 1.0,
  });

  AccessibilitySettings copyWith({
    AppThemeMode? themeMode,
    bool? enableSemantics,
    bool? enableDyslexiaFont,
    double? fontScale,
    double? contrastLevel,
  }) {
    return AccessibilitySettings(
      themeMode: themeMode ?? this.themeMode,
      enableSemantics: enableSemantics ?? this.enableSemantics,
      enableDyslexiaFont: enableDyslexiaFont ?? this.enableDyslexiaFont,
      fontScale: fontScale ?? this.fontScale,
      contrastLevel: contrastLevel ?? this.contrastLevel,
    );
  }
}

// Accessibility settings notifier using Riverpod 2.0 Notifier
class AccessibilityNotifier extends Notifier<AccessibilitySettings> {
  @override
  AccessibilitySettings build() {
    return const AccessibilitySettings();
  }

  void setThemeMode(AppThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setEnableSemantics(bool enabled) {
    state = state.copyWith(enableSemantics: enabled);
  }

  void setEnableDyslexiaFont(bool enabled) {
    state = state.copyWith(enableDyslexiaFont: enabled);
  }

  void setFontScale(double scale) {
    state = state.copyWith(fontScale: scale.clamp(0.8, 2.0));
  }

  void setContrastLevel(double level) {
    state = state.copyWith(contrastLevel: level.clamp(1.0, 2.0));
  }
}

// Provider using Riverpod 2.0 NotifierProvider
final accessibilityProvider =
    NotifierProvider<AccessibilityNotifier, AccessibilitySettings>(
      AccessibilityNotifier.new,
    );

// Theme mode provider that combines accessibility settings with system theme
final effectiveThemeModeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(accessibilityProvider);
  switch (settings.themeMode) {
    case AppThemeMode.system:
      return ThemeMode.system;
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
    case AppThemeMode.highContrast:
      return ThemeMode.dark;
  }
});

// High contrast theme data
class HighContrastTheme {
  static ThemeData get theme {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary, // Orange accent
        onPrimary: Colors.black,
        secondary: AppColors.primary,
        onSecondary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
      ),
      textTheme: _buildHighContrastTextTheme(),
      cardTheme: CardThemeData(
        color: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.black,
          textStyle: AppTextStyles.buttonLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 3),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.white,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      // Remove all gradients - use solid colors
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withOpacity(0.5);
          }
          return Colors.white.withOpacity(0.3);
        }),
      ),
    );
  }

  static TextTheme _buildHighContrastTextTheme() {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: Colors.white),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: Colors.white),
      headlineLarge: AppTextStyles.h1.copyWith(color: Colors.white),
      headlineMedium: AppTextStyles.h2.copyWith(color: Colors.white),
      headlineSmall: AppTextStyles.h3.copyWith(color: Colors.white),
      titleLarge: AppTextStyles.h4.copyWith(color: Colors.white),
      titleMedium: AppTextStyles.labelLarge.copyWith(color: Colors.white),
      titleSmall: AppTextStyles.labelMedium.copyWith(color: Colors.white),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
      labelLarge: AppTextStyles.statLarge.copyWith(color: Colors.white),
      labelMedium: AppTextStyles.statMedium.copyWith(color: Colors.white),
      labelSmall: AppTextStyles.caption.copyWith(color: Colors.white70),
    );
  }
}

// Helper to get dyslexia-friendly font family
String get dyslexiaFontFamily => 'OpenDyslexic';

// Text style modifier for dyslexia font
TextStyle applyDyslexiaFont(TextStyle style, bool enabled) {
  if (!enabled) return style;
  return style.copyWith(
    fontFamily: dyslexiaFontFamily,
    letterSpacing: (style.letterSpacing ?? 0) + 0.5,
    height: (style.height ?? 1.0) + 0.2,
  );
}
