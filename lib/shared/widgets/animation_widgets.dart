import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StreakFlameWidget extends StatelessWidget {
  final int count;

  const StreakFlameWidget({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/lottie/streak_fire.json',
          width: 60 + (count * 2.0).clamp(0, 40),
          height: 60 + (count * 2.0).clamp(0, 40),
        ),
        Text(
          '$count DAYS',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ErrorRetryWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorRetryWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/error_state.json',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }
}
