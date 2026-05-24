import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class ProfileSettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileSettingsRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDesign.borderRadiusXs,
      child: Padding(
        padding: AppDesign.paddingSymmetricMd,
        child: Row(
          children: [
            Icon(
              icon,
              size: AppDesign.iconSizeMd,
              color: AppColors.of(context).muted,
            ),
            const SizedBox(width: AppDesign.gapInlineSm),
            Expanded(child: Text(label, style: AppTypography.of(context).body)),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: AppDesign.iconSizeSm,
              color: AppColors.of(context).muted,
            ),
          ],
        ),
      ),
    );
  }
}
