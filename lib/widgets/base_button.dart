import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';

enum BaseButtonType { filled, outlined }

class BaseButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final BaseButtonType type;
  final bool fullWidth;
  final bool isLoading;

  const BaseButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.tooltip,
    this.type = BaseButtonType.filled,
    this.fullWidth = false,
    this.isLoading = false,
  }) : assert(label != null || icon != null);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final accentColor = colors.isDark ? AppColors.secondary : AppColors.primary;
    final contentColor = AppTypography.of(context).body.color ?? colors.text;

    final fillColor = type == BaseButtonType.filled
        ? accentColor
        : accentColor.withAlpha(20);

    final resolvedContentColor = type == BaseButtonType.outlined
        ? accentColor
        : contentColor;

    Widget content = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(resolvedContentColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(icon, size: 20, color: resolvedContentColor),
              if (icon != null && label != null)
                const SizedBox(width: AppDesign.gapInlineSm),
              if (label != null)
                Text(
                  label!,
                  style: AppTypography.of(context).body.copyWith(
                    color: resolvedContentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          );

    if (fullWidth) {
      content = Center(child: content);
    }

    final button = Opacity(
      opacity: onPressed == null && !isLoading ? 0.5 : 1.0,
      child: Material(
        color: Colors.transparent,
        borderRadius: AppDesign.borderRadiusXs,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: AppDesign.borderRadiusXs,
          splashColor: colors.text.withAlpha(60),
          highlightColor: colors.text.withAlpha(30),
          child: Ink(
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: AppDesign.borderRadiusXs,
              border: Border.all(color: accentColor, width: 1.5),
            ),
            padding: AppDesign.paddingSymmetricLg,
            child: content,
          ),
        ),
      ),
    );

    final sized = SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 48,
      child: button,
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: sized);
    }
    return sized;
  }
}
