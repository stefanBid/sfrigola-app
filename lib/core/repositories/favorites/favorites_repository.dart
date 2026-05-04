// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/be-models/be_filters.dart';

abstract interface class FavoritesRepository {
  /// Returns the authenticated user's saved meals.
  /// All filter params are optional — omit to return the full list.
  /// In production: GET /favorites — auth token is passed via Dio interceptor.
  Future<GetListDataResponse<MealPreview>> getFavorites({
    Complexity? complexity,
    Affordability? affordability,
    double? minRate,
    double? maxRate,
    SortOrder? sortOrder,
    int skip,
    int take,
  });

  /// Adds a meal to the user's favourites.
  /// In production: POST /favorites/{mealId}
  Future<MutationResponse> addFavorite(String mealId);

  /// Removes a meal from the user's favourites.
  /// In production: DELETE /favorites/{mealId}
  Future<MutationResponse> removeFavorite(String mealId);
}
