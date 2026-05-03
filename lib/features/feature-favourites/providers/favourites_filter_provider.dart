import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_filters.dart';

part 'favourites_filter_provider.g.dart';

class FavouritesFilterProviderState {
  final Complexity? complexity;
  final Affordability? affordability;
  final double? minRate;
  final SortOrder? sortOrder;

  FavouritesFilterProviderState({
    this.complexity,
    this.affordability,
    this.minRate,
    this.sortOrder,
  });

  bool get hasFilters =>
      complexity != null ||
      affordability != null ||
      minRate != null ||
      sortOrder != null;
}

@riverpod
class FavouritesFilter extends _$FavouritesFilter {
  @override
  FavouritesFilterProviderState build() {
    return FavouritesFilterProviderState(
      complexity: null,
      affordability: null,
      minRate: null,
      sortOrder: null,
    );
  }

  void update({
    Complexity? complexity,
    Affordability? affordability,
    double? minRate,
    SortOrder? sortOrder,
  }) {
    state = FavouritesFilterProviderState(
      complexity: complexity ?? state.complexity,
      affordability: affordability ?? state.affordability,
      minRate: minRate ?? state.minRate,
      sortOrder: sortOrder ?? state.sortOrder,
    );
  }

  void replaceWith(FavouritesFilterProviderState newState) {
    state = newState;
  }

  void reset() {
    state = build();
  }
}
