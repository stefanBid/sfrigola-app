import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_checkbox.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';

/// Styled multi-select field for use inside a [Form].
///
/// Renders a tappable [InputDecorator] that opens an [AlertDialog] with
/// [CheckboxListTile] items. Selected values are shown as deletable chips.
///
/// Items are passed as [List<BaseDropdownOption<T>>] — the same data class
/// shared with [BaseDropdown].
class BaseMultiSelect<T> extends StatelessWidget {
  final List<T> initialValues;
  final List<BaseDropdownOption<T>> items;
  final ValueChanged<List<T>>? onChanged;
  final String? Function(List<T>?)? validator;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Color? fillColor;
  final AutovalidateMode autovalidateMode;
  final bool disabled;
  final bool isLoading;

  const BaseMultiSelect({
    super.key,
    required this.items,
    this.initialValues = const [],
    this.onChanged,
    this.validator,
    this.label,
    this.hint,
    this.prefixIcon,
    this.fillColor,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.disabled = false,
    this.isLoading = false,
  });

  Future<List<T>?> _openDialog(BuildContext context, List<T> current) {
    final colors = AppColors.of(context);
    final l = AppLocale.getLabels(context);

    return showDialog<List<T>>(
      context: context,
      builder: (ctx) {
        List<T> temp = List<T>.from(current);
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              backgroundColor: colors.surface,
              contentPadding: AppDesign.paddingMd,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items.map((item) {
                    final isSelected = temp.contains(item.value);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDesign.gapItemXs,
                      ),
                      child: BaseCheckbox(
                        value: isSelected,
                        label: item.label,
                        fullWidth: true,
                        onChanged: (checked) {
                          setDialogState(() {
                            if (checked) {
                              temp.add(item.value);
                            } else {
                              temp.remove(item.value);
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    l.globalCancel,
                    style: AppTypography.of(
                      context,
                    ).bodyMedium.copyWith(color: colors.muted),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(temp),
                  child: Text(
                    l.globalConfirm,
                    style: AppTypography.of(
                      context,
                    ).bodyMedium.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  InputDecoration _decoration(BuildContext context, {String? errorText}) {
    final colors = AppColors.of(context);
    return InputDecoration(
      filled: true,
      fillColor: fillColor ?? colors.background,
      contentPadding: AppDesign.paddingSymmetricLg,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: colors.muted, size: AppDesign.iconSizeMd)
          : null,
      suffixIcon: isLoading
          ? SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: SizedBox(
                  width: AppDesign.iconSizeMd,
                  height: AppDesign.iconSizeMd,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.muted,
                  ),
                ),
              ),
            )
          : Icon(
              PhosphorIconsRegular.caretDown,
              size: AppDesign.iconSizeMd,
              color: AppColors.of(context).muted,
            ),
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
      disabledBorder: OutlineInputBorder(
        borderRadius: AppDesign.borderRadiusXs,
        borderSide: BorderSide(color: colors.muted.withAlpha(80), width: 1.5),
      ),
      errorText: errorText,
      errorStyle: AppTypography.of(
        context,
      ).caption.copyWith(color: AppColors.error),
      errorMaxLines: 3,
    );
  }

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
        FormField<List<T>>(
          initialValue: initialValues,
          autovalidateMode: autovalidateMode,
          validator: validator,
          builder: (state) {
            final selected = state.value ?? [];
            return InkWell(
              onTap: (disabled || isLoading)
                  ? null
                  : () async {
                      final result = await _openDialog(context, selected);
                      if (result != null) {
                        state.didChange(result);
                        onChanged?.call(result);
                      }
                    },
              borderRadius: AppDesign.borderRadiusXs,
              child: InputDecorator(
                decoration: _decoration(context, errorText: state.errorText),
                isEmpty: selected.isEmpty,
                child: selected.isEmpty
                    ? hint != null
                          ? Text(
                              hint!,
                              style: AppTypography.of(
                                context,
                              ).body.copyWith(color: colors.muted),
                            )
                          : const SizedBox.shrink()
                    : Wrap(
                        spacing: AppDesign.gapInlineXs,
                        runSpacing: AppDesign.gapInlineSm,
                        children: selected.map((v) {
                          final itemLabel = items
                              .firstWhere(
                                (i) => i.value == v,
                                orElse: () =>
                                    BaseDropdownOption(value: v, label: ''),
                              )
                              .label;
                          return Chip(
                            label: Text(
                              itemLabel,
                              style: AppTypography.of(context).caption,
                            ),
                            backgroundColor: AppColors.primary.withAlpha(30),
                            side: const BorderSide(
                              color: AppColors.primary,
                              width: 1,
                            ),
                            labelPadding: EdgeInsets.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            deleteIcon: const Icon(
                              PhosphorIconsRegular.x,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            onDeleted: disabled
                                ? null
                                : () {
                                    final updated = List<T>.from(selected)
                                      ..remove(v);
                                    state.didChange(updated);
                                    onChanged?.call(updated);
                                  },
                          );
                        }).toList(),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
