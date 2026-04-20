import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/ayurveda/domain/ayurveda_logic.dart';
import 'package:fitkarma/core/config/app_theme.dart';
import 'glass_card.dart';
import 'bilingual_label.dart';

class RitucharyaCard extends ConsumerWidget {
  const RitucharyaCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonData = ref.watch(currentSeasonDataProvider);
    
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: const Icon(Icons.eco_outlined, color: AppTheme.teal, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BilingualLabel(
                      english: 'Seasonal Wellness',
                      hindi: 'ऋतुचर्या स्वास्थ्य',
                    ),
                    Text(
                      seasonData['season'] as String,
                      style: AppTheme.labelLg(context).copyWith(color: AppTheme.teal),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            context,
            Icons.center_focus_strong_outlined,
            'Major Focus',
            seasonData['focus'] as String,
          ),
          const Divider(height: 24, color: AppTheme.divider),
          _buildInfoRow(
            context,
            Icons.restaurant_outlined,
            'Eat More',
            seasonData['foods'] as String,
          ),
          const Divider(height: 24, color: AppTheme.divider),
          _buildInfoRow(
            context,
            Icons.directions_run_outlined,
            'Suggested Activity',
            seasonData['activities'] as String,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: AppTheme.caption(context).copyWith(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTheme.bodyMd(context).copyWith(color: AppTheme.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
