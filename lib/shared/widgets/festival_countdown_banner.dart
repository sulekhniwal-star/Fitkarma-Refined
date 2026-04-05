import 'package:flutter/material.dart';
import 'festival_diet_badge.dart';

class FestivalCountdownBanner extends StatelessWidget {
  final String nameEn;
  final String nameHi;
  final DateTime startDate;
  final bool isFasting;
  final FastingType? fastingType;
  final Color? accentColor;
  final VoidCallback? onTap;
  final VoidCallback? onQuickLog;

  const FestivalCountdownBanner({
    super.key,
    required this.nameEn,
    required this.nameHi,
    required this.startDate,
    this.isFasting = false,
    this.fastingType,
    this.accentColor,
    this.onTap,
    this.onQuickLog,
  });

  int get _daysUntil {
    return startDate.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? Colors.orange;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.celebration, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          nameEn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nameHi,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _daysUntil == 0 ? 'Today!' : '$_daysUntil days',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isFasting && fastingType != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getFastingLabel(fastingType!),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFastingLabel(FastingType type) {
    switch (type) {
      case FastingType.nirjala: return 'Nirjala';
      case FastingType.phalahar: return 'Phalahar';
      case FastingType.roza: return 'Roza';
      case FastingType.feast: return 'Feast';
      case FastingType.sattvic: return 'Sattvic';
    }
  }
}