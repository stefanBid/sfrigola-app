import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_filter.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/provider_state.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-home/providers/selected_category_id_provider.dart';

// Project Utils
import 'package:sfrigola/core/utils/has_more.dart';
import 'package:sfrigola/core/utils/request_builder.dart';

part 'meals_provider.g.dart';

// Trending

@riverpod
class TrendingMeals extends _$TrendingMeals {
  static const _pageSize = 10;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final request = _categoryRequest(categoryId, take: _pageSize);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getTrending(request);
    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);

    final request = _categoryRequest(
      categoryId,
      skip: current.length,
      take: _pageSize,
    );
    final response = await ref
        .read(mealRepositoryProvider)
        .getTrending(request);

    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class EasyMeals extends _$EasyMeals {
  static const _pageSize = 10;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final request = _categoryRequest(categoryId, take: _pageSize);
    final response = await ref.watch(mealRepositoryProvider).getEasy(request);
    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final request = _categoryRequest(
      categoryId,
      skip: current.length,
      take: _pageSize,
    );
    final response = await ref.read(mealRepositoryProvider).getEasy(request);
    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class ChallengeMeals extends _$ChallengeMeals {
  static const _pageSize = 10;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final request = _categoryRequest(categoryId, take: _pageSize);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getChallenge(request);
    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final request = _categoryRequest(
      categoryId,
      skip: current.length,
      take: _pageSize,
    );
    final response = await ref
        .read(mealRepositoryProvider)
        .getChallenge(request);

    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class BudgetMeals extends _$BudgetMeals {
  static const _pageSize = 10;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final request = _categoryRequest(categoryId, take: _pageSize);
    final response = await ref.watch(mealRepositoryProvider).getBudget(request);
    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final request = _categoryRequest(
      categoryId,
      skip: current.length,
      take: _pageSize,
    );
    final response = await ref.read(mealRepositoryProvider).getBudget(request);

    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class PremiumMeals extends _$PremiumMeals {
  static const _pageSize = 10;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final request = _categoryRequest(categoryId, take: _pageSize);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getPremium(request);
    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final request = _categoryRequest(
      categoryId,
      skip: current.length,
      take: _pageSize,
    );
    final response = await ref.read(mealRepositoryProvider).getPremium(request);
    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Builds a [GetRequest] with an optional category filter and pagination params.
GetRequest<MealFilterKey, MealSortKey> _categoryRequest(
  String? categoryId, {
  int skip = 0,
  required int take,
}) => RequestBuilder<MealFilterKey, MealSortKey>()
    .setSkip(skip)
    .setTake(take)
    .addFilterIfNotNull(
      MealFilterKey.category,
      FilterOperator.equals,
      categoryId,
    )
    .build();
