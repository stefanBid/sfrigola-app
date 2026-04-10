// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

abstract interface class MealRepository {
  /// Returns all available categories.
  Future<List<Category>> getCategories();

  /// Returns trending meals (high rate, currently popular).
  /// Pass [categoryId] to filter by category, null for no filter.
  Future<List<Meal>> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Returns recently added meals.
  /// Pass [categoryId] to filter by category, null for no filter.
  Future<List<Meal>> getRecent(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Returns the most popular meals (community rating).
  /// Pass [categoryId] to filter by category, null for no filter.
  Future<List<Meal>> getPopular(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Returns a single meal by ID. Throws [MealNotFoundException] if not found.
  Future<Meal> getMealById(String id);
}
