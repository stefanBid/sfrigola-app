// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';

/// Simulates BE HTTP calls during mock development.
///
/// Each method mirrors a real endpoint — filtering, sorting, pagination and
/// mapping are all performed here, exactly as a server would do.
/// The repository only calls the method and checks [BeError] on the response.
///
/// To test the error path on any endpoint, set [simulateError] to true.
/// Replace each method body with the real Dio call when the BE is ready —
/// the repository contract stays unchanged.
class BeSimulators {
  static const BeError _error = BeError(
    message: 'Simulated BE error',
    code: 'SIMULATED',
  );

  // ---------------------------------------------------------------------------
  // Meal endpoints
  // ---------------------------------------------------------------------------

  /// GET /categories
  static Future<GetListDataResponse<Category>> getCategories({
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return GetListDataResponse(
      data: availableCategories,
      total: availableCategories.length,
      error: simulateError ? _error : null,
    );
  }

  /// GET /meals/trending
  static Future<GetListDataResponse<MealPreview>> getTrending({
    String? categoryId,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final sorted = [...availableMeals]
      ..sort((a, b) => b.rate.compareTo(a.rate));
    return _buildPreviewResponse(
      sorted,
      null,
      categoryId,
      skip,
      take,
      simulateError,
    );
  }

  /// GET /meals?complexity=simple
  static Future<GetListDataResponse<MealPreview>> getEasy({
    String? categoryId,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.simple)
        .toList();
    return _buildPreviewResponse(
      filtered,
      null,
      categoryId,
      skip,
      take,
      simulateError,
    );
  }

  /// GET /meals?complexity=hard
  static Future<GetListDataResponse<MealPreview>> getChallenge({
    String? categoryId,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.hard)
        .toList();
    return _buildPreviewResponse(
      filtered,
      null,
      categoryId,
      skip,
      take,
      simulateError,
    );
  }

  /// GET /meals?affordability=affordable
  static Future<GetListDataResponse<MealPreview>> getBudget({
    String? categoryId,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.affordable)
        .toList();
    return _buildPreviewResponse(
      filtered,
      null,
      categoryId,
      skip,
      take,
      simulateError,
    );
  }

  /// GET /meals?affordability=luxurious
  static Future<GetListDataResponse<MealPreview>> getPremium({
    String? categoryId,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.luxurious)
        .toList();
    return _buildPreviewResponse(
      filtered,
      null,
      categoryId,
      skip,
      take,
      simulateError,
    );
  }

  /// GET /meals
  static Future<GetListDataResponse<MealPreview>> getAllMeals({
    String? searchKey,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return _buildPreviewResponse(
      availableMeals,
      searchKey,
      null,
      skip,
      take,
      simulateError,
    );
  }

  /// GET /meals/{id}
  static Future<GetDataResponse<Meal>> getMealById(
    String id, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final meal = availableMeals.firstWhere((m) => m.id == id);
    return GetDataResponse(data: meal, error: simulateError ? _error : null);
  }

  // ---------------------------------------------------------------------------
  // Favorites endpoints
  // ---------------------------------------------------------------------------

  /// GET /favorites — returns meals whose IDs are in [favoriteIds], filtered by [categoryId].
  static Future<GetListDataResponse<Meal>> getFavorites(
    List<String> favoriteIds, {
    String? categoryId,
    Duration delay = const Duration(milliseconds: 300),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final favorites = availableMeals
        .where((m) => favoriteIds.contains(m.id))
        .toList();
    final filtered = categoryId == null
        ? favorites
        : favorites.where((m) => m.categories.contains(categoryId)).toList();
    return GetListDataResponse(
      data: filtered,
      total: filtered.length,
      error: simulateError ? _error : null,
    );
  }

  /// POST /favorites/{mealId}
  static Future<MutationResponse> addFavorite({
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  /// DELETE /favorites/{mealId}
  static Future<MutationResponse> removeFavorite({
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Generic helpers — for mutations and repositories without dedicated methods
  // ---------------------------------------------------------------------------

  /// Simulates a GET endpoint that returns a list with pagination metadata.
  static Future<GetListDataResponse<T>> getList<T>({
    required List<T> data,
    required int total,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return GetListDataResponse(
      data: data,
      total: total,
      error: simulateError ? _error : null,
    );
  }

  /// Simulates a mutation endpoint (POST / PUT / DELETE) with no response body.
  /// Returns a [MutationResponse] with [error] set when [simulateError] is true.
  static Future<MutationResponse> voidCall({
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  static GetListDataResponse<MealPreview> _buildPreviewResponse(
    List<Meal> meals,
    String? searchKey,
    String? categoryId,
    int skip,
    int take,
    bool simulateError,
  ) {
    final categoryFiltered = categoryId == null
        ? meals
        : meals.where((m) => m.categories.contains(categoryId)).toList();
    final fullyFiltered = searchKey == null || searchKey.isEmpty
        ? categoryFiltered
        : categoryFiltered
              .where(
                (m) => m.title.toLowerCase().contains(searchKey.toLowerCase()),
              )
              .toList();
    final paged = fullyFiltered
        .skip(skip)
        .take(take)
        .map((m) => MealPreview.fromJson(m.toJson()))
        .toList();
    return GetListDataResponse(
      data: paged,
      total: fullyFiltered.length,
      error: simulateError ? _error : null,
    );
  }
}
