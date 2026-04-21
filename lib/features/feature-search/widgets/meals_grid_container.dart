import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/features/feature-search/providers/all_meals_provider.dart';
import 'package:sfrigola/features/feature-search/providers/searched_key_provider.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';
import 'package:sfrigola/core/widgets/group-container/gc_grid_view.dart';

// Screen Widgets
import 'package:sfrigola/features/feature-search/widgets/general_meal_card.dart';
import 'package:sfrigola/features/feature-search/widgets/skeletons/general_meal_card_skeleton.dart';
import 'package:sfrigola/features/feature-search/widgets/skeletons/grid_cards_skeleton.dart';

class MealsGridContainer extends ConsumerStatefulWidget {
  const MealsGridContainer({super.key});

  @override
  ConsumerState<MealsGridContainer> createState() => _MealsGridContainerState();
}

class _MealsGridContainerState extends ConsumerState<MealsGridContainer> {
  static const int _pageSize = 20;
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

  Widget _buildGrid(BuildContext context, List<MealPreview> items) {
    final isTablet = AppDesign.isTablet(context);
    final skeletonCount = isTablet ? (items.length.isEven ? 2 : 3) : 1;
    final itemCount = items.length + (_isLoadingMore ? skeletonCount : 0);

    return GcGridView(
      itemCount: itemCount,
      scrollController: _scrollController,
      dimensions: GridDimensions(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: AppDesign.gapSectionLg,
        ),
        crossAxisCount: isTablet ? 2 : 1,
        maxItemWidth: isTablet ? 400 : double.infinity,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return _buildMealCard(context, items[index]);
        } else {
          return const GeneralMealCardSkeleton();
        }
      },
    );
  }

  Widget _buildMealCard(BuildContext context, MealPreview meal) {
    return GeneralMealCard(
      meal: meal,
      onTap: (id) => AppRouter.goTo(
        context,
        AppRouter.mealDetails,
        params: MealDetailsParams(mealId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allMeals = ref.watch(allMealsProvider);
    final isSearching = ref.watch(searchedKeyProvider)?.isNotEmpty ?? false;

    ref.listen<AsyncValue<List<MealPreview>>>(allMealsProvider, (prev, next) {
      if ((prev == null || prev.isLoading) && next.hasValue && mounted) {
        setState(() {
          _isLoadingMore = false;
          _hasMore = (next.value?.length ?? 0) >= _pageSize;
        });
      }
      if (next is AsyncError && prev is! AsyncError && mounted) {
        BaseScaffoldMessenger.show(
          context,
          message: AppLocale.getLabels(context).searchErrorLoadMeals,
          type: SnackBarType.error,
          retryLabel: AppLocale.getLabels(context).retry,
          onRetry: () => ref.invalidate(allMealsProvider),
        );
      }
    });

    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () => ref.refresh(allMealsProvider.future),
        child: Column(
          children: [
            Expanded(
              child: allMeals.isLoading && isSearching
                  ? const GridCardsSkeleton()
                  : switch (allMeals) {
                      AsyncError() => MessagePageLayout(
                        icon: PhosphorIconsBold.warningCircle,
                        message: AppLocale.getLabels(
                          context,
                        ).searchErrorLoadMeals,
                        type: MessagePageType.muted,
                        onRetry: () => ref.invalidate(allMealsProvider),
                      ),
                      AsyncData(value: []) when isSearching =>
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: MessagePageLayout(
                              icon: PhosphorIconsBold.cookingPot,
                              message: AppLocale.getLabels(
                                context,
                              ).searchEmptyResults,
                              type: MessagePageType.muted,
                            ),
                          ),
                        ),
                      AsyncData(value: []) => ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: MessagePageLayout(
                          icon: PhosphorIconsRegular.bowlFood,
                          message: AppLocale.getLabels(context).searchEmptyHint,
                          type: MessagePageType.standard,
                        ),
                      ),
                      AsyncData(:final value) => _buildGrid(context, value),
                      _ => ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: MessagePageLayout(
                          icon: PhosphorIconsRegular.bowlFood,
                          message: AppLocale.getLabels(context).searchEmptyHint,
                          type: MessagePageType.standard,
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
