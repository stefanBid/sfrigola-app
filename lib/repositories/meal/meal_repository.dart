// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

abstract interface class MealRepository {
  /// Returns all available categories.
  Future<List<Category>> getCategories();

  /// Returns trending meals (high rate, currently popular).
  Future<List<Meal>> getTrending(MealRepositoryFilter filter);

  /// Returns recently added meals.
  Future<List<Meal>> getRecent(MealRepositoryFilter filter);

  /// Returns the most popular meals (community rating).
  Future<List<Meal>> getPopular(MealRepositoryFilter filter);

  /// Returns a single meal by ID. Throws [MealNotFoundException] if not found.
  Future<Meal> getMealById(String id);
}
