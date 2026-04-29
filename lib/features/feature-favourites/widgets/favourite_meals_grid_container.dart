import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// project Providers
import 'package:sfrigola/features/feature-favourites/providers/all_favourites_provider.dart';
import 'package:sfrigola/features/feature-favourites/providers/favourites_filter_provider.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/group-container/gc_grid_view.dart';
import 'package:sfrigola/core/widgets/base_card.dart';
import 'package:sfrigola/features/feature-favourites/widgets/skeletons/favourite_meals_grid_skeleton.dart';
import 'package:sfrigola/features/feature-favourites/widgets/skeletons/favourite_meal_card_skeleton.dart';

class FavouriteMealsGridContainer extends ConsumerStatefulWidget {
  const FavouriteMealsGridContainer({super.key});

  @override
  ConsumerState<FavouriteMealsGridContainer> createState() =>
      _FavouriteMealsGridContainerState();
}

class _FavouriteMealsGridContainerState
    extends ConsumerState<FavouriteMealsGridContainer> {
  static const double _scrollThreshold = 200.0;

  late final ScrollController _scrollController;
  bool _isLoadingMore = false;

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
    if (_isLoadingMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _scrollThreshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    final hasMore = ref.read(allFavouritesProvider).value?.hasMore ?? false;
    if (_isLoadingMore || !hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      await ref.read(allFavouritesProvider.notifier).loadMore();

      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  Widget _buildGrid(BuildContext contex, List<MealPreview> meals) {
    final isTablet = AppDesign.isTablet(context);
    final crossAxisCount = isTablet ? 4 : 2;
    final itemCount = meals.length + (_isLoadingMore ? crossAxisCount : 0);

    return GcGridView(
      itemCount: itemCount,
      scrollController: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      dimensions: GridDimensions(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: AppDesign.gapSectionLg,
        ),
        crossAxisCount: crossAxisCount,
        maxItemWidth: 220,
        mainAxisExtent: 220,
      ),
      itemBuilder: (context, index) {
        if (index < meals.length) {
          return _buildMealCard(context, meals[index]);
        } else {
          return const FavouriteMealCardSkeleton();
        }
      },
    );
  }

  Widget _buildMealCard(BuildContext context, MealPreview meal) {
    return BaseCard(
      key: ValueKey(meal.id),
      title: meal.title,
      content: meal.subtitle,
      imageUrl: meal.imageUrl,
      height: double.infinity,
      onTap: () {
        AppRouter.goDeep(
          context,
          AppRouter.mealDetails,
          params: MealDetailsParams(mealId: meal.id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allFavourites = ref.watch(allFavouritesProvider);
    final filter = ref.watch(favouritesFilterProvider);

    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () => ref.refresh(allFavouritesProvider.future),
        child: Column(
          children: [
            Expanded(
              child: allFavourites.isLoading
                  ? const FavouriteMealsGridSkeleton()
                  : switch (allFavourites) {
                      AsyncError() => MessagePageLayout(
                        icon: PhosphorIconsBold.warningCircle,
                        message: AppLocale.getLabels(
                          context,
                        ).favouritesErrorLoad,
                        type: MessagePageType.muted,
                        onRetry: () => ref.invalidate(allFavouritesProvider),
                      ),
                      AsyncData(
                        value: AllFavouritesProviderState(favouriteMeals: []),
                      )
                          when filter.hasFilters =>
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: MessagePageLayout(
                              icon: PhosphorIconsBold.funnelSimple,
                              message: AppLocale.getLabels(
                                context,
                              ).favouritesEmptyFiltered,
                              type: MessagePageType.muted,
                            ),
                          ),
                        ),
                      AsyncData(
                        value: AllFavouritesProviderState(favouriteMeals: []),
                      ) =>
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: MessagePageLayout(
                              icon: PhosphorIconsBold.heartStraight,
                              message: AppLocale.getLabels(
                                context,
                              ).favouritesEmpty,
                              type: MessagePageType.standard,
                            ),
                          ),
                        ),
                      AsyncData(:final value) => _buildGrid(
                        context,
                        value.favouriteMeals,
                      ),
                      _ => SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: MessagePageLayout(
                            icon: PhosphorIconsBold.heartStraight,
                            message: AppLocale.getLabels(
                              context,
                            ).favouritesEmpty,
                            type: MessagePageType.standard,
                          ),
                        ),
                      ),
                    },
            ),
          ],
        ),
      ),
    );
  }
}
