import 'package:flutter/material.dart';
import 'badge_widgets.dart';

class FestivalCountdownBanner extends StatelessWidget {
  final String festivalName;
  final String hindiName;
  final String fastingType;
  final Duration timeRemaining;
  final VoidCallback? onAction;

  const FestivalCountdownBanner({
    super.key,
    required this.festivalName,
    required this.hindiName,
    required this.fastingType,
    required this.timeRemaining,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade800, Colors.orange.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    festivalName,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    hindiName,
                    style: const TextStyle(fontFamily: 'Devanagari', color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              FestivalDietBadge(type: fastingType),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'STARTS IN',
                      style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    Text(
                      '${hours}h ${minutes}m',
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.orange.shade800,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('VIEW GUIDE'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeddingRoleChip extends StatelessWidget {
  final String role;
  final String iconAsset;
  final bool isSelected;
  final VoidCallback onSelected;

  const WeddingRoleChip({
    super.key,
    required this.role,
    required this.iconAsset,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        height: 160,
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(color: Colors.amber.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber.withOpacity(0.1) : Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_pin, // Fallback icon
                color: isSelected ? Colors.amber.shade800 : Colors.grey,
                size: 40,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              role.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isSelected ? Colors.amber.shade900 : Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
