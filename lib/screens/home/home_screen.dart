import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Test Data
import 'package:sfrigola/data/dummy_data.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_logger.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/layouts/body/standard_page_layout.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/general_search_box.dart';
import 'package:sfrigola/screens/home/widgets/meals_group_row.dart';
import 'package:sfrigola/screens/home/widgets/categories_group_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static void _onSearchChanged(String value) {
    AppLogger.debug('Search query: $value', tag: 'HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    final availableMealsData = availableMeals;
    final availableCategoriesData = availableCategories;
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
          CategoriesGroupRow(
            selectedCategoryId: 'c1',
            categories: availableCategoriesData,
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
                    isViral: true,
                    meals: availableMealsData,
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
                    meals: availableMealsData,
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
                    meals: availableMealsData,
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
                    meals: availableMealsData,
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
