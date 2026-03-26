// lib/core/utils/image_compression_service.dart
// Image compression service for Low Data Mode

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Service for compressing images before upload in Low Data Mode.
///
/// Features:
/// - Compress images to ≤ 200 KB target size
/// - Progressive quality reduction
/// - Maintains aspect ratio
/// - Supports JPEG and PNG formats
class ImageCompressionService {
  static final ImageCompressionService instance = ImageCompressionService._();
  ImageCompressionService._();

  /// Target maximum file size in bytes (200 KB)
  static const int _targetMaxSizeBytes = 200 * 1024;

  /// Initial quality for compression (0-100)
  static const int _initialQuality = 85;

  /// Minimum quality threshold
  static const int _minQuality = 30;

  /// Quality reduction step
  static const int _qualityStep = 10;

  /// Maximum width for compressed images
  static const int _maxWidth = 1024;

  /// Maximum height for compressed images
  static const int _maxHeight = 1024;

  /// Compress an image file to target size (≤ 200 KB)
  ///
  /// [file] - The image file to compress
  /// [targetSizeBytes] - Target maximum size in bytes (default: 200 KB)
  ///
  /// Returns the compressed file path
  Future<String> compressImage(
    File file, {
    int targetSizeBytes = _targetMaxSizeBytes,
  }) async {
    try {
      final filePath = file.path;
      final extension = p.extension(filePath).toLowerCase();

      // Determine output format
      final isJpeg = extension == '.jpg' || extension == '.jpeg';
      final isPng = extension == '.png';

      if (!isJpeg && !isPng) {
        // For other formats, return original file
        print(
          'ImageCompression: Unsupported format $extension, returning original',
        );
        return filePath;
      }

      // Get temporary directory for compressed file
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final outputPath = p.join(
        tempDir.path,
        'compressed_$timestamp${isJpeg ? '.jpg' : '.png'}',
      );

      // Progressive compression
      int quality = _initialQuality;
      String? compressedPath;

      while (quality >= _minQuality) {
        final result = await FlutterImageCompress.compressAndGetFile(
          filePath,
          outputPath,
          quality: quality,
          minWidth: _maxWidth,
          minHeight: _maxHeight,
          format: isJpeg ? CompressFormat.jpeg : CompressFormat.png,
        );

        if (result == null) {
          print('ImageCompression: Compression failed at quality $quality');
          break;
        }

        final compressedFile = File(result.path);
        final compressedSize = await compressedFile.length();

        print(
          'ImageCompression: Compressed to ${compressedSize ~/ 1024} KB '
          'at quality $quality',
        );

        if (compressedSize <= targetSizeBytes) {
          compressedPath = result.path;
          break;
        }

        // Reduce quality and try again
        quality -= _qualityStep;

        // Clean up failed attempt
        if (await compressedFile.exists()) {
          await compressedFile.delete();
        }
      }

      // If we couldn't compress to target size, return the smallest we got
      if (compressedPath == null) {
        // Try one more time with minimum quality
        final result = await FlutterImageCompress.compressAndGetFile(
          filePath,
          outputPath,
          quality: _minQuality,
          minWidth: _maxWidth,
          minHeight: _maxHeight,
          format: isJpeg ? CompressFormat.jpeg : CompressFormat.png,
        );

        if (result != null) {
          compressedPath = result.path;
          final compressedFile = File(compressedPath);
          final compressedSize = await compressedFile.length();
          print(
            'ImageCompression: Final compressed size: ${compressedSize ~/ 1024} KB',
          );
        }
      }

      return compressedPath ?? filePath;
    } catch (e) {
      print('ImageCompression: Error compressing image: $e');
      return file.path;
    }
  }

  /// Compress image bytes to target size
  ///
  /// [bytes] - The image bytes to compress
  /// [format] - The image format (jpeg or png)
  /// [targetSizeBytes] - Target maximum size in bytes (default: 200 KB)
  ///
  /// Returns compressed bytes
  Future<Uint8List?> compressImageBytes(
    Uint8List bytes, {
    CompressFormat format = CompressFormat.jpeg,
    int targetSizeBytes = _targetMaxSizeBytes,
  }) async {
    try {
      int quality = _initialQuality;
      Uint8List? compressedBytes;

      while (quality >= _minQuality) {
        final result = await FlutterImageCompress.compressWithList(
          bytes,
          quality: quality,
          minWidth: _maxWidth,
          minHeight: _maxHeight,
          format: format,
        );

        if (result.length <= targetSizeBytes) {
          compressedBytes = result;
          break;
        }

        quality -= _qualityStep;
      }

      // If we couldn't compress to target size, return the smallest we got
      compressedBytes ??= await FlutterImageCompress.compressWithList(
          bytes,
          quality: _minQuality,
          minWidth: _maxWidth,
          minHeight: _maxHeight,
          format: format,
        );

      print(
        'ImageCompression: Compressed bytes to ${compressedBytes.length ~/ 1024} KB',
      );

      return compressedBytes;
    } catch (e) {
      print('ImageCompression: Error compressing image bytes: $e');
      return null;
    }
  }

  /// Get estimated compressed size without actually compressing
  ///
  /// [file] - The image file to estimate
  ///
  /// Returns estimated size in bytes
  Future<int> estimateCompressedSize(File file) async {
    try {
      final originalSize = await file.length();

      // Rough estimation: JPEG typically compresses to 10-20% of original
      // PNG compresses less, typically 50-70% of original
      final extension = p.extension(file.path).toLowerCase();
      final isJpeg = extension == '.jpg' || extension == '.jpeg';

      if (isJpeg) {
        return (originalSize * 0.15).round(); // 15% of original
      } else {
        return (originalSize * 0.6).round(); // 60% of original
      }
    } catch (e) {
      print('ImageCompression: Error estimating size: $e');
      return 0;
    }
  }

  /// Check if image needs compression
  ///
  /// [file] - The image file to check
  /// [thresholdBytes] - Size threshold in bytes (default: 200 KB)
  ///
  /// Returns true if image exceeds threshold
  Future<bool> needsCompression(
    File file, {
    int thresholdBytes = _targetMaxSizeBytes,
  }) async {
    try {
      final size = await file.length();
      return size > thresholdBytes;
    } catch (e) {
      return false;
    }
  }

  /// Clean up temporary compressed files
  Future<void> cleanupTempFiles() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final files = tempDir.listSync();

      for (final file in files) {
        if (file is File && file.path.contains('compressed_')) {
          final stat = await file.stat();
          final age = DateTime.now().difference(stat.modified);

          // Delete files older than 1 hour
          if (age.inHours > 1) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      print('ImageCompression: Error cleaning up temp files: $e');
    }
  }
}
