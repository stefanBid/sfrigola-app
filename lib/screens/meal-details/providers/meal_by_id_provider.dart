import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Providers
import 'package:sfrigola/providers/repository_provider.dart';

part 'meal_by_id_provider.g.dart';

@riverpod
Future<Meal> mealById(Ref ref, String mealId) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getMealById(mealId);
}
