import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_colors.dart';
import 'package:sfrigola/helpers/app_design.dart';
import 'package:sfrigola/helpers/app_router.dart';
import 'package:sfrigola/helpers/app_typography.dart';
import 'package:sfrigola/helpers/app_locale.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Providers
import 'package:sfrigola/screens/home/providers/meals_provider.dart';
import 'package:sfrigola/screens/home/providers/selected_category_id_provider.dart';

// Project Widgets
import 'package:sfrigola/screens/home/widgets/sections/viral_meal_card.dart';

class TrendingSection extends ConsumerStatefulWidget {
  const TrendingSection({super.key});

  @override
  ConsumerState<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends ConsumerState<TrendingSection> {
  static const int _pageSize = 10;

  late final PagingController<int, MealPreview> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, MealPreview>(
      getNextPageKey: (state) => (state.pages?.last.length ?? 0) < _pageSize
          ? null
          : state.nextIntPageKey,
      fetchPage: _fetchPage,
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<MealPreview>> _fetchPage(int pageKey) {
    return ref.read(trendingMealsProvider.notifier).fetchPage(pageKey);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedCategoryIdProvider, (_, __) {
      _pagingController.refresh();
    });

    // heading3 (18px) ≈ 22, subtitle body (16px) ≈ 20
    const double titleSectionHeight =
        22 + AppDesign.gapSectionXs + AppDesign.gapInlineXs + 20.0;
    const double groupHeight = 280;

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
        vertical: AppDesign.gapSectionLg,
      ),
      child: SizedBox(
        height: groupHeight + titleSectionHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppDesign.paddingHorizontalLg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        PhosphorIconsBold.trendUp,
                        size: 24,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppDesign.gapInlineXs),
                      Text(
                        AppLocale.getLabels(context).homeSectionTrending,
                        style: AppTypography.of(context).heading3,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesign.gapInlineXs),
                  Text(
                    AppLocale.getLabels(context).homeSectionTrendingSubtitle,
                    style: AppTypography.of(context).bodySecondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDesign.gapSectionXs),
            Expanded(
              child: PagingListener(
                controller: _pagingController,
                builder: (context, state, fetchNextPage) =>
                    PagedListView<int, MealPreview>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      scrollDirection: Axis.horizontal,
                      builderDelegate: PagedChildBuilderDelegate<MealPreview>(
                        itemBuilder: (context, meal, index) => ViralMealCard(
                          key: ValueKey(meal.id),
                          padding: AppDesign.paddingHorizontalLg.copyWith(
                            left: index == 0
                                ? AppDesign.paddingHorizontalLg.left
                                : 0,
                          ),
                          meal: meal,
                          onTap: (mealId) {
                            FocusScope.of(context).unfocus();
                            AppRouter.goDeep(
                              context,
                              AppRouter.mealDetails,
                              params: MealDetailsParams(mealId: mealId),
                            );
                          },
                        ),
                        firstPageProgressIndicatorBuilder: (_) =>
                            const _TrendingSkeletonRow(),
                        newPageProgressIndicatorBuilder: (_) => const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDesign.gapItemMd,
                          ),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Skeleton ────────────────────────────────────────────────────────────────

class _TrendingSkeletonRow extends StatefulWidget {
  const _TrendingSkeletonRow();

  @override
  State<_TrendingSkeletonRow> createState() => _TrendingSkeletonRowState();
}

class _TrendingSkeletonRowState extends State<_TrendingSkeletonRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacity = Tween<double>(
      begin: 0.3,
      end: 0.55,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: AppDesign.paddingHorizontalLg.copyWith(
            left: index == 0 ? AppDesign.paddingHorizontalLg.left : 0,
          ),
          child: SizedBox(
            width: 320,
            height: 280,
            child: Padding(
              padding: AppDesign.paddingSm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).muted,
                        borderRadius: AppDesign.borderRadiusSm,
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppDesign.paddingSm.copyWith(
                      top: AppDesign.gapItemSm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 180,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.of(context).muted,
                            borderRadius: AppDesign.borderRadiusXXs,
                          ),
                        ),
                        const SizedBox(height: AppDesign.gapItemXs),
                        Container(
                          width: 120,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.of(context).muted,
                            borderRadius: AppDesign.borderRadiusXXs,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
