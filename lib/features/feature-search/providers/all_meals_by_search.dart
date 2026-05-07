import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/provider_state.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-search/providers/searched_key_provider.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_keys.dart';

// Project Utils
import 'package:sfrigola/core/utils/has_more.dart';
import 'package:sfrigola/core/utils/request_builder.dart';

part 'all_meals_by_search.g.dart';

@riverpod
class AllMealsBySearch extends _$AllMealsBySearch {
  static const _pageSize = 20;
  @override
  Future<ListProviderState<MealPreview>> build() async {
    final searchKey = ref.watch(searchedKeyProvider);
    if (searchKey?.isEmpty ?? true) {
      return ListProviderState(items: [], hasMore: false);
    }

    final request = RequestBuilder<MealFilterKey, MealSortKey>()
        .setSearchKey(searchKey)
        .setTake(_pageSize)
        .build();

    final response = await ref
        .read(mealRepositoryProvider)
        .getAllMeals(request);

    return ListProviderState<MealPreview>(
      items: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.items ?? [];

    final searchKey = ref.read(searchedKeyProvider);
    final request = RequestBuilder<MealFilterKey, MealSortKey>()
        .setSearchKey(searchKey)
        .setTake(_pageSize)
        .setSkip(current.length)
        .build();

    final response = await ref
        .read(mealRepositoryProvider)
        .getAllMeals(request);

    state = AsyncData(
      state.value!.copyWith(
        items: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}
