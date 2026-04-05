import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';

class BaseValueCard extends StatelessWidget {
  final String value;
  final String label;

  const BaseValueCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDesign.paddingSymmetricMd,
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: AppDesign.borderRadiusXs,
      ),
      child: Column(
        children: [
          Text(value, style: AppTypography.of(context).heading3),
          const SizedBox(height: AppDesign.gapItemXs),
          Text(
            label,
            style: AppTypography.of(
              context,
            ).caption.copyWith(color: AppColors.of(context).muted),
          ),
        ],
      ),
    );
  }
}
