import 'package:flutter/material.dart';

// Project Helpers
import '../helpers/app_design.dart';
import '../helpers/app_typography.dart';
import '../helpers/app_colors.dart';

class BaseFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const BaseFormField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.of(context).caption),
          const SizedBox(height: AppDesign.gapInlineSm),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          focusNode: focusNode,
          autovalidateMode: autovalidateMode,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          style: AppTypography.of(context).body,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.of(
              context,
            ).body.copyWith(color: AppColors.of(context).muted),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.of(context).muted, size: 20)
                : null,
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
            errorBorder: const OutlineInputBorder(
              borderRadius: AppDesign.borderRadiusXs,
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: AppDesign.borderRadiusXs,
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            errorStyle: AppTypography.of(
              context,
            ).caption.copyWith(color: AppColors.error),
            errorMaxLines: 3,
          ),
        ),
      ],
    );
  }
}
