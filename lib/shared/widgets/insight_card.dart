import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onThumbsUp;
  final VoidCallback? onThumbsDown;
  final VoidCallback? onTap;

  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final List<Color>? gradientColors;

  const InsightCard({
    super.key,
    required this.title,
    required this.message,
    this.onThumbsUp,
    this.onThumbsDown,
    this.onTap,
    this.icon,
    this.color,
    this.backgroundColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundColor != null ? null : LinearGradient(
            colors: gradientColors ?? (isDark 
              ? [Colors.amber[900]!.withOpacity(0.3), Colors.amber[800]!.withOpacity(0.1)]
              : [Colors.amber[100]!, Colors.amber[50]!]),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: (color ?? Colors.amber).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon ?? Icons.lightbulb_outline, color: color ?? Colors.amber, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? (color?.withOpacity(0.8) ?? Colors.amber[200]) : (color ?? Colors.amber[900]),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[300] : (color?.withOpacity(0.8) ?? Colors.amber[900]),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _FeedbackButton(
                  icon: Icons.thumb_up_outlined,
                  onPressed: onThumbsUp,
                  color: color,
                ),
                const SizedBox(width: 8),
                _FeedbackButton(
                  icon: Icons.thumb_down_outlined,
                  onPressed: onThumbsDown,
                  color: color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;

  const _FeedbackButton({required this.icon, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color ?? Colors.amber),
      ),
    );
  }
}
