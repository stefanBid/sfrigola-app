import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_design.dart';
import 'package:sfrigola/core/helpers/app_locale.dart';
import 'package:sfrigola/core/helpers/app_router.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/provider_state.dart';

// Project Providers
import 'package:sfrigola/features/feature-admin-cookbook/providers/all_meals_by_filter_provider.dart';

// Project Layouts
import 'package:sfrigola/core/layouts/body/message_page_layout.dart';

// Project Widgets
import 'package:sfrigola/core/widgets/base_scaffold_messenger.dart';
import 'package:sfrigola/core/widgets/group-container/gc_grid_view.dart';

// Screen Widgets
import 'package:sfrigola/core/custom-widgets/general-meal-card/general_meal_card.dart';
import 'package:sfrigola/core/custom-widgets/general-meal-card/general_meal_card_skeleton.dart';
import 'package:sfrigola/features/feature-search/widgets/skeletons/meals_grid_skeleton.dart';

class CookbookGridContainer extends ConsumerStatefulWidget {
  const CookbookGridContainer({super.key});

  @override
  ConsumerState<CookbookGridContainer> createState() =>
      _CookbookGridContainerState();
}

class _CookbookGridContainerState extends ConsumerState<CookbookGridContainer> {
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
    final hasMore = ref.read(allMealsByFilterProvider).value?.hasMore ?? false;
    if (_isLoadingMore || !hasMore) return;
    setState(() => _isLoadingMore = true);

    try {
      await ref.read(allMealsByFilterProvider.notifier).loadMore();

      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  Widget _buildGrid(BuildContext context, List<MealPreview> items) {
    final isTablet = AppDesign.isTablet(context);
    final crossAxisCount = isTablet ? 2 : 1;
    final skeletonCount = crossAxisCount - (items.length % crossAxisCount);
    final itemCount = items.length + (_isLoadingMore ? skeletonCount : 0);

    return GcGridView(
      itemCount: itemCount,
      scrollController: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      dimensions: GridDimensions(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: AppDesign.gapSectionLg,
        ),
        crossAxisCount: crossAxisCount,
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
      onTap: (id) => AppRouter.goDeep(
        context,
        AppRouter.mealDetails,
        params: MealDetailsParams(mealId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allMeals = ref.watch(allMealsByFilterProvider);

    ref.listen<AsyncValue<ListProviderState<MealPreview>>>(
      allMealsByFilterProvider,
      (prev, next) {
        if ((prev == null || prev.isLoading) && next.hasValue && mounted) {
          setState(() => _isLoadingMore = false);
        }
        if (next is AsyncError && prev is! AsyncError && mounted) {
          BaseScaffoldMessenger.show(
            context,
            message: AppLocale.getLabels(context).searchErrorLoadMeals,
            type: SnackBarType.error,
            retryLabel: AppLocale.getLabels(context).retry,
            onRetry: () => ref.invalidate(allMealsByFilterProvider),
          );
        }
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () => ref.refresh(allMealsByFilterProvider.future),
        child: Column(
          children: [
            Expanded(
              child: allMeals.isLoading
                  ? const MealsGridSkeleton()
                  : switch (allMeals) {
                      AsyncError() => MessagePageLayout(
                        icon: PhosphorIconsBold.warningCircle,
                        message: AppLocale.getLabels(
                          context,
                        ).searchErrorLoadMeals,
                        type: MessagePageType.muted,
                        onRetry: () => ref.invalidate(allMealsByFilterProvider),
                      ),

                      AsyncData(
                        value: ListProviderState<MealPreview>(items: []),
                      ) =>
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: MessagePageLayout(
                            icon: PhosphorIconsRegular.bowlFood,
                            message: AppLocale.getLabels(
                              context,
                            ).searchEmptyHint,
                            type: MessagePageType.standard,
                          ),
                        ),
                      AsyncData(:final value) => _buildGrid(
                        context,
                        value.items,
                      ),
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
