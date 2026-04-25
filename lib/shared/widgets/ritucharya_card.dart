import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/ayurveda/domain/ayurveda_logic.dart';
import 'package:fitkarma/core/theme/app_colors.dart';
import 'package:fitkarma/core/theme/app_typography.dart';
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
                  color: (Theme.of(context).brightness == Brightness.dark ? AppColorsDark.teal : AppColorsLight.teal).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.eco_outlined, color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.teal : AppColorsLight.teal, size: 24),
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
                      style: AppTypography.labelLg(color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.teal : AppColorsLight.teal),
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
          Divider(height: 24, color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.divider : AppColorsLight.divider),
          _buildInfoRow(
            context,
            Icons.restaurant_outlined,
            'Eat More',
            seasonData['foods'] as String,
          ),
          Divider(height: 24, color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.divider : AppColorsLight.divider),
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
        Icon(icon, size: 18, color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.textMuted : AppColorsLight.textMuted),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: AppTypography.caption(color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.textMuted : AppColorsLight.textMuted).copyWith(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTypography.bodyMd(color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
