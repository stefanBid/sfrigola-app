import 'package:flutter/material.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/sections/viral_meal_card.dart';

import 'package:sfrigola/widgets/group-container/gc_list_view.dart';
import 'package:sfrigola/widgets/base_card.dart';

class MealsGroupRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;

  final List<MealPreview> meals;
  final bool isViral;
  final bool isLoading;

  final VoidCallback? onLoadMore;

  const MealsGroupRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.meals,
    this.isViral = false,
    this.isLoading = false,
    this.onLoadMore,
  });

  static Widget _buildViralCard(
    BuildContext context,
    MealPreview meal,
    int index,
  ) {
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
          AppRouter.mealDetails,
          params: MealDetailsParams(mealId: mealId),
        );
      },
    );
  }

  static Widget? _buildMealCard(
    BuildContext context,
    MealPreview meal,
    int index,
  ) {
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
          AppRouter.mealDetails,
          params: MealDetailsParams(mealId: meal.id),
        );
      },
    );
  }

  static Widget? _buildMealItems(
    BuildContext context,
    int index,
    List<MealPreview> list,
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
    final double groupHeight = isViral ? 280 : 220;

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
            child: isLoading
                ? _MealsSkeletonRow(isViral: isViral)
                : GcListView(
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

// ─── Skeleton ────────────────────────────────────────────────────────────────

class _MealsSkeletonRow extends StatefulWidget {
  final bool isViral;

  const _MealsSkeletonRow({required this.isViral});

  @override
  State<_MealsSkeletonRow> createState() => _MealsSkeletonRowState();
}

class _MealsSkeletonRowState extends State<_MealsSkeletonRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.3,
      end: 0.55,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget? _buildViralSkeleton(BuildContext context, int index) {
    return Padding(
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
      ),
      child: SizedBox(
        width: 320,
        height: 280,
        child: Padding(
          padding: AppDesign.paddingSm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).muted,
                    borderRadius: AppDesign.borderRadiusSm,
                  ),
                ),
              ),
              Padding(
                padding: AppDesign.paddingSm.copyWith(top: AppDesign.gapItemSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).muted,
                        borderRadius: AppDesign.borderRadiusXXs,
                      ),
                    ),
                    const SizedBox(height: AppDesign.gapItemXs),
                    Container(
                      width: 120,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).muted,
                        borderRadius: AppDesign.borderRadiusXXs,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildNormalSkeleton(BuildContext context, int index) {
    return Padding(
      padding: AppDesign.paddingHorizontalLg.copyWith(
        left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
      ),
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.of(context).surface,
          borderRadius: AppDesign.borderRadiusMd,
        ),
        padding: AppDesign.paddingSm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.of(context).muted,
                  borderRadius: AppDesign.borderRadiusSm,
                ),
              ),
            ),
            Padding(
              padding: AppDesign.paddingSm.copyWith(top: AppDesign.gapItemSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).muted,
                      borderRadius: AppDesign.borderRadiusXXs,
                    ),
                  ),
                  const SizedBox(height: AppDesign.gapItemXs),
                  Container(
                    width: 90,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).muted,
                      borderRadius: AppDesign.borderRadiusXXs,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: GcListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: widget.isViral
            ? _buildViralSkeleton
            : _buildNormalSkeleton,
      ),
    );
  }
}
