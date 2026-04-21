import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sfrigola/core/helpers/app_colors.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';

class ErrorPageLayout extends StatelessWidget {
  final IconData? icon;
  final String errorMessage;
  final VoidCallback? onRetry;

  const ErrorPageLayout({
    super.key,
    required this.errorMessage,
    this.icon,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppDesign.paddingPage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 64, color: AppColors.of(context).muted),
              const SizedBox(height: AppDesign.gapSectionSm),
            ],
            Text(
              errorMessage,
              style: AppTypography.of(context).body,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDesign.gapSectionSm),
              BaseButton(
                label: AppLocale.getLabels(context).retry,
                icon: PhosphorIconsBold.arrowClockwise,
                type: BaseButtonType.outlined,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
