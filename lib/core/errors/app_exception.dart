class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message ${code != null ? '($code)' : ''}';
}

class EncryptionException extends AppException {
  EncryptionException([String message = 'Decryption failed']) : super(message, 'ENCRYPTION_ERROR');
}
