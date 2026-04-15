import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Providers
import 'package:sfrigola/screens/home/providers/meals_provider.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/skeletons/skeleton_card_row.dart';
import 'package:sfrigola/screens/home/widgets/skeletons/skeleton_header.dart';
import 'package:sfrigola/widgets/base_button.dart';
import 'package:sfrigola/widgets/base_card.dart';
import 'package:sfrigola/widgets/group-container/gc_list_view.dart';

class ChallengeSection extends ConsumerWidget {
  const ChallengeSection({super.key});

  // ─── Section shell ──────────────────────────────────────────────────────────

  static Widget _buildSection(
    BuildContext context, {
    required Widget header,
    required Widget content,
    double groupHeight = 220.0,
  }) {
    const double titleSectionHeight =
        22 + AppDesign.gapSectionXs + AppDesign.gapInlineXs + 20.0;

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
        vertical: AppDesign.gapSectionLg,
      ),
      child: SizedBox(
        height: groupHeight + titleSectionHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: AppDesign.paddingHorizontalLg, child: header),
            const SizedBox(height: AppDesign.gapSectionXs),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }

  // ─── Header ─────────────────────────────────────────────────────────────────

  static Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              PhosphorIconsBold.fire,
              size: 24,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppDesign.gapInlineXs),
            Text(
              AppLocale.getLabels(context).homeSectionChallenge,
              style: AppTypography.of(context).heading3,
            ),
          ],
        ),
        const SizedBox(height: AppDesign.gapInlineXs),
        Text(
          AppLocale.getLabels(context).homeSectionChallengeSubtitle,
          style: AppTypography.of(context).bodySecondary,
        ),
      ],
    );
  }

  // ─── List ───────────────────────────────────────────────────────────────────

  static Widget _buildList(
    BuildContext context,
    WidgetRef ref,
    List<MealPreview> items,
  ) {
    return GcListView(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final meal = items[index];
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
      },
    );
  }

  // ─── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(challengeMealsProvider);

    return meals.when(
      loading: () => _buildSection(
        context,
        header: const SkeletonHeader(),
        content: const SkeletonCardRow(),
      ),
      error: (_, __) => _buildSection(
        context,
        groupHeight: 120.0,
        header: _buildHeader(context),
        content: Center(
          child: BaseButton(
            label: 'Retry',
            icon: PhosphorIconsBold.arrowClockwise,
            type: BaseButtonType.outlined,
            onPressed: () => ref.invalidate(challengeMealsProvider),
          ),
        ),
      ),
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();
        return _buildSection(
          context,
          header: _buildHeader(context),
          content: _buildList(context, ref, items),
        );
      },
    );
  }
}
