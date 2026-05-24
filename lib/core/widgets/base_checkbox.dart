import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class BaseCheckbox extends StatelessWidget {
  const BaseCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.fullWidth = false,
    this.label,
  });

  final bool value;
  final bool fullWidth;
  final ValueChanged<bool> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: const BoxDecoration(
            borderRadius: AppDesign.borderRadiusXs,
            color: Colors.transparent,
          ),
          child: InkWell(
            splashColor: AppColors.of(context).text.withAlpha(60),
            highlightColor: AppColors.of(context).text.withAlpha(30),
            borderRadius: AppDesign.borderRadiusXs,
            onTap: () => onChanged(!value),
            child: Padding(
              padding: AppDesign.paddingXs,
              child: Row(
                mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  Icon(
                    value
                        ? PhosphorIconsFill.checkSquare
                        : PhosphorIconsRegular.square,
                    size: AppDesign.iconSizeLg,
                    color: value
                        ? AppColors.primary
                        : AppColors.of(context).muted,
                  ),
                  if (label != null) ...[
                    const SizedBox(width: AppDesign.gapInlineSm),
                    Text(label!, style: AppTypography.of(context).bodyMedium),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
