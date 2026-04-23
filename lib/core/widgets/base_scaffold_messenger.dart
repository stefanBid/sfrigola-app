import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import '../helpers/app_colors.dart';
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';

enum SnackBarType { success, error, warning, info }

class BaseScaffoldMessenger {
  const BaseScaffoldMessenger._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    String? retryLabel,
    VoidCallback? onRetry,
  }) {
    final colors = AppColors.of(context);

    final (bgColor, iconData) = switch (type) {
      SnackBarType.success => (
        AppColors.success,
        PhosphorIconsRegular.checkCircle,
      ),
      SnackBarType.error => (AppColors.error, PhosphorIconsRegular.xCircle),
      SnackBarType.warning => (
        AppColors.warning,
        PhosphorIconsRegular.warningCircle,
      ),
      SnackBarType.info => (
        colors.isDark ? AppColors.secondary : AppColors.primary,
        PhosphorIconsRegular.info,
      ),
    };

    final messenger = ScaffoldMessenger.of(context)..clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        content: Container(
          padding: AppDesign.paddingSymmetricMd,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: AppDesign.borderRadiusTopXs,
          ),
          child: Row(
            children: [
              Icon(iconData, color: Colors.white, size: AppDesign.iconSizeMd),
              const SizedBox(width: AppDesign.gapInlineSm),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.of(context).bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(width: AppDesign.gapInlineSm),
                TextButton(
                  onPressed: () {
                    messenger.hideCurrentSnackBar();
                    onRetry();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    retryLabel ?? 'Retry',
                    style: AppTypography.of(context).bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
