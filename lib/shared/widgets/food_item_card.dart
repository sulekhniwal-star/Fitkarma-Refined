import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'bilingual_label.dart';

class FoodItemCard extends StatelessWidget {
  final String? imageUrl;
  final String emoji;
  final String englishName;
  final String hindiName;
  final String portion;
  final int kcal;
  final bool isLowDataMode;
  final VoidCallback onAdd;

  const FoodItemCard({
    super.key,
    this.imageUrl,
    required this.emoji,
    required this.englishName,
    required this.hindiName,
    required this.portion,
    required this.kcal,
    this.isLowDataMode = false,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: theme.cardTheme.color,
      shape: theme.cardTheme.shape,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Food Image / Emoji Fallback ---
            _buildImage(isDarkMode),

            // --- Details ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BilingualLabel(
                      english: englishName,
                      hindi: hindiName,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          portion,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.dividerColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$kcal kcal',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // --- Add Action ---
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_rounded),
                  color: AppColors.primary,
                  iconSize: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(bool isDarkMode) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: (imageUrl != null && !isLowDataMode)
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: Icon(Icons.restaurant_rounded, color: AppColors.textMuted, size: 24),
              ),
              errorWidget: (context, url, error) => _buildEmojiFallback(),
            )
          : _buildEmojiFallback(),
    );
  }

  Widget _buildEmojiFallback() {
    return Center(
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 32),
      ),
    );
  }
}
