import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';

class BoxSettings {
  final Color? color;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  const BoxSettings({
    this.color,
    this.borderRadius = AppDesign.borderRadiusXs,
    this.padding = AppDesign.paddingSm,
  });
}

class BaseBox extends StatelessWidget {
  final Widget child;
  final BoxSettings settings;
  final VoidCallback? onTap;

  const BaseBox({
    super.key,
    required this.child,
    this.settings = const BoxSettings(),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: settings.borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: settings.borderRadius,
        splashColor: AppColors.of(context).text.withAlpha(60),
        highlightColor: AppColors.of(context).text.withAlpha(30),
        child: Ink(
          padding: settings.padding,
          decoration: BoxDecoration(
            borderRadius: settings.borderRadius,
            color: settings.color ?? AppColors.of(context).surface,
          ),
          child: child,
        ),
      ),
    );
  }
}
