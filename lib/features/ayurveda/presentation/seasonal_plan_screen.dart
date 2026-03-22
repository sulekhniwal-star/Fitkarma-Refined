// lib/features/ayurveda/presentation/seasonal_plan_screen.dart
// Seasonal plan screen (Ritucharya)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_providers.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class SeasonalPlanScreen extends ConsumerWidget {
  const SeasonalPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(currentSeasonProvider);
    final recommendation = ref.watch(seasonalRecommendationProvider);
    final doshaResult = ref.watch(doshaResultProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seasonal Plan'),
            Text(
              'Ritucharya',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
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
            // Current season card
            _buildSeasonCard(context, season, recommendation),

            const SizedBox(height: 24),

            // Special note
            if (recommendation.specialNote != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.tips_and_updates,
                      color: AppColors.accentDark,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        recommendation.specialNote!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Dosha-specific adjustments
            if (doshaResult != null) ...[
              Text(
                'Your Personalized Adjustments',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Based on your ${doshaResult.dominantDosha.displayName} constitution',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
            ],

            // Diet section
            _buildSection(
              context,
              '🥗 Diet Recommendations',
              recommendation.diet,
              Icons.restaurant,
            ),

            const SizedBox(height: 24),

            // Lifestyle section
            _buildSection(
              context,
              '🏠 Lifestyle',
              recommendation.lifestyle,
              Icons.home,
            ),

            const SizedBox(height: 24),

            // Exercise section
            _buildSection(
              context,
              '💪 Exercise',
              recommendation.exercises,
              Icons.fitness_center,
            ),

            const SizedBox(height: 24),

            // Avoid section
            _buildAvoidSection(context, recommendation.avoid),

            const SizedBox(height: 24),

            // All seasons overview
            _buildAllSeasonsOverview(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonCard(
    BuildContext context,
    IndianSeason season,
    SeasonalRecommendation recommendation,
  ) {
    return Card(
      color: AppColors.primarySurface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getSeasonEmoji(season),
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        season.displayName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        season.sanskritName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    season.months,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getSeasonDescription(season),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<String> items,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map((item) => _buildBulletItem(context, item)),
      ],
    );
  }

  Widget _buildBulletItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildAvoidSection(BuildContext context, List<String> avoidItems) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: AppColors.error, size: 20),
              const SizedBox(width: 8),
              Text(
                '⚠️ Avoid',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...avoidItems.map((item) => _buildBulletItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildAllSeasonsOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Seasons (Ritucharya)',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: IndianSeason.values.map((s) {
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          _getSeasonEmoji(s),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          s.displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          s.months.split(' - ').first,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tap on any season above to view detailed recommendations',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
        ),
      ],
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

  String _getSeasonDescription(IndianSeason season) {
    switch (season) {
      case IndianSeason.spring:
        return 'Nature awakens. Focus on detoxification and light foods.';
      case IndianSeason.summer:
        return 'Heat intensifies. Focus on cooling and hydrating practices.';
      case IndianSeason.monsoon:
        return 'Humidity rises. Focus on boosting immunity and digestion.';
      case IndianSeason.autumn:
        return 'Air becomes cool and dry. Focus on grounding and nourishment.';
      case IndianSeason.winter:
        return 'Cold and heavy. Focus on warmth, nourishment, and oil massage.';
      case IndianSeason.lateWinter:
        return 'Cold peaks. Focus on strengthening and preparing for spring.';
    }
  }
}
