abstract class AppException implements Exception {
  final String code;
  final String message;
  final String? details;
  final dynamic original;

  const AppException({
    required this.code,
    required this.message,
    this.details,
    this.original,
  });

  @override
  String toString() => 'AppException($code): $message';
}

class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException({
    required super.code,
    required super.message,
    super.details,
    super.original,
    this.statusCode,
  });
}

class StorageException extends AppException {
  const StorageException({
    required super.code,
    required super.message,
    super.details,
    super.original,
  });
}

class AuthException extends AppException {
  final bool isExpired;

  const AuthException({
    required super.code,
    required super.message,
    super.details,
    super.original,
    this.isExpired = false,
  });
}

class EncryptionException extends AppException {
  const EncryptionException({
    required super.code,
    required super.message,
    super.details,
    super.original,
  });
}

class SyncException extends AppException {
  final int retryCount;
  final bool isDeadLetter;

  const SyncException({
    required super.code,
    required super.message,
    super.details,
    super.original,
    this.retryCount = 0,
    this.isDeadLetter = false,
  });
}

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.code,
    required super.message,
    super.details,
    super.original,
    this.fieldErrors,
  });
}

class PermissionException extends AppException {
  const PermissionException({
    required super.code,
    required super.message,
    super.details,
    super.original,
  });
}

class RateLimitException extends AppException {
  final DateTime? retryAfter;

  const RateLimitException({
    required super.code,
    required super.message,
    super.details,
    super.original,
    this.retryAfter,
  });
}