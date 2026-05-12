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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.of(context).muted),
        borderRadius: AppDesign.borderRadiusSm,
      ),
      padding: AppDesign.paddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseCheckbox(
            value: fields.isGlutenFree,
            label: l.mealDetailsBadgeGlutenFree,
            onChanged: (v) => onFieldsChanged(fields.copyWith(isGlutenFree: v)),
          ),
          const SizedBox(height: AppDesign.gapItemMd),
          BaseCheckbox(
            value: fields.isLactoseFree,
            label: l.mealDetailsBadgeLactoseFree,
            onChanged: (v) =>
                onFieldsChanged(fields.copyWith(isLactoseFree: v)),
          ),
          const SizedBox(height: AppDesign.gapItemMd),
          BaseCheckbox(
            value: fields.isVegan,
            label: l.mealDetailsBadgeVegan,
            onChanged: (v) => onFieldsChanged(fields.copyWith(isVegan: v)),
          ),
          const SizedBox(height: AppDesign.gapItemMd),
          BaseCheckbox(
            value: fields.isVegetarian,
            label: l.mealDetailsBadgeVegetarian,
            onChanged: (v) => onFieldsChanged(fields.copyWith(isVegetarian: v)),
          ),
        ],
      ),
    );
  }
}
