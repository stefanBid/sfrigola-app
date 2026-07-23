import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_filter.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/provider_state.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/core/providers/meals_filter_provider.dart';

// Project Utils
import 'package:sfrigola/core/utils/has_more.dart';
import 'package:sfrigola/core/utils/request_builder.dart';

part 'all_favourites_by_filter_provider.g.dart';

@riverpod
class AllFavouritesByFilter extends _$AllFavouritesByFilter {
  static const _pageSize = 20;

  @override
  Future<ListProviderState<MealPreview>> build() async {
    final filterState = ref.watch(
      mealsFilterProvider(MealsFilterScope.favorites),
    );
    final request = _buildRequest(
      searchKey: null,
      filterState: filterState,
      skip: 0,
    );
    final response = await ref
        .watch(favoritesRepositoryProvider)
        .getFavorites(request);

    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];

    final filterState = ref.read(
      mealsFilterProvider(MealsFilterScope.favorites),
    );

    final request = _buildRequest(
      searchKey: null,
      filterState: filterState,
      skip: current.length,
    );
    final response = await ref
        .read(favoritesRepositoryProvider)
        .getFavorites(request);

    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }

  GetRequest<MealFilterKey, MealSortKey> _buildRequest({
    required String? searchKey,
    required MealsFilterProviderState filterState,
    required int skip,
  }) {
    return RequestBuilder<MealFilterKey, MealSortKey>()
        .setSearchKey(searchKey)
        .addFilterIfNotNull(
          MealFilterKey.complexity,
          FilterOperator.equals,
          filterState.complexity,
        )
        .addFilterIfNotNull(
          MealFilterKey.affordability,
          FilterOperator.equals,
          filterState.affordability,
        )
        .addFilterIfNotNull(
          MealFilterKey.rating,
          FilterOperator.greaterThanOrEquals,
          filterState.rateRange?.min,
        )
        .addFilterIfNotNull(
          MealFilterKey.rating,
          FilterOperator.lessThanOrEquals,
          filterState.rateRange?.max,
        )
        .setSortIfNotNull(filterState.sort)
        .setSkip(skip)
        .setTake(_pageSize)
        .build();
  }
}
