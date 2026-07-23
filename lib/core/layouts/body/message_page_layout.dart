import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:sfrigola/core/helpers/app_colors.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';

enum MessagePageType { standard, muted }

class MessagePageLayout extends StatelessWidget {
  final IconData? icon;
  final String message;
  final MessagePageType type;
  final VoidCallback? onRetry;
  final Widget? customButton;

  const MessagePageLayout({
    super.key,
    required this.message,
    this.icon,
    this.onRetry,
    this.type = MessagePageType.standard,
    this.customButton,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = switch (type) {
      MessagePageType.muted => AppColors.of(context).muted,
      MessagePageType.standard => AppColors.of(context).text,
    };
    final textStyle = switch (type) {
      MessagePageType.muted => AppTypography.of(
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
                icon: LucideIcons.refreshCw,
                type: BaseButtonType.ghost,
                pill: true,
                onPressed: onRetry,
              ),
            ],
            if (customButton != null) ...[
              const SizedBox(height: AppDesign.gapSectionSm),
              customButton!,
            ],
          ],
        ),
      ),
    );
  }
}

