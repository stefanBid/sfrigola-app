import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/meals_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_button.dart';
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

  Widget _buildAllErrorState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: AppDesign.paddingPage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsBold.wifiX,
              size: 48,
              color: AppColors.of(context).muted,
            ),
            const SizedBox(height: AppDesign.gapSectionSm),
            Text(
              'Unable to load meals. Please try again.',
              style: AppTypography.of(context).body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDesign.gapSectionSm),
            BaseButton(
              label: 'Retry',
              icon: PhosphorIconsBold.arrowClockwise,
              type: BaseButtonType.outlined,
              onPressed: () => _retryAll(ref),
            ),
          ],
        ),
      ),
    );
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
              'No meals found for the selected category.',
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
      if (!next.hasError || (prev?.hasError ?? false)) return;
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
            message: 'Some sections could not be loaded.',
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
    final allHaveError = allProviders.every((s) => s.hasError);
    final allEmpty =
        !isAnyLoading && allProviders.every((s) => s.value?.isEmpty ?? false);

    return switch (null) {
      _ when allHaveError => _buildAllErrorState(context, ref),
      _ when allEmpty => _buildEmptyState(context),
      _ => ListView(
        padding: EdgeInsets.zero,
        children: const [
          TrendingSection(),
          EasySection(),
          ChallengeSection(),
          BudgetSection(),
          PremiumSection(),
        ],
      ),
    };
  }
}
