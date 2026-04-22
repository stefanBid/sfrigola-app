import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-home/providers/selected_category_id_provider.dart';

part 'meals_provider.g.dart';

class MealsProviderState {
  final List<MealPreview> meals;
  final bool hasMore;

  MealsProviderState({required this.meals, required this.hasMore});

  MealsProviderState copyWith({List<MealPreview>? meals, bool? hasMore}) {
    return MealsProviderState(
      meals: meals ?? this.meals,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// Trending

@riverpod
class TrendingMeals extends _$TrendingMeals {
  static const _pageSize = 10;

  @override
  Future<MealsProviderState> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getTrending(categoryId, take: _pageSize);
    return MealsProviderState(
      meals: response.meals,
      hasMore: response.hasMore(0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.meals ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final response = await ref
        .read(mealRepositoryProvider)
        .getTrending(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData(
      MealsProviderState(
        meals: [...current, ...response.meals],
        hasMore: response.hasMore(current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class EasyMeals extends _$EasyMeals {
  static const _pageSize = 10;

  @override
  Future<MealsProviderState> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getEasy(categoryId, take: _pageSize);
    return MealsProviderState(
      meals: response.meals,
      hasMore: response.hasMore(0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.meals ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final response = await ref
        .read(mealRepositoryProvider)
        .getEasy(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData(
      MealsProviderState(
        meals: [...current, ...response.meals],
        hasMore: response.hasMore(current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class ChallengeMeals extends _$ChallengeMeals {
  static const _pageSize = 10;

  @override
  Future<MealsProviderState> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getChallenge(categoryId, take: _pageSize);
    return MealsProviderState(
      meals: response.meals,
      hasMore: response.hasMore(0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.meals ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final response = await ref
        .read(mealRepositoryProvider)
        .getChallenge(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData(
      MealsProviderState(
        meals: [...current, ...response.meals],
        hasMore: response.hasMore(current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class BudgetMeals extends _$BudgetMeals {
  static const _pageSize = 10;

  @override
  Future<MealsProviderState> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getBudget(categoryId, take: _pageSize);
    return MealsProviderState(
      meals: response.meals,
      hasMore: response.hasMore(0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.meals ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final response = await ref
        .read(mealRepositoryProvider)
        .getBudget(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData(
      MealsProviderState(
        meals: [...current, ...response.meals],
        hasMore: response.hasMore(current.length, _pageSize),
      ),
    );
  }
}

@riverpod
class PremiumMeals extends _$PremiumMeals {
  static const _pageSize = 10;

  @override
  Future<MealsProviderState> build() async {
    final categoryId = ref.watch(selectedCategoryIdProvider);
    final response = await ref
        .watch(mealRepositoryProvider)
        .getPremium(categoryId, take: _pageSize);
    return MealsProviderState(
      meals: response.meals,
      hasMore: response.hasMore(0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.meals ?? [];
    final categoryId = ref.read(selectedCategoryIdProvider);
    final response = await ref
        .read(mealRepositoryProvider)
        .getPremium(categoryId, skip: current.length, take: _pageSize);
    state = AsyncData(
      MealsProviderState(
        meals: [...current, ...response.meals],
        hasMore: response.hasMore(current.length, _pageSize),
      ),
    );
  }
}
