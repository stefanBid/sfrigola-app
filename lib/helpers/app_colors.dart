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
  static const Color primary = Color(0xFF60C9F8);
  static const Color secondary = Color(0xFF0A599C);

  // Constants for direct use (non-adaptive)
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Dark: near black / Light: pure white
  Color get background =>
      isDark ? const Color(0xFF0B1E30) : const Color(0xFFF5FAFE);

  // Dark: elevated dark gray / Light: dirty white
  Color get surface =>
      isDark ? const Color(0xFF163350) : const Color(0xFFDAECF8);

  // Dark: white / Light: near black
  Color get text => isDark ? const Color(0xFFE8F3FB) : const Color(0xFF0D2137);

  // Dark: medium gray / Light: medium gray
  Color get muted => isDark ? const Color(0xFF4D7A9E) : const Color(0xFF6B8DA8);

  Color get bottomBar =>
      isDark ? const Color(0xFF0E2840) : const Color(0xFFEAF4FC);
}
