import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:fitkarma/core/errors/app_exception.dart';

enum AppLocale { en, hi }

class ErrorHandler {
  static AppLocale _locale = AppLocale.en;

  static void setLocale(AppLocale locale) {
    _locale = locale;
  }

  static AppLocale get locale => _locale;

  static String getMessage(AppException error, [AppLocale? overrideLocale]) {
    final loc = overrideLocale ?? _locale;
    return _getMessage(error, loc);
  }

  static String _getMessage(AppException error, AppLocale loc) {
    switch (error) {
      case NetworkException():
        return _networkError(error, loc);
      case StorageException():
        return _storageError(error, loc);
      case AuthException():
        return _authError(error, loc);
      case EncryptionException():
        return _encryptionError(error, loc);
      case SyncException():
        return _syncError(error, loc);
      case ValidationException():
        return _validationError(error, loc);
      default:
        return loc == AppLocale.hi
            ? 'एक अज्ञात त्रुटि हुई। कृपया पुनः प्रयास करें।'
            : 'An unknown error occurred. Please try again.';
    }
  }

  static String _networkError(NetworkException error, AppLocale loc) {
    switch (error.code) {
      case 'network_error':
        return loc == AppLocale.hi
            ? 'इंटरनेट कनेक्शन समस्या। कृपया अपना नेटवर्क जाँचें।'
            : 'Internet connection issue. Please check your network.';
      case 'timeout':
        return loc == AppLocale.hi
            ? 'सर्वर से कनेक्शन टाइमआउट हो गया।'
            : 'Connection to server timed out.';
      case 'server_error':
        return loc == AppLocale.hi
            ? 'सर्वर में समस्या है। कृपया कुछ देर बाद प्रयास करें।'
            : 'Server issue. Please try again later.';
      case 'no_network':
        return loc == AppLocale.hi
            ? 'इंटरनेट उपलब्ध नहीं है।'
            : 'Internet not available.';
      default:
        return loc == AppLocale.hi
            ? 'नेटवर्क त्रुटि: ${error.message}'
            : 'Network error: ${error.message}';
    }
  }

  static String _storageError(StorageException error, AppLocale loc) {
    switch (error.code) {
      case 'database_error':
        return loc == AppLocale.hi
            ? 'डेटाबेस त्रुटि हुई।'
            : 'Database error occurred.';
      case 'corrupted':
        return loc == AppLocale.hi
            ? 'डेटा दूषित है। कृपया ऐप पुनः आरंभ करें।'
            : 'Data is corrupted. Please restart the app.';
      case 'migration_failed':
        return loc == AppLocale.hi
            ? 'अपडेट विफल। कृपया ऐप पुनः इंस्टॉल करें।'
            : 'Update failed. Please reinstall the app.';
      default:
        return loc == AppLocale.hi
            ? 'स्टोरेज त्रुटि: ${error.message}'
            : 'Storage error: ${error.message}';
    }
  }

  static String _authError(AuthException error, AppLocale loc) {
    if (error.isExpired) {
      return loc == AppLocale.hi
          ? 'सत्र समाप्त हो गया है। पुनः लॉगिन करें।'
          : 'Session expired. Please login again.';
    }

    switch (error.code) {
      case 'unauthorized':
        return loc == AppLocale.hi
            ? 'लॉगिन आवश्यक है।'
            : 'Login required.';
      case 'forbidden':
        return loc == AppLocale.hi
            ? 'इस क्रिया की अनुमति नहीं है।'
            : 'Permission denied for this action.';
      case 'user_not_found':
        return loc == AppLocale.hi
            ? 'उपयोगकर्ता नहीं मिला।'
            : 'User not found.';
      case 'invalid_credentials':
        return loc == AppLocale.hi
            ? 'गलत ईमेल या पासवर्ड।'
            : 'Invalid email or password.';
      default:
        return loc == AppLocale.hi
            ? 'प्रमाणीकरण त्रुटि: ${error.message}'
            : 'Auth error: ${error.message}';
    }
  }

  static String _encryptionError(EncryptionException error, AppLocale loc) {
    switch (error.code) {
      case 'decryption_failed':
        return loc == AppLocale.hi
            ? 'डेटा पढ़ नहीं सका। एन्क्रिप्शन समस्या।'
            : 'Could not read data. Encryption issue.';
      case 'key_expired':
        return loc == AppLocale.hi
            ? 'सुरक्षा कुंजी समाप्त हो गई। पुनः लॉगिन करें।'
            : 'Security key expired. Please login again.';
      case 'invalid_key':
        return loc == AppLocale.hi
            ? 'अमान्य सुरक्षा कुंजी।'
            : 'Invalid security key.';
      default:
        return loc == AppLocale.hi
            ? 'सुरक्षा त्रुटि: ${error.message}'
            : 'Security error: ${error.message}';
    }
  }

  static String _syncError(SyncException error, AppLocale loc) {
    if (error.isDeadLetter) {
      return loc == AppLocale.hi
          ? 'सिंक विफल। ${error.retryCount} बार प्रयास किया।'
          : 'Sync failed. Tried ${error.retryCount} times.';
    }

    return loc == AppLocale.hi
        ? 'डेटा सिंक करने में त्रुटि।'
        : 'Error syncing data.';
  }

  static String _validationError(ValidationException error, AppLocale loc) {
    if (error.fieldErrors != null && error.fieldErrors!.isNotEmpty) {
      final firstField = error.fieldErrors!.keys.first;
      return loc == AppLocale.hi
          ? '${error.fieldErrors![firstField]}'
          : error.fieldErrors![firstField]!;
    }

    return loc == AppLocale.hi
        ? 'दर्ज की गई जानकारी में त्रुटि।'
        : 'Invalid input.';
  }
}

AppException mapToAppException(dynamic error) {
  if (error is AppException) return error;

  final errorStr = error.toString().toLowerCase();

  if (error is AppwriteException) {
    final String errorCode = 'appwrite_error';
    final String errorMessage = 'Appwrite error: ${error.code}';
    
    if (errorStr.contains('401') || errorStr.contains('unauthorized')) {
      return AuthException(
        code: 'unauthorized',
        message: errorMessage,
        isExpired: true,
        original: error,
      );
    }
    return NetworkException(
      code: errorCode,
      message: errorMessage,
      original: error,
    );
  }

  if (errorStr.contains('socket') || errorStr.contains('handshake')) {
    return const NetworkException(
      code: 'network_error',
      message: 'Connection failed',
    );
  }

  if (errorStr.contains('timeout')) {
    return const NetworkException(
      code: 'timeout',
      message: 'Request timed out',
    );
  }

  if (errorStr.contains('unauthorized') || errorStr.contains('401')) {
    return const AuthException(
      code: 'unauthorized',
      message: 'Unauthorized',
      isExpired: true,
    );
  }

  if (errorStr.contains('forbidden') || errorStr.contains('403')) {
    return const AuthException(
      code: 'forbidden',
      message: 'Access denied',
    );
  }

  if (errorStr.contains('database') || errorStr.contains('sqlite')) {
    return const StorageException(
      code: 'database_error',
      message: 'Database error',
    );
  }

  if (errorStr.contains('encryption') || errorStr.contains('decrypt')) {
    return const EncryptionException(
      code: 'decryption_failed',
      message: 'Could not read data',
    );
  }

  return _UnknownException(
    code: 'unknown',
    message: error.toString(),
    original: error,
  );
}

class _UnknownException implements AppException {
  @override final String code;
  @override final String message;
  @override final String? details;
  @override final dynamic original;

  const _UnknownException({
    required this.code,
    required this.message,
    this.details,
    this.original,
  });
}

Widget buildErrorWidget(
  dynamic error,
  VoidCallback? onRetry, [
  AppLocale? locale,
]) {
  final appError = mapToAppException(error);
  final message = ErrorHandler.getMessage(appError, locale ?? ErrorHandler.locale);

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(
                locale == AppLocale.hi ? 'पुनः प्रयास' : 'Retry',
              ),
            ),
          ],
        ],
      ),
    ),
  );
}