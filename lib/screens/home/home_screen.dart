import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Test Data
import 'package:sfrigola/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_logger.dart';
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/general_search_box.dart';
import 'package:sfrigola/screens/home/widgets/meals_group_row.dart';
import 'package:sfrigola/screens/home/widgets/viral_meal_card.dart';

import 'package:sfrigola/widgets/base_card.dart';
import 'package:sfrigola/widgets/group-container/gc_list_view.dart';

class TestItmes {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  TestItmes({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Widget? _buildViralMealsItems(
    BuildContext context,
    int index,
    List<Meal> list,
  ) {
    if (index < 0 || index >= list.length) return null;

    final meal = list[index];
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

  static Widget? _buildMealsItems(
    BuildContext context,
    int index,
    List<Meal> list,
  ) {
    if (index < 0 || index >= list.length) return null;

    final meal = list[index];
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

  static void _onSearchChanged(String value) {
    AppLogger.debug('Search query: $value', tag: 'HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    final availableMealsData = availableMeals;
    return StandardPageLayout(
      hasPadding: false,
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.house),
        title: AppLocale.getLabels(context).homeTitle,
        bottomContent: const GeneralSearchBox(onChanged: _onSearchChanged),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDesign.paddingHorizontalLg,
            child: Text(
              AppLocale.getLabels(context).homeSubtitle,
              style: AppTypography.of(context).body,
            ),
          ),
          const SizedBox(height: AppDesign.gapSectionLg),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionTrending,
                    subtitle: AppLocale.getLabels(
                      context,
                    ).homeSectionTrendingSubtitle,
                    icon: PhosphorIconsBold.trendUp,
                    groupHeight: 280,
                    child: GcListView(
                      itemBuilder: (context, index) => _buildViralMealsItems(
                        context,
                        index,
                        availableMealsData,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: availableMealsData.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionRecent,
                    subtitle: AppLocale.getLabels(
                      context,
                    ).homeSectionRecentSubtitle,
                    icon: PhosphorIconsBold.star,
                    groupHeight: 220,
                    child: GcListView(
                      itemBuilder: (context, index) =>
                          _buildMealsItems(context, index, availableMealsData),
                      scrollDirection: Axis.horizontal,
                      itemCount: availableMealsData.length,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionFavorites,
                    subtitle: AppLocale.getLabels(
                      context,
                    ).homeSectionFavoritesSubtitle,
                    icon: PhosphorIconsBold.heart,
                    groupHeight: 220,
                    child: GcListView(
                      itemBuilder: (context, index) =>
                          _buildMealsItems(context, index, availableMealsData),
                      scrollDirection: Axis.horizontal,
                      itemCount: availableMealsData.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    vertical: AppDesign.gapSectionLg,
                  ),
                  child: MealsGroupRow(
                    title: AppLocale.getLabels(context).homeSectionPopular,
                    subtitle: AppLocale.getLabels(
                      context,
                    ).homeSectionPopularSubtitle,
                    icon: PhosphorIconsBold.fire,
                    groupHeight: 220,
                    child: GcListView(
                      itemBuilder: (context, index) =>
                          _buildMealsItems(context, index, availableMealsData),
                      scrollDirection: Axis.horizontal,
                      itemCount: availableMealsData.length,
                    ),
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
