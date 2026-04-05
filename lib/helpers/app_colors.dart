// * ════════════════════════════════════════════════════════════════════════════
// *  APP COLORS
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Adaptive colour palette. Instantiate with AppColors.of(context) to get
// *  colours that automatically switch between light and dark mode.
// *
// *  Adaptive tokens:  AppColors.of(context).background / surface / text / ...
// *  Static constants: AppColors.primary / secondary / error / success / warning
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

class AppColors {
  final bool isDark;

  AppColors._(this.isDark);

  static AppColors of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppColors._(brightness == Brightness.dark);
  }

  // Base colors (used for theming)
  static const Color primary = Color(0xFFFF6B35);
  static const Color secondary = Color(0xFFFFD166);

  // Constants for direct use (non-adaptive)
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Dark: near black / Light: pure white
  Color get background =>
      isDark ? const Color(0xFF272727) : const Color(0xFFFFFFFF);

  // Dark: elevated dark gray / Light: dirty white
  Color get surface =>
      isDark ? const Color(0xFF323232) : const Color(0xFFFAF6F5);

  // Dark: white / Light: near black
  Color get text => isDark ? const Color(0xFFFFFFFF) : const Color(0xFF1A1A1A);

  // Dark: medium gray / Light: medium gray
  Color get muted => isDark ? const Color(0xFF888888) : const Color(0xFF888888);

  Color get bottomBar =>
      isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEDE5E2);
}
