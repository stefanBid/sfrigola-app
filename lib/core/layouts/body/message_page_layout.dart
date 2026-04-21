import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sfrigola/core/helpers/app_colors.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';

enum MessagePageType { error, standard, empty }

class MessagePageLayout extends StatelessWidget {
  final IconData? icon;
  final String message;
  final MessagePageType type;
  final VoidCallback? onRetry;

  const MessagePageLayout({
    super.key,
    required this.message,
    this.icon,
    this.onRetry,
    this.type = MessagePageType.standard,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = switch (type) {
      MessagePageType.error => AppColors.error,
      MessagePageType.empty => AppColors.of(context).muted,
      MessagePageType.standard => AppColors.of(context).text,
    };
    final textStyle = switch (type) {
      MessagePageType.error => AppTypography.of(
        context,
      ).heading4.copyWith(color: AppColors.error),
      MessagePageType.empty => AppTypography.of(
        context,
      ).bodySecondary.copyWith(fontWeight: FontWeight.w600),
      MessagePageType.standard => AppTypography.of(context).heading4,
    };
    return Center(
      child: Padding(
        padding: AppDesign.paddingPage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppDesign.iconSizeXxl, color: iconColor),
              const SizedBox(height: AppDesign.gapSectionSm),
            ],
            Text(message, style: textStyle, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppDesign.gapSectionSm),
              BaseButton(
                label: AppLocale.getLabels(context).retry,
                icon: PhosphorIconsBold.arrowClockwise,
                type: BaseButtonType.ghost,
                pill: true,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
