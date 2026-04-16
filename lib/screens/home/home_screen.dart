import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_typography.dart';
import 'package:sfrigola/helpers/app_colors.dart';

// Project Layouts
import 'package:sfrigola/layouts/app_bars/classic_app_bar.dart';
import 'package:sfrigola/layouts/body/standard_page_layout.dart';

// Project Providers
import 'package:sfrigola/screens/home/providers/meals_provider.dart';
import 'package:sfrigola/screens/home/providers/selected_category_id_provider.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/fake_search_box.dart';
import 'package:sfrigola/screens/home/widgets/categories_group_row.dart';

// Page Sections
import 'package:sfrigola/screens/home/widgets/sections/budget_section.dart';
import 'package:sfrigola/screens/home/widgets/sections/challenge_section.dart';
import 'package:sfrigola/screens/home/widgets/sections/easy_section.dart';
import 'package:sfrigola/screens/home/widgets/sections/premium_section.dart';
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
        bottomContent: FakeSearchBox(onTap: () {}),
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
                final easy = ref.watch(easyMealsProvider);
                final challenge = ref.watch(challengeMealsProvider);
                final budget = ref.watch(budgetMealsProvider);
                final premium = ref.watch(premiumMealsProvider);

                final allProviders = [
                  trending,
                  easy,
                  challenge,
                  budget,
                  premium,
                ];
                final isAnyLoading = allProviders.any((s) => s.isLoading);
                final hasData = allProviders.any(
                  (s) => s.value?.isNotEmpty ?? false,
                );

                if (!isAnyLoading && !hasData) {
                  return Center(
                    child: Padding(
                      padding: AppDesign.paddingPage,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIconsBold.forkKnife,
                            size: 48,
                            color: AppColors.of(context).muted,
                          ),
                          const SizedBox(height: AppDesign.gapSectionSm),
                          Text(
                            'No meals found for the selected category.',
                            style: AppTypography.of(context).body,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    TrendingSection(),
                    EasySection(),
                    ChallengeSection(),
                    BudgetSection(),
                    PremiumSection(),
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
