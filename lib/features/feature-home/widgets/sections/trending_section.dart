import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/meals_provider.dart';
// Project Widgets
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_header.dart';
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_viral_card.dart';
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_viral_row.dart';
import 'package:sfrigola/core/widgets/group-container/gc_list_view.dart';
import 'package:sfrigola/features/feature-home/widgets/viral_meal_card.dart';

class TrendingSection extends ConsumerStatefulWidget {
  const TrendingSection({super.key});

  @override
  ConsumerState<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends ConsumerState<TrendingSection> {
  static const double _scrollThreshold = 300.0;

  late final ScrollController _scrollController;
  late final ProviderSubscription<AsyncValue<MealsProviderState>>
  _mealsSubscription;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _mealsSubscription = ref.listenManual<AsyncValue<MealsProviderState>>(
      trendingMealsProvider,
      (prev, current) {
        if ((prev == null || prev.isLoading) && current.hasValue && mounted) {
          setState(() => _isLoadingMore = false);
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0);
          }
        }
      },
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _mealsSubscription.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    final pos = _scrollController.position;
    if (!pos.hasContentDimensions) return;
    final maxExtent = pos.maxScrollExtent;
    if (maxExtent <= 0) return;
    final triggerAt = maxExtent - _scrollThreshold < 0
        ? maxExtent * 0.8
        : maxExtent - _scrollThreshold;
    if (pos.pixels >= triggerAt) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    final hasMore = ref.read(trendingMealsProvider).value?.hasMore ?? false;
    if (_isLoadingMore || !hasMore) return;
    setState(() => _isLoadingMore = true);
    try {
      await ref.read(trendingMealsProvider.notifier).loadMore();
      if (mounted) setState(() => _isLoadingMore = false);
    } catch (_) {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  // ─── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              PhosphorIconsBold.trendUp,
              size: AppDesign.iconSizeLg,
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
    );
  }

  // ─── Section shell ────────────────────────────────────────────────────────────

  Widget _buildSection(
    BuildContext context, {
    required Widget header,
    required Widget content,
    double groupHeight = 280.0,
  }) {
    // heading3 (18px) ≈ 22, subtitle body (16px) ≈ 20
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

  // ─── List ─────────────────────────────────────────────────────────────────────

  Widget _buildList(BuildContext context, List<MealPreview> items) {
    final itemCount = items.length + (_isLoadingMore ? 1 : 0);
    return GcListView(
      scrollController: _scrollController,
      itemBuilder: (context, index) {
        if (_isLoadingMore && index == items.length) {
          return const SkeletonViralCard();
        }
        return _buildMealCard(context, items[index], index);
      },
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
    );
  }

  Widget _buildMealCard(BuildContext context, MealPreview meal, int index) {
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
          AppRouter.mealDetails,
          params: MealDetailsParams(mealId: mealId),
        );
      },
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(trendingMealsProvider);

    if (meals.isLoading) {
      return _buildSection(
        context,
        header: const SkeletonHeader(),
        content: const SkeletonViralRow(),
      );
    }

    return switch (meals) {
      AsyncError() => const SizedBox.shrink(),
      AsyncData(:final value) when value.meals.isEmpty =>
        const SizedBox.shrink(),
      AsyncData(:final value) => _buildSection(
        context,
        header: _buildHeader(context),
        content: _buildList(context, value.meals),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
