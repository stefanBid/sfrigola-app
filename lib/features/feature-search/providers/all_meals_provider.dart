import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'all_meals_provider.g.dart';

@riverpod
class AllMeals extends _$AllMeals {
  static const _pageSize = 20;

  @override
  Future<List<MealPreview>> build() async {
    return ref.watch(mealRepositoryProvider).getAllMeals(take: _pageSize);
  }

  Future<bool> loadMore() async {
    final current = state.value ?? [];
    final next = await ref
        .read(mealRepositoryProvider)
        .getAllMeals(skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
    return next.length >= _pageSize;
  }
}
