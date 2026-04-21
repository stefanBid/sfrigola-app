import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/meals_provider.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/error_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';

// Page Sections
import 'package:sfrigola/features/feature-home/widgets/sections/budget_section.dart';
import 'package:sfrigola/features/feature-home/widgets/sections/challenge_section.dart';
import 'package:sfrigola/features/feature-home/widgets/sections/easy_section.dart';
import 'package:sfrigola/features/feature-home/widgets/sections/premium_section.dart';
import 'package:sfrigola/features/feature-home/widgets/sections/trending_section.dart';

class SectionsContainer extends ConsumerWidget {
  const SectionsContainer({super.key});

  void _retryAll(WidgetRef ref) {
    ref.invalidate(trendingMealsProvider);
    ref.invalidate(easyMealsProvider);
    ref.invalidate(challengeMealsProvider);
    ref.invalidate(budgetMealsProvider);
    ref.invalidate(premiumMealsProvider);
  }

  Widget _buildEmptyState(BuildContext context) {
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
              AppLocale.getLabels(context).homeEmptyCategory,
              style: AppTypography.of(context).body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(trendingMealsProvider);
    final easy = ref.watch(easyMealsProvider);
    final challenge = ref.watch(challengeMealsProvider);
    final budget = ref.watch(budgetMealsProvider);
    final premium = ref.watch(premiumMealsProvider);

    void onAnyError(AsyncValue? prev, AsyncValue next) {
      if (!next.hasError) return;
      // Suppress only if prev was a pure error state (not retry-loading with a stale error)
      if (prev != null && prev.hasError && !prev.isLoading) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final states = [
          ref.read(trendingMealsProvider),
          ref.read(easyMealsProvider),
          ref.read(challengeMealsProvider),
          ref.read(budgetMealsProvider),
          ref.read(premiumMealsProvider),
        ];
        if (!states.every((s) => s.hasError)) {
          BaseScaffoldMessenger.show(
            context,
            message: AppLocale.getLabels(context).homeErrorSomeSections,
            type: SnackBarType.warning,
          );
        }
      });
    }

    ref.listen(trendingMealsProvider, onAnyError);
    ref.listen(easyMealsProvider, onAnyError);
    ref.listen(challengeMealsProvider, onAnyError);
    ref.listen(budgetMealsProvider, onAnyError);
    ref.listen(premiumMealsProvider, onAnyError);

    final allProviders = [trending, easy, challenge, budget, premium];
    final isAnyLoading = allProviders.any((s) => s.isLoading);
    final allHaveError = !isAnyLoading && allProviders.every((s) => s.hasError);
    final nothingToShow =
        !isAnyLoading &&
        allProviders.every((s) => s.hasError || (s.value?.isEmpty ?? false));

    Future<void> onRefresh() async {
      _retryAll(ref);
      try {
        await Future.wait([
          ref.read(trendingMealsProvider.future),
          ref.read(easyMealsProvider.future),
          ref.read(challengeMealsProvider.future),
          ref.read(budgetMealsProvider.future),
          ref.read(premiumMealsProvider.future),
        ]);
      } catch (_) {}
    }

    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: onRefresh,
        child: switch (null) {
          _ when allHaveError => ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: ErrorPageLayout(
              errorMessage: AppLocale.getLabels(context).homeErrorLoadMeals,
              onRetry: () => _retryAll(ref),
            ),
          ),
          _ when nothingToShow => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: _buildEmptyState(context),
            ),
          ),
          _ => ListView(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              TrendingSection(),
              EasySection(),
              ChallengeSection(),
              BudgetSection(),
              PremiumSection(),
            ],
          ),
        },
      ),
    );
  }
}
