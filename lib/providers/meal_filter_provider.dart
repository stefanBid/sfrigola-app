import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

part 'meal_filter_provider.g.dart';

@riverpod
class MealFilter extends _$MealFilter {
  @override
  MealRepositoryFilter build() => const MealRepositoryFilter();

  /// Sets (or clears) the active category filter.
  void setCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
  }

  /// Updates the free-text search query.
  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  /// Resets all filters to their default values.
  void reset() => state = const MealRepositoryFilter();
}
