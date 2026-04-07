import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

// Project Providers
import 'package:sfrigola/providers/repository_provider.dart';

part 'meal_provider.g.dart';

/// All available categories. Used for the filter row on the Home screen.
@riverpod
Future<List<Category>> categories(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getCategories();
}

/// Trending meals — highest rated, currently popular.
@riverpod
Future<List<Meal>> trendingMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getTrending(const MealFilter());
}

/// Recently added meals.
@riverpod
Future<List<Meal>> recentMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getRecent(const MealFilter());
}

/// Most popular meals (community rating).
@riverpod
Future<List<Meal>> popularMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getPopular(const MealFilter());
}
