import 'package:flutter/material.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/viral_meal_card.dart';

import 'package:sfrigola/widgets/group-container/gc_list_view.dart';
import 'package:sfrigola/widgets/base_card.dart';

class MealsGroupRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final double groupHeight;

  final List<Meal> meals;
  final bool isViral;
  final bool isLoading;

  const MealsGroupRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.groupHeight,
    required this.meals,
    this.isViral = false,
    this.isLoading = false,
  });

  static Widget _buildViralCard(BuildContext context, Meal meal, int index) {
    return ViralMealCard(
      key: ValueKey(meal.id),
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
      ),
      meal: meal,
      onTap: (mealId) {
        FocusScope.of(context).unfocus();
        AppRouter.goDeep(
          context,
          AppRouter.details,
          params: DetailParams(detailId: mealId),
        );
      },
    );
  }

  static Widget? _buildMealCard(BuildContext context, Meal meal, int index) {
    // Placeholder for a non-viral meal card implementation
    return BaseCard(
      key: ValueKey(meal.id),
      title: meal.title,
      content: meal.subtitle,
      imageUrl: meal.imageUrl,
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        AppRouter.goDeep(
          context,
          AppRouter.details,
          params: DetailParams(detailId: meal.id),
        );
      },
    );
  }

  static Widget? _buildMealItems(
    BuildContext context,
    int index,
    List<Meal> list,
    bool isViralGroup,
  ) {
    if (index < 0 || index >= list.length) return null;

    final meal = list[index];
    return isViralGroup
        ? _buildViralCard(context, meal, index)
        : _buildMealCard(context, meal, index);
  }

  @override
  Widget build(BuildContext context) {
    // heading3 (18px) rendered height ≈ 22, body (16px) ≈ 20
    final double titleSectionHeight =
        22 +
        AppDesign.gapSectionXs +
        (subtitle != null ? AppDesign.gapInlineXs + 20.0 : 0.0);
    return SizedBox(
      height: groupHeight + titleSectionHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppDesign.paddingHorizontalLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 24, color: AppColors.primary),
                      const SizedBox(width: AppDesign.gapInlineXs),
                    ],
                    Text(title, style: AppTypography.of(context).heading3),
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppDesign.gapInlineXs),
                  Text(
                    subtitle!,
                    style: AppTypography.of(context).bodySecondary,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppDesign.gapSectionXs),
          Expanded(
            child: GcListView(
              itemBuilder: (context, index) =>
                  _buildMealItems(context, index, meals, isViral),
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
            ),
          ),
        ],
      ),
    );
  }
}
