import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../sync/sync_worker.dart';

class SyncStatusBanner extends ConsumerWidget {
  const SyncStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityStreamProvider);
    final dlq = ref.watch(dlqCountProvider);

    if (connectivity.asData?.value == ConnectivityResult.none) {
      return Container(
        color: Colors.blue.shade100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Row(
          children: [
            Icon(Icons.cloud_off, color: Colors.blue),
            SizedBox(width: 12),
            Text('You are offline. Data is being saved locally.'),
          ],
        ),
      );
    }

    return dlq.when(
      data: (count) {
        if (count == 0) return const SizedBox.shrink();
        
        return Container(
          color: Colors.amber.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.sync_problem, color: Colors.amber),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$count items failed to sync. Tap to retry.',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => ref.read(syncWorkerProvider.notifier).syncPending(),
                child: const Text('RETRY'),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
