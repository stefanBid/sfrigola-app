import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_design.dart';

enum IconButtonType { filled, outlined }

class BaseIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final IconButtonType type;
  final Color? color;

  const BaseIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.type = IconButtonType.filled,
    this.color,
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
          child: Icon(
            icon,
            size: 24,
            color: color ?? AppColors.of(context).text,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
