import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';
import 'package:sfrigola/features/feature-meal-details/providers/meal_by_id_provider.dart';

part 'update_rating_provider.g.dart';

@riverpod
class UpdateRating extends _$UpdateRating {
  @override
  Future<double> build(String mealId) async {
    final meal = await ref.watch(mealByIdProvider(mealId).future);
    return meal.userRate ?? 0.0;
  }

  Future<void> rate(double newRating) async {
    final current = await future;
    final repo = ref.read(mealRepositoryProvider);

    // Optimistic update — UI responds immediately.
    state = AsyncData(newRating);

    try {
      await repo.updateMealRating(mealId, newRating);
    } catch (e, _) {
      // Rollback — restore previous value so the next rate() starts clean.
      state = AsyncData(current);
      rethrow;
    }
  }
}
