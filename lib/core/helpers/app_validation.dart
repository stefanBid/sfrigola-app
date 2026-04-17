// * ════════════════════════════════════════════════════════════════════════════
// *  APP VALIDATION
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Static validation helpers for use inside TextFormField / BaseFormField
// *  validators. Each method returns null if the value is valid, or an error
// *  message string if it fails.
// *
// *  Chain validators with ?? to run them in order — the first failure wins:
// *
// *    validator: (v) => AppValidation.notEmpty(v) ?? AppValidation.email(v),
// *
// * ════════════════════════════════════════════════════════════════════════════

class AppValidation {
  const AppValidation._();

  /// Field must not be null or empty.
  static String? notEmpty(String? v, {String message = 'Required field'}) {
    if (v == null || v.trim().isEmpty) return message;
    return null;
  }

  /// Must be a valid email address.
  static String? email(String? v, {String message = 'Invalid email'}) {
    if (v == null || v.trim().isEmpty) return null;
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(v.trim())) return message;
    return null;
  }

  /// Minimum character length.
  static String? minLength(String? v, int min, {String? message}) {
    if (v == null || v.isEmpty) return null;
    if (v.length < min) return message ?? 'Minimum $min characters';
    return null;
  }

  /// Maximum character length.
  static String? maxLength(String? v, int max, {String? message}) {
    if (v == null || v.isEmpty) return null;
    if (v.length > max) return message ?? 'Maximum $max characters';
    return null;
  }

  /// Value must match [other] (e.g. confirm password).
  static String? match(
    String? v,
    String? other, {
    String message = 'Values do not match',
  }) {
    if (v != other) return message;
    return null;
  }

  /// Must contain only numeric characters.
  static String? numeric(
    String? v, {
    String message = 'Solo numeri consentiti',
  }) {
    if (v == null || v.isEmpty) return null;
    if (RegExp(r'[^0-9]').hasMatch(v)) return message;
    return null;
  }

  /// Must contain at least one uppercase, one lowercase and one digit.
  static String? strongPassword(
    String? v, {
    String message = 'Password must contain uppercase, lowercase and numbers',
  }) {
    if (v == null || v.isEmpty) return null;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(v);
    final hasLower = RegExp(r'[a-z]').hasMatch(v);
    final hasDigit = RegExp(r'[0-9]').hasMatch(v);
    if (!hasUpper || !hasLower || !hasDigit) return message;
    return null;
  }
}
