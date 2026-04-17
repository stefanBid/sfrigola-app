// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';

abstract interface class MealRepository {
  /// Returns all available categories.
  Future<List<Category>> getCategories();

  /// Trending meals — highest rated, currently viral.
  Future<List<MealPreview>> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Easy meals — complexity == simple.
  Future<List<MealPreview>> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Challenge meals — complexity == hard.
  Future<List<MealPreview>> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Budget meals — affordability == affordable.
  Future<List<MealPreview>> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Premium meals — affordability == luxurious.
  Future<List<MealPreview>> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// All meals, paginated
  Future<List<MealPreview>> getAllMeals({int skip = 0, int take = 10});

  /// Returns a single meal by ID. Throws [MealNotFoundException] if not found.
  Future<Meal> getMealById(String id);
}
