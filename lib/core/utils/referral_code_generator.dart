import 'dart:math';

/// Utility class for generating and validating referral codes
class ReferralCodeGenerator {
  static const String _chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  static final Random _random = Random.secure();
  static const int _codeLength = 8;

  /// Generate a unique referral code
  /// Format: 8 characters, uppercase letters and numbers (excluding ambiguous chars like 0, O, I, 1)
  static String generateCode() {
    return List.generate(
      _codeLength,
      (_) => _chars[_random.nextInt(_chars.length)],
    ).join();
  }

  /// Validate a referral code format
  static bool isValidCode(String code) {
    if (code.length != _codeLength) return false;
    final validPattern = RegExp(r'^[A-Z2-9]+$');
    return validPattern.hasMatch(code);
  }
}
