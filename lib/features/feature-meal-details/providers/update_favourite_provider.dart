import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/providers/repository_provider.dart';

// Project Features
import 'package:sfrigola/features/feature-favourites/providers/all_favourites_provider.dart';
import 'package:sfrigola/features/feature-meal-details/providers/meal_by_id_provider.dart';

part 'update_favourite_provider.g.dart';

@riverpod
class UpdateFavourite extends _$UpdateFavourite {
  @override
  Future<bool> build(String mealId) async {
    final meal = await ref.watch(mealByIdProvider(mealId).future);
    return meal.isFavourite;
  }

  Future<void> toggle() async {
    final isFav = await future;
    final repo = ref.read(favoritesRepositoryProvider);

    // Optimistic update — UI responds immediately.
    state = AsyncData(!isFav);

    try {
      if (isFav) {
        await repo.removeFavorite(mealId);
      } else {
        await repo.addFavorite(mealId);
      }
      // Sync the favourites list with the new state.
      ref.invalidate(allFavouritesProvider);
    } catch (e, st) {
      // Rollback — restore previous value and surface the error.
      state = AsyncError(e, st);
    }
  }
}
