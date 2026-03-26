import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A wrapper widget that conditionally loads images based on Low Data Mode.
///
/// When Low Data Mode is enabled:
/// - Network images are not loaded (shows placeholder)
/// - Local file images are still displayed
/// - This helps reduce data usage significantly
class LowDataModeImage extends ConsumerWidget {
  /// URL for network image
  final String? imageUrl;

  /// Path for local file image
  final File? localFile;

  /// Width of the image
  final double? width;

  /// Height of the image
  final double? height;

  /// Box fit for the image
  final BoxFit fit;

  /// Placeholder widget when image is not loaded
  final Widget? placeholder;

  /// Error widget when image fails to load
  final Widget? errorWidget;

  /// Border radius for the image
  final BorderRadius? borderRadius;

  const LowDataModeImage({
    super.key,
    this.imageUrl,
    this.localFile,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch low data mode status
    final lowDataModeService = ref.watch(lowDataModeServiceProvider);
    final isLowDataMode = lowDataModeService.isLowDataModeEnabled;

    Widget imageWidget;

    if (isLowDataMode) {
      // In low data mode, don't load network images
      if (imageUrl != null && imageUrl!.isNotEmpty) {
        imageWidget = placeholder ?? _buildDefaultPlaceholder();
      } else if (localFile != null) {
        // Show local files even in low data mode
        imageWidget = Image.file(
          localFile!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? _buildDefaultError(),
        );
      } else {
        imageWidget = placeholder ?? _buildDefaultPlaceholder();
      }
    } else {
      // Normal mode - load network images
      if (imageUrl != null && imageUrl!.isNotEmpty) {
        imageWidget = CachedNetworkImage(
          imageUrl: imageUrl!,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) =>
              placeholder ?? _buildDefaultPlaceholder(),
          errorWidget: (context, url, error) =>
              errorWidget ?? _buildDefaultError(),
        );
      } else if (localFile != null) {
        imageWidget = Image.file(
          localFile!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? _buildDefaultError(),
        );
      } else {
        imageWidget = placeholder ?? _buildDefaultPlaceholder();
      }
    }

    // Apply border radius if specified
    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: SizedBox(width: width, height: height, child: imageWidget),
      );
    }

    return SizedBox(width: width, height: height, child: imageWidget);
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.grey, size: 32),
      ),
    );
  }

  Widget _buildDefaultError() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 32),
      ),
    );
  }
}

/// A simpler widget that just shows/hides network images based on low data mode
/// Use this when you only need to control network image loading
class LowDataModeNetworkImage extends ConsumerWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const LowDataModeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lowDataModeService = ref.watch(lowDataModeServiceProvider);
    final isLowDataMode = lowDataModeService.isLowDataModeEnabled;

    if (isLowDataMode) {
      // Don't load network images in low data mode
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey[100],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.grey),
        ),
      ),
    );
  }
}
