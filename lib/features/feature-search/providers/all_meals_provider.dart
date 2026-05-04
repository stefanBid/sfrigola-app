import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-home/providers/meals_provider.dart';
import 'package:sfrigola/features/feature-search/providers/searched_key_provider.dart';

// Project Utils
import 'package:sfrigola/core/utils/has_more.dart';

part 'all_meals_provider.g.dart';

@riverpod
class AllMeals extends _$AllMeals {
  static const _pageSize = 20;

  @override
  Future<MealsProviderState> build() async {
    final searchKey = ref.watch(searchedKeyProvider);
    if (searchKey?.isEmpty ?? true) {
      return MealsProviderState(meals: [], hasMore: false);
    }
    final response = await ref
        .read(mealRepositoryProvider)
        .getAllMeals(searchKey, take: _pageSize);
    return MealsProviderState(
      meals: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.meals ?? [];
    final searchKey = ref.read(searchedKeyProvider);
    final response = await ref
        .read(mealRepositoryProvider)
        .getAllMeals(searchKey, skip: current.length, take: _pageSize);
    state = AsyncData(
      state.value!.copyWith(
        meals: [...current, ...response.data],
        hasMore: hasMore(response.total, current.length, _pageSize),
      ),
    );
  }
}
