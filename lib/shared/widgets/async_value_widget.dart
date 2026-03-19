import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'error_retry_widget.dart';
import 'shimmer_loader.dart';

/// A generic wrapper for handling [AsyncValue] states (Loading, Error, Data).
/// Used across all screens that interact with Drift or Appwrite.
class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;
  
  /// Optional: Custom loading widget. If null, a default shimmer card is shown.
  final Widget? loading;
  
  /// Optional: Callback when the retry button is pressed in the error state.
  final VoidCallback? onRetry;
  
  /// Optional: Whether the entire widget should be center-aligned. Defaults to true.
  final bool center;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.onRetry,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (error, stackTrace) => ErrorRetryWidget(
        message: error.toString(),
        onRetry: onRetry,
      ),
      loading: () => loading ?? _buildDefaultLoading(context),
    );
  }

  Widget _buildDefaultLoading(BuildContext context) {
    final shimmer = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ShimmerLoader.card(),
          const SizedBox(height: 16),
          ShimmerLoader.card(),
        ],
      ),
    );

    if (center) {
      return Center(child: shimmer);
    }
    return shimmer;
  }
}
