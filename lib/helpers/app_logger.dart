// * ════════════════════════════════════════════════════════════════════════════
// *  APP LOGGER
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Debug-only logger. All output is gated behind kDebugMode and is
// *  automatically stripped in release / profile builds — no manual cleanup
// *  required before shipping.
// *
// *  Usage:
// *
// *    AppLogger.debug('User loaded', tag: 'HomeScreen');
// *    AppLogger.warn('Token is about to expire');
// *    AppLogger.error('Failed to fetch data', error: e, stackTrace: st);
// *
// *  Output format:
// *    [D] HomeScreen | User loaded
// *    [W] Token is about to expire
// *    [E] Failed to fetch data
// *        Error   : Exception: 404
// *        Stack   : #0 ...
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/foundation.dart';

class AppLogger {
  const AppLogger._();

  // ─── Public API ────────────────────────────────────────────────────────────

  /// General debug information. Stripped in release builds.
  static void debug(String message, {String? tag}) {
    _log('D', message, tag: tag);
  }

  /// Non-critical warning. Stripped in release builds.
  static void warn(String message, {String? tag}) {
    _log('W', message, tag: tag);
  }

  /// Error with optional exception and stack trace. Stripped in release builds.
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    final prefix = _buildPrefix('E', tag);
    debugPrint('$prefix $message');
    if (error != null) debugPrint('    Error   : $error');
    if (stackTrace != null) debugPrint('    Stack   : $stackTrace');
  }

  // ─── Internal ──────────────────────────────────────────────────────────────

  static void _log(String level, String message, {String? tag}) {
    if (!kDebugMode) return;
    debugPrint('${_buildPrefix(level, tag)} $message');
  }

  static String _buildPrefix(String level, String? tag) {
    return tag != null ? '[$level] $tag |' : '[$level]';
  }
}
