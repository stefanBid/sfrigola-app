// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

abstract interface class MealRepository {
  /// Returns all available categories.
  Future<GetListDataResponse<Category>> getCategories();

  /// Trending meals — highest rated, currently viral.
  Future<GetListDataResponse<MealPreview>> getTrending(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// Easy meals — complexity == simple.
  Future<GetListDataResponse<MealPreview>> getEasy(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// Challenge meals — complexity == hard.
  Future<GetListDataResponse<MealPreview>> getChallenge(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// Budget meals — affordability == affordable.
  Future<GetListDataResponse<MealPreview>> getBudget(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// Premium meals — affordability == luxurious.
  Future<GetListDataResponse<MealPreview>> getPremium(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// All meals, paginated
  Future<GetListDataResponse<MealPreview>> getAllMeals(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// Returns a single meal by ID. Throws [MealNotFoundException] if not found.
  Future<GetDataResponse<Meal>> getMealById(String id);

  /// Updates a meal's average rating based on a new user rating. Returns success status.
  Future<MutationResponse> updateMealRating(String mealId, double newRating);
}
