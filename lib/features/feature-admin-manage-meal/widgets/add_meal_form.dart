import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
import 'package:sfrigola/core/widgets/base_dropdown.dart';
import 'package:sfrigola/core/widgets/base_form_field.dart';
import 'package:sfrigola/core/widgets/base_slider.dart';

class AddMealForm extends ConsumerStatefulWidget {
  const AddMealForm({super.key});

  @override
  ConsumerState<AddMealForm> createState() => _AddMealFormState();
}

class _AddMealFormState extends ConsumerState<AddMealForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Complexity? _complexity;
  Affordability? _affordability;
  double _durationMinutes = 30;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process form submission logic here
    }
  }

  void _cancelForm() {
    FocusScope.of(context).unfocus();
    AppRouter.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpacing = MediaQuery.of(context).padding.bottom;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppDesign.paddingLg,
                child: Column(
                  children: [
                    BaseFormField(
                      controller: titleController,
                      fillColor: AppColors.of(context).surface,
                      label: 'Meal Title',
                      prefixIcon: PhosphorIconsRegular.fileText,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppDesign.gapSectionMd),
                    BaseFormField(
                      controller: subtitleController,
                      fillColor: AppColors.of(context).surface,
                      label: 'Meal Subtitle',
                      prefixIcon: PhosphorIconsRegular.fileText,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppDesign.gapSectionMd),
                    BaseFormField(
                      controller: descriptionController,
                      fillColor: AppColors.of(context).surface,
                      label: 'Meal Description',
                      prefixIcon: PhosphorIconsRegular.fileText,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      maxLength: 500,
                    ),
                    SizedBox(height: AppDesign.gapSectionMd),
                    BaseDropdown<Complexity>(
                      initialValue: _complexity,
                      label: AppLocale.getLabels(
                        context,
                      ).favouritesFilterComplexityLabel,
                      prefixIcon: PhosphorIconsRegular.chartBar,
                      fillColor: AppColors.of(context).surface,
                      items: Complexity.values
                          .map(
                            (c) => BaseDropdownOption(
                              value: c,
                              label: c.label(context),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _complexity = v),
                    ),
                    const SizedBox(height: AppDesign.gapSectionMd),

                    // ── Affordability ────────────────────────────────────────────────
                    BaseDropdown<Affordability>(
                      initialValue: _affordability,
                      label: AppLocale.getLabels(
                        context,
                      ).favouritesFilterAffordabilityLabel,

                      prefixIcon: PhosphorIconsRegular.tag,
                      fillColor: AppColors.of(context).surface,
                      items: Affordability.values
                          .map(
                            (a) => BaseDropdownOption(
                              value: a,
                              label: a.label(context),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _affordability = v),
                    ),
                    const SizedBox(height: AppDesign.gapSectionMd),
                    BaseSlider(
                      label: 'Total time (prep + cooking)',
                      value: _durationMinutes,
                      min: 5,
                      max: 300,
                      divisions: 59,
                      valueFormatter: (v) => '${v.toInt()} min',
                      onChanged: (v) => setState(() => _durationMinutes = v),
                    ),
                    const SizedBox(height: AppDesign.gapSectionSm),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: AppDesign.paddingLg.copyWith(
              bottom: bottomSpacing + AppDesign.gapSectionMd,
            ),
            color: AppColors.of(context).bottomBar,
            child: Row(
              children: [
                Expanded(
                  child: BaseButton(
                    label: 'Save',
                    icon: PhosphorIconsRegular.check,
                    onPressed: _submitForm,
                  ),
                ),
                const SizedBox(width: AppDesign.gapInlineMd),
                Expanded(
                  child: BaseButton(
                    label: 'Cancel',
                    icon: PhosphorIconsRegular.x,
                    type: BaseButtonType.outlined,
                    onPressed: _cancelForm,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
