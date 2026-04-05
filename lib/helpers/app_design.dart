// * ════════════════════════════════════════════════════════════════════════════
// *  APP DESIGN
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Spacing, border radius and padding tokens for the design system.
// *  All values are static const — use them directly without instantiation.
// *
// *  AppDesign.borderRadiusSm   →  border radius presets
// *  AppDesign.paddingPage      →  standard page content padding
// *  AppDesign.gapItemMd        →  gap between list / grid items
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

class AppDesign {
  AppDesign._();

  // Border Radius scale — independent from spacing
  static const double _radiusXXs = 6;
  static const double _radiusXs = 10;
  static const double _radiusSm = 20;
  static const double _radiusMd = 32;
  static const double _radiusLg = 48;

  // Border Radius - All
  static const BorderRadius borderRadiusXXs = BorderRadius.all(
    Radius.circular(_radiusXXs),
  );
  static const BorderRadius borderRadiusXs = BorderRadius.all(
    Radius.circular(_radiusXs),
  );
  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(_radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(_radiusMd),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(_radiusLg),
  );

  // Border Radius - Top only
  static const BorderRadius borderRadiusTopXs = BorderRadius.only(
    topLeft: Radius.circular(_radiusXs),
    topRight: Radius.circular(_radiusXs),
  );
  static const BorderRadius borderRadiusTopSm = BorderRadius.only(
    topLeft: Radius.circular(_radiusSm),
    topRight: Radius.circular(_radiusSm),
  );
  static const BorderRadius borderRadiusTopMd = BorderRadius.only(
    topLeft: Radius.circular(_radiusMd),
    topRight: Radius.circular(_radiusMd),
  );
  static const BorderRadius borderRadiusTopLg = BorderRadius.only(
    topLeft: Radius.circular(_radiusLg),
    topRight: Radius.circular(_radiusLg),
  );

  // Border Radius - Bottom only
  static const BorderRadius borderRadiusBottomSm = BorderRadius.only(
    bottomLeft: Radius.circular(_radiusSm),
    bottomRight: Radius.circular(_radiusSm),
  );
  static const BorderRadius borderRadiusBottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(_radiusMd),
    bottomRight: Radius.circular(_radiusMd),
  );

  // Spacing scale — independent from border radius
  static const double _spacingXs = 4;
  static const double _spacingSm = 8;
  static const double _spacingMd2 = 10;
  static const double _spacingMd = 16;
  static const double _spacingLg = 20;
  static const double _spacingXl = 24;

  // Padding - All sides
  static const EdgeInsets paddingXs = EdgeInsets.all(_spacingXs);
  static const EdgeInsets paddingSm = EdgeInsets.all(_spacingSm);
  static const EdgeInsets paddingMd = EdgeInsets.all(_spacingMd);
  static const EdgeInsets paddingLg = EdgeInsets.all(_spacingLg);
  static const EdgeInsets paddingXl = EdgeInsets.all(_spacingXl);

  // Padding - Symmetric (horizontal > vertical)
  static const EdgeInsets paddingSymmetricSm = EdgeInsets.symmetric(
    horizontal: _spacingSm,
    vertical: _spacingXs,
  );
  static const EdgeInsets paddingSymmetricMd = EdgeInsets.symmetric(
    horizontal: _spacingMd,
    vertical: _spacingSm,
  );
  static const EdgeInsets paddingSymmetricLg = EdgeInsets.symmetric(
    horizontal: _spacingLg,
    vertical: _spacingSm,
  );

  // Padding - Horizontal only
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(
    horizontal: _spacingSm,
  );
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(
    horizontal: _spacingMd,
  );
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(
    horizontal: _spacingLg,
  );

  // Padding - Page layout
  static const EdgeInsets paddingPage = EdgeInsets.only(
    left: _spacingLg,
    right: _spacingLg,
    top: 0,
    bottom: 0,
  );

  // ─── Gap scale ───────────────────────────────────────────────────────────────
  // Horizontal: between icon and label, between badges in a row, between inline elements
  static const double gapInlineXs = _spacingXs; // 4  — icon ↔ label
  static const double gapInlineSm =
      _spacingSm; // 8  — closely related inline elements
  static const double gapInlineMd = _spacingMd; // 16 — distinct inline elements

  // Vertical: between elements inside the same card or component
  static const double gapItemXs = _spacingXs; // 4  — title ↔ subtitle
  static const double gapItemSm = _spacingSm; // 8  — image ↔ text area
  static const double gapItemMd = _spacingMd; // 16 — distinct info groups

  // Vertical: between page sections
  static const double gapSectionXs =
      _spacingMd2; // 10  — closely related sections
  static const double gapSectionSm = _spacingMd; // 16 — related sections
  static const double gapSectionMd = _spacingLg; // 20 — distinct sections
  static const double gapSectionLg =
      _spacingXl; // 24 — widely separated sections
}
