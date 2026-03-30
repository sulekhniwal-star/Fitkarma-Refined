import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shimmer_loader.dart';
import 'error_retry_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stack)? error;
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
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const _DefaultLoading(),
      error: (e, s) =>
          error?.call(e, s) ??
          ErrorRetryWidget(
            message: e.toString(),
            onRetry: onRetry,
          ),
    );
  }
}

class AsyncValueSliverWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stack)? error;
  final VoidCallback? onRetry;

  const AsyncValueSliverWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () =>
          SliverToBoxAdapter(child: loading ?? const _DefaultLoading()),
      error: (e, s) => SliverToBoxAdapter(
        child: error?.call(e, s) ??
            ErrorRetryWidget(
              message: e.toString(),
              onRetry: onRetry,
            ),
      ),
    );
  }
}

class _DefaultLoading extends StatelessWidget {
  const _DefaultLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: ShimmerListLoader(),
    );
  }
}
