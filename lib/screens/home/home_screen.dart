import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/layouts/body/standard_page_layout.dart';

// Project Providers
import 'package:sfrigola/providers/meal_provider.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/general_search_box.dart';
import 'package:sfrigola/screens/home/widgets/meals_group_row.dart';
import 'package:sfrigola/screens/home/widgets/categories_group_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static void _onSearchChanged(String value) {}

  @override
  Widget build(BuildContext context) {
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
          const CategoriesGroupRow(selectedCategoryId: 'c3'),
          const SizedBox(height: AppDesign.gapSectionLg),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final trending = ref.watch(trendingMealsProvider);
                final recent = ref.watch(recentMealsProvider);
                final popular = ref.watch(popularMealsProvider);

                return ListView(
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
                        isViral: true,
                        isLoading: trending.isLoading,
                        meals: trending.value ?? [],
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
                        isLoading: recent.isLoading,
                        meals: recent.value ?? [],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        vertical: AppDesign.gapSectionLg,
                      ),
                      child: MealsGroupRow(
                        title: AppLocale.getLabels(
                          context,
                        ).homeSectionFavorites,
                        subtitle: AppLocale.getLabels(
                          context,
                        ).homeSectionFavoritesSubtitle,
                        icon: PhosphorIconsBold.heart,
                        isLoading: popular.isLoading,
                        meals: popular.value ?? [],
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
                        isLoading: popular.isLoading,
                        meals: popular.value ?? [],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
