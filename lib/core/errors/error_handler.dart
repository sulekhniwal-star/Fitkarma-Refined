import 'package:flutter/material.dart';
import 'app_exception.dart';

/// Maps [AppException] (and raw exceptions) to bilingual UI messages.
class ErrorHandler {
  ErrorHandler._();

  /// Returns a [_BilingualMessage] with English + Hindi text for the given error.
  static _BilingualMessage messageFor(Object error) {
    if (error is ValidationException) {
      return _BilingualMessage(error.message, error.message);
    }
    if (error is SessionExpiredException) {
      return const _BilingualMessage(
        'Your session has expired. Please log in again.',
        'आपका सत्र समाप्त हो गया। कृपया फिर से लॉग इन करें।',
      );
    }
    if (error is AuthException) {
      return _BilingualMessage(
        error.message,
        _authHindi(error.code),
      );
    }
    if (error is TimeoutException) {
      return const _BilingualMessage(
        'Request timed out. Please check your connection.',
        'अनुरोध का समय समाप्त हो गया। कृपया अपना इंटरनेट जांचें।',
      );
    }
    if (error is NetworkException) {
      return const _BilingualMessage(
        'No internet connection. Data saved locally.',
        'इंटरनेट नहीं है। डेटा स्थानीय रूप से सहेजा गया।',
      );
    }
    if (error is KeyDerivationException) {
      return const _BilingualMessage(
        'Could not unlock secure storage. Please restart the app.',
        'सुरक्षित संग्रहण नहीं खुल सका। ऐप को दोबारा आज़माएं।',
      );
    }
    if (error is EncryptionException) {
      return const _BilingualMessage(
        'Security error. Your data is safe.',
        'सुरक्षा त्रुटि। आपका डेटा सुरक्षित है।',
      );
    }
    if (error is DeadLetterException) {
      return const _BilingualMessage(
        'Some items failed to sync after multiple attempts.',
        'कुछ आइटम बार-बार प्रयास के बाद भी सिंक नहीं हो सके।',
      );
    }
    if (error is SyncException) {
      return const _BilingualMessage(
        'Sync failed. Will retry automatically.',
        'सिंक विफल हुआ। स्वचालित रूप से पुनः प्रयास होगा।',
      );
    }
    if (error is StorageException) {
      return const _BilingualMessage(
        'Local storage error. Please restart the app.',
        'स्थानीय संग्रहण त्रुटि। ऐप को पुनः चालू करें।',
      );
    }
    if (error is PermissionException) {
      return _BilingualMessage(
        'Permission required: ${error.permission ?? 'unknown'}',
        'अनुमति आवश्यक: ${error.permission ?? 'अज्ञात'}',
      );
    }
    if (error is FoodNotFoundException) {
      return const _BilingualMessage(
        'Food item not found.',
        'खाद्य पदार्थ नहीं मिला।',
      );
    }
    // Fallback
    return const _BilingualMessage(
      'Something went wrong. Please try again.',
      'कुछ गलत हो गया। कृपया पुनः प्रयास करें।',
    );
  }

  /// Shows a [SnackBar] with bilingual message.
  static void show(BuildContext context, Object error) {
    final msg = messageFor(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(msg.english, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(msg.hindi, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        backgroundColor: const Color(0xFF1E1E2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          textColor: const Color(0xFFFF6B35),
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  /// Maps raw exceptions to [AppException].
  static AppException wrap(Object error) {
    if (error is AppException) return error;
    final msg = error.toString();
    if (msg.contains('network') || msg.contains('socket') || msg.contains('connection')) {
      return NetworkException(cause: error);
    }
    if (msg.contains('401') || msg.contains('unauthorized') || msg.contains('user_invalid')) {
      return AuthException(cause: error);
    }
    if (msg.contains('timeout')) return TimeoutException(cause: error);
    if (msg.contains('encrypt') || msg.contains('decrypt')) {
      return EncryptionException(cause: error);
    }
    if (msg.contains('database') || msg.contains('sqlite') || msg.contains('drift')) {
      return StorageException(cause: error);
    }
    return NetworkException(cause: error, message: msg);
  }

  static String _authHindi(String? code) {
    switch (code) {
      case 'user_invalid_credentials':
        return 'गलत ईमेल या पासवर्ड।';
      case 'user_already_exists':
        return 'यह ईमेल पहले से पंजीकृत है।';
      case 'session_expired':
        return 'आपका सत्र समाप्त हो गया।';
      default:
        return 'प्रमाणीकरण विफल हुआ।';
    }
  }
}

class _BilingualMessage {
  const _BilingualMessage(this.english, this.hindi);
  final String english;
  final String hindi;
}