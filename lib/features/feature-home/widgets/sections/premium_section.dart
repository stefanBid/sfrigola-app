import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/meals_provider.dart';

// Project Widgets
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_card_row.dart';
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_header.dart';
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_card.dart';
import 'package:sfrigola/core/widgets/base_card.dart';
import 'package:sfrigola/core/widgets/group-container/gc_list_view.dart';

class PremiumSection extends ConsumerStatefulWidget {
  const PremiumSection({super.key});

  @override
  ConsumerState<PremiumSection> createState() => _PremiumSectionState();
}

class _PremiumSectionState extends ConsumerState<PremiumSection> {
  static const int _pageSize = 10;
  static const double _scrollThreshold = 300.0;

  late final ScrollController _scrollController;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_hasMore || _isLoadingMore) return;
    final pos = _scrollController.position;
    if (!pos.hasContentDimensions) return;
    final maxExtent = pos.maxScrollExtent;
    if (maxExtent <= 0) return;
    final triggerAt =
        maxExtent - _scrollThreshold < 0
            ? maxExtent * 0.8
            : maxExtent - _scrollThreshold;
    if (pos.pixels >= triggerAt) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);
    try {
      final hasMore = await ref.read(premiumMealsProvider.notifier).loadMore();
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
          _hasMore = hasMore;
        });
      }
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
              PhosphorIconsBold.star,
              size: 24,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppDesign.gapInlineXs),
            Text(
              AppLocale.getLabels(context).homeSectionPremium,
              style: AppTypography.of(context).heading3,
            ),
          ],
        ),
        const SizedBox(height: AppDesign.gapInlineXs),
        Text(
          AppLocale.getLabels(context).homeSectionPremiumSubtitle,
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

  // ─── List ─────────────────────────────────────────────────────────────────────

  Widget _buildList(BuildContext context, List<MealPreview> items) {
    final itemCount = items.length + (_isLoadingMore ? 1 : 0);
    return GcListView(
      scrollController: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (_isLoadingMore && index == items.length) {
          return const SkeletonCard();
        }
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

  // ─── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(premiumMealsProvider);

    ref.listen<AsyncValue<List<MealPreview>>>(premiumMealsProvider, (
      prev,
      current,
    ) {
      if ((prev == null || prev.isLoading) && current.hasValue && mounted) {
        setState(() {
          _isLoadingMore = false;
          _hasMore = (current.value?.length ?? 0) >= _pageSize;
        });
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      }
    });

    if (meals.isLoading) {
      return _buildSection(
        context,
        header: const SkeletonHeader(),
        content: const SkeletonCardRow(),
      );
    }

    return switch (meals) {
      AsyncError() => const SizedBox.shrink(),
      AsyncData(:final value) when value.isEmpty => const SizedBox.shrink(),
      AsyncData(:final value) => _buildSection(
        context,
        header: _buildHeader(context),
        content: _buildList(context, value),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
