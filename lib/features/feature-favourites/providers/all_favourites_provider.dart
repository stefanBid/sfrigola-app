import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-favourites/providers/favourites_filter_provider.dart';

// Project Utils
import 'package:sfrigola/core/utils/has_more.dart';

part 'all_favourites_provider.g.dart';

class AllFavouritesProviderState {
  final List<MealPreview> favouriteMeals;
  final bool hasMore;

  AllFavouritesProviderState({
    required this.favouriteMeals,
    required this.hasMore,
  });

  AllFavouritesProviderState copyWith({
    List<MealPreview>? favouriteMeals,
    bool? hasMore,
  }) {
    return AllFavouritesProviderState(
      favouriteMeals: favouriteMeals ?? this.favouriteMeals,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

@riverpod
class AllFavourites extends _$AllFavourites {
  static const _pageSize = 10;

  @override
  Future<AllFavouritesProviderState> build() async {
    final filter = ref.watch(favouritesFilterProvider);
    final response = await ref
        .watch(favoritesRepositoryProvider)
        .getFavorites(
          complexity: filter.complexity,
          affordability: filter.affordability,
          minRate: filter.minRate,
          sortOrder: filter.sortOrder,
          skip: 0,
          take: _pageSize,
        );
    return AllFavouritesProviderState(
      favouriteMeals: response.data,
      hasMore: hasMore(response.total, 0, _pageSize),
    );
  }

  Future<void> loadMore() async {
    final current = state.value?.favouriteMeals ?? [];
    final filter = ref.read(favouritesFilterProvider);
    final response = await ref
        .read(favoritesRepositoryProvider)
        .getFavorites(
          complexity: filter.complexity,
          affordability: filter.affordability,
          minRate: filter.minRate,
          sortOrder: filter.sortOrder,
          skip: current.length,
          take: _pageSize,
        );
    state = AsyncData(
      state.value!.copyWith(
        favouriteMeals: [...current, ...response.data],
        hasMore: hasMore(
          response.total,
          current.length + response.data.length,
          _pageSize,
        ),
      ),
    );
  }
}
