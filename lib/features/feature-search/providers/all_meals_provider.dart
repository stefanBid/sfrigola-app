import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Utils
import 'package:sfrigola/core/utils/provider_retry.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-search/providers/searched_key_provider.dart';

part 'all_meals_provider.g.dart';

@Riverpod(retry: appRetry)
class AllMeals extends _$AllMeals {
  static const _pageSize = 20;

  @override
  Future<List<MealPreview>> build() async {
    final searchKey = ref.watch(searchedKeyProvider);
    if (searchKey?.isEmpty ?? true) return [];
    return ref
        .read(mealRepositoryProvider)
        .getAllMeals(searchKey, take: _pageSize);
  }

  Future<bool> loadMore() async {
    final current = state.value ?? [];
    final searchKey = ref.read(searchedKeyProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getAllMeals(searchKey, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
    return next.length >= _pageSize;
  }
}
