import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Utils
import 'package:sfrigola/core/utils/provider_retry.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'meal_by_id_provider.g.dart';

@Riverpod(retry: appRetry)
class MealById extends _$MealById {
  @override
  Future<Meal> build(String mealId) async {
    final repo = ref.watch(mealRepositoryProvider);
    return repo.getMealById(mealId);
  }
}
