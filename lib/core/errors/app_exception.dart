import 'package:appwrite/appwrite.dart' as appwrite;

/// Base exception class for all app-specific errors.
/// Provides a consistent structure for error handling across the app.
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => '$runtimeType: $message (code: $code)';
}

/// Network-related exceptions (connectivity, API failures, timeouts)
class NetworkException extends AppException {
  final bool isOffline;

  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.isOffline = false,
  });

  /// Factory for creating from connectivity errors
  factory NetworkException.noConnection({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return NetworkException(
      message: 'No internet connection available',
      code: 'NO_CONNECTION',
      originalError: originalError,
      stackTrace: stackTrace,
      isOffline: true,
    );
  }

  /// Factory for creating from timeout errors
  factory NetworkException.timeout({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return NetworkException(
      message: 'Request timed out',
      code: 'TIMEOUT',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Factory for creating from Appwrite network errors
  factory NetworkException.fromAppwrite(appwrite.AppwriteException error) {
    final code = error.code?.toString() ?? 'UNKNOWN';

    String message;
    switch (code) {
      case '400':
        message = 'Invalid request';
        break;
      case '401':
        message = 'Authentication required';
        break;
      case '403':
        message = 'Access denied';
        break;
      case '404':
        message = 'Resource not found';
        break;
      case '500':
      case '502':
      case '503':
        message = 'Server error';
        break;
      default:
        message = error.message ?? 'Network error occurred';
    }

    return NetworkException(message: message, code: code, originalError: error);
  }
}

/// Storage and database-related exceptions (Drift, file storage)
class StorageException extends AppException {
  final String? tableName;

  const StorageException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.tableName,
  });

  /// Factory for database read errors
  factory StorageException.readError({
    String? tableName,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return StorageException(
      message: 'Failed to read data from database',
      code: 'READ_ERROR',
      originalError: originalError,
      stackTrace: stackTrace,
      tableName: tableName,
    );
  }

  /// Factory for database write errors
  factory StorageException.writeError({
    String? tableName,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return StorageException(
      message: 'Failed to save data to database',
      code: 'WRITE_ERROR',
      originalError: originalError,
      stackTrace: stackTrace,
      tableName: tableName,
    );
  }

  /// Factory for database migration errors
  factory StorageException.migrationError({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return StorageException(
      message: 'Database migration failed',
      code: 'MIGRATION_ERROR',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Factory for encryption-related storage errors
  factory StorageException.encryptionError({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return StorageException(
      message: message,
      code: code ?? 'ENCRYPTION_ERROR',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }
}

/// Authentication and authorization exceptions
class AuthException extends AppException {
  final bool isSessionExpired;
  final bool isInvalidCredentials;

  const AuthException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.isSessionExpired = false,
    this.isInvalidCredentials = false,
  });

  /// Factory for session expiration
  factory AuthException.sessionExpired({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AuthException(
      message: 'Your session has expired. Please log in again.',
      code: 'SESSION_EXPIRED',
      originalError: originalError,
      stackTrace: stackTrace,
      isSessionExpired: true,
    );
  }

  /// Factory for invalid credentials
  factory AuthException.invalidCredentials({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AuthException(
      message: 'Invalid email or password',
      code: 'INVALID_CREDENTIALS',
      originalError: originalError,
      stackTrace: stackTrace,
      isInvalidCredentials: true,
    );
  }

  /// Factory for access denied
  factory AuthException.accessDenied({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AuthException(
      message: 'You do not have permission to perform this action',
      code: 'ACCESS_DENIED',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Factory for creating from Appwrite auth errors
  factory AuthException.fromAppwrite(appwrite.AppwriteException error) {
    final code = error.code?.toString() ?? 'UNKNOWN';
    final message = error.message?.toLowerCase() ?? '';

    // Check for specific Appwrite auth error codes
    if (code == '401' || error.type == 'user_unauthorized') {
      return AuthException.sessionExpired(originalError: error);
    }

    if (code == '400' &&
        (message.contains('invalid credential') ||
            message.contains('invalid email'))) {
      return AuthException.invalidCredentials(originalError: error);
    }

    return AuthException(
      message: error.message ?? 'Authentication failed',
      code: code,
      originalError: error,
    );
  }
}

/// Encryption and decryption exceptions
class EncryptionException extends AppException {
  final String? keyId;

  const EncryptionException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.keyId,
  });

  /// Factory for key not found
  factory EncryptionException.keyNotFound({
    String? keyId,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return EncryptionException(
      message: 'Encryption key not found',
      code: 'KEY_NOT_FOUND',
      originalError: originalError,
      stackTrace: stackTrace,
      keyId: keyId,
    );
  }

  /// Factory for encryption failure
  factory EncryptionException.encryptionFailed({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return EncryptionException(
      message: 'Failed to encrypt data',
      code: 'ENCRYPTION_FAILED',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Factory for decryption failure
  factory EncryptionException.decryptionFailed({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return EncryptionException(
      message: 'Failed to decrypt data',
      code: 'DECRYPTION_FAILED',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Factory for invalid key
  factory EncryptionException.invalidKey({
    String? keyId,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return EncryptionException(
      message: 'Invalid encryption key',
      code: 'INVALID_KEY',
      originalError: originalError,
      stackTrace: stackTrace,
      keyId: keyId,
    );
  }
}

/// Synchronization exceptions (offline sync, conflict resolution)
class SyncException extends AppException {
  final bool isConflict;
  final String? entityId;
  final int? retryCount;

  const SyncException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.isConflict = false,
    this.entityId,
    this.retryCount,
  });

  /// Factory for sync conflict
  factory SyncException.conflict({
    required String entityId,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return SyncException(
      message: 'Data conflict detected. Please resolve manually.',
      code: 'SYNC_CONFLICT',
      originalError: originalError,
      stackTrace: stackTrace,
      isConflict: true,
      entityId: entityId,
    );
  }

  /// Factory for sync failure
  factory SyncException.syncFailed({
    int? retryCount,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return SyncException(
      message: 'Failed to sync data with server',
      code: 'SYNC_FAILED',
      originalError: originalError,
      stackTrace: stackTrace,
      retryCount: retryCount,
    );
  }

  /// Factory for offline queue full
  factory SyncException.queueFull({
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return SyncException(
      message: 'Offline storage is full. Some changes may not be saved.',
      code: 'QUEUE_FULL',
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }
}

/// Unknown/unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unexpected error occurred',
    super.code = 'UNKNOWN',
    super.originalError,
    super.stackTrace,
  });
}
