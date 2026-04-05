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

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
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
                Icon(iconData, color: Colors.white, size: 20),
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
              ],
            ),
          ),
        ),
      );
  }
}
