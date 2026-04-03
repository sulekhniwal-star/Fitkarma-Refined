import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Amber card with lightbulb icon and 👍/👎 feedback buttons.
class InsightCard extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback? onThumbsUp;
  final VoidCallback? onThumbsDown;

  const InsightCard({
    super.key,
    required this.title,
    required this.body,
    this.onThumbsUp,
    this.onThumbsDown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // amber 50
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: Color(0xFFF9A825), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: AppTextStyles.titleSmall
                        .copyWith(color: const Color(0xFF795548))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(body, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _FeedbackButton(
                icon: Icons.thumb_up_outlined,
                onTap: onThumbsUp,
              ),
              const SizedBox(width: 8),
              _FeedbackButton(
                icon: Icons.thumb_down_outlined,
                onTap: onThumbsDown,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _FeedbackButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: const Color(0xFF795548)),
      ),
    );
  }
}
