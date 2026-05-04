import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

enum IconButtonType { filled, outlined }

class BaseIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final IconButtonType type;
  final Color? color;
  final int? badgeCount;

  const BaseIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.type = IconButtonType.filled,
    this.color,
    this.badgeCount,
  });

  // Colors.white.withAlpha(80)
  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent, // oppure surface per filled
      borderRadius: AppDesign.borderRadiusXs,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppDesign.borderRadiusXs,
        splashColor: AppColors.of(context).text.withAlpha(60),
        highlightColor: AppColors.of(context).text.withAlpha(30),
        child: Container(
          padding: AppDesign.paddingSm,
          decoration: BoxDecoration(
            color: type == IconButtonType.outlined
                ? color?.withAlpha(80) ??
                      AppColors.of(context).text.withAlpha(80)
                : color ?? AppColors.of(context).surface,
            borderRadius: AppDesign.borderRadiusXs,
            border: type == IconButtonType.outlined
                ? Border.all(
                    color: type == IconButtonType.outlined
                        ? color ?? AppColors.of(context).text
                        : color ?? AppColors.of(context).surface,
                    width: 1,
                  )
                : null,
          ),
          child: _buildIconWithBadge(context),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }

  Widget _buildIconWithBadge(BuildContext context) {
    final iconWidget = Icon(
      icon,
      size: AppDesign.iconSizeLg,
      color: color ?? AppColors.of(context).text,
    );

    if (badgeCount == null || badgeCount! <= 0) return iconWidget;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        Positioned(
          right: -AppDesign.gapItemXs,
          top: -AppDesign.gapItemXs,
          child: Container(
            padding: AppDesign.paddingXs,
            decoration: const BoxDecoration(
              color: AppColors.error,
              borderRadius: AppDesign.borderRadiusLg,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Text(
              '$badgeCount',
              style: AppTypography.of(context).small.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
