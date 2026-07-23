import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_icon_button.dart';
import 'package:sfrigola/core/widgets/base_input.dart';

/// An inline editable list of strings with an add-field and per-item delete.
///
/// - [items]: current list of strings (owned by the caller).
/// - [onChanged]: called with the updated list on every add or remove.
/// - [hint]: placeholder text for the add input field.
/// - [numbered]: when true, items are prefixed with "1.", "2." etc.
///   When false, a bullet "•" is shown instead.
/// - [validator]: optional FormField validator; receives the current list.
class EditableListField extends StatefulWidget {
  const EditableListField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.numbered = false,
    this.multiline = false,
    this.validator,
  });

  final List<String> items;
  final ValueChanged<List<String>> onChanged;
  final String hint;
  final bool numbered;
  final bool multiline;
  final String? Function(List<String>?)? validator;

  @override
  State<EditableListField> createState() => _EditableListFieldState();
}

class _EditableListFieldState extends State<EditableListField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _formFieldKey = GlobalKey<FormFieldState<List<String>>>();

  @override
  void didUpdateWidget(covariant EditableListField oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _formFieldKey.currentState?.didChange(widget.items);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onChanged([...widget.items, text]);
    _controller.clear();
    _focusNode.requestFocus();
  }

  void _removeItem(int index) {
    final updated = List<String>.from(widget.items)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      key: _formFieldKey,
      initialValue: widget.items,
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.items.isNotEmpty) ...[
              ...widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDesign.gapInlineMd),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 24,
                        child: Text(
                          widget.numbered ? '${index + 1}.' : '•',
                          style: AppTypography.of(context).body.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDesign.gapInlineSm),
                      Expanded(
                        child: Text(
                          item,
                          style: AppTypography.of(context).body,
                        ),
                      ),
                      const SizedBox(width: AppDesign.gapInlineSm),
                      BaseIconButton(
                        icon: LucideIcons.trash2,
                        onPressed: () => _removeItem(index),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: AppDesign.gapItemXs),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BaseInput(
                    controller: _controller,
                    focusNode: _focusNode,
                    hint: widget.hint,
                    fillColor: AppColors.of(context).surface,
                    maxLines: widget.multiline ? null : 1,
                  ),
                ),
                const SizedBox(width: AppDesign.gapInlineMd),
                BaseIconButton(
                  icon: LucideIcons.plus,
                  onPressed: _addItem,
                ),
              ],
            ),
            if (field.hasError) ...[
              const SizedBox(height: AppDesign.gapInlineXs),
              Text(
                field.errorText!,
                style: AppTypography.of(
                  context,
                ).caption.copyWith(color: AppColors.error),
              ),
            ],
          ],
        );
      },
    );
  }
}

