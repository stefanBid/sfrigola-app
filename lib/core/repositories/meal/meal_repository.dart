// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';

abstract interface class MealRepository {
  /// Returns all available categories.
  Future<List<Category>> getCategories();

  /// Trending meals — highest rated, currently viral.
  Future<MealRepositoryResponse> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Easy meals — complexity == simple.
  Future<MealRepositoryResponse> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Challenge meals — complexity == hard.
  Future<MealRepositoryResponse> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Budget meals — affordability == affordable.
  Future<MealRepositoryResponse> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Premium meals — affordability == luxurious.
  Future<MealRepositoryResponse> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// All meals, paginated
  Future<MealRepositoryResponse> getAllMeals(
    String? searchKey, {
    int skip = 0,
    int take = 10,
  });

  /// Returns a single meal by ID. Throws [MealNotFoundException] if not found.
  Future<Meal> getMealById(String id);
}
