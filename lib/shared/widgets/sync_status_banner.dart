import 'package:flutter/material.dart';

class SyncStatusBanner extends StatelessWidget {
  final bool isOnline;
  final bool isSyncing;
  final int pendingCount;
  final int dlqCount;
  final VoidCallback? onRetry;
  final VoidCallback? onViewDlq;

  const SyncStatusBanner({
    super.key,
    required this.isOnline,
    required this.isSyncing,
    this.pendingCount = 0,
    this.dlqCount = 0,
    this.onRetry,
    this.onViewDlq,
  });

  @override
  Widget build(BuildContext context) {
    if (isOnline && pendingCount == 0 && dlqCount == 0) {
      return const SizedBox.shrink();
    }

    Color backgroundColor;
    Color foregroundColor;
    IconData icon;
    String message;

    if (dlqCount > 0) {
      backgroundColor = Colors.red.shade100;
      foregroundColor = Colors.red.shade800;
      icon = Icons.error;
      message = '$dlqCount items failed to sync';
    } else if (!isOnline) {
      backgroundColor = Colors.orange.shade100;
      foregroundColor = Colors.orange.shade800;
      icon = Icons.cloud_off;
      message = 'Offline · $pendingCount pending';
    } else if (isSyncing) {
      backgroundColor = Colors.blue.shade100;
      foregroundColor = Colors.blue.shade800;
      icon = Icons.sync;
      message = 'Syncing... $pendingCount items';
    } else {
      backgroundColor = Colors.orange.shade100;
      foregroundColor = Colors.orange.shade800;
      icon = Icons.sync_problem;
      message = '$pendingCount items pending sync';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: backgroundColor,
      child: Row(
        children: [
          Icon(icon, color: foregroundColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: foregroundColor, fontWeight: FontWeight.w500),
            ),
          ),
          if (dlqCount > 0 && onViewDlq != null)
            TextButton(
              onPressed: onViewDlq,
              child: const Text('View'),
            ),
          if (!isOnline || (pendingCount > 0 && !isSyncing) && onRetry != null)
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 20),
              color: foregroundColor,
            ),
        ],
      ),
    );
  }
}