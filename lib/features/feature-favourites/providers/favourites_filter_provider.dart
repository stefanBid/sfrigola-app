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

  FavouritesFilterProviderState copyWith({
    Complexity? complexity,
    Affordability? affordability,
    double? minRate,
    SortOrder? sortOrder,
  }) {
    return FavouritesFilterProviderState(
      complexity: complexity ?? this.complexity,
      affordability: affordability ?? this.affordability,
      minRate: minRate ?? this.minRate,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
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
    state = state.copyWith(
      complexity: complexity,
      affordability: affordability,
      minRate: minRate,
      sortOrder: sortOrder,
    );
  }
}
