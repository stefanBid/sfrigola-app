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
    this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              value
                  ? PhosphorIconsBold.checkSquare
                  : PhosphorIconsRegular.square,
              size: AppDesign.iconSizeLg,
              color: value ? AppColors.primary : AppColors.of(context).muted,
            ),
            if (label != null) ...[
              const SizedBox(width: AppDesign.gapInlineSm),
              Text(label!, style: AppTypography.of(context).bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
