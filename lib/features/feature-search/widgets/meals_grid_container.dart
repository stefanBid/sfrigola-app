import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_colors.dart';
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_router.dart';
import 'package:sfrigola/core/helpers/app_typography.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/features/feature-search/providers/all_meals_provider.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/group-container/gc_grid_view.dart';

// Screen Widgets
import 'package:sfrigola/features/feature-search/widgets/general_meal_card.dart';

class MealsGridContainer extends ConsumerStatefulWidget {
  const MealsGridContainer({super.key});

  @override
  ConsumerState<MealsGridContainer> createState() => _MealsGridContainerState();
}

class _MealsGridContainerState extends ConsumerState<MealsGridContainer> {
  static const double _scrollThreshold = 200.0;

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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _scrollThreshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);

    try {
      final hasMore = await ref.read(allMealsProvider.notifier).loadMore();

      if (mounted) {
        setState(() {
          _hasMore = hasMore;
          _isLoadingMore = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allMeals = ref.watch(allMealsProvider);

    return Column(
      children: [
        Expanded(
          child: switch (allMeals) {
            AsyncLoading() => const Center(child: CircularProgressIndicator()),
            AsyncError() => Center(
              child: Text(
                'Failed to load meals.',
                style: AppTypography.of(
                  context,
                ).body.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            ),
            AsyncData(:final value) when value.isEmpty => Center(
              child: Text(
                'No meals found.',
                style: AppTypography.of(
                  context,
                ).body.copyWith(color: AppColors.of(context).muted),
              ),
            ),
            AsyncData(:final value) => GcGridView(
              itemCount: value.length,
              scrollController: _scrollController,
              itemBuilder: (context, index) => GeneralMealCard(
                meal: value[index],
                onTap: (id) => AppRouter.goTo(
                  context,
                  AppRouter.mealDetails,
                  params: MealDetailsParams(mealId: id),
                ),
              ),
            ),
          },
        ),
        if (_isLoadingMore)
          const Padding(
            padding: AppDesign.paddingMd,
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
