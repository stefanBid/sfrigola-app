import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class MealDetailsError extends StatelessWidget {
  const MealDetailsError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            PhosphorIconsRegular.warningCircle,
            size: 48,
            color: AppColors.error,
          ),
          const SizedBox(height: AppDesign.gapItemSm),
          Text(
            'Failed to load meal details.',
            style: AppTypography.of(
              context,
            ).body.copyWith(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
