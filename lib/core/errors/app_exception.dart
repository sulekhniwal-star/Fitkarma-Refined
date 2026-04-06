/// FitKarma typed exception hierarchy.
/// Every failure in the app should be mapped to one of these types
/// before reaching the UI layer.
library;

abstract class AppException implements Exception {
  const AppException({required this.message, this.cause});

  /// Developer-facing message (English).
  final String message;

  /// The original exception that caused this (if any).
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

// ─── Network ────────────────────────────────────────────────────────────────

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.cause,
    this.statusCode,
  });

  final int? statusCode;
}

class TimeoutException extends NetworkException {
  const TimeoutException({super.cause})
      : super(message: 'Request timed out');
}

class ServerException extends NetworkException {
  const ServerException({
    super.message = 'Server error',
    super.cause,
    super.statusCode,
  });
}

// ─── Auth ────────────────────────────────────────────────────────────────────

class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication failed',
    super.cause,
    this.code,
  });

  /// Appwrite error code (e.g. "user_invalid_credentials").
  final String? code;
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException({super.cause})
      : super(message: 'Session expired, please log in again', code: 'session_expired');
}

// ─── Storage / Drift ─────────────────────────────────────────────────────────

class StorageException extends AppException {
  const StorageException({
    super.message = 'Local storage error',
    super.cause,
  });
}

// ─── Encryption ──────────────────────────────────────────────────────────────

class EncryptionException extends AppException {
  const EncryptionException({
    super.message = 'Encryption or decryption failed',
    super.cause,
  });
}

class KeyDerivationException extends EncryptionException {
  const KeyDerivationException({super.cause})
      : super(message: 'Could not derive encryption key');
}

// ─── Sync ────────────────────────────────────────────────────────────────────

class SyncException extends AppException {
  const SyncException({
    super.message = 'Sync failed',
    super.cause,
    this.retryCount,
  });

  final int? retryCount;
}

class DeadLetterException extends SyncException {
  const DeadLetterException({super.cause, super.retryCount})
      : super(message: 'Item moved to dead-letter queue after max retries');
}

// ─── Validation ──────────────────────────────────────────────────────────────

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    this.field,
  });

  /// The form field that failed validation (if applicable).
  final String? field;
}

// ─── Permission ──────────────────────────────────────────────────────────────

class PermissionException extends AppException {
  const PermissionException({
    super.message = 'Permission denied',
    super.cause,
    this.permission,
  });

  final String? permission;
}

// ─── Feature-specific ────────────────────────────────────────────────────────

class FoodNotFoundException extends AppException {
  const FoodNotFoundException({super.cause})
      : super(message: 'Food item not found in database');
}

class WorkoutNotFoundException extends AppException {
  const WorkoutNotFoundException({super.cause})
      : super(message: 'Workout not found');
}