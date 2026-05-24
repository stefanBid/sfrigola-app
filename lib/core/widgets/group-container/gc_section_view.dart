import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class GcSectionView extends StatelessWidget {
  const GcSectionView({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.sectionFixedHeight,
    this.paddingHeader = EdgeInsets.zero,
    this.paddingContent = EdgeInsets.zero,
  });

  final String title;
  final Widget child;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry paddingHeader;
  final EdgeInsetsGeometry paddingContent;
  final double? sectionFixedHeight;

  @override
  Widget build(BuildContext context) {
    final double titleSectionHeight =
        22 + AppDesign.gapSectionXs + AppDesign.gapInlineXs + 20.0;

    final header = Padding(
      padding: paddingHeader,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: AppDesign.iconSizeLg,
                  color: iconColor ?? AppColors.of(context).text,
                ),
                const SizedBox(width: AppDesign.gapInlineSm),
              ],
              Text(title, style: AppTypography.of(context).heading3),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppDesign.gapItemXs),
            Text(
              subtitle!,
              style: AppTypography.of(
                context,
              ).bodySecondary.copyWith(color: AppColors.of(context).muted),
            ),
          ],
        ],
      ),
    );

    final content = Padding(padding: paddingContent, child: child);

    return sectionFixedHeight != null
        ? SizedBox(
            height: sectionFixedHeight! + titleSectionHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(height: AppDesign.gapSectionXs),
                Expanded(child: content),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: AppDesign.gapItemMd),
              content,
            ],
          );
  }
}
