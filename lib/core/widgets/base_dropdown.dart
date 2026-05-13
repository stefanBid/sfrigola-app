import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

class BaseDropdownOption<T> {
  final T value;
  final String label;

  const BaseDropdownOption({required this.value, required this.label});
}

/// Styled single-select [DropdownButtonFormField] for use inside a [Form].
/// For multi-select, use [BaseMultiSelect].
class BaseDropdown<T> extends StatelessWidget {
  final T? initialValue;
  final String? label;
  final String? voidSelectionItemLabel;
  final List<BaseDropdownOption<T>> items;
  final ValueChanged<T?>? onChanged;
  final Color? fillColor;
  final IconData? prefixIcon;
  final String? hint;
  final AutovalidateMode autovalidateMode;
  final String? Function(T?)? validator;
  final bool disabled;
  final bool isLoading;

  const BaseDropdown({
    super.key,
    required this.initialValue,
    required this.items,
    this.label,
    this.voidSelectionItemLabel,
    this.onChanged,
    this.fillColor,
    this.prefixIcon,
    this.hint,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.validator,
    this.disabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.of(context).bodyMedium),
          const SizedBox(height: AppDesign.gapInlineSm),
        ],
        DropdownButtonFormField<T?>(
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          validator: validator,
          style: AppTypography.of(context).body.copyWith(
            color: (disabled || isLoading) ? colors.muted : colors.text,
          ),
          hint: hint != null
              ? Text(
                  hint!,
                  style: AppTypography.of(context)
                      .body
                      .copyWith(color: colors.muted),
                )
              : null,
          dropdownColor: colors.surface,
          icon: isLoading
              ? SizedBox(
                  width: AppDesign.iconSizeMd,
                  height: AppDesign.iconSizeMd,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.muted,
                  ),
                )
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? colors.background,
            contentPadding: AppDesign.paddingSymmetricLg,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: colors.muted,
                    size: AppDesign.iconSizeMd,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: AppDesign.borderRadiusXs,
              borderSide: BorderSide(color: colors.surface, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppDesign.borderRadiusXs,
              borderSide: BorderSide(color: colors.surface, width: 1.5),
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
            disabledBorder: OutlineInputBorder(
              borderRadius: AppDesign.borderRadiusXs,
              borderSide: BorderSide(
                color: colors.muted.withAlpha(80),
                width: 1.5,
              ),
            ),
          ),
          items: [
            if (voidSelectionItemLabel != null)
              DropdownMenuItem<T?>(
                value: null,
                child: Text(
                  voidSelectionItemLabel!,
                  style: AppTypography.of(context).body,
                ),
              ),
            ...items.map(
              (e) => DropdownMenuItem<T?>(
                value: e.value,
                child: Text(e.label, style: AppTypography.of(context).body),
              ),
            ),
          ],
          onChanged: (disabled || isLoading) ? null : onChanged,
        ),
      ],
    );
  }
}
