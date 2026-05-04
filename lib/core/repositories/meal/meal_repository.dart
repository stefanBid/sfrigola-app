// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

abstract interface class MealRepository {
  /// Returns all available categories.
  Future<GetListDataResponse<Category>> getCategories();

  /// Trending meals — highest rated, currently viral.
  Future<GetListDataResponse<MealPreview>> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Easy meals — complexity == simple.
  Future<GetListDataResponse<MealPreview>> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Challenge meals — complexity == hard.
  Future<GetListDataResponse<MealPreview>> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Budget meals — affordability == affordable.
  Future<GetListDataResponse<MealPreview>> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// Premium meals — affordability == luxurious.
  Future<GetListDataResponse<MealPreview>> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  });

  /// All meals, paginated
  Future<GetListDataResponse<MealPreview>> getAllMeals(
    String? searchKey, {
    int skip = 0,
    int take = 10,
  });

  /// Returns a single meal by ID. Throws [MealNotFoundException] if not found.
  Future<GetDataResponse<Meal>> getMealById(String id);

  /// Updates a meal's average rating based on a new user rating. Returns success status.
  Future<MutationResponse> updateMealRating(String mealId, double newRating);
}
