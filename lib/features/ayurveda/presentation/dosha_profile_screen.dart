// lib/features/ayurveda/presentation/dosha_profile_screen.dart
// Dosha profile screen with donut chart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_providers.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class DoshaProfileScreen extends ConsumerWidget {
  const DoshaProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doshaResult = ref.watch(doshaResultProvider);

    if (doshaResult == null) {
      return _buildNoResultScreen(context, ref);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dosha Profile'),
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.go('/ayurveda/quiz'),
            tooltip: 'Retake Quiz',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dominant Dosha Card
            _buildDominantDoshaCard(context, doshaResult),

            const SizedBox(height: 24),

            // Donut Chart
            _buildDonutChart(context, doshaResult),

            const SizedBox(height: 24),

            // Dosha Details
            _buildDoshaDetails(context, doshaResult),

            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultScreen(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dosha Profile'),
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🧘', style: TextStyle(fontSize: 80)),
              const SizedBox(height: 16),
              Text(
                'Discover Your Dosha',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Take our 12-question quiz to discover your Ayurvedic constitution and get personalized recommendations.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => context.go('/ayurveda/quiz'),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Quiz'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDominantDoshaCard(BuildContext context, DoshaResult result) {
    String emoji;
    String name;
    Color color;

    switch (result.dominantDosha) {
      case DominantDosha.vataDominant:
      case DominantDosha.vataPitta:
      case DominantDosha.vataKapha:
        emoji = '🌬️';
        name = 'Vata';
        color = Colors.blue;
        break;
      case DominantDosha.pittaDominant:
      case DominantDosha.pittaKapha:
        emoji = '🔥';
        name = 'Pitta';
        color = Colors.orange;
        break;
      case DominantDosha.kaphaDominant:
        emoji = '💧';
        name = 'Kapha';
        color = Colors.green;
        break;
      case DominantDosha.tridoshic:
        emoji = '⚖️';
        name = 'Tridoshic';
        color = Colors.purple;
        break;
    }

    return Card(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
            Text(
              result.dominantDosha.displayName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              result.dominantDosha.description,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutChart(BuildContext context, DoshaResult result) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Dosha Balance',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: DoshaDonutChart(
                vataPercent: result.vataPercent,
                pittaPercent: result.pittaPercent,
                kaphaPercent: result.kaphaPercent,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(
                  'Vata',
                  result.vataPercent,
                  Colors.blue,
                  '🌬️',
                ),
                _buildLegendItem(
                  'Pitta',
                  result.pittaPercent,
                  Colors.orange,
                  '🔥',
                ),
                _buildLegendItem(
                  'Kapha',
                  result.kaphaPercent,
                  Colors.green,
                  '💧',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    String label,
    int percent,
    Color color,
    String emoji,
  ) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          '$percent%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDoshaDetails(BuildContext context, DoshaResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vata
        _buildDoshaDetailCard(
          context,
          DoshaType.vata,
          result.vataPercent,
          'Creative, Energetic, Quick-thinking',
          'Dry, Light, Cold, Rough',
        ),

        const SizedBox(height: 12),

        // Pitta
        _buildDoshaDetailCard(
          context,
          DoshaType.pitta,
          result.pittaPercent,
          'Intelligent, Ambitious, Focused',
          'Hot, Sharp, Light, Spreading',
        ),

        const SizedBox(height: 12),

        // Kapha
        _buildDoshaDetailCard(
          context,
          DoshaType.kapha,
          result.kaphaPercent,
          'Calm, Stable, Nurturing',
          'Heavy, Slow, Cold, Oily',
        ),
      ],
    );
  }

  Widget _buildDoshaDetailCard(
    BuildContext context,
    DoshaType doshaType,
    int percent,
    String qualities,
    String attributes,
  ) {
    Color color;
    String emoji;

    switch (doshaType) {
      case DoshaType.vata:
        color = Colors.blue;
        emoji = '🌬️';
        break;
      case DoshaType.pitta:
        color = Colors.orange;
        emoji = '🔥';
        break;
      case DoshaType.kapha:
        color = Colors.green;
        emoji = '💧';
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doshaType.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$percent%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    qualities,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Qualities: $attributes',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11,
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

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                context,
                Icons.checklist,
                'Daily Rituals',
                () => context.go('/ayurveda/rituals'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                context,
                Icons.calendar_month,
                'Seasonal Plan',
                () => context.go('/ayurveda/seasonal'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: _buildActionButton(
            context,
            Icons.local_pharmacy,
            'Herbal Remedies',
            () => context.go('/ayurveda/herbs'),
            isFullWidth: true,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isFullWidth = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: isFullWidth
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

/// Custom donut chart widget using fl_chart
class DoshaDonutChart extends StatelessWidget {
  final int vataPercent;
  final int pittaPercent;
  final int kaphaPercent;

  const DoshaDonutChart({
    super.key,
    required this.vataPercent,
    required this.pittaPercent,
    required this.kaphaPercent,
  });

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 60,
        sections: [
          PieChartSectionData(
            value: vataPercent.toDouble(),
            color: Colors.blue,
            radius: 30,
            showTitle: false,
          ),
          PieChartSectionData(
            value: pittaPercent.toDouble(),
            color: Colors.orange,
            radius: 30,
            showTitle: false,
          ),
          PieChartSectionData(
            value: kaphaPercent.toDouble(),
            color: Colors.green,
            radius: 30,
            showTitle: false,
          ),
        ],
      ),
    );
  }
}
