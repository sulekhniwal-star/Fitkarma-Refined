import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import '../../../core/config/app_theme.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/fit_scaffold.dart';
import '../../../shared/widgets/abha_link_badge.dart';
import '../../auth/domain/auth_providers.dart';
import '../../wedding_planner/presentation/wedding_providers.dart';
import '../../../shared/widgets/karma_level_card.dart';
import '../../../shared/widgets/dosha_chart.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _imagePath = image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      title: 'Profile',
      heroContent: _buildHeroContent(user),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKarmaLevelCard(),
          const SizedBox(height: 24),
          _buildDoshaCard(),
          const SizedBox(height: 24),
          _buildPersonalInfo(user),
          const SizedBox(height: 32),
          _buildABHASection(),
          const SizedBox(height: 32),
          _buildWeddingPlannerSection(context),
          const SizedBox(height: 32),
          _buildAchievementsSection(),
          const SizedBox(height: 32),
          _buildReferralCard(context),
          const SizedBox(height: 100), // Navigation avoidance
        ],
      ),
    );
  }

  Widget _buildHeroContent(dynamic user) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white24,
              backgroundImage: _imagePath != null
                  ? FileImage(File(_imagePath!))
                  : const AssetImage('assets/images/profiles/avatar_male.png')
                        as ImageProvider,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user?.name ?? 'FitKarma User',
          style: AppTheme.metricLg(
            context,
          ).copyWith(color: Colors.white, fontSize: 32),
        ),
        Text(
          user?.email ?? '',
          style: AppTheme.labelMd(context).copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildKarmaLevelCard() {
    return const KarmaLevelCard(
      level: 14,
      title: 'Warrior',
      currentXP: 1550,
      nextLevelXP: 2000,
    );
  }

  Widget _buildDoshaCard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text('Ayurvedic Constitution', style: AppTextStyles.h3(isDark)),
              const SizedBox(width: 4),
              Text(
                'आयुर्वेदिक प्रकृति',
                style: AppTextStyles.sectionHeaderHindi(isDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 160,
            child: DoshaChart(vataPct: 20, pittaPct: 60, kaphaPct: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(dynamic user) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Personal Info', 'व्यक्तिगत जानकारी', isDark),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.phone, 'Phone', '+91 98765 43210', isDark),
          _buildInfoRow(Icons.cake, 'Date of Birth', '12 Jan 1992', isDark),
          _buildInfoRow(Icons.height, 'Height', '178 cm', isDark),
          _buildInfoRow(Icons.monitor_weight, 'Weight', '74 kg', isDark),
          _buildInfoRow(Icons.bloodtype, 'Blood Group', 'B+', isDark),
          _buildInfoRow(Icons.language, 'Language', 'English', isDark),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String hindi, bool isDark) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(title.toUpperCase(), style: AppTextStyles.sectionHeader(isDark)),
        const SizedBox(width: 4),
        Text(hindi, style: AppTextStyles.caption(isDark)),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark
                ? AppColorsDark.textSecondary
                : AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTextStyles.bodyMedium(isDark))),
          Text(value, style: AppTextStyles.labelLarge(isDark)),
          const SizedBox(width: 8),
          Icon(
            Icons.edit,
            size: 14,
            color: isDark
                ? AppColorsDark.textSecondary
                : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildABHASection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('ABHA Health ID', 'आयुष्मान भारत', isDark),
                const SizedBox(height: 12),
                Text(
                  'Linked',
                  style: AppTextStyles.bodyMedium(
                    isDark,
                  ).copyWith(color: AppColors.success),
                ),
                Text(
                  '12-3456-7890-1234',
                  style: AppTextStyles.labelLarge(
                    isDark,
                  ).copyWith(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          const ABHALinkBadge(isLinked: true, isLarge: true),
        ],
      ),
    );
  }

  Widget _buildWeddingPlannerSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(weddingProfileProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.weddingGoldGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.celebration,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Wedding Planner',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          profileAsync.when(
            data: (profile) {
              if (profile == null || !profile.hasWeddingSetup) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set up your wedding planner to get personalized diet and fitness plans for your big day!',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () => context.push('/wedding-planner/setup'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.weddingGoldStart,
                        elevation: 0,
                      ),
                      child: const Text('Set Up Now'),
                    ),
                  ],
                );
              }

              final daysLeft = profile.startDate != null
                  ? profile.startDate!.difference(DateTime.now()).inDays
                  : 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        profile.role == 'none'
                            ? 'Guest'
                            : profile.role.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$daysLeft days',
                          style: const TextStyle(
                            color: AppColors.weddingGoldStart,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap to view your personalized wedding plan',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.push('/wedding-planner'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('View Plan'),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            error: (_, _) => const Text(
              'Unable to load wedding data',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final achievements = [
      {'icon': Icons.emoji_events, 'label': '7 Day Streak'},
      {'icon': Icons.fitness_center, 'label': '10 Workouts'},
      {'icon': Icons.restaurant, 'label': '100 Meals'},
      {'icon': Icons.directions_walk, 'label': '50K Steps'},
      {'icon': Icons.spa, 'label': 'Yoga Master'},
      {'icon': Icons.local_fire_department, 'label': 'On Fire'},
      {'icon': Icons.workspace_premium, 'badge': 'PRO'},
      {'icon': Icons.lock, 'badge': 'Locked'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Achievements', 'उपलब्धियाँ', isDark),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final earned = index < 5;
              final item = achievements[index];
              return _buildAchievementItem(
                icon: item['icon'] as IconData,
                label: item['label'] as String?,
                badge: item['badge'] as String?,
                isEarned: earned,
                isDark: isDark,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required IconData icon,
    String? label,
    String? badge,
    required bool isEarned,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isEarned
                ? AppColors.accent.withValues(alpha: 0.15)
                : (isDark
                      ? AppColorsDark.surfaceVariant
                      : Colors.grey.shade100),
            shape: BoxShape.circle,
            border: isEarned
                ? Border.all(
                    color: AppColors.accent.withValues(alpha: 0.5),
                    width: 2,
                  )
                : null,
          ),
          child: Icon(
            icon,
            color: isEarned
                ? AppColors.accent
                : (isDark ? AppColorsDark.textMuted : Colors.grey.shade400),
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        if (badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isEarned ? AppColors.accent : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else if (label != null)
          Text(
            label,
            style: AppTextStyles.caption(isDark).copyWith(fontSize: 9),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }


  Widget _buildReferralCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.amberGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.card_giftcard, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite Friends',
                  style: AppTextStyles.h3(isDark).copyWith(color: Colors.white),
                ),
                Text(
                  'Earn 500 XP for every successful join!',
                  style: AppTextStyles.bodyMedium(
                    isDark,
                  ).copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => context.push('/referral'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.accentDark,
            ),
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
}

