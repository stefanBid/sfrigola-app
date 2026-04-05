import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

class MealsGroupRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final double groupHeight;
  final Widget child;

  const MealsGroupRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.groupHeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // heading3 (18px) rendered height ≈ 22, body (16px) ≈ 20
    final double titleSectionHeight =
        22 +
        AppDesign.gapSectionXs +
        (subtitle != null ? AppDesign.gapInlineXs + 20.0 : 0.0);
    return SizedBox(
      height: groupHeight + titleSectionHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppDesign.paddingHorizontalLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 24, color: AppColors.primary),
                      const SizedBox(width: AppDesign.gapInlineXs),
                    ],
                    Text(title, style: AppTypography.of(context).heading3),
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppDesign.gapInlineXs),
                  Text(
                    subtitle!,
                    style: AppTypography.of(context).bodySecondary,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppDesign.gapSectionXs),
          Expanded(child: child),
        ],
      ),
    );
  }
}
