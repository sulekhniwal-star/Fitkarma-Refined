import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A card displaying a food item with nutrient highlights and quick-add action.
class FoodItemCard extends StatelessWidget {
  final String name;
  final String? nameHi;
  final String portionInfo; // e.g., "1 katori · 180 kcal"
  final String? imageUrl;
  final String? assetPath;
  final String emoji;
  final VoidCallback onAdd;

  const FoodItemCard({
    super.key,
    required this.name,
    this.nameHi,
    required this.portionInfo,
    this.imageUrl,
    this.assetPath,
    required this.emoji,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Food Image / Emoji
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.bg2 : AppColorsLight.bg2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: assetPath != null
                    ? Image.asset(assetPath!, fit: BoxFit.cover)
                    : imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => _EmojiFallback(emoji: emoji),
                          )
                        : _EmojiFallback(emoji: emoji),
              ),
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: (isDark ? AppTypography.h3() : AppTypography.h3(color: AppColorsLight.textPrimary)),
                  ),
                  if (nameHi != null)
                    Text(
                      nameHi!,
                      style: AppTypography.hindi(color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    portionInfo,
                    style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted)).copyWith(
                      color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            // Add Button
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: isDark ? AppColorsDark.primary : AppColorsLight.primary,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmojiFallback extends StatelessWidget {
  final String emoji;
  const _EmojiFallback({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 32),
      ),
    );
  }
}

