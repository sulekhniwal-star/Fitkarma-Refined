import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/device_tier.dart';
import '../../features/auth/domain/auth_providers.dart';
import 'bilingual_label.dart';
import 'abha_link_badge.dart';
import '../../features/abha/data/abha_repository.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final deviceTier = ref.watch(deviceTierProvider);
    final user = ref.watch(authStateProvider).value;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          // Glass Background
          if (deviceTier.hasBlur)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: isDark ? Colors.black.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.7),
              ),
            )
          else
            Container(
              color: isDark ? AppTheme.bg1 : AppTheme.lBg1,
            ),

          SafeArea(
            child: Column(
              children: [
                // Profile Header
                _DrawerHeader(user: user, isDark: isDark, ref: ref),
                
                const Divider(height: 1),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      _DrawerItem(
                        icon: Icons.person_outline,
                        english: 'My Profile',
                        hindi: 'मेरी प्रोफाइल',
                        onTap: () {},
                      ),
                      _DrawerItem(
                        icon: Icons.watch_outlined,
                        english: 'Wearable Devices',
                        hindi: 'पहनने योग्य उपकरण',
                        onTap: () {},
                      ),
                      _DrawerItem(
                        icon: Icons.settings_outlined,
                        english: 'Settings',
                        hindi: 'सेटिंग्स',
                        onTap: () {},
                      ),
                      _DrawerItem(
                        icon: Icons.help_outline,
                        english: 'Support',
                        hindi: 'सहायता',
                        onTap: () {},
                      ),
                      _DrawerItem(
                        icon: Icons.emergency_outlined,
                        english: 'Emergency Card',
                        hindi: 'आपातकालीन कार्ड',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                // Footer
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'FitKarma v2.0.0',
                        style: TextStyle(
                          color: isDark ? AppTheme.textMuted : AppTheme.lTextSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Offline Mode Active',
                        style: TextStyle(
                          color: AppTheme.accent.withValues(alpha: 0.7),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final dynamic user;
  final bool isDark;
  final WidgetRef ref;

  const _DrawerHeader({required this.user, required this.isDark, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isDark ? AppTheme.surface1 : AppTheme.lSurface1,
            child: Text(
              user?.name.characters.first ?? 'U',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? AppTheme.primary : AppTheme.lPrimary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'FitKarma User',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.email ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.textMuted : AppTheme.lTextSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                ref.watch(abhaStatusProvider).when(
                  data: (data) => ABHALinkBadge(isLinked: data != null),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String english;
  final String hindi;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.english,
    required this.hindi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(icon, color: isDark ? AppTheme.primary : AppTheme.lPrimary),
      title: BilingualLabel(english: english, hindi: hindi),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}

