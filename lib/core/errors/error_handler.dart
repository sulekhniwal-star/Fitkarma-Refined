import 'dart:async';

import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'app_exception.dart';

/// Bilingual error messages for UI display
class BilingualErrorMessage {
  final String english;
  final String hindi;
  final IconData icon;
  final ErrorSeverity severity;

  const BilingualErrorMessage({
    required this.english,
    required this.hindi,
    this.icon = Icons.error_outline_rounded,
    this.severity = ErrorSeverity.error,
  });

  /// Get the appropriate message based on locale
  String getMessage(BuildContext context) {
    // For now, we default to English. In production, you'd use
    // flutter_localizations and check the locale
    return english;
  }

  /// Get Hindi message directly
  String get hindiMessage => hindi;
}

/// Error severity levels for UI styling
enum ErrorSeverity { info, warning, error, critical }

/// Maps raw exceptions to user-friendly bilingual messages
class ErrorHandler {
  ErrorHandler._();

  /// Convert any exception to a BilingualErrorMessage
  static BilingualErrorMessage handle(dynamic error, {StackTrace? stackTrace}) {
    // First, check if it's already an AppException
    if (error is AppException) {
      return _handleAppException(error);
    }

    // Check for Appwrite exceptions
    if (error is appwrite.AppwriteException) {
      return _handleAppwriteException(error);
    }

    // Check for common Dart/Flutter exceptions
    if (error is FormatException) {
      return _handleFormatException(error);
    }

    if (error is TimeoutException) {
      return _handleTimeoutException(error);
    }

    // Check for socket/network exceptions
    if (error.toString().contains('SocketException') ||
        error.toString().contains('HandshakeException')) {
      return _handleNetworkException(error);
    }

    // Fallback to unknown error
    return _handleUnknownError(error);
  }

  /// Handle AppException types
  static BilingualErrorMessage _handleAppException(AppException error) {
    if (error is NetworkException) {
      return _handleNetworkException(error);
    }

    if (error is StorageException) {
      return _handleStorageException(error);
    }

    if (error is AuthException) {
      return _handleAuthException(error);
    }

    if (error is EncryptionException) {
      return _handleEncryptionException(error);
    }

    if (error is SyncException) {
      return _handleSyncException(error);
    }

    return _handleUnknownError(error);
  }

  /// Handle NetworkException
  static BilingualErrorMessage _handleNetworkException(dynamic error) {
    final isOffline = error is NetworkException
        ? error.isOffline
        : error.toString().contains('SocketException');

    if (isOffline || error.toString().contains('NO_CONNECTION')) {
      return const BilingualErrorMessage(
        english: 'No internet connection. Please check your network.',
        hindi: 'इंटरनेट कनेक्शन नहीं है। कृपया अपना नेटवर्क जांचें।',
        icon: Icons.wifi_off_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    if (error is NetworkException && error.code == 'TIMEOUT') {
      return const BilingualErrorMessage(
        english: 'Request timed out. Please try again.',
        hindi: 'अनुरोध का समय समाप्त हो गया। कृपया पुनः प्रयास करें।',
        icon: Icons.timelapse_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    return const BilingualErrorMessage(
      english: 'Network error. Please check your connection and try again.',
      hindi: 'नेटवर्क त्रुटि। कृपया अपना कनेक्शन जांचें और पुनः प्रयास करें।',
      icon: Icons.signal_cellular_connected_no_internet_4_bar_rounded,
      severity: ErrorSeverity.error,
    );
  }

  /// Handle StorageException
  static BilingualErrorMessage _handleStorageException(StorageException error) {
    if (error.code == 'READ_ERROR') {
      return const BilingualErrorMessage(
        english: 'Unable to load data. Please try again.',
        hindi: 'डेटा लोड करने में असमर्थ। कृपया पुनः प्रयास करें।',
        icon: Icons.storage_rounded,
        severity: ErrorSeverity.error,
      );
    }

    if (error.code == 'WRITE_ERROR') {
      return const BilingualErrorMessage(
        english: 'Unable to save data. Please try again.',
        hindi: 'डेटा सहेजने में असमर्थ। कृपया पुनः प्रयास करें।',
        icon: Icons.save_alt_rounded,
        severity: ErrorSeverity.error,
      );
    }

    if (error.code == 'MIGRATION_ERROR') {
      return const BilingualErrorMessage(
        english: 'Database update failed. Please restart the app.',
        hindi: 'डेटाबेस अपडेट विफल। कृपया ऐप को पुनः आरंभ करें।',
        icon: Icons.update_rounded,
        severity: ErrorSeverity.critical,
      );
    }

    if (error.code == 'ENCRYPTION_ERROR') {
      return const BilingualErrorMessage(
        english: 'Data security error. Please restart the app.',
        hindi: 'डेटा सुरक्षा त्रुटि। कृपया ऐप को पुनः आरंभ करें।',
        icon: Icons.security_rounded,
        severity: ErrorSeverity.critical,
      );
    }

    return const BilingualErrorMessage(
      english: 'Database error. Please try again.',
      hindi: 'डेटाबेस त्रुटि। कृपया पुनः प्रयास करें।',
      icon: Icons.storage_rounded,
      severity: ErrorSeverity.error,
    );
  }

  /// Handle AuthException
  static BilingualErrorMessage _handleAuthException(AuthException error) {
    if (error.isSessionExpired) {
      return const BilingualErrorMessage(
        english: 'Your session has expired. Please log in again.',
        hindi: 'आपका सत्र समाप्त हो गया है। कृपया पुनः लॉग इन करें।',
        icon: Icons.logout_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    if (error.isInvalidCredentials) {
      return const BilingualErrorMessage(
        english: 'Invalid email or password.',
        hindi: 'अमान्य ईमेल या पासवर्ड।',
        icon: Icons.lock_outline_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    if (error.code == 'ACCESS_DENIED') {
      return const BilingualErrorMessage(
        english: 'You do not have permission to perform this action.',
        hindi: 'आपको इस क्रिया को करने की अनुमति नहीं है।',
        icon: Icons.block_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    return const BilingualErrorMessage(
      english: 'Authentication error. Please try again.',
      hindi: 'प्रमाणीकरण त्रुटि। कृपया पुनः प्रयास करें।',
      icon: Icons.lock_rounded,
      severity: ErrorSeverity.error,
    );
  }

  /// Handle EncryptionException
  static BilingualErrorMessage _handleEncryptionException(
    EncryptionException error,
  ) {
    if (error.code == 'KEY_NOT_FOUND') {
      return const BilingualErrorMessage(
        english: 'Security key not found. Please restart the app.',
        hindi: 'सुरक्षा कुंजी नहीं मिली। कृपया ऐप को पुनः आरंभ करें।',
        icon: Icons.key_off_rounded,
        severity: ErrorSeverity.critical,
      );
    }

    if (error.code == 'DECRYPTION_FAILED') {
      return const BilingualErrorMessage(
        english: 'Unable to read secure data. Please restart the app.',
        hindi: 'सुरक्षित डेटा पढ़ने में असमर्थ। कृपया ऐप को पुनः आरंभ करें।',
        icon: Icons.security_rounded,
        severity: ErrorSeverity.critical,
      );
    }

    return const BilingualErrorMessage(
      english: 'Security error. Please restart the app.',
      hindi: 'सुरक्षा त्रुटि। कृपया ऐप को पुनः आरंभ करें।',
      icon: Icons.security_rounded,
      severity: ErrorSeverity.critical,
    );
  }

  /// Handle SyncException
  static BilingualErrorMessage _handleSyncException(SyncException error) {
    if (error.isConflict) {
      return const BilingualErrorMessage(
        english: 'Data conflict detected. Please resolve to continue.',
        hindi: 'डेटा संघर्ष का पता चला। जारी रखने के लिए कृपया हल करें।',
        icon: Icons.sync_problem_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    if (error.code == 'QUEUE_FULL') {
      return const BilingualErrorMessage(
        english: 'Storage full. Some changes may not be saved.',
        hindi: 'भंडारण भरा हुआ है। कुछ परिवर्तन सहेजे नहीं जा सकते।',
        icon: Icons.storage_rounded,
        severity: ErrorSeverity.warning,
      );
    }

    return const BilingualErrorMessage(
      english: 'Sync failed. Will retry when online.',
      hindi: 'सिंक विफल। ऑनलाइन होने पर पुनः प्रयास होगा।',
      icon: Icons.sync_rounded,
      severity: ErrorSeverity.info,
    );
  }

  /// Handle Appwrite exceptions
  static BilingualErrorMessage _handleAppwriteException(
    appwrite.AppwriteException error,
  ) {
    final code = error.code?.toString() ?? '';

    switch (code) {
      case '400':
        return const BilingualErrorMessage(
          english: 'Invalid request. Please try again.',
          hindi: 'अमान्य अनुरोध। कृपया पुनः प्रयास करें।',
          icon: Icons.error_outline_rounded,
        );
      case '401':
        return const BilingualErrorMessage(
          english: 'Please log in to continue.',
          hindi: 'जारी रखने के लिए कृपया लॉग इन करें।',
          icon: Icons.logout_rounded,
        );
      case '403':
        return const BilingualErrorMessage(
          english: 'You do not have permission for this action.',
          hindi: 'आपको इस क्रिया की अनुमति नहीं है।',
          icon: Icons.block_rounded,
        );
      case '404':
        return const BilingualErrorMessage(
          english: 'Content not found.',
          hindi: 'सामग्री नहीं मिली।',
          icon: Icons.search_off_rounded,
        );
      case '409':
        return const BilingualErrorMessage(
          english: 'Data conflict. Please try again.',
          hindi: 'डेटा संघर्ष। कृपया पुनः प्रयास करें।',
          icon: Icons.sync_problem_rounded,
        );
      case '500':
      case '502':
      case '503':
        return const BilingualErrorMessage(
          english: 'Server error. Please try again later.',
          hindi: 'सर्वर त्रुटि। कृपया बाद में पुनः प्रयास करें।',
          icon: Icons.cloud_off_rounded,
        );
      case 'NETWORK_ERROR':
        return const BilingualErrorMessage(
          english: 'Network error. Please check your connection.',
          hindi: 'नेटवर्क त्रुटि। कृपया अपना कनेक्शन जांचें।',
          icon: Icons.wifi_off_rounded,
        );
      default:
        return BilingualErrorMessage(
          english: error.message ?? 'An error occurred. Please try again.',
          hindi: 'एक त्रुटि हुई। कृपया पुनः प्रयास करें।',
        );
    }
  }

  /// Handle FormatException
  static BilingualErrorMessage _handleFormatException(FormatException error) {
    return const BilingualErrorMessage(
      english: 'Invalid data format. Please try again.',
      hindi: 'अमान्य डेटा प्रारूप। कृपया पुनः प्रयास करें।',
      icon: Icons.format_list_bulleted_rounded,
    );
  }

  /// Handle TimeoutException
  static BilingualErrorMessage _handleTimeoutException(TimeoutException error) {
    return const BilingualErrorMessage(
      english: 'Request timed out. Please try again.',
      hindi: 'अनुरोध का समय समाप्त हो गया। कृपया पुनः प्रयास करें।',
      icon: Icons.timelapse_rounded,
    );
  }

  /// Handle unknown errors
  static BilingualErrorMessage _handleUnknownError(dynamic error) {
    return BilingualErrorMessage(
      english: 'Something went wrong. Please try again.',
      hindi: 'कुछ गलत हो गया। कृपया पुनः प्रयास करें।',
      icon: Icons.error_outline_rounded,
    );
  }
}

/// Extension to easily convert exceptions to BilingualErrorMessage
extension ErrorHandlerExtension on dynamic {
  BilingualErrorMessage toBilingualError() {
    return ErrorHandler.handle(this);
  }
}
