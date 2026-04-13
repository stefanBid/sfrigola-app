import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_button.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppDesign.paddingPage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              PhosphorIconsBold.warningCircle,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: AppDesign.gapSectionSm),
            Text(
              message,
              style: AppTypography.of(context).body,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDesign.gapSectionSm),
              BaseButton(
                label: 'Retry',
                onPressed: onRetry,
                type: BaseButtonType.outlined,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
