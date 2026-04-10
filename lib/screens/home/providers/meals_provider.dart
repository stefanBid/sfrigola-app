import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Providers
import 'package:sfrigola/providers/repository_provider.dart';
import 'package:sfrigola/screens/home/providers/selected_category_id_provider.dart';

part 'meals_provider.g.dart';

// Trending

@riverpod
class TrendingMeals extends _$TrendingMeals {
  static const _pageSize = 10;

  @override
  Future<List<Meal>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getTrending(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getTrending(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}

@riverpod
class RecentMeals extends _$RecentMeals {
  static const _pageSize = 10;

  @override
  Future<List<Meal>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getRecent(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getRecent(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}

@riverpod
class PopularMeals extends _$PopularMeals {
  static const _pageSize = 10;

  @override
  Future<List<Meal>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getPopular(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getPopular(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}
