// lib/features/bp/presentation/bp_emergency_alert.dart
// Emergency Alert Dialog for Hypertensive Crisis (≥180/120)

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class BpEmergencyAlert extends StatelessWidget {
  final int systolic;
  final int diastolic;

  const BpEmergencyAlert({
    super.key,
    required this.systolic,
    required this.diastolic,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Warning Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 20),
          
          // Title
          const Text(
            'Hypertensive Crisis!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 12),
          
          // Reading
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$systolic',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const Text(
                  ' / ',
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                ),
                Text(
                  '$diastolic',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const Text(
                  ' mmHg',
                  style: TextStyle(fontSize: 14, color: Colors.purple),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Warning message
          const Text(
            'This is a medical emergency!\nSeek immediate medical attention.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          
          // Instructions
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: AppColors.success),
                    SizedBox(width: 8),
                    Text('Call emergency services', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: AppColors.success),
                    SizedBox(width: 8),
                    Text('Do not delay treatment', style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: AppColors.success),
                    SizedBox(width: 8),
                    Text('Sit down and rest', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Call Emergency
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _callEmergency(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.phone),
            label: const Text(
              'Call Emergency (102/108)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // View Emergency Contacts
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _viewEmergencyContacts(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.purple),
            ),
            icon: const Icon(Icons.contacts),
            label: const Text('View Emergency Contacts'),
          ),
        ),
        const SizedBox(height: 8),
        
        // Dismiss (not recommended)
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'I understand, continue',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(16),
    );
  }

  Future<void> _callEmergency(BuildContext context) async {
    // Try to call emergency number (102 or 108 in India)
    final Uri phoneUri = Uri(scheme: 'tel', path: '102');
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unable to make call. Please dial 102 or 108 manually.'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _viewEmergencyContacts(BuildContext context) {
    // In a real app, this would navigate to emergency contacts
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency Contacts'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.red),
              title: Text('Ambulance'),
              subtitle: Text('102 / 108'),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.purple),
              title: Text('Family Doctor'),
              subtitle: Text('Tap to call'),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: AppColors.primary),
              title: Text('Nearest Hospital'),
              subtitle: Text('View on map'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
