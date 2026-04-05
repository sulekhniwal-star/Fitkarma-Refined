import 'package:flutter/material.dart';
import 'app_exception.dart';

class ErrorHandler {
  static String getUserMessage(AppException exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return 'No internet connection. Please check your network.';
      case StorageException:
        return 'Unable to save data. Please try again.';
      case AuthException:
        if (exception.code == 'invalid_credentials') {
          return 'Invalid email or password.';
        } else if (exception.code == 'user_not_found') {
          return 'No account found with this email.';
        } else if (exception.code == 'session_expired') {
          return 'Your session expired. Please login again.';
        }
        return 'Authentication failed. Please try again.';
      case EncryptionException:
        return 'Security error. Please restart the app.';
      case SyncException:
        if (exception.code == 'conflict') {
          return 'Data conflict. Please try again.';
        } else if (exception.code == 'dead_letter') {
          return 'Sync failed after multiple attempts. Please check your connection.';
        }
        return 'Unable to sync data. Will retry automatically.';
      case ValidationException:
        return exception.message;
      case PermissionException:
        return 'Permission denied. Please check app permissions.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  static String getHindiMessage(AppException exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return 'इंटरनेट कनेक्शन नहीं है। कृपया नेटवर्क जांचें।';
      case StorageException:
        return 'डेटा सेव नहीं हो सका। कृपया पुनः प्रयास करें।';
      case AuthException:
        if (exception.code == 'invalid_credentials') {
          return 'गलत ईमेल या पासवर्ड।';
        } else if (exception.code == 'user_not_found') {
          return 'इस ईमेल पर कोई खाता नहीं मिला।';
        } else if (exception.code == 'session_expired') {
          return 'आपका सत्र समाप्त हो गया। कृपया पुनः लॉगिन करें।';
        }
        return 'प्रमाणीकरण विफल। कृपया पुनः प्रयास करें।';
      case EncryptionException:
        return 'सुरक्षा त्रुटि। कृपया ऐप पुनः आरंभ करें।';
      case SyncException:
        if (exception.code == 'conflict') {
          return 'डेटा विरोध। कृपया पुनः प्रयास करें।';
        } else if (exception.code == 'dead_letter') {
          return 'कई प्रयासों के बाद सिंक विफल। कृपया कनेक्शन जांचें।';
        }
        return 'डेटा सिंक नहीं हो सका। स्वचालित रूप से पुनः प्रयास होगा।';
      case ValidationException:
        return exception.message;
      case PermissionException:
        return 'अनुमति नहीं मिली। कृपया ऐप अनुमतियां जांचें।';
      default:
        return 'कुछ गलत हो गया। कृपया पुनः प्रयास करें।';
    }
  }

  static Widget buildErrorWidget(
    BuildContext context,
    AppException exception, {
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
  }) {
    final locale = Localizations.localeOf(context);
    final isHindi = locale.languageCode == 'hi';
    
    final message = isHindi 
        ? getHindiMessage(exception) 
        : getUserMessage(exception);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIconForException(exception),
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(isHindi ? 'पुनः प्रयास' : 'Retry'),
              ),
            if (onDismiss != null)
              TextButton(
                onPressed: onDismiss,
                child: Text(isHindi ? 'बंद करें' : 'Dismiss'),
              ),
          ],
        ),
      ),
    );
  }

  static IconData _getIconForException(AppException exception) {
    switch (exception.runtimeType) {
      case NetworkException:
        return Icons.wifi_off;
      case StorageException:
        return Icons.storage;
      case AuthException:
        return Icons.lock_outline;
      case EncryptionException:
        return Icons.security;
      case SyncException:
        return Icons.sync_problem;
      case PermissionException:
        return Icons.no_accounts;
      default:
        return Icons.error_outline;
    }
  }

  static AppException handle(Object error, StackTrace? stackTrace) {
    if (error is AppException) return error;

    // Wrap known Dart exceptions
    if (error.toString().contains('SocketException') ||
        error.toString().contains('HttpException')) {
      return NetworkException(
        message: 'Network error',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error.toString().contains('FormatException')) {
      return ValidationException(
        message: 'Invalid data format',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Default to generic exception
    return StorageException(
      message: error.toString(),
      originalError: error,
      stackTrace: stackTrace,
    );
  }
}