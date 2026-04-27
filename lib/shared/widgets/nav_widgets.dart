import 'dart:ui';
import 'package:flutter/material.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final bool showBlur;

  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: showBlur ? 10 : 0, sigmaY: showBlur ? 10 : 0),
        child: AppBar(
          title: title,
          actions: actions,
          backgroundColor: Colors.white.withOpacity(showBlur ? 0.7 : 1.0),
          elevation: 0,
          centerTitle: false,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class FitKarmaBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const FitKarmaBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            backgroundColor: Colors.transparent,
            indicatorColor: const Color(0xFFF97316).withOpacity(0.2),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard, color: Color(0xFFF97316)), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.restaurant_outlined), selectedIcon: Icon(Icons.restaurant, color: Color(0xFFF97316)), label: 'Food'),
              NavigationDestination(icon: Icon(Icons.fitness_center_outlined), selectedIcon: Icon(Icons.fitness_center, color: Color(0xFFF97316)), label: 'Active'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: Color(0xFFF97316)), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
