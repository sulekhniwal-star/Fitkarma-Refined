import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class HomeWidgetPreview extends StatelessWidget {
  final Widget child;
  final String deviceType; // 'iOS' or 'Android'

  const HomeWidgetPreview({
    super.key,
    required this.child,
    this.deviceType = 'iOS',
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = deviceType == 'iOS';
    
    return Container(
      width: 300,
      height: 480,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: isIOS ? const Color(0xFF1C1C1E) : Colors.black87,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: Colors.grey[800]!, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Home Screen Wallpaper Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: _buildWallpaper(isIOS),
            ),
          ),
          
          // App Icons Grid
          Positioned.fill(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 32,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(12, (index) => _buildAppIconPlaceholder(isIOS)),
            ),
          ),
          
          // The Scaled Widget
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Transform.scale(
              scale: 0.9,
              child: child,
            ),
          ),
          
          // Notch / Pill
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              width: 80,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          
          // Home Bar
          if (isIOS)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 120,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWallpaper(bool isIOS) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isIOS 
              ? [Colors.blue[900]!, Colors.purple[900]!] 
              : [Colors.green[900]!, Colors.teal[900]!],
        ),
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }

  Widget _buildAppIconPlaceholder(bool isIOS) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(isIOS ? 10 : 20),
      ),
    );
  }
}

/// Helper for constructing a small widget for preview
class MiniStatWidget extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const MiniStatWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              const Icon(Icons.bolt, color: AppColors.accent, size: 16),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.h1.copyWith(fontSize: 24, color: AppColors.textPrimary),
          ),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
