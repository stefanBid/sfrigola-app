import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_flutter/lucide_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/provider_state.dart';

// Project Providers
import 'package:sfrigola/features/feature-home/providers/meals_provider.dart';

// Project Widgets
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_card_row.dart';
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_header.dart';
import 'package:sfrigola/features/feature-home/widgets/skeletons/skeleton_card.dart';
import 'package:sfrigola/core/widgets/base_card.dart';
import 'package:sfrigola/core/widgets/group-container/gc_list_view.dart';
import 'package:sfrigola/core/widgets/group-container/gc_section_view.dart';

class ChallengeSection extends ConsumerStatefulWidget {
  const ChallengeSection({super.key});

  @override
  ConsumerState<ChallengeSection> createState() => _ChallengeSectionState();
}

class _ChallengeSectionState extends ConsumerState<ChallengeSection> {
  static const double _scrollThreshold = 300.0;

  late final ScrollController _scrollController;
  late final ProviderSubscription<AsyncValue<ListProviderState<MealPreview>>>
  _mealsSubscription;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _mealsSubscription = ref
        .listenManual<AsyncValue<ListProviderState<MealPreview>>>(
          challengeMealsProvider,
          (prev, current) {
            if ((prev == null || prev.isLoading) &&
                current.hasValue &&
                mounted) {
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
    final hasMore = ref.read(challengeMealsProvider).value?.hasMore ?? false;
    if (_isLoadingMore || !hasMore) return;
    setState(() => _isLoadingMore = true);
    try {
      await ref.read(challengeMealsProvider.notifier).loadMore();
      if (mounted) setState(() => _isLoadingMore = false);
    } catch (_) {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  // ─── Skeleton shell ──────────────────────────────────────────────────────────

  Widget _buildSkeletonSection(BuildContext context) {
    const double titleSectionHeight =
        22 + AppDesign.gapSectionXs + AppDesign.gapInlineXs + 20.0;
    return const Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: AppDesign.gapSectionLg),
      child: SizedBox(
        height: 220.0 + titleSectionHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppDesign.paddingHorizontalLg,
              child: SkeletonHeader(),
            ),
            SizedBox(height: AppDesign.gapSectionXs),
            Expanded(child: SkeletonCardRow()),
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
    final meals = ref.watch(challengeMealsProvider);

    if (meals.isLoading) return _buildSkeletonSection(context);

    return switch (meals) {
      AsyncError() => const SizedBox.shrink(),
      AsyncData(:final value) when value.items.isEmpty =>
        const SizedBox.shrink(),
      AsyncData(:final value) => Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: AppDesign.gapSectionLg,
        ),
        child: GcSectionView(
          title: AppLocale.getLabels(context).homeSectionChallenge,
          subtitle: AppLocale.getLabels(context).homeSectionChallengeSubtitle,
          icon: LucideIcons.flame,
          iconColor: AppColors.primary,
          paddingHeader: AppDesign.paddingHorizontalLg,
          sectionFixedHeight: 220.0,
          child: _buildList(context, value.items),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
