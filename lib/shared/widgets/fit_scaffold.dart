import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import 'ambient_glow_blobs.dart';
import 'glass_app_bar.dart';

enum ScaffoldPattern { standard, immersiveHero, fullBleed }

class FitScaffold extends ConsumerWidget {
  final ScaffoldPattern pattern;
  final Widget body;
  final Widget? heroContent;
  final Widget? heroBackground;
  final PreferredSizeWidget? appBar;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool extendBodyBehindAppBar;
  final double heroHeight;
  final ScrollController? scrollController;

  const FitScaffold({
    super.key,
    required this.body,
    this.pattern = ScaffoldPattern.standard,
    this.heroContent,
    this.heroBackground,
    this.appBar,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.extendBodyBehindAppBar = false,
    this.heroHeight = 320,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Apply System Overlays automatically as requested
    final overlayStyle = pattern == ScaffoldPattern.fullBleed 
      ? SystemUiOverlayStyle.light 
      : (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: _buildScaffold(context, isDark),
    );
  }

  Widget _buildScaffold(BuildContext context, bool isDark) {
    switch (pattern) {
      case ScaffoldPattern.immersiveHero:
        return _buildImmersiveHero(context, isDark);
      case ScaffoldPattern.fullBleed:
        return _buildFullBleed(context, isDark);
      case ScaffoldPattern.standard:
      default:
        return _buildStandard(context, isDark);
    }
  }

  Widget _buildStandard(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
      appBar: appBar ?? (title != null ? GlassAppBar(title: Text(title!), actions: actions) : null),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }

  Widget _buildImmersiveHero(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
      extendBodyBehindAppBar: true,
      appBar: appBar ?? (title != null ? GlassAppBar(title: Text(title!), actions: actions) : null),
      body: Stack(
        children: [
          // 1. Hero Background
          SizedBox(
            height: heroHeight,
            width: double.infinity,
            child: Stack(
              children: [
                heroBackground ?? Container(decoration: BoxDecoration(gradient: isDark ? AppColorsDark.heroDeep : AppColorsLight.heroDeep)),
                const AmbientGlowBlobs(),
                if (heroContent != null) 
                  SafeArea(child: Center(child: heroContent!)),
              ],
            ),
          ),
          
          // 2. Overlapping Body
          Positioned.fill(
            top: heroHeight - 28,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: body,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }

  Widget _buildFullBleed(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: Colors.black, // Typical for full-bleed video/maps
      body: Stack(
        children: [
          Positioned.fill(child: body),
          if (title != null || appBar != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: appBar ?? GlassAppBar(title: Text(title!), actions: actions),
            ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }
}

