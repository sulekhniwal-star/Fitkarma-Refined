// lib/features/bp/presentation/bp_screen.dart
// BP Screen - Main screen for blood pressure tracking

import 'package:flutter/material.dart';
import 'package:fitkarma/features/bp/data/bp_service.dart';
import 'package:fitkarma/features/bp/presentation/bp_logging_sheet.dart';
import 'package:fitkarma/features/bp/presentation/bp_trend_chart.dart';
import 'package:fitkarma/features/bp/presentation/bp_emergency_alert.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class BpScreen extends StatefulWidget {
  final String userId;

  const BpScreen({super.key, required this.userId});

  @override
  State<BpScreen> createState() => _BpScreenState();
}

class _BpScreenState extends State<BpScreen> {
  int? _latestSystolic;
  int? _latestDiastolic;
  String? _latestClassification;
  DateTime? _latestLoggedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _showReminderInfo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Log Card
            _buildQuickLogCard(),
            const SizedBox(height: 20),

            // Latest Reading Card
            _buildLatestReadingCard(),
            const SizedBox(height: 20),

            // Trend Chart
            _buildTrendSection(),
            const SizedBox(height: 20),

            // AHA Guidelines Info
            _buildGuidelinesCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showLoggingSheet,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Log BP'),
      ),
    );
  }

  Widget _buildQuickLogCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quick Log',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.timer, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '< 20 sec',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Log your blood pressure in seconds',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showLoggingSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.favorite_border),
                label: const Text(
                  'Log Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestReadingCard() {
    final hasData = _latestSystolic != null;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latest Reading',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if (hasData)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(
                        _getClassificationColor(_latestClassification ?? ''),
                      ).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _latestClassification ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(
                          _getClassificationColor(_latestClassification ?? ''),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (hasData) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$_latestSystolic',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      ' / ',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '$_latestDiastolic',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12, left: 8),
                    child: Text(
                      'mmHg',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              if (_latestLoggedAt != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _formatDate(_latestLoggedAt!),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
            ] else ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.favorite_border, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'No readings yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Log your first blood pressure reading',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTrendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trend Analysis',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        BpTrendChart(userId: widget.userId),
      ],
    );
  }

  Widget _buildGuidelinesCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'AHA Guidelines',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildGuidelineRow('Normal', '< 120/80', AppColors.success),
            _buildGuidelineRow('Elevated', '120-129/<80', AppColors.warning),
            _buildGuidelineRow('Stage 1 HTN', '130-139/80-89', Colors.orange),
            _buildGuidelineRow('Stage 2 HTN', '≥ 140/90', AppColors.error),
            _buildGuidelineRow('Crisis', '≥ 180/120', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineRow(String label, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Text(range, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  void _showLoggingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BpLoggingSheet(
        userId: widget.userId,
        onLogComplete: (systolic, diastolic, classification, isCrisis) {
          setState(() {
            _latestSystolic = systolic;
            _latestDiastolic = diastolic;
            _latestClassification = classification.displayName;
            _latestLoggedAt = DateTime.now();
          });

          // Show emergency alert if hypertensive crisis
          if (isCrisis) {
            _showEmergencyAlert(systolic, diastolic);
          }
        },
      ),
    );
  }

  void _showEmergencyAlert(int systolic, int diastolic) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          BpEmergencyAlert(systolic: systolic, diastolic: diastolic),
    );
  }

  void _showReminderInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('BP Reminders'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📅 Morning: 6:00 - 9:00 AM'),
            SizedBox(height: 8),
            Text('🌙 Evening: 6:00 - 9:00 PM'),
            SizedBox(height: 16),
            Text(
              'Enable notifications to get reminded to log your blood pressure.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  int _getClassificationColor(String classification) {
    switch (classification.toLowerCase()) {
      case 'normal':
        return 0xFF4CAF50;
      case 'elevated':
        return 0xFFFFEB3B;
      case 'stage 1 hypertension':
        return 0xFFFF9800;
      case 'stage 2 hypertension':
        return 0xFFF44336;
      case 'hypertensive crisis':
        return 0xFF9C27B0;
      default:
        return 0xFF9E9E9E;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
