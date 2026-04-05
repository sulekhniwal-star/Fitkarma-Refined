import 'package:flutter/material.dart';

enum WeddingRole { bride, groom, guest, relative }

class WeddingRoleChip extends StatelessWidget {
  final WeddingRole role;
  final bool isSelected;
  final ValueChanged<WeddingRole>? onSelected;

  const WeddingRoleChip({
    super.key,
    required this.role,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected?.call(role),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 48,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              _getLabel(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
            ),
            if (isSelected)
              const SizedBox(height: 4),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (role) {
      case WeddingRole.bride:
        return Icons.face_6;
      case WeddingRole.groom:
        return Icons.face_5;
      case WeddingRole.guest:
        return Icons.people;
      case WeddingRole.relative:
        return Icons.family_restroom;
    }
  }

  String _getLabel() {
    switch (role) {
      case WeddingRole.bride:
        return 'Bride';
      case WeddingRole.groom:
        return 'Groom';
      case WeddingRole.guest:
        return 'Guest';
      case WeddingRole.relative:
        return 'Relative';
    }
  }
}