import 'package:flutter/material.dart';
import 'bilingual_text.dart';

class FoodItemCard extends StatelessWidget {
  final String? imageUrl;
  final String nameEn;
  final String nameLocal;
  final String portion;
  final int calories;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;
  final bool isLoading;

  const FoodItemCard({
    super.key,
    this.imageUrl,
    required this.nameEn,
    required this.nameLocal,
    required this.portion,
    required this.calories,
    this.onTap,
    this.onAdd,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(context),
                  ),
                )
              else
                _placeholder(context),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BilingualText(
                      english: nameEn,
                      hindi: nameLocal,
                      englishStyle: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$portion · $calories kcal',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              if (onAdd != null)
                IconButton(
                  onPressed: isLoading ? null : onAdd,
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_circle),
                  color: Theme.of(context).colorScheme.primary,
                  iconSize: 32,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.restaurant,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}