// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/be-models/be_filters.dart';
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
    final resolved = meal.copyWith(isFavourite: _favoriteIds.contains(id));
    return GetDataResponse(data: resolved, error: simulateError ? _error : null);
  }

  // ---------------------------------------------------------------------------
  // Favorites endpoints
  // ---------------------------------------------------------------------------

  /// In-memory favourite IDs — seeded from [isFavourite] in dummy data.
  /// Mutated by [addFavorite] / [removeFavorite] during the session.
  static final List<String> _favoriteIds =
      availableMeals.where((m) => m.isFavourite).map((m) => m.id).toList();

  /// GET /favorites — returns meal previews for the current in-memory favourite list, filtered and sorted.
  static Future<GetListDataResponse<MealPreview>> getFavorites({
    Complexity? complexity,
    Affordability? affordability,
    double? minRate,
    double? maxRate,
    SortOrder? sortOrder,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 300),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);

    var results = availableMeals.where((m) => _favoriteIds.contains(m.id));

    if (complexity != null) {
      results = results.where((m) => m.complexity == complexity);
    }
    if (affordability != null) {
      results = results.where((m) => m.affordability == affordability);
    }
    if (minRate != null) {
      results = results.where((m) => m.rate >= minRate);
    }
    if (maxRate != null) {
      results = results.where((m) => m.rate <= maxRate);
    }

    final sorted = results.toList();
    if (sortOrder != null) {
      sorted.sort(
        (a, b) => switch (sortOrder) {
          SortOrder.alphabeticalAscending => a.title.compareTo(b.title),
          SortOrder.alphabeticalDescending => b.title.compareTo(a.title),
          SortOrder.rateAscending => a.rate.compareTo(b.rate),
          SortOrder.rateDescending => b.rate.compareTo(a.rate),
          SortOrder.complexityAscending => a.complexity.index.compareTo(
            b.complexity.index,
          ),
          SortOrder.complexityDescending => b.complexity.index.compareTo(
            a.complexity.index,
          ),
          SortOrder.affordabilityAscending => a.affordability.index.compareTo(
            b.affordability.index,
          ),
          SortOrder.affordabilityDescending => b.affordability.index.compareTo(
            a.affordability.index,
          ),
        },
      );
    }

    final paged = sorted.skip(skip).take(take).toList();

    return GetListDataResponse(
      data: paged
          .map(
            (m) => MealPreview(
              id: m.id,
              title: m.title,
              subtitle: m.subtitle,
              imageUrl: m.imageUrl,
              duration: m.duration,
              complexity: m.complexity,
              affordability: m.affordability,
              rate: m.rate,
            ),
          )
          .toList(),
      total: sorted.length,
      error: simulateError ? _error : null,
    );
  }

  /// POST /favorites/{mealId}
  static Future<MutationResponse> addFavorite({
    required String mealId,
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    if (!simulateError && !_favoriteIds.contains(mealId)) {
      _favoriteIds.add(mealId);
    }
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  /// DELETE /favorites/{mealId}
  static Future<MutationResponse> removeFavorite({
    required String mealId,
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    if (!simulateError) _favoriteIds.remove(mealId);
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

  /// PATCH /meals/{mealId}/rating
  static Future<MutationResponse> updateMealRating({
    required String mealId,
    required double newRating,
    Duration delay = const Duration(milliseconds: 300),
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
