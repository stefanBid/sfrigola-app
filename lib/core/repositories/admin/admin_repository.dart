import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

abstract interface class AdminRepository {
  /// Adds a new meal to the menu.
  /// In production: POST /admin/meals
  Future<MutationResponse> addMeal(Meal meal);

  /// Updates an existing meal's details.
  /// In production: PUT /admin/meals/{mealId}
  Future<MutationResponse> updateMeal(Meal meal);

  /// Deletes a meal from the menu.
  /// In production: DELETE /admin/meals/{mealId}
  Future<MutationResponse> deleteMeal(String mealId);
}
