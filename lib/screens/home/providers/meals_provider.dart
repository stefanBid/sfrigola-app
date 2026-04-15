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
  Future<List<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getTrending(categoryId, take: _pageSize);
  }

  Future<List<MealPreview>> fetchPage(int pageKey, {int pageSize = _pageSize}) {
    final categoryId = ref.read(selectedCategoryIdProvider);
    return ref
        .read(mealRepositoryProvider)
        .getTrending(categoryId, skip: pageKey, take: pageSize);
  }
}

@riverpod
class EasyMeals extends _$EasyMeals {
  static const _pageSize = 10;

  @override
  Future<List<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getEasy(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getEasy(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}

@riverpod
class ChallengeMeals extends _$ChallengeMeals {
  static const _pageSize = 10;

  @override
  Future<List<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getChallenge(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getChallenge(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}

@riverpod
class BudgetMeals extends _$BudgetMeals {
  static const _pageSize = 10;

  @override
  Future<List<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getBudget(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getBudget(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}

@riverpod
class PremiumMeals extends _$PremiumMeals {
  static const _pageSize = 10;

  @override
  Future<List<MealPreview>> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    return ref
        .watch(mealRepositoryProvider)
        .getPremium(categoryId, take: _pageSize);
  }

  Future<void> loadMore() async {
    final current = state.value ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final next = await ref
        .read(mealRepositoryProvider)
        .getPremium(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData([...current, ...next]);
  }
}
