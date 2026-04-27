import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'animation_widgets.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(
        child: ErrorRetryWidget(
          message: e.toString(),
          onRetry: onRetry ?? () {},
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFF97316),
        ),
      ),
    );
  }
}
