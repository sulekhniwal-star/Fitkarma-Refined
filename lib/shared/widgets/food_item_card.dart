import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/shared/widgets/bilingual_label.dart';

/// Food item card: photo, bilingual name, portion, kcal, + button.
class FoodItemCard extends StatelessWidget {
  final String nameEn;
  final String nameHi;
  final String portion;
  final int calories;
  final String? imageUrl;
  final VoidCallback? onAdd;

  const FoodItemCard({
    super.key,
    required this.nameEn,
    required this.nameHi,
    required this.portion,
    required this.calories,
    this.imageUrl,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Photo or placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BilingualLabel(english: nameEn, hindi: nameHi),
                  const SizedBox(height: 4),
                  Text(
                    '$portion  ·  $calories kcal',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            // + button
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              tooltip: 'Log this food',
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.lightSurfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.restaurant, color: AppColors.lightOutline),
    );
  }
}
