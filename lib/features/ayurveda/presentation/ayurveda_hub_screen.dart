// lib/features/ayurveda/presentation/ayurveda_hub_screen.dart
// Main Ayurveda hub screen

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_providers.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class AyurvedaHubScreen extends ConsumerWidget {
  const AyurvedaHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doshaResult = ref.watch(doshaResultProvider);
    final currentSeason = ref.watch(currentSeasonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayurveda'),
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            _buildWelcomeHeader(context, doshaResult, currentSeason),

            const SizedBox(height: 24),

            // Quick actions grid
            Text(
              'Explore Ayurveda',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            _buildActionGrid(context, doshaResult),

            const SizedBox(height: 24),

            // Current season card
            _buildSeasonCard(context, currentSeason),

            const SizedBox(height: 24),

            // Quick tips
            _buildTipsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(
    BuildContext context,
    DoshaResult? doshaResult,
    IndianSeason currentSeason,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondary, AppColors.secondaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🧘', style: TextStyle(fontSize: 40)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Ayurveda',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ancient wisdom for modern health',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (doshaResult != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    _getDoshaEmoji(doshaResult),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Constitution',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          doshaResult.dominantDosha.displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              'Take the quiz to discover your dosha',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
        ],
      ),
    );
  }

  String _getDoshaEmoji(DoshaResult result) {
    switch (result.dominantDosha) {
      case DominantDosha.vataDominant:
      case DominantDosha.vataPitta:
      case DominantDosha.vataKapha:
        return '🌬️';
      case DominantDosha.pittaDominant:
      case DominantDosha.pittaKapha:
        return '🔥';
      case DominantDosha.kaphaDominant:
        return '💧';
      case DominantDosha.tridoshic:
        return '⚖️';
    }
  }

  Widget _buildActionGrid(BuildContext context, DoshaResult? doshaResult) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildActionCard(
          context,
          '📋',
          doshaResult != null ? 'My Profile' : 'Take Quiz',
          doshaResult != null
              ? 'View your dosha details'
              : 'Discover your constitution',
          () => context.go(
            doshaResult != null ? '/ayurveda/profile' : '/ayurveda/quiz',
          ),
          AppColors.primary,
        ),
        _buildActionCard(
          context,
          '✅',
          'Daily Rituals',
          'Dinacharya checklist',
          () => context.go('/ayurveda/rituals'),
          AppColors.success,
        ),
        _buildActionCard(
          context,
          '📅',
          'Seasonal Plan',
          'Ritucharya guide',
          () => context.go('/ayurveda/seasonal'),
          AppColors.warning,
        ),
        _buildActionCard(
          context,
          '🌿',
          'Herbal Library',
          'Ayurvedic remedies',
          () => context.go('/ayurveda/herbs'),
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String emoji,
    String title,
    String subtitle,
    VoidCallback onTap,
    Color color,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonCard(BuildContext context, IndianSeason season) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getSeasonEmoji(season),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Season',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        season.displayName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        season.sanskritName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    season.months,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => context.go('/ayurveda/seasonal'),
            ),
          ],
        ),
      ),
    );
  }

  String _getSeasonEmoji(IndianSeason season) {
    switch (season) {
      case IndianSeason.spring:
        return '🌸';
      case IndianSeason.summer:
        return '☀️';
      case IndianSeason.monsoon:
        return '🌧️';
      case IndianSeason.autumn:
        return '🍂';
      case IndianSeason.winter:
        return '❄️';
      case IndianSeason.lateWinter:
        return '🌫️';
    }
  }

  Widget _buildTipsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'Ayurvedic Tip of the Day',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Start your day with warm water and lemon to stimulate digestion and flush toxins. This simple practice, known as "ushapan", is a cornerstone of Dinacharya.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
