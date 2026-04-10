import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_typography.dart';

class FakeSearchBox extends StatelessWidget {
  final VoidCallback onTap;

  const FakeSearchBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppDesign.paddingSymmetricLg,
        decoration: BoxDecoration(
          color: AppColors.of(context).background,
          borderRadius: AppDesign.borderRadiusXs,
          border: Border.all(color: AppColors.of(context).surface, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              PhosphorIconsRegular.magnifyingGlass,
              size: 20,
              color: AppColors.of(context).muted,
            ),
            const SizedBox(width: AppDesign.gapInlineSm),
            Text(
              AppLocale.getLabels(context).homeSearchHint,
              style: AppTypography.of(
                context,
              ).body.copyWith(color: AppColors.of(context).muted),
            ),
          ],
        ),
      ),
    );
  }
}
