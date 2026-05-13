import 'package:flutter/material.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_checkbox.dart';

class DietaryInfoFields {
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const DietaryInfoFields({
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.isVegan = false,
    this.isVegetarian = false,
  });

  DietaryInfoFields copyWith({
    bool? isGlutenFree,
    bool? isLactoseFree,
    bool? isVegan,
    bool? isVegetarian,
  }) {
    return DietaryInfoFields(
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
    );
  }
}

class DietaryInfo extends StatelessWidget {
  const DietaryInfo({
    super.key,
    required this.fields,
    required this.onFieldsChanged,
  });

  final DietaryInfoFields fields;
  final ValueChanged<DietaryInfoFields> onFieldsChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocale.getLabels(context);

    final entries = [
      (
        value: fields.isGlutenFree,
        label: l.mealDetailsBadgeGlutenFree,
        update: (bool v) => fields.copyWith(isGlutenFree: v),
      ),
      (
        value: fields.isLactoseFree,
        label: l.mealDetailsBadgeLactoseFree,
        update: (bool v) => fields.copyWith(isLactoseFree: v),
      ),
      (
        value: fields.isVegan,
        label: l.mealDetailsBadgeVegan,
        update: (bool v) => fields.copyWith(isVegan: v),
      ),
      (
        value: fields.isVegetarian,
        label: l.mealDetailsBadgeVegetarian,
        update: (bool v) => fields.copyWith(isVegetarian: v),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.of(context).muted),
        borderRadius: AppDesign.borderRadiusSm,
      ),
      padding: AppDesign.paddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDesign.gapItemSm,
        children: entries
            .map(
              (e) => BaseCheckbox(
                value: e.value,
                label: e.label,
                fullWidth: true,
                onChanged: (v) => onFieldsChanged(e.update(v)),
              ),
            )
            .toList(),
      ),
    );
  }
}
