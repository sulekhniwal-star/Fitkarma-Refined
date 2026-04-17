import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shimmer_loader.dart';
import 'error_retry_widget.dart';

/// A generic wrapper for Riverpod's [AsyncValue] to reduce boilerplate in the UI.
/// 
/// Automatically handles loading and error states with sensible defaults 
/// ([ShimmerLoader] and [ErrorRetryWidget]).
class AsyncValueWidget<T> extends ConsumerWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final Widget? error;
  final VoidCallback? onRetry;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: data,
      loading: () => loading ?? const ShimmerLoader(),
      error: (err, stack) =>
          error ??
          ErrorRetryWidget(
            error: err,
            onRetry: onRetry ?? () {},
            message: null,
          ),
    );
  }
}

