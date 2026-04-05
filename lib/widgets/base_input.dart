import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';
import '../helpers/app_colors.dart';

class BaseInput extends StatelessWidget {
  final TextEditingController controller;
  final Color? fillColor;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  const BaseInput({
    super.key,
    required this.controller,
    this.hint,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTypography.of(context).body,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColors.of(context).background,
        contentPadding: AppDesign.paddingSymmetricLg,
        border: OutlineInputBorder(
          borderRadius: AppDesign.borderRadiusXs,
          borderSide: BorderSide(
            color: AppColors.of(context).surface,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDesign.borderRadiusXs,
          borderSide: BorderSide(
            color: AppColors.of(context).surface,
            width: 1.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppDesign.borderRadiusXs,
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
