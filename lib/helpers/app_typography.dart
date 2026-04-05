// * ════════════════════════════════════════════════════════════════════════════
// *  APP TYPOGRAPHY
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Text style scale. Instantiate with AppTypography.of(context) to get
// *  styles that inherit the adaptive text colour from AppColors.
// *
// *  Scale: heading1 (28px) › heading2 (22px) › heading3 (18px) › heading4 (16px)
// *         body (16px) › bodyMedium (14px) › caption (12px) › small (11px)
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  final AppColors colors;

  const AppTypography._(this.colors);

  static AppTypography of(BuildContext context) =>
      AppTypography._(AppColors.of(context));

  // Typography styles optimized for mobile devices following Material Design guidelines
  // Scale: 28 > 22 > 18 > 16 > 14 > 12 > 11

  /// Main screen titles (28px, bold)
  TextStyle get heading1 =>
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colors.text);

  /// Section titles (22px, bold)
  TextStyle get heading2 =>
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.text);

  /// Subsection titles (18px, semibold)
  TextStyle get heading3 =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colors.text);

  /// Card titles, list item titles (16px, semibold)
  TextStyle get heading4 =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.text);

  /// Regular body text (16px, normal)
  TextStyle get body =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: colors.text);

  /// Compact body text for inputs and dense UI (14px, normal)
  TextStyle get bodyMedium =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.text);

  /// Secondary body text (16px, normal)
  TextStyle get bodySecondary =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: colors.muted);

  /// Secondary information, labels (12px, normal)
  TextStyle get caption =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.text);

  /// Badges, tiny labels (11px, normal)
  TextStyle get small =>
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: colors.text);
}
