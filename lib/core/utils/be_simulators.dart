// Project Helpers
import 'package:sfrigola/core/helpers/app_logger.dart';

// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/be_filter.dart';
import 'package:sfrigola/core/models/be-models/be_sort.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories

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
    AppLogger.debug(
      'fetching all categories',
      tag: 'BeSimulators.getCategories',
    );
    final response = GetListDataResponse(
      data: availableCategories,
      total: availableCategories.length,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'total: ${response.total} | error: ${response.error}',
      tag: 'BeSimulators.getCategories',
    );
    return response;
  }

  /// GET /meals/trending
  static Future<GetListDataResponse<MealPreview>> getTrending(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getTrending',
    );
    final base = [..._meals]..sort((a, b) => b.rate.compareTo(a.rate));
    final response = _buildPreviewResponse(base, request, simulateError);
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getTrending',
    );
    return response;
  }

  /// GET /meals?complexity=simple
  static Future<GetListDataResponse<MealPreview>> getEasy(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getEasy',
    );
    final base = _meals
        .where((m) => m.complexity == Complexity.simple)
        .toList();
    final response = _buildPreviewResponse(base, request, simulateError);
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getEasy',
    );
    return response;
  }

  /// GET /meals?complexity=hard
  static Future<GetListDataResponse<MealPreview>> getChallenge(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getChallenge',
    );
    final base = _meals
        .where((m) => m.complexity == Complexity.hard)
        .toList();
    final response = _buildPreviewResponse(base, request, simulateError);
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getChallenge',
    );
    return response;
  }

  /// GET /meals?affordability=affordable
  static Future<GetListDataResponse<MealPreview>> getBudget(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getBudget',
    );
    final base = _meals
        .where((m) => m.affordability == Affordability.affordable)
        .toList();
    final response = _buildPreviewResponse(base, request, simulateError);
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getBudget',
    );
    return response;
  }

  /// GET /meals?affordability=luxurious
  static Future<GetListDataResponse<MealPreview>> getPremium(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getPremium',
    );
    final base = _meals
        .where((m) => m.affordability == Affordability.luxurious)
        .toList();
    final response = _buildPreviewResponse(base, request, simulateError);
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getPremium',
    );
    return response;
  }

  /// GET /meals
  static Future<GetListDataResponse<MealPreview>> getAllMeals(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getAllMeals',
    );
    final response = _buildPreviewResponse(
      _meals,
      request,
      simulateError,
    );
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getAllMeals',
    );
    return response;
  }

  /// GET /meals/{id}
  static Future<GetDataResponse<Meal>> getMealById(
    String id, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug('id: $id', tag: 'BeSimulators.getMealById');
    final meal = _meals.firstWhere((m) => m.id == id);
    final resolved = meal.copyWith(
      isFavourite: _favoriteIds.contains(id),
      userRate: _userRatings[id] ?? meal.userRate,
    );
    final response = GetDataResponse(
      data: resolved,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'found: ${meal.title} | isFavourite: ${resolved.isFavourite} | error: ${response.error}',
      tag: 'BeSimulators.getMealById',
    );
    return response;
  }

  // ---------------------------------------------------------------------------
  // Favorites endpoints
  // ---------------------------------------------------------------------------

  /// In-memory favourite IDs — seeded from [isFavourite] in dummy data.
  /// Mutated by [addFavorite] / [removeFavorite] to mirror server-side state.
  static final List<String> _favoriteIds = availableMeals
      .where((m) => m.isFavourite)
      .map((m) => m.id)
      .toList();

  /// In-memory user ratings — seeded from [userRate] in dummy data.
  /// Mutated by [updateMealRating] to mirror server-side state.
  static final Map<String, double> _userRatings = {
    for (final m in availableMeals)
      if (m.userRate != null) m.id: m.userRate!,
  };

  /// In-memory meals list — mutable copy of [availableMeals].
  /// Mutated by admin operations ([addMeal], [updateMeal], [deleteMeal]).
  static final List<Meal> _meals = [...availableMeals];

  /// GET /favorites — returns meal previews for the current favourite list, filtered and sorted.
  static Future<GetListDataResponse<MealPreview>> getFavorites(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 300),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug(
      'request: ${request.toJson()}',
      tag: 'BeSimulators.getFavorites',
    );
    final base = _meals
        .where((m) => _favoriteIds.contains(m.id))
        .toList();
    final response = _buildPreviewResponse(base, request, simulateError);
    AppLogger.debug(
      'total: ${response.total} | returned: ${response.data.length} | error: ${response.error}',
      tag: 'BeSimulators.getFavorites',
    );
    return response;
  }

  /// POST /favorites/{mealId}
  static Future<MutationResponse> addFavorite({
    required String mealId,
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug('mealId: $mealId', tag: 'BeSimulators.addFavorite');
    if (!simulateError && !_favoriteIds.contains(mealId)) {
      _favoriteIds.add(mealId);
    }
    final response = MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'success: ${response.success} | error: ${response.error}',
      tag: 'BeSimulators.addFavorite',
    );
    return response;
  }

  /// DELETE /favorites/{mealId}
  static Future<MutationResponse> removeFavorite({
    required String mealId,
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug('mealId: $mealId', tag: 'BeSimulators.removeFavorite');
    if (!simulateError) _favoriteIds.remove(mealId);
    final response = MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'success: ${response.success} | error: ${response.error}',
      tag: 'BeSimulators.removeFavorite',
    );
    return response;
  }

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
    AppLogger.debug(
      'mealId: $mealId | newRating: $newRating',
      tag: 'BeSimulators.updateMealRating',
    );
    if (!simulateError) {
      _userRatings[mealId] = newRating;
    }
    final response = MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'success: ${response.success} | error: ${response.error}',
      tag: 'BeSimulators.updateMealRating',
    );
    return response;
  }

  // ---------------------------------------------------------------------------
  // Admin endpoints
  // ---------------------------------------------------------------------------

  /// POST /admin/meals
  static Future<MutationResponse> addMeal({
    required Meal meal,
    Duration delay = const Duration(milliseconds: 400),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug('mealId: ${meal.id}', tag: 'BeSimulators.addMeal');
    if (!simulateError) _meals.add(meal);
    final response = MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'success: ${response.success} | error: ${response.error}',
      tag: 'BeSimulators.addMeal',
    );
    return response;
  }

  /// PUT /admin/meals/{mealId}
  static Future<MutationResponse> updateMeal({
    required Meal meal,
    Duration delay = const Duration(milliseconds: 400),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug('mealId: ${meal.id}', tag: 'BeSimulators.updateMeal');
    if (!simulateError) {
      final index = _meals.indexWhere((m) => m.id == meal.id);
      if (index != -1) _meals[index] = meal;
    }
    final response = MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'success: ${response.success} | error: ${response.error}',
      tag: 'BeSimulators.updateMeal',
    );
    return response;
  }

  /// DELETE /admin/meals/{mealId}
  static Future<MutationResponse> deleteMeal({
    required String mealId,
    Duration delay = const Duration(milliseconds: 300),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    AppLogger.debug('mealId: $mealId', tag: 'BeSimulators.deleteMeal');
    if (!simulateError) _meals.removeWhere((m) => m.id == mealId);
    final response = MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
    AppLogger.debug(
      'success: ${response.success} | error: ${response.error}',
      tag: 'BeSimulators.deleteMeal',
    );
    return response;
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Applies [request] filters, text search, sort and pagination to [meals].
  ///
  /// [meals] must already be base-filtered by the calling endpoint
  /// (e.g. complexity == simple for getEasy) and base-sorted when relevant
  /// (e.g. by rate desc for getTrending). [request.sort] overrides the base
  /// sort when set.
  static GetListDataResponse<MealPreview> _buildPreviewResponse(
    List<Meal> meals,
    GetRequest<MealFilterKey, MealSortKey> request,
    bool simulateError,
  ) {
    var filtered = List<Meal>.from(meals);

    // Apply FilterGroups — conditions in a group are OR; groups are AND
    for (final group in request.filters) {
      filtered = filtered
          .where((m) => group.conditions.any((c) => _matchesCondition(m, c)))
          .toList();
    }

    // Apply text search (title + description)
    if (request.searchKey?.isNotEmpty ?? false) {
      final key = request.searchKey!.toLowerCase();
      filtered = filtered
          .where(
            (m) =>
                m.title.toLowerCase().contains(key) ||
                m.description.toLowerCase().contains(key),
          )
          .toList();
    }

    // Apply sort — overrides endpoint's default sort when set
    if (request.sort != null) {
      filtered.sort((a, b) => _compareMealBy(a, b, request.sort!));
    }

    final total = filtered.length;
    final paged = filtered
        .skip(request.skip)
        .take(request.take)
        .map((m) => MealPreview.fromJson(m.toJson()))
        .toList();

    return GetListDataResponse(
      data: paged,
      total: total,
      error: simulateError ? _error : null,
    );
  }

  static bool _matchesCondition(
    Meal meal,
    FilterCondition<MealFilterKey> condition,
  ) {
    return switch (condition.key) {
      MealFilterKey.category => switch (condition.comparator) {
        FilterOperator.equals => meal.categories.contains(
          condition.value as String,
        ),
        _ => true,
      },
      MealFilterKey.complexity => switch (condition.comparator) {
        FilterOperator.equals =>
          meal.complexity == (condition.value as Complexity),
        _ => true,
      },
      MealFilterKey.affordability => switch (condition.comparator) {
        FilterOperator.equals =>
          meal.affordability == (condition.value as Affordability),
        _ => true,
      },
      MealFilterKey.rating => switch (condition.comparator) {
        FilterOperator.greaterThanOrEquals =>
          meal.rate >= (condition.value as double),
        FilterOperator.lessThanOrEquals =>
          meal.rate <= (condition.value as double),
        FilterOperator.greaterThan => meal.rate > (condition.value as double),
        FilterOperator.lessThan => meal.rate < (condition.value as double),
        FilterOperator.equals => meal.rate == (condition.value as double),
        _ => true,
      },
    };
  }

  static int _compareMealBy(Meal a, Meal b, SortParam<MealSortKey> sort) {
    final cmp = switch (sort.key) {
      MealSortKey.name => a.title.compareTo(b.title),
      MealSortKey.rating => a.rate.compareTo(b.rate),
      MealSortKey.complexity => a.complexity.index.compareTo(
        b.complexity.index,
      ),
      MealSortKey.affordability => a.affordability.index.compareTo(
        b.affordability.index,
      ),
    };
    return sort.direction == SortDirection.desc ? -cmp : cmp;
  }
}
