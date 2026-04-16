// Project Models
import 'package:sfrigola/models/meal.dart';

abstract interface class FavoritesRepository {
  /// Returns the authenticated user's saved meals.
  /// Pass [categoryId] to filter by category, null for no filter.
  /// In production: GET /favorites — auth token is passed via Dio interceptor.
  Future<List<Meal>> getFavorites(String? categoryId);

  /// Adds a meal to the user's favourites.
  /// In production: POST /favorites/{mealId}
  Future<void> addFavorite(String mealId);

  /// Removes a meal from the user's favourites.
  /// In production: DELETE /favorites/{mealId}
  Future<void> removeFavorite(String mealId);

  /// Synchronous check against a locally cached list of IDs.
  /// No network call — the provider caches IDs after [getFavorites].
  bool isFavorite(String mealId, List<String> cachedIds);
}
