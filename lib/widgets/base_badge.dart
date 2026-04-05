import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';

enum BadgeSize { small, normal }

enum BadgeVariant { filled, outlined }

class BadgeStyle {
  final Color? color;
  final Color? foregroundColor;
  final BadgeSize size;
  final BadgeVariant variant;
  final BorderRadiusGeometry borderRadius;

  const BadgeStyle({
    this.color,
    this.foregroundColor,
    this.size = BadgeSize.small,
    this.variant = BadgeVariant.filled,
    this.borderRadius = AppDesign.borderRadiusXXs,
  });
}

class BaseBadge extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final BadgeStyle style;

  const BaseBadge({
    super.key,
    this.label,
    this.icon,
    this.style = const BadgeStyle(),
  });

  @override
  Widget build(BuildContext context) {
    final isOutlined = style.variant == BadgeVariant.outlined;
    final color = isOutlined
        ? Colors.transparent
        : style.color ?? AppColors.of(context).surface;
    final borderColor = style.color ?? AppColors.of(context).surface;
    final fgColor = style.foregroundColor ?? AppColors.of(context).text;
    final textStyle = switch (style.size) {
      BadgeSize.small => AppTypography.of(context).small,
      BadgeSize.normal => AppTypography.of(context).caption,
    };
    final iconSize = switch (style.size) {
      BadgeSize.small => 14.0,
      BadgeSize.normal => 16.0,
    };

    return Container(
      padding: AppDesign.paddingSymmetricSm,
      decoration: BoxDecoration(
        color: color,
        borderRadius: style.borderRadius,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon!, size: iconSize, color: fgColor),
          if (icon != null && label != null)
            const SizedBox(width: AppDesign.gapInlineXs),

          if (label != null)
            Text(
              label!,
              style: textStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
            ),
        ],
      ),
    );
  }
}
