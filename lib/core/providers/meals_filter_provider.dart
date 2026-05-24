import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_sort.dart';

part 'meals_filter_provider.g.dart';

abstract final class MealsFilterScope {
  static const String adminCookbook = 'admin-cookbook';
  static const String favorites = 'favorites';
}

class MealsFilterProviderState {
  final Complexity? complexity;
  final Affordability? affordability;
  final MealsRateRange? rateRange;
  final SortParam<MealSortKey>? sort;

  MealsFilterProviderState({
    this.complexity,
    this.affordability,
    this.rateRange,
    this.sort,
  });

  bool get hasFilters =>
      complexity != null ||
      affordability != null ||
      rateRange != null ||
      sort != null;

  int get appliedFiltersCount {
    var count = 0;
    if (complexity != null) count++;
    if (affordability != null) count++;
    if (rateRange != null) count++;
    if (sort != null) count++;
    return count;
  }
}

@riverpod
class MealsFilter extends _$MealsFilter {
  @override
  MealsFilterProviderState build(String scope) {
    return MealsFilterProviderState(
      complexity: null,
      affordability: null,
      rateRange: null,
      sort: null,
    );
  }

  void update({
    Complexity? complexity,
    Affordability? affordability,
    MealsRateRange? rateRange,
    SortParam<MealSortKey>? sort,
  }) {
    state = MealsFilterProviderState(
      complexity: complexity ?? state.complexity,
      affordability: affordability ?? state.affordability,
      rateRange: rateRange ?? state.rateRange,
      sort: sort ?? state.sort,
    );
  }

  void replaceWith(MealsFilterProviderState newState) {
    state = newState;
  }

  void clear() {
    state = MealsFilterProviderState(
      complexity: null,
      affordability: null,
      rateRange: null,
      sort: null,
    );
  }
}
