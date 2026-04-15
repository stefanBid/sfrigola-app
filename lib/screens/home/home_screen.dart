import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

// State Views
import 'package:sfrigola/screens/home/widgets/state-view/error_view.dart';
import 'package:sfrigola/screens/home/widgets/state-view/no_data_view.dart';

// Page Sections
import 'package:sfrigola/screens/home/widgets/sections/trending_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPageLayout(
      hasPadding: false,
      appBar: ClassicAppBar(
        leading: const Icon(PhosphorIconsBold.chefHat),
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
                final easy = ref.watch(easyMealsProvider);
                final challenge = ref.watch(challengeMealsProvider);
                final budget = ref.watch(budgetMealsProvider);
                final premium = ref.watch(premiumMealsProvider);

                final providers = [easy, challenge, budget, premium];

                final isAnyLoading = providers.any((s) => s.isLoading);
                final hasErrors = providers.any((s) => s.hasError);
                final hasData = providers.any(
                  (s) => s.value != null && s.value!.isNotEmpty,
                );

                return switch ((isAnyLoading, hasErrors, hasData)) {
                  (false, true, _) => const ErrorView(
                    message: 'Failed to load meals. Please try again.',
                  ),
                  (false, false, false) => const NoDataView(
                    message: 'No meals found.',
                  ),
                  _ => ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const TrendingSection(),

                      if (easy.isLoading || (easy.value?.isNotEmpty ?? false))
                        Padding(
                          padding: const EdgeInsetsGeometry.symmetric(
                            vertical: AppDesign.gapSectionLg,
                          ),
                          child: MealsGroupRow(
                            title: AppLocale.getLabels(context).homeSectionEasy,
                            subtitle: AppLocale.getLabels(
                              context,
                            ).homeSectionEasySubtitle,
                            icon: PhosphorIconsBold.lightning,
                            isLoading: easy.isLoading,
                            meals: easy.value ?? [],
                            onLoadMore: () =>
                                ref.read(easyMealsProvider.notifier).loadMore(),
                          ),
                        ),
                      if (challenge.isLoading ||
                          (challenge.value?.isNotEmpty ?? false))
                        Padding(
                          padding: const EdgeInsetsGeometry.symmetric(
                            vertical: AppDesign.gapSectionLg,
                          ),
                          child: MealsGroupRow(
                            title: AppLocale.getLabels(
                              context,
                            ).homeSectionChallenge,
                            subtitle: AppLocale.getLabels(
                              context,
                            ).homeSectionChallengeSubtitle,
                            icon: PhosphorIconsBold.fire,
                            isLoading: challenge.isLoading,
                            meals: challenge.value ?? [],
                            onLoadMore: () => ref
                                .read(challengeMealsProvider.notifier)
                                .loadMore(),
                          ),
                        ),
                      if (budget.isLoading ||
                          (budget.value?.isNotEmpty ?? false))
                        Padding(
                          padding: const EdgeInsetsGeometry.symmetric(
                            vertical: AppDesign.gapSectionLg,
                          ),
                          child: MealsGroupRow(
                            title: AppLocale.getLabels(
                              context,
                            ).homeSectionBudget,
                            subtitle: AppLocale.getLabels(
                              context,
                            ).homeSectionBudgetSubtitle,
                            icon: PhosphorIconsBold.piggyBank,
                            isLoading: budget.isLoading,
                            meals: budget.value ?? [],
                            onLoadMore: () => ref
                                .read(budgetMealsProvider.notifier)
                                .loadMore(),
                          ),
                        ),
                      if (premium.isLoading ||
                          (premium.value?.isNotEmpty ?? false))
                        Padding(
                          padding: const EdgeInsetsGeometry.symmetric(
                            vertical: AppDesign.gapSectionLg,
                          ),
                          child: MealsGroupRow(
                            title: AppLocale.getLabels(
                              context,
                            ).homeSectionPremium,
                            subtitle: AppLocale.getLabels(
                              context,
                            ).homeSectionPremiumSubtitle,
                            icon: PhosphorIconsBold.star,
                            isLoading: premium.isLoading,
                            meals: premium.value ?? [],
                            onLoadMore: () => ref
                                .read(premiumMealsProvider.notifier)
                                .loadMore(),
                          ),
                        ),
                    ],
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
