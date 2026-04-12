import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project Providers
import 'package:sfrigola/screens/meal-details/providers/meal_by_id_provider.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/transparent_app_bar.dart';
import 'package:sfrigola/layouts/body/hero_page_layout.dart';

// Project Widgets
import 'package:sfrigola/widgets/base_badge.dart';
import 'package:sfrigola/widgets/base_icon_button.dart';

// Screen Widgets
import 'package:sfrigola/screens/meal-details/widgets/meal_details_skeleton.dart';
import 'package:sfrigola/screens/meal-details/widgets/meal_details_error.dart';

class MealDetailsScreen extends ConsumerWidget {
  final String mealId;

  const MealDetailsScreen({super.key, required this.mealId});

  Widget _buildStateLayout(BuildContext context, Widget child) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // — Top muted area
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.35,
          child: ColoredBox(color: AppColors.of(context).muted),
        ),

        // — Slide-up content container
        Positioned(
          top: screenHeight * 0.35 - 48,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: AppDesign.borderRadiusTopLg,
              color: AppColors.of(context).background,
            ),
            child: child,
          ),
        ),

        // — Transparent app bar with back button
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TransparentAppBar(
            leading: BaseIconButton(
              color: Colors.white,
              type: IconButtonType.outlined,
              icon: PhosphorIconsRegular.arrowBendUpLeft,
              onPressed: () => AppRouter.goBack(context),
              tooltip: 'Back',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(mealByIdProvider(mealId));

    return switch (mealAsync) {
      AsyncLoading() => _buildStateLayout(context, const MealDetailsSkeleton()),
      AsyncError() => _buildStateLayout(context, const MealDetailsError()),
      AsyncData(:final value) => HeroPageLayout(
        imageUrl: value.imageUrl,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Title & subtitle & rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.title,
                        style: AppTypography.of(context).heading1,
                      ),
                      const SizedBox(height: AppDesign.gapItemXs),
                      Text(
                        value.subtitle,
                        style: AppTypography.of(context).bodySecondary.copyWith(
                          color: AppColors.of(context).muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDesign.gapInlineSm),
                BaseBadge(
                  style: const BadgeStyle(
                    color: AppColors.secondary,
                    foregroundColor: Colors.black,
                    borderRadius: AppDesign.borderRadiusSm,
                  ),
                  label: value.rate.toStringAsFixed(1),
                  icon: PhosphorIconsRegular.star,
                ),
              ],
            ),
            const SizedBox(height: AppDesign.gapSectionSm),

            // — Stats badges
            Wrap(
              spacing: AppDesign.gapInlineSm,
              runSpacing: AppDesign.gapInlineSm,
              children: [
                BaseBadge(
                  label: '${value.duration} min',
                  icon: PhosphorIconsRegular.clock,
                  style: BadgeStyle(
                    color: const Color(0xFFB3E5FC),
                    foregroundColor: const Color(0xFF0277BD),
                  ),
                ),
                BaseBadge(
                  label: value.complexity.label(context),
                  icon: PhosphorIconsRegular.chefHat,
                  style: BadgeStyle(
                    color: value.complexity.badgeColors.color,
                    foregroundColor: value.complexity.badgeColors.foreground,
                  ),
                ),
                BaseBadge(
                  label: value.affordability.label(context),
                  icon: PhosphorIconsRegular.wallet,
                  style: BadgeStyle(
                    color: value.affordability.badgeColors.color,
                    foregroundColor: value.affordability.badgeColors.foreground,
                  ),
                ),
                if (value.isGlutenFree)
                  BaseBadge(
                    label: AppLocale.getLabels(
                      context,
                    ).mealDetailsBadgeGlutenFree,
                    icon: PhosphorIconsRegular.grains,
                    style: const BadgeStyle(
                      color: Color(0xFFFFF3CD),
                      foregroundColor: Color(0xFF856404),
                    ),
                  ),
                if (value.isLactoseFree)
                  BaseBadge(
                    label: AppLocale.getLabels(
                      context,
                    ).mealDetailsBadgeLactoseFree,
                    icon: PhosphorIconsRegular.drop,
                    style: const BadgeStyle(
                      color: Color(0xFFD1ECF1),
                      foregroundColor: Color(0xFF0C5460),
                    ),
                  ),
                if (value.isVegan)
                  BaseBadge(
                    label: AppLocale.getLabels(context).mealDetailsBadgeVegan,
                    icon: PhosphorIconsRegular.leaf,
                    style: BadgeStyle(
                      color: AppColors.success.withAlpha(45),
                      foregroundColor: const Color(0xFF065F46),
                    ),
                  ),
                if (value.isVegetarian)
                  BaseBadge(
                    label: AppLocale.getLabels(
                      context,
                    ).mealDetailsBadgeVegetarian,
                    icon: PhosphorIconsRegular.plant,
                    style: const BadgeStyle(
                      color: Color(0xFFD4EDDA),
                      foregroundColor: Color(0xFF155724),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppDesign.gapSectionMd),

            // — Description
            Text(
              AppLocale.getLabels(context).mealDetailsSectionDescription,
              style: AppTypography.of(context).heading3,
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            Text(value.description, style: AppTypography.of(context).body),
            const SizedBox(height: AppDesign.gapSectionMd),

            // — Ingredients
            Text(
              AppLocale.getLabels(context).mealDetailsSectionIngredients,
              style: AppTypography.of(context).heading3,
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            for (final ingredient in value.ingredients) ...[
              Text('• $ingredient', style: AppTypography.of(context).body),
              const SizedBox(height: AppDesign.gapItemXs),
            ],
            const SizedBox(height: AppDesign.gapSectionMd),

            // — Steps
            Text(
              AppLocale.getLabels(context).mealDetailsSectionSteps,
              style: AppTypography.of(context).heading3,
            ),
            const SizedBox(height: AppDesign.gapItemSm),
            for (int i = 0; i < value.steps.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseBadge(
                    label: '${i + 1}',
                    style: BadgeStyle(
                      color: AppColors.of(context).surface,
                      foregroundColor: AppColors.of(context).muted,
                    ),
                  ),
                  const SizedBox(width: AppDesign.gapInlineSm),
                  Expanded(
                    child: Text(
                      value.steps[i],
                      style: AppTypography.of(context).body,
                    ),
                  ),
                ],
              ),
              if (i < value.steps.length - 1)
                const SizedBox(height: AppDesign.gapItemSm),
            ],
          ],
        ),
      ),
    };
  }
}
