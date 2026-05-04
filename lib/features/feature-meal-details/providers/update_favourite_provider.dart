import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/providers/repository_provider.dart';

// Project Features
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
    final isFav = state.requireValue;
    // Optimistic update — flip immediately.
    state = AsyncData(!isFav);
    try {
      final repo = ref.read(favoritesRepositoryProvider);
      if (isFav) {
        await repo.removeFavorite(mealId);
      } else {
        await repo.addFavorite(mealId);
      }
    } catch (e, _) {
      // Rollback — restore previous value.
      state = AsyncData(isFav);
      rethrow;
    }
  }
}
