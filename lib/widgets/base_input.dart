import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';
import '../helpers/app_colors.dart';

class BaseInput extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onTap;

  const BaseInput({
    super.key,
    this.controller,
    this.hint,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
  }) : assert(
         readOnly || controller != null,
         'controller is required when readOnly is false',
       );

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: AppColors.of(context).surface,
      width: 1.5,
    );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      autofocus: autofocus,
      showCursor: readOnly ? false : null,
      onTap: onTap,
      onChanged: readOnly ? null : onChanged,
      style: AppTypography.of(context).body,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.of(
          context,
        ).body.copyWith(color: AppColors.of(context).muted),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColors.of(context).background,
        contentPadding: AppDesign.paddingSymmetricLg,
        border: OutlineInputBorder(
          borderRadius: AppDesign.borderRadiusXs,
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDesign.borderRadiusXs,
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDesign.borderRadiusXs,
          borderSide: readOnly
              ? borderSide
              : const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
