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
import 'package:sfrigola/screens/home/providers/meals_provider.dart';
import 'package:sfrigola/screens/home/providers/selected_category_id_provider.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/fake_search_box.dart';
import 'package:sfrigola/screens/home/widgets/meals_group_row.dart';
import 'package:sfrigola/screens/home/widgets/categories_group_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      hasPadding: false,
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.house),
        title: AppLocale.getLabels(context).homeTitle,
        bottomContent: FakeSearchBox(
          onTap: () {
            print('Fake search box tapped');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final selectedId = ref.watch(selectedCategoryIdProvider);

              return CategoriesGroupRow(
                selectedCategoryId: selectedId,
                onCategorySelected: (id) =>
                    ref.read(selectedCategoryIdProvider.notifier).select(id),
              );
            },
          ),
          const SizedBox(height: AppDesign.gapSectionMd),
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
                        onLoadMore: () =>
                            ref.read(trendingMealsProvider.notifier).loadMore(),
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
                        onLoadMore: () =>
                            ref.read(recentMealsProvider.notifier).loadMore(),
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
                        onLoadMore: () =>
                            ref.read(popularMealsProvider.notifier).loadMore(),
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
                        onLoadMore: () =>
                            ref.read(popularMealsProvider.notifier).loadMore(),
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
