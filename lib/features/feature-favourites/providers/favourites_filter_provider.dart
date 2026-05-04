import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_filters.dart';

part 'favourites_filter_provider.g.dart';

class FavouritesFilterProviderState {
  final Complexity? complexity;
  final Affordability? affordability;
  final RangeValues? rateRange;
  final SortOrder? sortOrder;

  FavouritesFilterProviderState({
    this.complexity,
    this.affordability,
    this.rateRange,
    this.sortOrder,
  });

  bool get hasFilters =>
      complexity != null ||
      affordability != null ||
      rateRange != null ||
      sortOrder != null;

  int get appliedFiltersCount {
    var count = 0;
    if (complexity != null) count++;
    if (affordability != null) count++;
    if (rateRange != null) count++;
    if (sortOrder != null) count++;
    return count;
  }
}

@riverpod
class FavouritesFilter extends _$FavouritesFilter {
  @override
  FavouritesFilterProviderState build() {
    return FavouritesFilterProviderState(
      complexity: null,
      affordability: null,
      rateRange: null,
      sortOrder: null,
    );
  }

  void update({
    Complexity? complexity,
    Affordability? affordability,
    RangeValues? rateRange,
    SortOrder? sortOrder,
  }) {
    state = FavouritesFilterProviderState(
      complexity: complexity ?? state.complexity,
      affordability: affordability ?? state.affordability,
      rateRange: rateRange ?? state.rateRange,
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
